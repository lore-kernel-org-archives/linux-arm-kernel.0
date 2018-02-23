From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Feb 2018 13:00:58 -0800
Subject: [PATCH 10/12] ARM: OMAP2+: Try to parse earlycon from parent too
In-Reply-To: <20180223210100.86732-1-tony@atomide.com>
References: <20180223210100.86732-1-tony@atomide.com>
Message-ID: <20180223210100.86732-11-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With ti-sysc driver the "ti,hwmods" property will be moved to the
interconnect target module instead of the child device. To keep
earlycon working, we need to match against the interconnect target
module in the ti-sysc case.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3492,6 +3492,12 @@ static void __init omap_hwmod_setup_earlycon_flags(void)
 			if (np) {
 				uart = of_get_property(np, "ti,hwmods", NULL);
 				oh = omap_hwmod_lookup(uart);
+				if (!oh) {
+					uart = of_get_property(np->parent,
+							       "ti,hwmods",
+							       NULL);
+					oh = omap_hwmod_lookup(uart);
+				}
 				if (oh)
 					oh->flags |= DEBUG_OMAPUART_FLAGS;
 			}
-- 
2.16.2
