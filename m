From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Feb 2014 09:36:06 +0100
Subject: [PATCH v7 2/8] clk: sunxi: Implement MMC phase control
In-Reply-To: <20140219052125.8345.70717@quantum>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch>
 <20140217100221.15040.47203.stgit@pagira.o2s.ch>
 <20140218141532.GH3142@lukather>
 <20140219052125.8345.70717@quantum>
Message-ID: <20140219083606.GR3142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Tue, Feb 18, 2014 at 09:21:25PM -0800, Mike Turquette wrote:
> Quoting Maxime Ripard (2014-02-18 06:15:32)
> > Hi,
> > 
> > On Mon, Feb 17, 2014 at 11:02:21AM +0100, David Lanzend?rfer wrote:
> > > From: Emilio L?pez <emilio@elopez.com.ar>
> > > 
> > > Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> > 
> > You're missing your Signed-off-by here too.  Remember, for every patch
> > you send, your Signed-off-by must be there, regardless wether you're
> > the author or not.
> > 
> > A commit log would be very much welcome too.
> > 
> > Now, down to the patch itself, I remember Mike saying that he would
> > prefer adding a function in the framework instead of hardcoding
> > it. Mike, what's your feeling on this? Would merging this seem
> > reasonnable to you as is, or do you want to take this to the
> > framework?
> 
> Hi Maxime & Emilio,
> 
> Maybe something like the following RFC? If it seems sufficient for this
> case then I will post to the wider list with an eye towards merging it
> for 3.15. I've Cc'd Dinh since this came up on the socfpga thread as
> well.
> 
> Regards,
> Mike
> 
> 
> 
> From 56fa297591be5c5e22df6d2ca43fccf285a45636 Mon Sep 17 00:00:00 2001
> From: Mike Turquette <mturquette@linaro.org>
> Date: Tue, 18 Feb 2014 20:33:50 -0800
> Subject: [PATCH] clk: introduce clk_set_phase function & callback
> 
> A common operation for a clock signal generator is to shift the phase of
> that signal. This patch introduces a new function to the clk.h API to
> dynamically adjust the phase of a clock signal. Additionally this patch
> introduces support for the new function in the common clock framework
> via the .set_phase call back in struct clk_ops.
> 
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> ---
> This patch is totally untested. It may make your board burst into
> flames.
> 
>  drivers/clk/clk.c            | 84 +++++++++++++++++++++++++++++++++++++++++---
>  include/linux/clk-private.h  |  1 +
>  include/linux/clk-provider.h |  5 +++
>  include/linux/clk.h          | 29 +++++++++++++++
>  4 files changed, 115 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index ea2ca9f..635170a 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -106,11 +106,11 @@ static void clk_summary_show_one(struct seq_file *s, struct clk *c, int level)
>  	if (!c)
>  		return;
>  
> -	seq_printf(s, "%*s%-*s %-11d %-12d %-10lu %-11lu",
> +	seq_printf(s, "%*s%-*s %-11d %-12d %-10lu %-11lu %-3d",
>  		   level * 3 + 1, "",
>  		   30 - level * 3, c->name,
>  		   c->enable_count, c->prepare_count, clk_get_rate(c),
> -		   clk_get_accuracy(c));
> +		   clk_get_accuracy(c), clk_get_phase(c));
>  	seq_printf(s, "\n");
>  }
>  
> @@ -132,8 +132,8 @@ static int clk_summary_show(struct seq_file *s, void *data)
>  {
>  	struct clk *c;
>  
> -	seq_printf(s, "   clock                        enable_cnt  prepare_cnt  rate        accuracy\n");
> -	seq_printf(s, "---------------------------------------------------------------------------------\n");
> +	seq_printf(s, "   clock                        enable_cnt  prepare_cnt  rate        accuracy   phase\n");
> +	seq_printf(s, "-----------------------------------------------------------------------------------------\n");
>  
>  	clk_prepare_lock();
>  
> @@ -171,6 +171,7 @@ static void clk_dump_one(struct seq_file *s, struct clk *c, int level)
>  	seq_printf(s, "\"prepare_count\": %d,", c->prepare_count);
>  	seq_printf(s, "\"rate\": %lu", clk_get_rate(c));
>  	seq_printf(s, "\"accuracy\": %lu", clk_get_accuracy(c));
> +	seq_printf(s, "\"phase\": %d", clk_get_phase(c));
>  }
>  
>  static void clk_dump_subtree(struct seq_file *s, struct clk *c, int level)
> @@ -257,6 +258,11 @@ static int clk_debug_create_one(struct clk *clk, struct dentry *pdentry)
>  	if (!d)
>  		goto err_out;
>  
> +	d = debugfs_create_u32("clk_phase", S_IRUGO, clk->dentry,
> +			(u32 *)&clk->phase);
> +	if (!d)
> +		goto err_out;
> +
>  	d = debugfs_create_x32("clk_flags", S_IRUGO, clk->dentry,
>  			(u32 *)&clk->flags);
>  	if (!d)
> @@ -1766,6 +1772,76 @@ out:
>  EXPORT_SYMBOL_GPL(clk_set_parent);
>  
>  /**
> + * clk_set_phase - adjust the phase shift of a clock signal
> + * @clk: clock signal source
> + * @degrees: number of degrees the signal is shifted
> + *
> + * Shifts the phase of a clock signal by the specified degrees. Returns 0 on
> + * success, -EERROR otherwise.
> + *
> + * This function makes no distiction about the input or reference signal that
> + * we adjust the clock signal phase against. For example phase locked-loop
> + * clock signal generators we may shift phase with respect to feedback clock
> + * signal input, but for other cases the clock phase may be shifted with
> + * respect to some other, unspecified signal.
> + *
> + * Additionally the concept of phase shift does not propagate through the clock
> + * tree hierarchy, which sets it appart from clock rates and clock accuracy. A
> + * parent clock phase attribute does not have an impact on the phase attribute
> + * of a child clock.
> + */
> +int clk_set_phase(struct clk *clk, int degrees)

Actually, while this is what I had in mind too, we'd need a bit more
control here. We have two phases to control (namely, input and
sample).

Maybe passing an additional enum to tell which phase we want to
adjust, that could easily be extended by new drivers need would fit
our need here?

Thanks!
Maxime


-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140219/09ea0ba2/attachment-0001.sig>
