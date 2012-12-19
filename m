From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 19 Dec 2012 15:52:17 +0000
Subject: [PATCH 5/7] arm64: ARMv8 RTSM model (SoC) support
In-Reply-To: <1355930886.22260.53.camel@hornet>
References: <1354914392-9634-1-git-send-email-catalin.marinas@arm.com>
 <20121211163932.GC16071@arm.com> <20121218162944.GA594@arm.com>
 <201212181759.45394.arnd@arndb.de>
 <1355930886.22260.53.camel@hornet>
Message-ID: <20121219155217.GH26899@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 03:28:06PM +0000, Pawel Moll wrote:
> On Tue, 2012-12-18 at 17:59 +0000, Arnd Bergmann wrote:
> > On Tuesday 18 December 2012, Catalin Marinas wrote:
> > > After some more thinking, none of these would work for arch/arm since
> > > vexpress_clk_of_init() is called very early via the time_init() ...
> > > v2m_dt_timer_init(). On arm64 we rely on the architected timers to be
> > > always present but this assumption is not valid on arm where clocks
> > > would need to be initialised early.
> > > 
> > > While I'd really like to get rid of the SoC code in arch/arm64, the best
> > > place I see for the vexpress_clk_of_init() call is still the arch code
> > > (unless we add #ifdefs in the clk-vexpress.c code).
> > 
> > I think I'd prefer the #ifdef in this case. Ideally, we would get rid
> > of most of the early init functions in ARM as well, but that is
> > a different battle for now. Getting the arch/arm64 to look nice
> > IMHO is more important in this case, and we can fix the 32 bit
> > version later.
> 
> I'm sure we'll be able to make the vexpress_clk_* functions behave
> correctly, either with a help of #ifdef or in some other way - don't
> concern yourself with this detail.
> 
> The bigger fish to fry is the generic initialization of the clocks (as
> in: when to call the of_clk_init() and how to gather all possible
> of_match-es)...

Some code I was just trying below. But I have to sort out some
initialisation order and can do an arch_initcall(vexpress_clk_of_init)
in clk-vexpress.c together with your patch for the self-initialising
vexpress sysregs.

diff --git a/drivers/clk/versatile/clk-vexpress.c b/drivers/clk/versatile/clk-vexpress.c
index 4f83ff9..11f2da6 100644
--- a/drivers/clk/versatile/clk-vexpress.c
+++ b/drivers/clk/versatile/clk-vexpress.c
@@ -98,21 +98,11 @@ struct clk *vexpress_sp810_of_get(struct of_phandle_args *clkspec, void *data)
 	return vexpress_sp810_timerclken[clkspec->args[0]];
 }
 
-static const __initconst struct of_device_id vexpress_fixed_clk_match[] = {
-	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
-	{ .compatible = "arm,vexpress-osc", .data = vexpress_osc_of_setup, },
-	{}
-};
-
-void __init vexpress_clk_of_init(void)
+static void __init vexpress_sp810_of_setup(struct device_node *node)
 {
-	struct device_node *node;
 	struct clk *clk;
 	struct clk *refclk, *timclk;
 
-	of_clk_init(vexpress_fixed_clk_match);
-
-	node = of_find_compatible_node(NULL, NULL, "arm,sp810");
 	vexpress_sp810_init(of_iomap(node, 0));
 	of_clk_add_provider(node, vexpress_sp810_of_get, NULL);
 
@@ -138,4 +128,16 @@ void __init vexpress_clk_of_init(void)
 				"v2m-timer1", "sp804"));
 }
 
+static const __initconst struct of_device_id vexpress_clk_match[] = {
+	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
+	{ .compatible = "arm,vexpress-osc", .data = vexpress_osc_of_setup, },
+	{ .compatible = "arm,sp810", .data = vexpress_sp810_of_setup, },
+	{}
+};
+
+void __init vexpress_clk_of_init(void)
+{
+	of_clk_init(vexpress_clk_match);
+}
+
 #endif

-- 
Catalin
