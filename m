From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Jan 2015 10:36:16 -0800
Subject: [PATCH v4 13/21] ARM: omap: convert wakeupgen to stacked domains
In-Reply-To: <54BFE05E.9080403@arm.com>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
 <1421660655-21394-14-git-send-email-marc.zyngier@arm.com>
 <20150121163031.GR7718@atomide.com> <54BFE05E.9080403@arm.com>
Message-ID: <20150121183615.GS7718@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <marc.zyngier@arm.com> [150121 09:25]:
> On 21/01/15 16:30, Tony Lindgren wrote:
> 
> > I gave this a quick boot test on am437x-gp-evm and the
> > interrupts look OK with the fix also applied:
> > 
> > # cat /proc/interrupts 
> >             CPU0       
> >  16:        657     WUGEN  68  gp_timer
> >  18:          0     WUGEN   9  l3-dbg-irq
> >  19:          0     WUGEN  10  l3-app-irq
> >  20:          5     WUGEN  12  edma
> >  22:          0     WUGEN  14  edma_error
> >  23:         96     WUGEN  72  OMAP UART0
> >  33:          0  44e07000.gpio   6  mmc0
> > 158:         52     WUGEN  70  44e0b000.i2c
> > 159:          0     WUGEN  71  4802a000.i2c
> > 160:         35     WUGEN  64  mmc0
> > 161:          0     WUGEN  40  4a100000.ethernet
> > 162:       7739     WUGEN  41  4a100000.ethernet
> > 163:       7608     WUGEN  42  4a100000.ethernet
> > 164:          0     WUGEN  43  4a100000.ethernet
> > 170:          0     WUGEN 100  gpmc
> > 180:          0     WUGEN   7  tps65218
> > IPI0:          0  CPU wakeup interrupts
> > IPI1:          0  Timer broadcast interrupts
> > IPI2:          0  Rescheduling interrupts
> > IPI3:          0  Function call interrupts
> > IPI4:          0  Single function call interrupts
> > IPI5:          0  CPU stop interrupts
> > IPI6:          0  IRQ work interrupts
> > IPI7:          0  completion interrupts
> > Err:          0
> 
> Interesting. No TWD timer on this one?

Good question, adding Felipe to cc. It eems to be there in
the TRM in "Table 2-3.  L4_PER Peripheral Memory Map" as
MPU_PRV_TIMERS. Also seems to actually work with the
attached patch:

# cat /proc/interrupts 
            CPU0       
 16:          0     WUGEN  67  gp_timer
 17:        529       GIC  29  twd
 18:          0     WUGEN   9  l3-dbg-irq
 19:          0     WUGEN  10  l3-app-irq
 20:          5     WUGEN  12  edma
 22:          0     WUGEN  14  edma_error
 23:        130     WUGEN  72  OMAP UART0
 34:          0  44e07000.gpio   6  mmc0
159:         52     WUGEN  70  44e0b000.i2c
160:          0     WUGEN  71  4802a000.i2c
161:         35     WUGEN  64  mmc0
162:          0     WUGEN  40  4a100000.ethernet
163:       8033     WUGEN  41  4a100000.ethernet
164:       7769     WUGEN  42  4a100000.ethernet
165:          0     WUGEN  43  4a100000.ethernet
171:          0     WUGEN 100  gpmc
181:          0     WUGEN   7  tps65218
IPI0:          0  CPU wakeup interrupts
IPI1:          0  Timer broadcast interrupts
IPI2:          0  Rescheduling interrupts
IPI3:          0  Function call interrupts
IPI4:          0  Single function call interrupts
IPI5:          0  CPU stop interrupts
IPI6:          0  IRQ work interrupts
IPI7:          0  completion interrupts
Err:          0

Hmm I wonder why we have the !is_smp() check in the TWD timer?

Regards,

Tony

8< -------------------
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -51,6 +51,14 @@
 		interrupt-parent = <&gic>;
 	};
 
+	local-timer at 48240600 {
+		compatible = "arm,cortex-a9-twd-timer";
+		clocks = <&dpll_mpu_m2_ck>;
+		reg = <0x48240600 0x20>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupt-parent = <&gic>;
+	};
+
 	wakeupgen: interrupt-controller at 48281000 {
 		compatible = "ti,omap4-wugen-mpu";
 		interrupt-controller;
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -388,7 +388,7 @@ static void __init twd_local_timer_of_register(struct device_node *np)
 {
 	int err;
 
-	if (!is_smp() || !setup_max_cpus)
+	if (!setup_max_cpus)
 		return;
 
 	twd_ppi = irq_of_parse_and_map(np, 0);
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -237,7 +237,7 @@ DT_MACHINE_START(AM43_DT, "Generic AM43 (Flattened Device Tree)")
 	.init_late	= am43xx_init_late,
 	.init_irq	= omap_gic_of_init,
 	.init_machine	= omap_generic_init,
-	.init_time	= omap3_gptimer_timer_init,
+	.init_time	= omap4_local_timer_init,
 	.dt_compat	= am43_boards_compat,
 	.restart	= omap44xx_restart,
 MACHINE_END
