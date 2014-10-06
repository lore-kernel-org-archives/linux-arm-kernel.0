From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue,  7 Oct 2014 01:08:00 +0200
Subject: [PATCH v1 4/5] DON'T MERGE ME: arm: pxa: change clocks init sequence
In-Reply-To: <1412636881-6211-1-git-send-email-robert.jarzmik@free.fr>
References: <1412636881-6211-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1412636881-6211-5-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since pxa clocks were ported to the clock framework, an ordering issue
appears between clocks and clocksource initialization. As a consequence,
the pxa timer clock cannot be acquired in pxa_timer, and is disabled by
clock framework because it is "unused".

The ordering issue is that in the kernel boot sequence :
  start_kernel()
    ...
    time_init()
      -> pxa_timer()
        -> here the clocksource is initialized
    ...
    rest_init()
      kernel_init()
	initcalls
	  -> here the clocks are initialized

In the current sequence, the clocks are initialized way after pxa_timer,
which cannot acquire the OSTIMER0 clock.

To solve this issue, the clocks initialization is moved to pxa_timer(),
so that clocks are initialized before clocksource for non device-tree.
For device-tree, the standard arm time_init() will take care of the
ordering.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/generic.c  | 2 ++
 arch/arm/mach-pxa/generic.h  | 1 +
 drivers/clk/pxa/clk-pxa27x.c | 3 +--
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index 04b013f..4ca801b 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -63,6 +63,8 @@ EXPORT_SYMBOL(get_clock_tick_rate);
  */
 void __init pxa_timer_init(void)
 {
+	if (cpu_is_pxa27x())
+		pxa27x_clocks_init();
 	pxa_timer_nodt_init(IRQ_OST0, io_p2v(0x40a00000),
 			    get_clock_tick_rate());
 }
diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
index 8963984..7fda082 100644
--- a/arch/arm/mach-pxa/generic.h
+++ b/arch/arm/mach-pxa/generic.h
@@ -14,6 +14,7 @@
 struct irq_data;
 
 extern void pxa_timer_init(void);
+extern int pxa27x_clocks_init(void);
 
 extern void __init pxa_map_io(void);
 
diff --git a/drivers/clk/pxa/clk-pxa27x.c b/drivers/clk/pxa/clk-pxa27x.c
index 5f9b54b..2b8343a 100644
--- a/drivers/clk/pxa/clk-pxa27x.c
+++ b/drivers/clk/pxa/clk-pxa27x.c
@@ -362,12 +362,11 @@ static void __init pxa27x_base_clocks_init(void)
 	clk_register_clk_pxa27x_lcd_base();
 }
 
-static int __init pxa27x_clocks_init(void)
+int __init pxa27x_clocks_init(void)
 {
 	pxa27x_base_clocks_init();
 	return clk_pxa_cken_init(pxa27x_clocks, ARRAY_SIZE(pxa27x_clocks));
 }
-postcore_initcall(pxa27x_clocks_init);
 
 static void __init pxa27x_dt_clocks_init(struct device_node *np)
 {
-- 
2.1.0
