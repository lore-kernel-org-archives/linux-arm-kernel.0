From: slash.tmp@free.fr (Mason)
Date: Tue, 22 Sep 2015 16:36:48 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <2206647.QPrIpE2UC0@wuerfel>
References: <56001B78.2090001@free.fr> <2206647.QPrIpE2UC0@wuerfel>
Message-ID: <56016780.5080104@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/09/2015 17:49, Arnd Bergmann wrote:

> On Monday 21 September 2015 17:00:08 Mason wrote:
> 
>> I've been working on an arch/arm port for some time. I've removed
>> a lot of non-essential code, and currently, what I have is:
>>
>> $ git diff --stat v4.2 my4.2
>>  Makefile                                               |    4 +-
>>  arch/arm/Kconfig                                       |   26 ++
>>  arch/arm/Makefile                                      |    1 +
>>  arch/arm/boot/dts/Makefile                             |    1 +
>>  arch/arm/boot/dts/tango.dts                            |   96 ++++++++
>>  arch/arm/kernel/smp_twd.c                              |    3 +-
>>  arch/arm/mach-tangox/Kconfig                           |   57 +++++
>>  arch/arm/mach-tangox/Makefile                          |   10 +
>>  arch/arm/mach-tangox/Makefile.boot                     |    3 +
>>  arch/arm/mach-tangox/clock-tangox.c                    |  134 ++++++++++
>>  arch/arm/mach-tangox/io.c                              |   18 ++
>>  arch/arm/mach-tangox/setup.c                           |   22 ++
>>  arch/arm/tools/mach-types                              |    1 +
>>  drivers/irqchip/Makefile                               |    1 +
>>  drivers/irqchip/irq-tangox.c                           |  234 ++++++++++++++++++
>>  drivers/net/ethernet/Kconfig                           |    1 +
>>  drivers/net/ethernet/Makefile                          |    1 +
>>  drivers/net/ethernet/sigmadesigns/Kconfig              |    7 +
>>  drivers/net/ethernet/sigmadesigns/Makefile             |    5 +
>>  drivers/net/ethernet/sigmadesigns/tangox/Kconfig       |   21 ++
>>  drivers/net/ethernet/sigmadesigns/tangox/Makefile      |    5 +
>>  drivers/net/ethernet/sigmadesigns/tangox/tangox_enet.c | 1158 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/net/ethernet/sigmadesigns/tangox/tangox_enet.h |  257 +++++++++++++++++++
>>  drivers/tty/serial/8250/8250_core.c                    |    8 +-
>>  drivers/tty/serial/of_serial.c                         |    2 +-
>>  25 files changed, 2066 insertions(+), 10 deletions(-)
>>
>> (The two drivers (irqchip and ethernet) are from Mans Rullgard's tree.)
>>
>> TODO
>> Convert the clock registration code to device tree
>> Add PHY ISR to ethernet driver
>>
>>
>> Could you provide some pointers/links and guidance detailing the
>> steps required to submit a new port under arch/arm?
>> (With the current requirements: DT, ARCH_MULTIPLATFORM, etc)
> 
> A few things to be aware of:
> 
> - As you are probably aware, please split the series into multiple patches,
>   doing one thing at a time. A lot of the patches don't have dependencies
>   on one another and can just get merged as soon as they are ready

I'm supposed to use git-format-patch, right?

> [snip advice for drivers]
> - no mach-types changes please

The new way is DT_MACHINE_START?

> - Makefile.boot should not be needed

I'll try removing it altogether.

> - the clock support should probably go to drivers/clk, unless this is
>   a clocksource driver, which should go to drivers/clocksource. Add a
>   DT binding spec. If you lack DT support, don't bother sending it,
>   but send the rest anyway.

I'll take a look at Mans' DT clock code, but I want to simplify it.

> - merge io.c and setup.c into one file

Done.

> - whatever you need in smp_twd.c will have to get merged by Russell,
>   the other patches go through the arm-soc tree.

One change is a temp wart for getting twd_clk until I have proper DT.

The other change is to remove CLOCK_EVT_FEAT_C3STOP for my board.
(We discussed this in May.)

Thanks for your guidance. Just to get the ball rolling, here's
the full platform patch minus drivers.

Open question:

1) arch/arm/Kconfig vs arch/arm/mach-tangox/Kconfig
What goes in the first? What goes in the second?


