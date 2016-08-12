From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 12 Aug 2016 16:17:53 +0800
Subject: [PATCH v9 01/10] clk: fix initial state of critical clock's
 parents
In-Reply-To: <20160810210922.GD2996@codeaurora.org>
References: <1466581229-2342-1-git-send-email-erin.lo@mediatek.com>
 <1466581229-2342-2-git-send-email-erin.lo@mediatek.com>
 <20160702012140.GB17071@codeaurora.org>
 <1467604308.26485.4.camel@mtksdaap41>
 <146802073038.73491.6675612765998057903@resonance>
 <1468225452.31247.7.camel@mtksdaap41> <1470203182.17063.3.camel@mtksdaap41>
 <1470721183.8551.6.camel@mtksdaap41> <20160810210922.GD2996@codeaurora.org>
Message-ID: <1470989873.8551.10.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-08-10 at 14:09 -0700, Stephen Boyd wrote:
> (Including lists)
> 
> On 08/09, James Liao wrote:
> > On Wed, 2016-08-03 at 13:46 +0800, James Liao wrote:
> >>
> >> Hi Mike,
> >>
> >> Do you have new patches to fix new clock parents? If not, I think we can
> >> use my patch first. Is it okay?
> >>
> >
> > Hi Stephen,
> >
> > Do you have comments for the bug fixing? I prefer to use my patch (clk:
> > fix initial state of critical clock's parents). How do you think?
> >
> 
> How about we recalc accuracies and rates in addition to the patch
> from Mike? That will fix everything?

Hi Stephen,

It works!

I'll send a new series of MT2701 clock support in few days. Should I
include this patch in my series? Or you'll merge it into clk-next
directly?


Best regards,

James

> ---8<----
> From: Michael Turquette <mturquette@baylibre.com>
> Subject: [PATCH] clk: migrate ref counts when orphans are reunited
> 
> It's always nice to see families reunited, and this is equally true when
> talking about parent clocks and their children. However, if the orphan
> clk had a positive prepare_count or enable_count, then we would not
> migrate those counts up the parent chain correctly.
> 
> This has manifested with the recent critical clocks feature, which often
> enables clocks very early, before their parents have been registered.
> 
> Fixed by replacing the call to clk_core_reparent with calls to
> __clk_set_parent_{before,after}.
> 
> Cc: James Liao <jamesjj.liao@mediatek.com>
> Cc: Erin Lo <erin.lo@mediatek.com>
> Signed-off-by: Michael Turquette <mturquette@baylibre.com>
> [sboyd at codeaurora.org: Recalc accuracies and rates too]
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/clk/clk.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 820a939fb6bb..dc3fff2bf839 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2449,8 +2449,16 @@ static int __clk_core_init(struct clk_core *core)
>  	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
>  		struct clk_core *parent = __clk_init_parent(orphan);
>  
> -		if (parent)
> -			clk_core_reparent(orphan, parent);
> +		/*
> +		 * we could call __clk_set_parent, but that would result in a
> +		 * reducant call to the .set_rate op, if it exists
> +		 */
> +		if (parent) {
> +			__clk_set_parent_before(orphan, parent);
> +			__clk_set_parent_after(orphan, parent, NULL);
> +			__clk_recalc_accuracies(orphan);
> +			__clk_recalc_rates(orphan, 0);
> +		}
>  	}
>  
>  	/*
