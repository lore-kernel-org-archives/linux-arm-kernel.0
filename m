From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Feb 2016 08:35:20 -0800
Subject: GPIO regression in Linux next caused by syscon change
In-Reply-To: <56C8471A.1040702@ti.com>
References: <20160213002643.GQ19432@atomide.com>
 <20160213004935.GR19432@atomide.com>
 <CA+gwMccZeYimupmGsMX8YbNH9eEA6=Xi=rupciubBwzktfjvBA@mail.gmail.com>
 <20160215160115.GU19432@atomide.com>
 <1455552961.4899.37.camel@pengutronix.de>
 <20160215164757.GV19432@atomide.com>
 <20160215180635.GW19432@atomide.com> <56C8471A.1040702@ti.com>
Message-ID: <20160222163520.GC13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [160220 02:59]:
> On 02/15/2016 08:06 PM, Tony Lindgren wrote:
> >Tero, got any better ideas?
> 
> The underlying problem is the fact that OMAP3 control module register map is
> split into multiple regions, which in certain cases have overlapping
> functionality, and need to be accessed over boundaries. And the fact that we
> decided to split it in such way in the first place, for example to have
> pinmux regions separate.

Well we should only use regmap for the scm_conf area as that contains
tens of random registers that may need to be shared between various
device drivers.

For other SCM regions, we should just do standard Linux device drivers,
like we're doing with the pinmux regions.

> If you are going to bypass the usage of regmap, you could just drop it
> completely from the omap_ctrl_readl / writel APIs, and use the iomap
> directly. That simplifies the code and is slightly faster also.

OK that's a good idea. I'll update the patch to drop regmap for
omap_ctrl_read/write.

> Eventually this should probably be fixed in such way that any out-of-bounds
> accesses on the omap_ctrl region should use the actual driver APIs for that.
> The padconf accesses I have no clue how to fix (as pinctrl driver doesn't
> provide direct register read/write API), but for others we should introduce
> new regions under the DTS files and use a separate syscon mapping or
> something similar.

Best to keep regmap out of it for ranges that can be clearly ioremapped
for a dedicated device drivers.

Anyways, updated patch below, please take a look and ack if that
works for you and I'll apply it into omap-for-v4.6/fixes-not-urgent.

Regards,

Tony

8< ----------------------
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 17 Feb 2016 10:36:31 -0800
Subject: [PATCH] ARM: OMAP2+: Fix out of range register access with
 syscon_config.max_register

If syscon_config.max_register is initialized like it should be, we have
omap_ctrl_read/write() fail with out of range register access at least
for omap3.

We have omap3.dtsi setting up a regmap range for scm_conf, but we now
have omap_ctrl_read/write() also attempt to use the regmap. However,
omap_ctrl_read/write() is also used for other register ranges in the
system control module (SCM).

Let's fix the issue by just removing the regmap_read/write() usage for
control module as suggested by Tero Kristo <t-kristo@ti.com>.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -36,7 +36,6 @@
 
 static void __iomem *omap2_ctrl_base;
 static s16 omap2_ctrl_offset;
-static struct regmap *omap2_ctrl_syscon;
 
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 struct omap3_scratchpad {
@@ -166,16 +165,9 @@ u16 omap_ctrl_readw(u16 offset)
 
 u32 omap_ctrl_readl(u16 offset)
 {
-	u32 val;
-
 	offset &= 0xfffc;
-	if (!omap2_ctrl_syscon)
-		val = readl_relaxed(omap2_ctrl_base + offset);
-	else
-		regmap_read(omap2_ctrl_syscon, omap2_ctrl_offset + offset,
-			    &val);
 
-	return val;
+	return readl_relaxed(omap2_ctrl_base + offset);
 }
 
 void omap_ctrl_writeb(u8 val, u16 offset)
@@ -207,11 +199,7 @@ void omap_ctrl_writew(u16 val, u16 offset)
 void omap_ctrl_writel(u32 val, u16 offset)
 {
 	offset &= 0xfffc;
-	if (!omap2_ctrl_syscon)
-		writel_relaxed(val, omap2_ctrl_base + offset);
-	else
-		regmap_write(omap2_ctrl_syscon, omap2_ctrl_offset + offset,
-			     val);
+	writel_relaxed(val, omap2_ctrl_base + offset);
 }
 
 #ifdef CONFIG_ARCH_OMAP3
@@ -715,8 +703,6 @@ int __init omap_control_init(void)
 			if (IS_ERR(syscon))
 				return PTR_ERR(syscon);
 
-			omap2_ctrl_syscon = syscon;
-
 			if (of_get_child_by_name(scm_conf, "clocks")) {
 				ret = omap2_clk_provider_init(scm_conf,
 							      data->index,
@@ -724,9 +710,6 @@ int __init omap_control_init(void)
 				if (ret)
 					return ret;
 			}
-
-			iounmap(omap2_ctrl_base);
-			omap2_ctrl_base = NULL;
 		} else {
 			/* No scm_conf found, direct access */
 			ret = omap2_clk_provider_init(np, data->index, NULL,
