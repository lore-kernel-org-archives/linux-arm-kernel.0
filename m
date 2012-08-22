From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 22 Aug 2012 17:27:29 +0800
Subject: [PATCH 2/2] ARM: imx6q: replace clk_register_clkdev with clock
 DT lookup
In-Reply-To: <20120822083223.GW18957@n2100.arm.linux.org.uk>
References: <1345104526-14797-1-git-send-email-shawn.guo@linaro.org>
 <1345104526-14797-3-git-send-email-shawn.guo@linaro.org>
 <503232E0.3000007@gmail.com>
 <CAKGA1bn2uCWE8YkGR4EzTxZ_bXJ_ov2diq63uxQ=dT7b6Fu9GQ@mail.gmail.com>
 <20120820151609.GN24242@S2101-09.ap.freescale.net>
 <CAKGA1bnfhMC8QG9OqBbpy5iq6ZAfEgrYMg_LVd50U7yikLhDAg@mail.gmail.com>
 <20120821122753.GU18957@n2100.arm.linux.org.uk>
 <5033891D.90509@calxeda.com>
 <20120822083223.GW18957@n2100.arm.linux.org.uk>
Message-ID: <20120822092726.GV24242@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 09:32:23AM +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 21, 2012 at 08:11:57AM -0500, Rob Herring wrote:
> > On 08/21/2012 07:27 AM, Russell King - ARM Linux wrote:
> > > So now, you're not dealing with inventing a whole load of names for clocks
> > > on a platform, instead what you're doing is describing _where_ the clock
> > > comes from in the system for a particular device by device node and index
> > > into it - just like we do for interrupts.
> > 
> > That is what we're doing. The names are optional for DT, but happen to
> > be required for struct clk now. If we don't put something in DT, then
> > the clock names will have to be something generic like ccm-1..ccm-185.
> 
> And that's what's wrong.  Clocks themselves should _not_ be required to
> be named.
> 
> If you use purely "producer node + index" then you don't need to name a
> whole bunch of clocks, and you don't need to have an array of clock names
> in the DT file.  This also gets rid of the time consuming strcmp against
> every clock, which has already been raised as a problem with the existing
> clk_get().
> 
Ok, if I got your point correctly, it's about amending the following
changes, and then we can get rid of that big clock-output-names list
from dts.

Regards,
Shawn

--8<---

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 433c683..d52f3f4 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -387,7 +387,7 @@ int __init mx6q_clocks_init(void)
                        pr_err("i.MX6q clk %d: register failed with %ld\n",
                                i, PTR_ERR(clk[i]));

-       of_clk_add_provider(np, of_clk_src_onecell_get, NULL);
+       of_clk_add_provider(np, of_clk_src_onecell_get, clk);

        clk_register_clkdev(clk[gpt_ipg], "ipg", "imx-gpt.0");
        clk_register_clkdev(clk[gpt_ipg_per], "per", "imx-gpt.0");
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 06bc0b5..a010ed6 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1584,16 +1584,10 @@ EXPORT_SYMBOL_GPL(of_clk_src_simple_get);

 struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data)
 {
-       const char *clk_name;
+       struct clk **clks = data;
        int idx = clkspec->args[0];
-       int ret;
-
-       ret = of_property_read_string_index(clkspec->np, "clock-output-names",
-                                           idx, &clk_name);
-       if (ret < 0)
-               return ERR_PTR(ret);

-       return __clk_lookup(clk_name);
+       return clks[idx];
 }
 EXPORT_SYMBOL_GPL(of_clk_src_onecell_get);