Regards



diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c5021002fe4..06002e552afd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -758,6 +758,21 @@ config ARCH_OMAP1
 	help
 	  Support for older TI OMAP1 (omap7xx, omap15xx or omap16xx)
 
+config ARCH_TANGOX
+	bool "Sigma Designs Tango"
+	select CLKDEV_LOOKUP
+	select HAVE_CLK
+	select HAVE_SMP
+	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_HAS_CPUFREQ
+	select CLKSRC_MMIO
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_CHIP
+	select ARCH_HAS_HOLES_MEMORYMODEL
+	select SPARSE_IRQ
+	help
+	  Support for Sigma Designs Tango platform.
+
 endchoice
 
 menu "Multiple platform selection"
@@ -896,6 +911,8 @@ source "arch/arm/mach-omap1/Kconfig"
 
 source "arch/arm/mach-omap2/Kconfig"
 
+source "arch/arm/mach-tangox/Kconfig"
+
 source "arch/arm/mach-orion5x/Kconfig"
 
 source "arch/arm/mach-picoxcell/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 7451b447cc2d..54a4453857ad 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -203,6 +203,7 @@ machine-$(CONFIG_ARCH_SOCFPGA)		+= socfpga
 machine-$(CONFIG_ARCH_STI)		+= sti
 machine-$(CONFIG_ARCH_STM32)		+= stm32
 machine-$(CONFIG_ARCH_SUNXI)		+= sunxi
+machine-$(CONFIG_ARCH_TANGOX)		:= tangox
 machine-$(CONFIG_ARCH_TEGRA)		+= tegra
 machine-$(CONFIG_ARCH_U300)		+= u300
 machine-$(CONFIG_ARCH_U8500)		+= ux500
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 246473a244f6..0ac4ed7c267e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1,5 +1,6 @@
 ifeq ($(CONFIG_OF),y)
 
+dtb-$(CONFIG_ARCH_TANGOX) += tango.dtb
 dtb-$(CONFIG_ARCH_ALPINE) += \
 	alpine-db.dtb
 dtb-$(CONFIG_MACH_ASM9260) += \
diff --git a/arch/arm/boot/dts/tango.dts b/arch/arm/boot/dts/tango.dts
new file mode 100644
index 000000000000..de3bf7ccc760
--- /dev/null
+++ b/arch/arm/boot/dts/tango.dts
@@ -0,0 +1,96 @@
+/dts-v1/;
+
+/ {
+	compatible = "sigma,tango4-soc";
+
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	gic: interrupt-controller at 20001000 {
+		compatible = "arm,cortex-a9-gic";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x20001000 0x1000>,
+		      <0x20000100 0x0100>;
+	};
+
+	twd-timer at 20000600 {
+		compatible = "arm,cortex-a9-twd-timer";
+		reg = <0x20000600 0x10>;
+		interrupts = <1 13 0xf01>;
+		interrupt-parent = <&gic>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&irqintc>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		uart0: uart at 10700 {
+			compatible = "ns16550a";
+			reg = <0x10700 0x100>;
+			clock-frequency = <7372800>;
+			reg-shift = <2>;
+			no-loopback-test;
+		};
+
+		eth0: emac at 26000 {
+			compatible = "sigma,smp8640-emac";
+			reg = <0x26000 0x800>;
+			interrupt-parent = <&irqintc>;
+			interrupts = <38 4>;
+			mac-address = [ 00 16 e8 02 08 42 ];
+			phy-connection-type = "rgmii";
+			max-speed = <1000>;
+		};
+	};
+
+	cpublock: cpublock {
+		compatible = "simple-bus";
+		reg = <0x60000 0x10000>;
+		ranges = <0x0 0x60000 0x10000>;
+		interrupt-parent = <&irqintc>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		intc: intc at e000 {
+			compatible = "sigma,tango-intc";
+			reg = <0xe000 0x1000>;
+			ranges = <0x0 0xe000 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			irqintc: irq at 000 {
+				reg = <0x000 0x100>;
+				interrupt-parent = <&gic>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 2 4>;
+				label = "IRQ";
+			};
+
+			fiqintc: fiq at 100 {
+				reg = <0x100 0x100>;
+				interrupt-parent = <&gic>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 3 4>;
+				label = "FIQ";
+			};
+
+			iiqintc: iiq at 300 {
+				reg = <0x300 0x100>;
+				interrupt-parent = <&gic>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 4 4>;
+				label = "IIQ";
+			};
+		};
+	};
+
+};
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 172c6a05d27f..29235f7b02db 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -34,6 +34,7 @@ static unsigned long twd_timer_rate;
 static DEFINE_PER_CPU(bool, percpu_setup_called);
 
 static struct clock_event_device __percpu *twd_evt;
