From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 18 Mar 2016 11:19:21 +0100
Subject: [PATCH 2/2] ARM: dts: r8a7779: Correct interrupt type for ARM TWD
In-Reply-To: <1458296361-4468-1-git-send-email-geert+renesas@glider.be>
References: <1458296361-4468-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1458296361-4468-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM TWD interrupt is a private peripheral interrupt (PPI), and per
the ARM GIC documentation, whether the type for PPIs can be set is
IMPLEMENTATION DEFINED.

For R-Car H1 devices the PPI type cannot be set, and so when we attempt
to set the type for the ARM TWD interrupt it fails.  This has gone
unnoticed because it fails silently, and because we cannot re-configure
the type it has had no impact. Nevertheless fix the type for the TWD
interrupt so that it matches the hardware configuration.

Based on patches by Jon Hunter for Tegra20/30 and OMAP4.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Exposed by Jon Hunter's "[PATCH 04/15] irqchip/gic: WARN if setting the
interrupt type fails":

WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-common.c:61 gic_configure_irq+0x64/0x7c()
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.5.0-marzen-00426-g226dd0f378de2fe5-dirty #87
Hardware name: Generic R8A7779 (Flattened Device Tree)
[<c010fb54>] (unwind_backtrace) from [<c010b614>] (show_stack+0x10/0x14)
[<c010b614>] (show_stack) from [<c02f362c>] (dump_stack+0xa4/0xdc)
[<c02f362c>] (dump_stack) from [<c0121d88>] (warn_slowpath_common+0x84/0xb0)
[<c0121d88>] (warn_slowpath_common) from [<c0121e44>] (warn_slowpath_null+0x18/0x20)
[<c0121e44>] (warn_slowpath_null) from [<c03171cc>] (gic_configure_irq+0x64/0x7c)
[<c03171cc>] (gic_configure_irq) from [<c0316878>] (gic_set_type+0x48/0x60)
[<c0316878>] (gic_set_type) from [<c016fa98>] (__irq_set_trigger+0xac/0x17c)
[<c016fa98>] (__irq_set_trigger) from [<c016feac>] (__setup_irq+0x344/0x5d8)
[<c016feac>] (__setup_irq) from [<c017042c>] (request_percpu_irq+0x98/0xe0)
[<c017042c>] (request_percpu_irq) from [<c0804dd8>] (twd_local_timer_common_register+0x38/0x1ac)
[<c0804dd8>] (twd_local_timer_common_register) from [<c0804f94>] (twd_local_timer_of_register+0x48/0x70)
[<c0804f94>] (twd_local_timer_of_register) from [<c081c04c>] (clocksource_probe+0x48/0x88)
[<c081c04c>] (clocksource_probe) from [<c0800b14>] (start_kernel+0x24c/0x3cc)
[<c0800b14>] (start_kernel) from [<6000807c>] (0x6000807c)
---
 arch/arm/boot/dts/r8a7779.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 540f3c57a7b32356..2581363879d9dfff 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -71,7 +71,7 @@
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0xf0000600 0x20>;
 		interrupts = <GIC_PPI 13
-			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
 		clocks = <&cpg_clocks R8A7779_CLK_ZS>;
 	};
 
-- 
1.9.1
