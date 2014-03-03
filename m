From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Mar 2014 14:26:22 +0100
Subject: [linux-sunxi] [PATCH v2 2/5] clk: sun6i: Reparent AHB clock on
 PLL6
In-Reply-To: <53120BA8.3000508@redhat.com>
References: <1393605440-14643-1-git-send-email-maxime.ripard@free-electrons.com>
 <1393605440-14643-3-git-send-email-maxime.ripard@free-electrons.com>
 <53120BA8.3000508@redhat.com>
Message-ID: <20140303132622.GY607@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Sat, Mar 01, 2014 at 05:32:40PM +0100, Hans de Goede wrote:
> On 02/28/2014 05:37 PM, Maxime Ripard wrote:
> > In order for the DMA controller to work for SDRAM to devices transfers, the AHB
> > clock should be reparented on the PLL6.
> > 
> > Force that parenting in the clock driver.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clk/sunxi/clk-sunxi.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> > index f6f61cc..a5c5882 100644
> > --- a/drivers/clk/sunxi/clk-sunxi.c
> > +++ b/drivers/clk/sunxi/clk-sunxi.c
> > @@ -1286,7 +1286,7 @@ static void __init of_sunxi_table_clock_setup(const struct of_device_id *clk_mat
> >   */
> >  static void __init sunxi_clock_protect(void)
> >  {
> > -	struct clk *clk;
> > +	struct clk *clk, *parent;
> >  
> >  	/* memory bus clock - sun5i+ */
> >  	clk = clk_get(NULL, "mbus");
> > @@ -1307,6 +1307,22 @@ static void __init sunxi_clock_protect(void)
> >  	if (!IS_ERR(clk))
> >  		clk_prepare_enable(clk);
> >  
> > +	clk = clk_get(NULL, "ahb1_mux");
> > +	if (IS_ERR(clk)) {
> > +		pr_err("Couldn't get AHB1 Mux\n");
> > +		return;
> > +	}
> 
> I think Emilio already made a similar remark for v1, but since this
> is still here in v2, ahb1_mux is only available on sun6i, so
> at a minimum the pr_err should be dropped. Preferably I would like
> to see this changed to something like:
> 
> 	clk = clk_get(NULL, "ahb1_mux");
> 	parent = clk_get(NULL, "pll6");
> 	if (!IS_ERR(clk) && !IS_ERR(parent))
> 		clk_set_parent(clk, parent);
> 	if (!IS_ERR(parent))
> 		clk_put(parent);
> 	if (!IS_ERR(clk))
> 		clk_put(clk);

Still. The DMA doesn't work at all if the parenting is not set, so
having an error if it fails is mandatory.

And the statement that you made can also apply to any clock we enable
here, that might or might not be present in all the SoCs.

I guess we can solve this in two steps:
  - split out the reparenting, and move this into the DMA driver. That
    would isolate things in the driver itself, and prevent a
    reparenting attempt on every SoCs.
  - Split this function into several functions, one for each SoC. That
    would allow to do pretty much anything we want without having to
    care about wether it applies to other platforms.

> > +	parent = clk_get(NULL, "pll6");
> > +	if (IS_ERR(clk)) {
> 
> Copy paste error should be IS_ERR(parent).

Ah, yep, thanks!

> 
> > +		pr_err("Couldn't get PLL6\n");
> 
> If we keep things this way this error path should do a clk_put(clk);

Good catch too.

> > +		return;
> > +	}
> > +
> > +	clk_set_parent(clk, parent);
> > +
> > +	clk_put(clk);
> > +	clk_put(parent);
> >  }
> >  
> >  static void __init sunxi_init_clocks(void)
> > 
> 
> Regards,
> 
> Hans
> 
> p.s.
> 
> Given Russell's remarks it would also be good to have a
> patch in this set dropping the clk_put calls of the existing
> enables / protections.

Yes, I'll do it in the v3.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/34d5c39f/attachment.sig>