+static int feat_c3stop;
 static int twd_ppi;
 
 static void twd_set_mode(enum clock_event_mode mode,
@@ -245,7 +246,8 @@ static void twd_get_clock(struct device_node *np)
 	int err;
 
 	if (np)
-		twd_clk = of_clk_get(np, 0);
+		//twd_clk = of_clk_get(np, 0);
+		twd_clk = clk_get_sys("smp_twd", NULL);
 	else
 		twd_clk = clk_get_sys("smp_twd", NULL);
 
@@ -294,7 +296,7 @@ static void twd_timer_setup(void)
 
 	clk->name = "local_timer";
 	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
-			CLOCK_EVT_FEAT_C3STOP;
+			feat_c3stop;
 	clk->rating = 350;
 	clk->set_mode = twd_set_mode;
 	clk->set_next_event = twd_set_next_event;
@@ -346,6 +348,8 @@ static int __init twd_local_timer_common_register(struct device_node *np)
 		goto out_irq;
 
 	twd_get_clock(np);
+	if (!of_property_read_bool(np, "twd_never_stops"))
+		feat_c3stop = CLOCK_EVT_FEAT_C3STOP;
 
 	/*
 	 * Immediately configure the timer on the boot CPU, unless we need
diff --git a/arch/arm/mach-tangox/Kconfig b/arch/arm/mach-tangox/Kconfig
new file mode 100644
index 000000000000..aba4eef9227c
--- /dev/null
+++ b/arch/arm/mach-tangox/Kconfig
@@ -0,0 +1,48 @@
+if ARCH_TANGOX
+
+config UNCOMPRESS_INCLUDE
+	string
+	default "debug/uncompress.h"
+
+config ARM_L1_CACHE_SHIFT
+	int
+	default 5
+
+config TANGOX
+	bool
+
+comment "Sigma Designs Tangox options"
+
+menu "Sigma Designs TANGOX Specific Features"
+
+config MACH_TANGOX_87XX
+	bool "Sigma Designs TANGOX 87XX Board"
+	default y
+	depends on ARCH_TANGOX
+	select MIGHT_HAVE_CACHE_L2X0
+	select CPU_V7
+	select ARM_GIC
+	select VFP
+	select SMP
+	select LOCAL_TIMERS if SMP
+	select HAVE_ARM_TWD if SMP
+	select HAVE_ARM_SCU if SMP
+	select PL310_ERRATA_588369
+	select PL310_ERRATA_727915
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_775420
+	select ARCH_HAS_OPP
+	select PM_OPP if PM
+	select USB_ARCH_HAS_EHCI if USB_SUPPORT
+	select ARM_CPU_SUSPEND if PM
+	select CPU_USE_DOMAINS if MMU
+	select COMMON_CLK
+	select TANGOX
+
+config TANGOX_SMC
+	bool "Enable TANGOX secure monitor call operations"
+	default y
+
+endmenu
+
+endif
diff --git a/arch/arm/mach-tangox/Makefile b/arch/arm/mach-tangox/Makefile
new file mode 100644
index 000000000000..cc7f91b05577
--- /dev/null
+++ b/arch/arm/mach-tangox/Makefile
@@ -0,0 +1,7 @@
+obj-y += setup.o
+obj-y += clock-tangox.o
+##obj-$(CONFIG_CACHE_L2X0)	+= l2x0.o
+##obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
+
+##plus_sec := $(call as-instr,.arch_extension sec,+sec)
+##AFLAGS_smc.o :=-Wa,-march=armv7-a$(plus_sec)
diff --git a/arch/arm/mach-tangox/Makefile.boot b/arch/arm/mach-tangox/Makefile.boot
new file mode 100644
index 000000000000..b03e562acc60
--- /dev/null
+++ b/arch/arm/mach-tangox/Makefile.boot
@@ -0,0 +1,3 @@
+  zreladdr-y		+= 0x80008000
+params_phys-y		:= 0x80000100
+initrd_phys-y		:= 0x80800000
diff --git a/arch/arm/mach-tangox/clock-tangox.c b/arch/arm/mach-tangox/clock-tangox.c
new file mode 100644
index 000000000000..505782329c92
--- /dev/null
+++ b/arch/arm/mach-tangox/clock-tangox.c
@@ -0,0 +1,118 @@
+#include <linux/clocksource.h>	/* clocksource_register_khz	*/
+#include <linux/sched_clock.h>	/* sched_clock_register		*/
+#include <linux/clk-provider.h>	/* clk_register_fixed_rate	*/
+#include <linux/clkdev.h>	/* clk_register_clkdev		*/
+#include <linux/delay.h>	/* register_current_timer_delay	*/
+
+#define FAST_RAMP		1
+#define XTAL_FREQ		27000000 /* in Hz */
+#define CLKGEN_BASE		0x10000
+#define SYS_clkgen0_pll		(clkgen_base + 0x00)
+#define SYS_cpuclk_div_ctrl	(clkgen_base + 0x24)
+#define SYS_xtal_in_cnt		(clkgen_base + 0x48)
+
+static void __iomem *clkgen_base;
+
+static unsigned long read_xtal_counter(void)
+{
+	return readl_relaxed(SYS_xtal_in_cnt);
+}
+
+static u64 read_sched_clock(void)
+{
+	return read_xtal_counter();
+}
+
+static cycle_t read_clocksource(struct clocksource *cs)
+{
+	return read_xtal_counter();
+}
+
+static struct clocksource tangox_xtal = {
+	.name	= "tangox_xtal",
+	.rating	= 300,
+	.read	= read_clocksource,
+	.mask	= CLOCKSOURCE_MASK(32),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static struct delay_timer delay_timer = { read_xtal_counter, XTAL_FREQ };
+
+#define pi_alert(format, ...) do {				\
+	static char fmt[] __initdata = KERN_ALERT format;	\
+	printk(fmt, ## __VA_ARGS__);				\
+} while (0)
+
+#define REG(name, ...) union name { struct { u32 __VA_ARGS__; }; u32 val; }
+
+REG(SYS_clkgen_pll, N:7, :6, K:3, M:3, :5, Isel:3, :3, T:1, B:1);
+/*
+ * CG0, CG1, CG2, CG3 PLL Control:
+ * -------------------------------
+ *
+ * |    Byte 3     |    Byte 2     |    Byte 1     |    Byte 0     |
+ * |3 3 2 2 2 2 2 2|2 2 2 2 1 1 1 1|1 1 1 1 1 1    |               |
+ * |1 0 9 8 7 6 5 4|3 2 1 0 9 8 7 6|5 4 3 2 1 0 9 8|7 6 5 4 3 2 1 0|
+ * |-|-|-----|-----|---------|-----|-----|---------|-|-------------|
+ * |B|T|xxxxx|Isel |xxxxxxxxx|  M  |  K  |xxxxxxxxx|x|      N      |
+ * |-|-|-----|-----|---------|-----|-----|---------|-|-------------|
+ *
+ * These registers are used to configure the PLL parameters:
+ *
+ * Bits  6 to  0: N[6:0]. Default = 29
+ * Bits 15 to 13: K[2:0]. Default = 1
+ * Bit  18 to 16: M[2:0]. Default = 0
+ * Bits 26 to 24: Isel[2:0] (PLL Input Select). Default = 1
+ * Bits 30      : T (PLL Test). Default = 0
+ * Bits 31      : B (PLL Bypass). Default = 0
+ *
+ * PLL0 : Out = In * (N+1) / (M+1) / 2^K
+ * PLL1 : Same as PLL0
+ * PLL2 : Same as PLL0
+ * Default values : All PLLs configured to output 405MHz.
+ */
+static void __init tangox_clock_tree_register(void)
+{
+	struct clk *clk;
+	unsigned int mul, div;
+	union SYS_clkgen_pll pll;
+
+	pll.val = readl_relaxed(SYS_clkgen0_pll);
+	mul = pll.N + 1; div = (pll.M + 1) << pll.K;
+	if (pll.Isel != 1) pi_alert("PLL0 source is not XTAL_IN!\n");
+
+	clk = clk_register_fixed_rate(0, "XTAL", 0, CLK_IS_ROOT, XTAL_FREQ);
+	if (!clk) pi_alert("Failed to register %s clk!\n", "XTAL");
+
+	clk = clk_register_fixed_factor(0, "PLL0", "XTAL", 0, mul, div);
+	if (!clk) pi_alert("Failed to register %s clk!\n", "PLL0");
+
+	clk = clk_register_divider(0, "CPU_CLK", "PLL0", 0, SYS_cpuclk_div_ctrl, 8, 8, CLK_DIVIDER_ONE_BASED, 0);
+	if (!clk) pi_alert("Failed to register %s clk!\n", "CPU_CLK");
+	clk_register_clkdev(clk, NULL, "cpu_clk");
+
+	clk = clk_register_fixed_factor(0, "PERIPHCLK", "CPU_CLK", 0, 1, 2);
+	if (!clk) pi_alert("Failed to register %s clk!\n", "PERIPHCLK");
+	clk_register_clkdev(clk, NULL, "smp_twd");
+
+	writel_relaxed(FAST_RAMP << 21 | 1 << 8, SYS_cpuclk_div_ctrl);
+}
+
+void __init tangox_timer_init(void)
+{
+	int err;
+
+	clkgen_base = ioremap(CLKGEN_BASE, 0x100);
+	if (clkgen_base == NULL) return;
+
+	register_current_timer_delay(&delay_timer);
+	sched_clock_register(read_sched_clock, 32, XTAL_FREQ);
+
+	err = clocksource_register_hz(&tangox_xtal, XTAL_FREQ);
+	if (err) pi_alert("Failed to register tangox_xtal clocksource!\n");
+
+	tangox_clock_tree_register();
+
+	of_clk_init(NULL);
+	clocksource_of_init();
+}
diff --git a/arch/arm/mach-tangox/setup.c b/arch/arm/mach-tangox/setup.c
new file mode 100644
index 000000000000..1c694e35558d
--- /dev/null
+++ b/arch/arm/mach-tangox/setup.c
@@ -0,0 +1,34 @@
+#include <asm/mach/map.h>	// iotable_init
+#include <asm/mach/arch.h>	// MACHINE_START
+#include <asm/mach-types.h>	// TANGOX_87XX
+
+#define TANGO_IO_START	0xf0000000
+#define TANGO_IO_SIZE	SZ_16M
+
+static struct map_desc tango_map_desc[] __initdata = {
+	{
+		.virtual	= TANGO_IO_START,
+		.pfn		=__phys_to_pfn(0),
+		.length		= TANGO_IO_SIZE,
+		.type 		= MT_DEVICE,
+	},
+};
+
+static void __init tango_map_io(void)
+{
+	iotable_init(tango_map_desc, ARRAY_SIZE(tango_map_desc));
+}
+
+extern void __init tangox_timer_init(void);
+//extern struct smp_operations tangox_smp_ops;
+
+static const char *tango_dt_compat[] = { "sigma,tango4-soc", NULL };
+
+MACHINE_START(TANGOX_87XX, "TANGOX_87XX")
+	.atag_offset	= 0x100,
+	.init_time	= tangox_timer_init,
+	.map_io		= tango_map_io,
+	//.smp		= &tangox_smp_ops,
+	//.restart	= tango_restart, /*** REQUIRED FOR CLEAN REBOOT ***/
+	.dt_compat	= tango_dt_compat,
+MACHINE_END
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 2ed1b8a922ed..5ffb975d68ea 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -554,6 +554,7 @@ smdk4412		MACH_SMDK4412		SMDK4412		3765
 marzen			MACH_MARZEN		MARZEN			3790
 krome			MACH_KROME		KROME			3797
 armadillo800eva		MACH_ARMADILLO800EVA	ARMADILLO800EVA		3863
+tangox_87xx		MACH_TANGOX_87XX	TANGOX_87XX		3892
 mx53_umobo		MACH_MX53_UMOBO		MX53_UMOBO		3927
 mt4			MACH_MT4		MT4			3981
 u8520			MACH_U8520		U8520			3990
