From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: [PATCH v2] ARM: sort the meminfo array earlier
Message-ID: <mailman.142.1316405218.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The meminfo array has to be sorted before sanity_check_meminfo() in
arch/arm/mm/mmu.c is called for it to work properly.  This also allows
for a simpler find_limits() in arch/arm/mm/init.c.

The sort is moved to arch/arm/kernel/setup.c because that's where the
meminfo array is populated.  Eventually this should be improved upon
to make the memory bank parser a bit more robust against problems
such as overlapping memory ranges.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/kernel/setup.c |    8 ++++++++
 arch/arm/mm/init.c      |   38 ++++++++------------------------------
 2 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 70bca649e9..56cd8c351c 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -29,6 +29,7 @@
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
 #include <linux/memblock.h>
+#include <linux/sort.h>
 
 #include <asm/unified.h>
 #include <asm/cpu.h>
@@ -875,6 +876,12 @@ static struct machine_desc * __init setup_machine_tags(unsigned int nr)
 	return mdesc;
 }
 
+static int __init meminfo_cmp(const void *_a, const void *_b)
+{
+	const struct membank *a = _a, *b = _b;
+	long cmp = bank_pfn_start(a) - bank_pfn_start(b);
+	return cmp < 0 ? -1 : cmp > 0 ? 1 : 0;
+}
 
 void __init setup_arch(char **cmdline_p)
 {
@@ -903,6 +910,7 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
+	sort(&meminfo.bank, meminfo.nr_banks, sizeof(meminfo.bank[0]), meminfo_cmp, NULL);
 	sanity_check_meminfo();
 	arm_memblock_init(&meminfo, mdesc);
 
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 91bca355cd..c82a817689 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -19,7 +19,6 @@
 #include <linux/highmem.h>
 #include <linux/gfp.h>
 #include <linux/memblock.h>
-#include <linux/sort.h>
 
 #include <asm/mach-types.h>
 #include <asm/prom.h>
@@ -133,30 +132,18 @@ void show_mem(unsigned int filter)
 }
 
 static void __init find_limits(unsigned long *min, unsigned long *max_low,
-	unsigned long *max_high)
+			       unsigned long *max_high)
 {
 	struct meminfo *mi = &meminfo;
 	int i;
 
-	*min = -1UL;
-	*max_low = *max_high = 0;
-
-	for_each_bank (i, mi) {
-		struct membank *bank = &mi->bank[i];
-		unsigned long start, end;
-
-		start = bank_pfn_start(bank);
-		end = bank_pfn_end(bank);
-
-		if (*min > start)
-			*min = start;
-		if (*max_high < end)
-			*max_high = end;
-		if (bank->highmem)
-			continue;
-		if (*max_low < end)
-			*max_low = end;
-	}
+	/* This assumes the meminfo array is properly sorted */
+	*min = bank_pfn_start(&mi->bank[0]);
+	for_each_bank (i, mi)
+		if (mi->bank[i].highmem)
+				break;
+	*max_low = bank_pfn_end(&mi->bank[i - 1]);
+	*max_high = bank_pfn_end(&mi->bank[mi->nr_banks - 1]);
 }
 
 static void __init arm_bootmem_init(unsigned long start_pfn,
@@ -318,19 +305,10 @@ static void arm_memory_present(void)
 }
 #endif
 
-static int __init meminfo_cmp(const void *_a, const void *_b)
-{
-	const struct membank *a = _a, *b = _b;
-	long cmp = bank_pfn_start(a) - bank_pfn_start(b);
-	return cmp < 0 ? -1 : cmp > 0 ? 1 : 0;
-}
-
 void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
 {
 	int i;
 
-	sort(&meminfo.bank, meminfo.nr_banks, sizeof(meminfo.bank[0]), meminfo_cmp, NULL);
-
 	memblock_init();
 	for (i = 0; i < mi->nr_banks; i++)
 		memblock_add(mi->bank[i].start, mi->bank[i].size);


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.144.1316607142.20020.linux-arm-kernel@lists.infradead.org>

Also the patch series depends on Tero's Irq_chaining patches.
Dependent irq_chaining patches are as below.

3d5b543 omap3: pm: use prcm chain handler
c00b340 OMAP2+: mux: add support for PAD wakeup interrupts
db6397c power: omap-prm: added chain interrupt handler
b3f8628 TEMP: OMAP4xxx: hwmod data: add PRM hwmod
61ec0fc TEMP: OMAP3xxx: hwmod data: add PRM hwmod
a1ecf8c power: add omap prm driver skeleton

Same combination is hosted at:
git://gitorious.org/runtime_3-0/runtime_3-0.git v5_uart_irqchn

Ensure CONFIG_OMAP_PRM is set while testing irq_chaining with uart.

Changes from v4:
---------------

1.) Fixing v4 comments from Kevin.
    Spilt into smaller logical patches.
2.) Using Irq_chaining OMAP_PRM driver for waking up uart.

Testing updates:
----------------
3430SDP:
retention, off_mode, system_wide suspend is tested.
(earlyprintk & no_console_suspend checked)

OMAP3630 - Zoom3:
pm-retention checked with quart/omap-uart3
[Also tested with uart3 as console uart and pm-ret checked]

OMAP4430-SDP: Boot tested.
OMAP2420/2430SDP: Boot tested.

Deepak K (1):
  OMAP2+: UART: Allow UART parameters to be configured from board file.

Govindraj.R (13):
  OMAP2+: hwmod: Add API to enable IO ring wakeup.
  OMAP2+: hwmod: Add API to check IO PAD wakeup status
  OMAP2+: UART: cleanup + remove uart pm specific API
  OMAP2+: UART: cleanup 8250 console driver support
  OMAP2+: UART: Cleanup part of clock gating mechanism for uart
  OMAP2+: UART: Remove certain feilds from omap_uart_state struct
  OMAP2+: UART: Add default mux for all uarts.
  OMAP2+: UART: Store certain reg values to port structure
  OMAP2+: UART: Add runtime pm support for omap-serial driver
  OMAP2+: UART: Move errata handling from serial.c to omap-serial
  OMAP2+: UART: Take console_lock in suspend path if not taken
  OMAP2+: UART: Enable back uart clocks with runtime API for early
    console
  OMAP2+: UART: Do not gate uart clocks if used for debug_prints

Jon Hunter (1):
  OMAP2+: UART: Make the RX_TIMEOUT for DMA configurable for each UART

 arch/arm/mach-omap2/board-3430sdp.c           |  100 +---
 arch/arm/mach-omap2/board-4430sdp.c           |    8 +-
 arch/arm/mach-omap2/board-n8x0.c              |    6 +-
 arch/arm/mach-omap2/board-omap4panda.c        |    8 +-
 arch/arm/mach-omap2/mux.c                     |   30 +
 arch/arm/mach-omap2/mux.h                     |   13 +
 arch/arm/mach-omap2/omap_hwmod.c              |   66 ++
 arch/arm/mach-omap2/pm24xx.c                  |   19 -
 arch/arm/mach-omap2/pm34xx.c                  |   24 -
 arch/arm/mach-omap2/serial.c                  |  933 +++++++------------------
 arch/arm/plat-omap/include/plat/omap-serial.h |   30 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
 arch/arm/plat-omap/include/plat/serial.h      |   11 +-
 drivers/tty/serial/omap-serial.c              |  305 +++++++--
 14 files changed, 654 insertions(+), 900 deletions(-)

-- 
1.7.4.1



>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.145.1316612000.20020.linux-arm-kernel@lists.infradead.org>

wrong thing for functions where the entry point is not at the start of
the function body (or where there are loops or multiple entry points)
-- I expect such instances to be pretty rare though, and this should
never happen for C.

Tricks like this are no good for reconstructing what happened on the
path up to an unexpected event like an exception, though.  This is
possible only when certain assumptions are made and the faulting 
function has a sufficiently simple structure.  This can work most of
the time, but it's hard to make it watertight -- this is one reason why
backtracing in gdb is still far from foolproof.

Alternatively, we would need to use some other frame description format
such as DWARF, which would involve building everything with debug, and
keeping the .debug_frame content (possibly with some filtering/post-
processing).  Unwind annotations in .S files would presumably need to be
rewritten to use the .cfi_ dierctives instead of the ARM-specific
directives in order for this to work everywhere.  Apparently there were
some patches around for using DWARF for backtracing in the kernel some
years ago, but they didn't get merged.



...all of which means that making unwinding work _perfectly_ probably
involves significant pain, at least for Thumb-2.

I guess the question would be: how many failed backtraces are we getting
right now?  Is the current unwinder behaviour "good enough"?

Cheers
---Dave


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.146.1316615078.20020.linux-arm-kernel@lists.infradead.org>

a bit worried that if sp804 is turned into a full driver, it will get
initialised twice -- once explicitly and once in of_platform_populate()...
at least until the baord code is adapted to work properly with the new
driver.

Commenting these entries out for now seemed a good idea to avoid the flag-day
hazard.  Am I being too cautious?

> 
> > +
> > +			// DVI I2C bus (DDC)
> > +			i2c1: i2c at 16000 {
> > +				compatible = "arm,versatile-i2c";
> > +				reg = <0x16000 0x1000>;
> > +
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				edid at 50 {
> > +					compatible = "edid";
> > +					reg = <0x50>;
> > +				};
> > +			};
> > +
> > +			rtc at 17000 {
> > +				compatible = "arm,pl031", "arm,primecell";
> > +				reg = <0x017000 0x1000>;
> > +				interrupts = <4>;
> > +			};
> > +
> > +			compact-flash at 1a000 {
> > +				compatible = "ata-generic";
> > +				reg = <0x1a000 0x100
> > +				       0x1a100 0xf00>;
> > +				reg-shift = <2>;
> > +			};
> > +		};
> > +	};
> > +};
> > diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> > new file mode 100644
> > index 0000000..059be97
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> > @@ -0,0 +1,80 @@
> > +// ARM Ltd. Versatile Express Corex-A9 (Quad Core) Core Tile V2P-CA9 (HBI-0191B)
> > +
> > +/dts-v1/;
> > +
> > +/include/ "skeleton.dtsi"
> > +
> > +/ {
> > +	model = "ARM Versatile Express (Cortex-A9 Quad Core Tile)";
> > +	compatible = "arm,vexpress-v2p-ca9", "arm,vexpress";
> > +	interrupt-parent = <&intc>;
> > +
> > +	memory {
> > +		device_type = "memory";
> > +		reg = <0x60000000 0x40000000>;
> > +	};
> > +
> > +	intc: interrupt-controller at 1e001000 {
> > +		compatible = "arm,cortex-a9-gic";
> > +		#interrupt-cells = <2>;
> > +		#address-cells = <0>;
> > +		interrupt-controller;
> > +		reg = <0x1e001000 0x1000>,
> > +		      <0x1e000100 0x100>;
> > +	};
> 
> Is this really all by itself? It should be in the sub-tree of the
> appropriate bus.

Hmmm, yes.  I guess I got away with this due to not using the proper GIC
bindings yet (and not declaring the other core-tile peripherals).

> You need an "interrupt-parent;" line so the parent is not itself.

Do you mean for the bus?

> 
> > +
> > +	motherboard {
> > +		ranges = <0 0 0x40000000 0x04000000
> > +			  1 0 0x44000000 0x04000000
> > +			  2 0 0x48000000 0x04000000
> > +			  3 0 0x4c000000 0x04000000
> > +			  7 0 0x10000000 0x00020000>;
> > +
> > +		interrupt-map-mask = <0 0 63>;
> > +		interrupt-map = <0 0 0 &intc 32 8

^ This should be ... 4 btw (thanks to Pawel for spotting that)

> > +				 0 0 1 &intc 33 4
> > +				 0 0 2 &intc 34 4
> > +				 0 0 3 &intc 35 4
> > +				 0 0 4 &intc 36 4
> > +				 0 0 5 &intc 37 4
> > +				 0 0 6 &intc 38 4
> > +				 0 0 7 &intc 39 4
> > +				 0 0 8 &intc 40 4
> > +				 0 0 9 &intc 41 4
> > +				 0 0 10 &intc 42 4
> > +				 0 0 11 &intc 43 4
> > +				 0 0 12 &intc 44 4
> > +				 0 0 13 &intc 45 4
> > +				 0 0 14 &intc 46 4
> > +				 0 0 15 &intc 47 4
> > +				 0 0 16 &intc 48 4
> > +				 0 0 17 &intc 49 4
> > +				 0 0 18 &intc 50 4
> > +				 0 0 19 &intc 51 4
> > +				 0 0 20 &intc 52 4
> > +				 0 0 21 &intc 53 4
> > +				 0 0 22 &intc 54 4
> > +				 0 0 23 &intc 55 4
> > +				 0 0 24 &intc 56 4
> > +				 0 0 25 &intc 57 4
> > +				 0 0 26 &intc 58 4
> > +				 0 0 27 &intc 59 4
> > +				 0 0 28 &intc 60 4
> > +				 0 0 29 &intc 61 4
> > +				 0 0 30 &intc 62 4
> > +				 0 0 31 &intc 63 4
> > +				 0 0 32 &intc 64 4
> > +				 0 0 33 &intc 65 4
> > +				 0 0 34 &intc 66 4
> > +				 0 0 35 &intc 67 4
> > +				 0 0 36 &intc 68 4
> > +				 0 0 37 &intc 69 4
> > +				 0 0 38 &intc 70 4
> > +				 0 0 39 &intc 71 4
> > +				 0 0 40 &intc 72 4
> > +				 0 0 41 &intc 73 4
> > +				 0 0 42 &intc 74 4>;
> > +	};
> > +};
> > +
> > +/include/ "vexpress-v2m-legacy.dtsi"
> > diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
> > index f2de51f..6c3c5f6 100644
> > --- a/arch/arm/configs/vexpress_defconfig
> > +++ b/arch/arm/configs/vexpress_defconfig
> > @@ -22,6 +22,7 @@ CONFIG_MODULE_UNLOAD=y
> >  # CONFIG_IOSCHED_DEADLINE is not set
> >  # CONFIG_IOSCHED_CFQ is not set
> >  CONFIG_ARCH_VEXPRESS=y
> > +CONFIG_ARCH_VEXPRESS_ATAGS=y
> >  CONFIG_ARCH_VEXPRESS_CA9X4=y
> >  # CONFIG_SWP_EMULATE is not set
> >  CONFIG_SMP=y
> > diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> > index 9311484..ea64630 100644
> > --- a/arch/arm/mach-vexpress/Kconfig
> > +++ b/arch/arm/mach-vexpress/Kconfig
> > @@ -1,12 +1,55 @@
> >  menu "Versatile Express platform type"
> >  	depends on ARCH_VEXPRESS
> >  
> > +# ARCH_VEXPRESS ensures a sane minimal config is selected by selecting
> > +# ARCH_VEXPRESS_SANE_CONFIG.
> > +# Extend the logic here when adding new core tiles.
> > +
> > +config ARCH_VEXPRESS_SANE_CONFIG
> > +	bool
> > +	select ARCH_VEXPRESS_CA9X4
> > +	select ARCH_VEXPRESS_ATAGS if !ARCH_VEXPRESS_DT
> > +
> > +
> > +comment "At least one boot type must be selected"
> > +
> > +config ARCH_VEXPRESS_ATAGS
> > +	bool "Boot via ATAGs"
> > +	default y
> > +	help
> > +	  This option enables support for the board using the standard
> > +	  ATAGs boot protocol.
> > +
> > +	  If your bootloader supports FDT-based booting and you do not
> > +	  intend ever to boot via the traditional ATAGs method, you can say
> > +	  N here.
> > +
> > +config ARCH_VEXPRESS_DT
> > +	bool "Boot via Device Tree"
> > +	select USE_OF
> > +	help
> > +	  This option enables support for the board, and enables booting
> > +	  via a Flattened Device Tree provided by the bootloader.
> > +
> > +	  If your bootloader supports FDT-based booting, you can say Y
> > +	  here, otherwise, say N.
> > +
> > +
> > +# Core Tile support options
> > +
> > +comment "At least one core tile must be selected"
> > +
> >  config ARCH_VEXPRESS_CA9X4
> > -	bool "Versatile Express Cortex-A9x4 tile"
> > +	bool "Versatile Express Cortex-A9x4 Core Tile"
> > +	default y
> >  	select CPU_V7
> >  	select ARM_GIC
> >  	select ARM_ERRATA_720789
> >  	select ARM_ERRATA_751472
> >  	select ARM_ERRATA_753970
> > +	help
> > +	  Include support for the Cortex-A9x4 Core Tile (HBI-0191B).
> > +
> > +	  If unsure, say Y.
> >  
> >  endmenu
> > diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
> > index bfd32f5..e2fe2c9 100644
> > --- a/arch/arm/mach-vexpress/ct-ca9x4.c
> > +++ b/arch/arm/mach-vexpress/ct-ca9x4.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/amba/bus.h>
> >  #include <linux/amba/clcd.h>
> >  #include <linux/clkdev.h>
> > +#include <linux/irqdomain.h>
> >  
> >  #include <asm/hardware/arm_timer.h>
> >  #include <asm/hardware/cache-l2x0.h>
> > @@ -59,10 +60,16 @@ static void __init ct_ca9x4_map_io(void)
> >  	iotable_init(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
> >  }
> >  
> > +static const struct of_device_id gic_of_match[] __initconst = {
> > +	{ .compatible = "arm,cortex-a9-gic", },
> > +	{}
> > +};
> > +
> >  static void __init ct_ca9x4_init_irq(void)
> >  {
> >  	gic_init(0, 29, MMIO_P2V(A9_MPCORE_GIC_DIST),
> >  		 MMIO_P2V(A9_MPCORE_GIC_CPU));
> > +	irq_domain_generate_simple(gic_of_match, A9_MPCORE_GIC_DIST, 0);
> >  }
> >  
> >  #if 0
> > diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> > index 9e6b93b..6defce6 100644
> > --- a/arch/arm/mach-vexpress/v2m.c
> > +++ b/arch/arm/mach-vexpress/v2m.c
> > @@ -6,6 +6,8 @@
> >  #include <linux/amba/mmci.h>
> >  #include <linux/io.h>
> >  #include <linux/init.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/ata_platform.h>
> >  #include <linux/smsc911x.h>
> > @@ -118,7 +120,7 @@ int v2m_cfg_read(u32 devfn, u32 *data)
> >  	return !!(val & SYS_CFG_ERR);
> >  }
> >  
> > -
> > +#ifdef CONFIG_ARCH_VEXPRESS_ATAGS
> >  static struct resource v2m_pcie_i2c_resource = {
> >  	.start	= V2M_SERIAL_BUS_PCI,
> >  	.end	= V2M_SERIAL_BUS_PCI + SZ_4K - 1,
> > @@ -200,6 +202,7 @@ static struct platform_device v2m_usb_device = {
> >  	.num_resources	= ARRAY_SIZE(v2m_usb_resources),
> >  	.dev.platform_data = &v2m_usb_config,
> >  };
> > +#endif /* CONFIG_ARCH_VEXPRESS_ATAGS */
> >  
> >  static void v2m_flash_set_vpp(struct platform_device *pdev, int on)
> >  {
> > @@ -211,6 +214,7 @@ static struct physmap_flash_data v2m_flash_data = {
> >  	.set_vpp	= v2m_flash_set_vpp,
> >  };
> >  
> > +#ifdef CONFIG_ARCH_VEXPRESS_ATAGS
> >  static struct resource v2m_flash_resources[] = {
> >  	{
> >  		.start	= V2M_NOR0,
> > @@ -254,6 +258,7 @@ static struct platform_device v2m_cf_device = {
> >  	.num_resources	= ARRAY_SIZE(v2m_pata_resources),
> >  	.dev.platform_data = &v2m_pata_data,
> >  };
> > +#endif /* CONFIG_ARCH_VEXPRESS_ATAGS */
> >  
> >  static unsigned int v2m_mmci_status(struct device *dev)
> >  {
> > @@ -265,6 +270,7 @@ static struct mmci_platform_data v2m_mmci_data = {
> >  	.status		= v2m_mmci_status,
> >  };
> >  
> > +#ifdef CONFIG_ARCH_VEXPRESS_ATAGS
> >  static AMBA_DEVICE(aaci,  "mb:aaci",  V2M_AACI, NULL);
> >  static AMBA_DEVICE(mmci,  "mb:mmci",  V2M_MMCI, &v2m_mmci_data);
> >  static AMBA_DEVICE(kmi0,  "mb:kmi0",  V2M_KMI0, NULL);
> > @@ -288,6 +294,7 @@ static struct amba_device *v2m_amba_devs[] __initdata = {
> >  	&wdt_device,
> >  	&rtc_device,
> >  };
> > +#endif /* CONFIG_ARCH_VEXPRESS_ATAGS */
> >  
> >  
> >  static long v2m_osc_round(struct clk *clk, unsigned long rate)
> > @@ -415,6 +422,8 @@ static void __init v2m_init_irq(void)
> >  	ct_desc->init_irq();
> >  }
> >  
> > +
> > +#ifdef CONFIG_ARCH_VEXPRESS_ATAGS
> >  static void __init v2m_init(void)
> >  {
> >  	int i;
> > @@ -443,3 +452,46 @@ MACHINE_START(VEXPRESS, "ARM-Versatile Express")
> >  	.timer		= &v2m_timer,
> >  	.init_machine	= v2m_init,
> >  MACHINE_END
> > +#endif /* CONFIG_ARCH_VEXPRESS_ATAGS */
> > +
> > +#ifdef CONFIG_ARCH_VEXPRESS_DT
> > +struct of_dev_auxdata v2m_dt_auxdata_lookup[] __initdata = {
> > +	OF_DEV_AUXDATA("arm,vexpress-flash", V2M_NOR0, "physmap-flash", &v2m_flash_data),
> > +	OF_DEV_AUXDATA("arm,primecell", V2M_AACI, "mb:aaci", NULL),
> > +	OF_DEV_AUXDATA("arm,primecell", V2M_WDT, "mb:wdt", NULL),
> > +	OF_DEV_AUXDATA("arm,primecell", V2M_MMCI, "mb:mmci", &v2m_mmci_data),
> > +	OF_DEV_AUXDATA("arm,primecell", V2M_KMI0, "mb:kmi0", NULL),
> > +	OF_DEV_AUXDATA("arm,primecell", V2M_KMI1, "mb:kmi1", NULL),
> > +	OF_DEV_AUXDATA("arm,primecell", V2M_UART0, "mb:uart0", NULL),
> > +	OF_DEV_AUXDATA("arm,primecell", V2M_UART1, "mb:uart1", NULL),
> > +	OF_DEV_AUXDATA("arm,primecell", V2M_UART2, "mb:uart2", NULL),
> > +	OF_DEV_AUXDATA("arm,primecell", V2M_UART3, "mb:uart3", NULL),
> > +	OF_DEV_AUXDATA("arm,primecell", V2M_RTC, "mb:rtc", NULL),
> > +	{}
> > +};
> > +
> > +static void __init v2m_dt_init(void)
> > +{
> > +	of_platform_populate(NULL, of_default_bus_match_table,
> > +			     v2m_dt_auxdata_lookup, NULL);
> > +
> > +	pm_power_off = v2m_power_off;
> > +	arm_pm_restart = v2m_restart;
> > +
> > +	ct_desc->init_tile();
> > +}
> > +
> > +static const char *v2m_dt_match[] __initconst = {
> > +	"arm,vexpress",
> > +	NULL,
> > +};
> > +
> > +DT_MACHINE_START(VEXPRESS_DT, "ARM Versatile Express")
> > +	.map_io		= v2m_map_io,
> > +	.init_early	= v2m_init_early,
> > +	.init_irq	= v2m_init_irq,
> > +	.timer		= &v2m_timer,
> > +	.init_machine	= v2m_dt_init,
> > +	.dt_compat	= v2m_dt_match,
> > +MACHINE_END
> > +#endif /* CONFIG_ARCH_VEXPRESS_DT */
> 
> All the ifdefs are really ugly. Most people are creating new board_dt.c
> file and copying over pieces they need. Once DT support is on par with
> the old file, the old file can be deleted.

Would you expect the common code between the DT and non-DT boards to
dwindle away to nothing over time?  I wasn't sure whether we would
get that far.

Agreed regarding the ifdefs -- but I thought it would be better to do
this refactoring in a separate patch which _only_ does the refactoring,
once the functional changes are agreed.

That way the actual functional changes will be clear in the history.
If I try to refactor it ahead of time, I will probably miss some
bits of factoring which turn out to be necessary later, resulting
in extra churn.


If this round of review produces something which feels likely to be
close to the final form, I could propose a refactoring patch to go
on top of it, but I'm wary of doing this prematurely.

Cheers
---Dave


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.149.1316793782.20020.linux-arm-kernel@lists.infradead.org>

- Fixed !GENERIC_HARDIRQS build
- Fixed request_percpu_irq documentation


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.150.1316793783.20020.linux-arm-kernel@lists.infradead.org>

- General tidy-up after Thomas' review. I've kept the config option
  for the time being until we can sort out the anonymous union
  problem.

Marc Zyngier (3):
  genirq: add support for per-cpu dev_id interrupts
  ARM: gic: consolidate PPI handling
  ARM: gic, local timers: use the request_percpu_irq() interface

 arch/arm/common/Kconfig                           |    1 +
 arch/arm/common/gic.c                             |   38 +++-
 arch/arm/include/asm/entry-macro-multi.S          |    7 -
 arch/arm/include/asm/hardirq.h                    |    3 -
 arch/arm/include/asm/hardware/entry-macro-gic.S   |   19 +--
 arch/arm/include/asm/hardware/gic.h               |    1 -
 arch/arm/include/asm/localtimer.h                 |   19 +-
 arch/arm/include/asm/smp.h                        |    5 -
 arch/arm/include/asm/smp_twd.h                    |    2 +-
 arch/arm/kernel/irq.c                             |    3 -
 arch/arm/kernel/smp.c                             |   33 +----
 arch/arm/kernel/smp_twd.c                         |   47 +++++-
 arch/arm/mach-exynos4/include/mach/entry-macro.S  |    6 +-
 arch/arm/mach-exynos4/mct.c                       |    5 -
 arch/arm/mach-msm/board-msm8x60.c                 |   11 -
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   73 +-------
 arch/arm/mach-msm/timer.c                         |   69 ++++---
 arch/arm/mach-omap2/include/mach/entry-macro.S    |   14 +--
 arch/arm/mach-shmobile/entry-intc.S               |    3 -
 arch/arm/mach-shmobile/include/mach/entry-macro.S |    3 -
 include/linux/interrupt.h                         |   40 +++-
 include/linux/irq.h                               |   16 ++-
 include/linux/irqdesc.h                           |    1 +
 kernel/irq/Kconfig                                |    4 +
 kernel/irq/chip.c                                 |   54 ++++++
 kernel/irq/internals.h                            |    2 +
 kernel/irq/irqdesc.c                              |   25 +++
 kernel/irq/manage.c                               |  206 +++++++++++++++++=
+++-
 kernel/irq/settings.h                             |    7 +
 29 files changed, 468 insertions(+), 249 deletions(-)




>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.152.1316873214.20020.linux-arm-kernel@lists.infradead.org>

onwards. I should have been more clear in the description.

Regards,
Simon


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.153.1317034966.20020.linux-arm-kernel@lists.infradead.org>

- Add forgotten patch to make global handler and MULTI_IRQ_HANDLER
  mutually exclusive.
- Introduce handle_IPI(), which is similar to do_IP() and callable
  from C code.

Marc Zyngier (16):
  ARM: Make global handler and CONFIG_MULTI_IRQ_HANDLER mutually
    exclusive
  ARM: smp: Add an IPI handler callable from C code
  ARM: GIC: Add global gic_handle_irq() function
  ARM: RealView: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: VExpress: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: msm: convert SMP platforms to CONFIG_MULTI_IRQ_HANDLER
  ARM: GIC: Add global gic_handle_irq_offset() function
  ARM: exynos4: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: tegra2: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: ux500: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: shmobile: convert smp platforms to gic_handle_irq()
  ARM: cns3xxx: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: zynq: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: omap2/3: Add global omap2/3_intc_handle_irq() functions
  ARM: omap2plus: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: GIC: Make MULTI_IRQ_HANDLER mandatory

 arch/arm/Kconfig                                  |    2 +
 arch/arm/common/Kconfig                           |    1 +
 arch/arm/common/gic.c                             |   49 +++++++-
 arch/arm/include/asm/hardware/entry-macro-gic.S   |   60 ---------
 arch/arm/include/asm/hardware/gic.h               |    3 +-
 arch/arm/include/asm/smp.h                        |    5 +
 arch/arm/kernel/entry-armv.S                      |    7 +-
 arch/arm/kernel/smp.c                             |    5 +
 arch/arm/mach-cns3xxx/cns3420vb.c                 |    2 +
 arch/arm/mach-cns3xxx/include/mach/entry-macro.S  |    2 -
 arch/arm/mach-exynos4/include/mach/entry-macro.S  |   62 ---------
 arch/arm/mach-exynos4/mach-armlex4210.c           |    2 +
 arch/arm/mach-exynos4/mach-nuri.c                 |    2 +
 arch/arm/mach-exynos4/mach-origen.c               |    2 +
 arch/arm/mach-exynos4/mach-smdk4212.c             |    2 +
 arch/arm/mach-exynos4/mach-smdkv310.c             |    2 +
 arch/arm/mach-exynos4/mach-universal_c210.c       |    2 +
 arch/arm/mach-msm/board-msm8960.c                 |    2 +
 arch/arm/mach-msm/board-msm8x60.c                 |    4 +
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   17 ---
 arch/arm/mach-msm/include/mach/entry-macro-vic.S  |   37 ------
 arch/arm/mach-msm/include/mach/entry-macro.S      |   27 ++++-
 arch/arm/mach-omap2/Kconfig                       |    2 +
 arch/arm/mach-omap2/board-2430sdp.c               |    1 +
 arch/arm/mach-omap2/board-3430sdp.c               |    1 +
 arch/arm/mach-omap2/board-3630sdp.c               |    1 +
 arch/arm/mach-omap2/board-4430sdp.c               |    2 +
 arch/arm/mach-omap2/board-am3517crane.c           |    1 +
 arch/arm/mach-omap2/board-am3517evm.c             |    1 +
 arch/arm/mach-omap2/board-apollon.c               |    1 +
 arch/arm/mach-omap2/board-cm-t35.c                |    2 +
 arch/arm/mach-omap2/board-cm-t3517.c              |    1 +
 arch/arm/mach-omap2/board-devkit8000.c            |    1 +
 arch/arm/mach-omap2/board-generic.c               |    1 +
 arch/arm/mach-omap2/board-h4.c                    |    1 +
 arch/arm/mach-omap2/board-igep0020.c              |    2 +
 arch/arm/mach-omap2/board-ldp.c                   |    1 +
 arch/arm/mach-omap2/board-n8x0.c                  |    3 +
 arch/arm/mach-omap2/board-omap3beagle.c           |    1 +
 arch/arm/mach-omap2/board-omap3evm.c              |    1 +
 arch/arm/mach-omap2/board-omap3logic.c            |    2 +
 arch/arm/mach-omap2/board-omap3pandora.c          |    1 +
 arch/arm/mach-omap2/board-omap3stalker.c          |    1 +
 arch/arm/mach-omap2/board-omap3touchbook.c        |    1 +
 arch/arm/mach-omap2/board-omap4panda.c            |    2 +
 arch/arm/mach-omap2/board-overo.c                 |    1 +
 arch/arm/mach-omap2/board-rm680.c                 |    1 +
 arch/arm/mach-omap2/board-rx51.c                  |    1 +
 arch/arm/mach-omap2/board-zoom.c                  |    2 +
 arch/arm/mach-omap2/include/mach/entry-macro.S    |  137 -----------------=
----
 arch/arm/mach-omap2/irq.c                         |   49 ++++++++
 arch/arm/mach-pxa/include/mach/entry-macro.S      |   36 ------
 arch/arm/mach-realview/include/mach/entry-macro.S |    2 -
 arch/arm/mach-realview/realview_eb.c              |    1 +
 arch/arm/mach-realview/realview_pb1176.c          |    1 +
 arch/arm/mach-realview/realview_pb11mp.c          |    1 +
 arch/arm/mach-realview/realview_pba8.c            |    1 +
 arch/arm/mach-realview/realview_pbx.c             |    1 +
 arch/arm/mach-shmobile/Makefile                   |    1 -
 arch/arm/mach-shmobile/board-ag5evm.c             |    2 +-
 arch/arm/mach-shmobile/entry-gic.S                |   18 ---
 arch/arm/mach-shmobile/include/mach/common.h      |    1 -
 arch/arm/mach-shmobile/include/mach/entry-macro.S |    9 --
 arch/arm/mach-tegra/board-dt.c                    |    2 +
 arch/arm/mach-tegra/board-harmony.c               |    2 +
 arch/arm/mach-tegra/board-paz00.c                 |    2 +
 arch/arm/mach-tegra/board-seaboard.c              |    4 +
 arch/arm/mach-tegra/board-trimslice.c             |    2 +
 arch/arm/mach-tegra/include/mach/entry-macro.S    |   22 +---
 arch/arm/mach-ux500/board-mop500.c                |    4 +
 arch/arm/mach-ux500/board-u5500.c                 |    2 +
 arch/arm/mach-ux500/include/mach/entry-macro.S    |    2 -
 arch/arm/mach-vexpress/include/mach/entry-macro.S |    2 -
 arch/arm/mach-vexpress/v2m.c                      |    2 +
 arch/arm/mach-zynq/common.c                       |    1 +
 arch/arm/mach-zynq/include/mach/entry-macro.S     |    3 -
 arch/arm/plat-omap/include/plat/irqs.h            |    2 +
 77 files changed, 225 insertions(+), 420 deletions(-)
 delete mode 100644 arch/arm/include/asm/hardware/entry-macro-gic.S
 delete mode 100644 arch/arm/mach-msm/include/mach/entry-macro-qgic.S
 delete mode 100644 arch/arm/mach-msm/include/mach/entry-macro-vic.S
 delete mode 100644 arch/arm/mach-shmobile/entry-gic.S




>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.157.1317201260.20020.linux-arm-kernel@lists.infradead.org>

prototype.

With the patch 'ARM: l2x0: add empty l2x0_of_init' applied, the code
compiles even without CONFIG_CACHE_L2X0 enabled.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Makefile     |    1 -
 arch/arm/mach-imx/cache-l2x0.c |   56 ----------------------------------------
 arch/arm/mach-imx/mm-imx3.c    |   38 +++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 57 deletions(-)
 delete mode 100644 arch/arm/mach-imx/cache-l2x0.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index fb5dfd5..aba7321 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_SOC_IMX27) += clock-imx27.o mm-imx27.o ehci-imx27.o
 
 obj-$(CONFIG_SOC_IMX31) += mm-imx3.o cpu-imx31.o clock-imx31.o iomux-imx31.o ehci-imx31.o
 obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clock-imx35.o ehci-imx35.o
-obj-$(CONFIG_CACHE_L2X0) += cache-l2x0.o
 
 # Support for CMOS sensor interface
 obj-$(CONFIG_MX1_VIDEO) += mx1-camera-fiq.o mx1-camera-fiq-ksym.o
diff --git a/arch/arm/mach-imx/cache-l2x0.c b/arch/arm/mach-imx/cache-l2x0.c
deleted file mode 100644
index e5538a4..0000000
--- a/arch/arm/mach-imx/cache-l2x0.c
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * Copyright (C) 2009-2010 Pengutronix
- * Sascha Hauer <s.hauer@pengutronix.de>
- * Juergen Beisert <j.beisert@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or modify it under
- * the terms of the GNU General Public License version 2 as published by the
- * Free Software Foundation.
- */
-
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/kernel.h>
-
-#include <asm/hardware/cache-l2x0.h>
-
-#include <mach/hardware.h>
-
-static int mxc_init_l2x0(void)
-{
-	void __iomem *l2x0_base;
-	void __iomem *clkctl_base;
-
-	if (!cpu_is_mx31() && !cpu_is_mx35())
-		return 0;
-
-/*
- * First of all, we must repair broken chip settings. There are some
- * i.MX35 CPUs in the wild, comming with bogus L2 cache settings. These
- * misconfigured CPUs will run amok immediately when the L2 cache gets enabled.
- * Workaraound is to setup the correct register setting prior enabling the
- * L2 cache. This should not hurt already working CPUs, as they are using the
- * same value.
- */
-#define L2_MEM_VAL 0x10
-
-	clkctl_base = ioremap(MX35_CLKCTL_BASE_ADDR, 4096);
-	if (clkctl_base != NULL) {
-		writel(0x00000515, clkctl_base + L2_MEM_VAL);
-		iounmap(clkctl_base);
-	} else {
-		pr_err("L2 cache: Cannot fix timing. Trying to continue without\n");
-	}
-
-	l2x0_base = ioremap(MX3x_L2CC_BASE_ADDR, 4096);
-	if (IS_ERR(l2x0_base)) {
-		printk(KERN_ERR "remapping L2 cache area failed with %ld\n",
-				PTR_ERR(l2x0_base));
-		return 0;
-	}
-
-	l2x0_init(l2x0_base, 0x00030024, 0x00000000);
-
-	return 0;
-}
-early_initcall(mxc_init_l2x0);
diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index e06eed1..ffa33b4 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 
 #include <asm/pgtable.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/map.h>
 
 #include <mach/common.h>
@@ -29,6 +30,39 @@
 #include <mach/iomux-v3.h>
 #include <mach/irqs.h>
 
+void imx3_init_l2x0(void)
+{
+	void __iomem *l2x0_base;
+	void __iomem *clkctl_base;
+
+/*
+ * First of all, we must repair broken chip settings. There are some
+ * i.MX35 CPUs in the wild, comming with bogus L2 cache settings. These
+ * misconfigured CPUs will run amok immediately when the L2 cache gets enabled.
+ * Workaraound is to setup the correct register setting prior enabling the
+ * L2 cache. This should not hurt already working CPUs, as they are using the
+ * same value.
+ */
+#define L2_MEM_VAL 0x10
+
+	clkctl_base = ioremap(MX35_CLKCTL_BASE_ADDR, 4096);
+	if (clkctl_base != NULL) {
+		writel(0x00000515, clkctl_base + L2_MEM_VAL);
+		iounmap(clkctl_base);
+	} else {
+		pr_err("L2 cache: Cannot fix timing. Trying to continue without\n");
+	}
+
+	l2x0_base = ioremap(MX3x_L2CC_BASE_ADDR, 4096);
+	if (IS_ERR(l2x0_base)) {
+		printk(KERN_ERR "remapping L2 cache area failed with %ld\n",
+				PTR_ERR(l2x0_base));
+		return;
+	}
+
+	l2x0_init(l2x0_base, 0x00030024, 0x00000000);
+}
+
 static struct map_desc mx31_io_desc[] __initdata = {
 	imx_map_entry(MX31, X_MEMC, MT_DEVICE),
 	imx_map_entry(MX31, AVIC, MT_DEVICE_NONSHARED),
@@ -102,6 +136,8 @@ void __init imx31_soc_init(void)
 {
 	int to_version = mx31_revision() >> 4;
 
+	imx3_init_l2x0();
+
 	mxc_register_gpio("imx31-gpio", 0, MX31_GPIO1_BASE_ADDR, SZ_16K, MX31_INT_GPIO1, 0);
 	mxc_register_gpio("imx31-gpio", 1, MX31_GPIO2_BASE_ADDR, SZ_16K, MX31_INT_GPIO2, 0);
 	mxc_register_gpio("imx31-gpio", 2, MX31_GPIO3_BASE_ADDR, SZ_16K, MX31_INT_GPIO3, 0);
@@ -154,6 +190,8 @@ void __init imx35_soc_init(void)
 {
 	int to_version = mx35_revision() >> 4;
 
+	imx3_init_l2x0();
+
 	/* i.mx35 has the i.mx31 type gpio */
 	mxc_register_gpio("imx31-gpio", 0, MX35_GPIO1_BASE_ADDR, SZ_16K, MX35_INT_GPIO1, 0);
 	mxc_register_gpio("imx31-gpio", 1, MX35_GPIO2_BASE_ADDR, SZ_16K, MX35_INT_GPIO2, 0);
-- 
1.7.4.1



>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.158.1317311243.20020.linux-arm-kernel@lists.infradead.org>

from Colin used braces, and from there it's likely that everyone just
copied and pasted -- I know that's what I did.

Thanks for catching it, Russell, it had obviously completely gone
unnoticed by me and others.

I'll fix up the rest of the file. Peter -- no need to respin, I'll fix
up when I apply.


-Olof


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.159.1317380486.20020.linux-arm-kernel@lists.infradead.org>

Also the patch series depends on Tero's v9 Irq_chaining patches.
Dependent irq_chaining patches are as below.

e9e7ae1 omap3+: add omap prm driver initialization
e52486f OMAP3: pm: do not enable PRCM MPU interrupts manually
ae5f2af omap3: pm: use prcm chain handler
61ad50f OMAP2+: mux: add support for PAD wakeup interrupts
cab47bf mfd: omap-prm: added suspend prepare and complete callbacks
8ed5bcd mfd: omap-prm: added chain interrupt handler
024f0e3 mfd: omap-prm: add driver skeleton
d285827 TEMP: OMAP4xxx: hwmod data: add PRM hwmod
da6f48f TEMP: OMAP3xxx: hwmod data: add PRM hwmod

Same combination is hosted at:
git://gitorious.org/runtime_3-0/runtime_3-0.git v6_uart_runtime

Ensure CONFIG_OMAP_PRM is set while testing irq_chaining with uart.

Changes from v5:
---------------
* Incorporating omap_uart_can_sleep function to avoid
  console sluglishness as reported by tero.
* fixing below comments adding omap4 for autosuspend and wakeup.
  http://www.mail-archive.com/linux-omap at vger.kernel.org/msg56221.html

  In addition cleaning up pads from omap4430sdp/panda board file
  to use default pads from serial.c

Changes from v4:
---------------

1.) Fixing v4 comments from Kevin.
    Spilt into smaller logical patches.
2.) Using Irq_chaining OMAP_PRM driver for waking up uart.

Testing updates:
----------------
OMAP2420/2430SDP: Boot tested.

OMAP3430SDP:
retention, off_mode, system_wide suspend is tested.
(earlyprintk & no_console_suspend checked)

OMAP3630 - Zoom3:
pm-retention checked with quart/omap-uart3
[Also tested with uart3 as console uart and pm-ret checked]

BeagleBoard XM Rev C(3630):
retention, off_mode, system_wide suspend is tested.

OMAP4430-SDP/PANDA-4430/PANDA-4460: Boot tested.

Deepak K (1):
  OMAP2+: UART: Allow UART parameters to be configured from board file.

Govindraj.R (14):
  OMAP2+: hwmod: Add API to enable IO ring wakeup.
  OMAP2+: hwmod: Add API to check IO PAD wakeup status
  OMAP2+: UART: cleanup + remove uart pm specific API
  OMAP2+: UART: cleanup 8250 console driver support
  OMAP2+: UART: Cleanup part of clock gating mechanism for uart
  OMAP2+: UART: Remove certain feilds from omap_uart_state struct
  OMAP2+: UART: Add default mux for all uarts.
  OMAP2+: UART: Store certain reg values to port structure
  OMAP2+: UART: Add runtime pm support for omap-serial driver
  OMAP2+: UART: Modify omap_uart_can_sleep function
  OMAP2+: UART: Move errata handling from serial.c to omap-serial
  OMAP2+: UART: Take console_lock in suspend path if not taken
  OMAP2+: UART: Enable back uart clocks with runtime API for early
    console
  OMAP2+: UART: Do not gate uart clocks if used for debug_prints

Jon Hunter (1):
  OMAP2+: UART: Make the RX_TIMEOUT for DMA configurable for each UART

 arch/arm/mach-omap2/board-3430sdp.c           |  100 +---
 arch/arm/mach-omap2/board-4430sdp.c           |   68 +--
 arch/arm/mach-omap2/board-n8x0.c              |    6 +-
 arch/arm/mach-omap2/board-omap4panda.c        |   68 +--
 arch/arm/mach-omap2/mux.c                     |   30 +
 arch/arm/mach-omap2/mux.h                     |   13 +
 arch/arm/mach-omap2/omap_hwmod.c              |   66 ++
 arch/arm/mach-omap2/pm24xx.c                  |   18 -
 arch/arm/mach-omap2/pm34xx.c                  |   23 -
 arch/arm/mach-omap2/serial.c                  |  937 +++++++------------------
 arch/arm/plat-omap/include/plat/omap-serial.h |   30 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
 arch/arm/plat-omap/include/plat/serial.h      |   10 +-
 drivers/tty/serial/omap-serial.c              |  305 +++++++--
 14 files changed, 660 insertions(+), 1015 deletions(-)

-- 
1.7.4.1



>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.164.1317661438.20020.linux-arm-kernel@lists.infradead.org>

- enable_percpu_irq() now takes trigger information, which is useful
  to MSM (this platform has configurable triggers on PPIs).
- More tidy-ups (cpumask allocation, more checks to make sure the API
  is used in a consistent way)
- The configuration option is gone in order to thrash out any problem
  as soon as possible


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.165.1317661439.20020.linux-arm-kernel@lists.infradead.org>

- Fixed !GENERIC_HARDIRQS build
- Fixed request_percpu_irq documentation


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.166.1317661439.20020.linux-arm-kernel@lists.infradead.org>

- General tidy-up after Thomas' review. I've kept the config option
  for the time being until we can sort out the anonymous union
  problem.

Marc Zyngier (4):
  genirq: Add support for per-cpu dev_id interrupts
  genirq: percpu: allow interrupt type to be set at enable time
  ARM: gic: consolidate PPI handling
  ARM: gic, local timers: use the request_percpu_irq() interface

 arch/arm/common/Kconfig                           |    1 +
 arch/arm/common/gic.c                             |   38 +++-
 arch/arm/include/asm/entry-macro-multi.S          |    7 -
 arch/arm/include/asm/hardirq.h                    |    3 -
 arch/arm/include/asm/hardware/entry-macro-gic.S   |   19 +--
 arch/arm/include/asm/hardware/gic.h               |    1 -
 arch/arm/include/asm/localtimer.h                 |   19 +-
 arch/arm/include/asm/smp.h                        |    5 -
 arch/arm/include/asm/smp_twd.h                    |    2 +-
 arch/arm/kernel/irq.c                             |    3 -
 arch/arm/kernel/smp.c                             |   33 +---
 arch/arm/kernel/smp_twd.c                         |   47 +++++-
 arch/arm/mach-exynos4/include/mach/entry-macro.S  |    6 +-
 arch/arm/mach-exynos4/mct.c                       |    5 -
 arch/arm/mach-msm/board-msm8x60.c                 |   11 -
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   73 +-------
 arch/arm/mach-msm/timer.c                         |   69 ++++---
 arch/arm/mach-omap2/include/mach/entry-macro.S    |   14 +--
 arch/arm/mach-shmobile/entry-intc.S               |    3 -
 arch/arm/mach-shmobile/include/mach/entry-macro.S |    3 -
 include/linux/interrupt.h                         |   38 +++-
 include/linux/irq.h                               |   16 ++-
 include/linux/irqdesc.h                           |    1 +
 kernel/irq/chip.c                                 |   64 ++++++-
 kernel/irq/internals.h                            |   19 ++-
 kernel/irq/irqdesc.c                              |   32 +++-
 kernel/irq/manage.c                               |  215 +++++++++++++++++=
+++-
 kernel/irq/settings.h                             |    7 +
 28 files changed, 487 insertions(+), 267 deletions(-)




>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.167.1317663347.20020.linux-arm-kernel@lists.infradead.org>

- Converted all SMP platforms
- Added some cleanup as a last patch


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.168.1317663347.20020.linux-arm-kernel@lists.infradead.org>

- Split the SMP ops between init and runtime operations in order to
  have separate lifetimes for the different structures. This is not
  perfect though, as it still allows an __init function to make it to
  a runtime structure (all smp_*_ops structures are __initdata in
  order to be able to discard them). Thanks to Nico for pointing this
  out.
- Use macros to hide the #ifdef-ery in the SoC descriptor init,
  courtesy of Arnd.


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.169.1317663347.20020.linux-arm-kernel@lists.infradead.org>

- Move the SMP ops out of the descriptor, which makes the structure
  init a bit cleaner (thanks to Arnd).
- Mark all structures __initdata and keep a copy of the used ones.
- Keep a global pointer for the SMP ops.

Marc Zyngier (10):
  ARM: SoC: Introduce per SoC descriptor
  ARM: SoC: Add per SoC SMP and CPU hotplug operations
  ARM: SoC: convert VExpress/RealView to SoC descriptor
  ARM: SoC: convert OMAP4 to SoC descriptor
  ARM: SoC: convert Tegra to SoC descriptor
  ARM: SoC: convert Exynos4 to SoC descriptor
  ARM: SoC: convert MSM SMP to SoC descriptor
  ARM: SoC: convert ux500 to SoC descriptor
  ARM: SoC: convert shmobile sh73a0 to SoC descriptor
  ARM: smp: Make SoC descriptor mandatory for SMP platforms

 arch/arm/include/asm/mach/arch.h                |    2 +
 arch/arm/include/asm/smp.h                      |   15 -----
 arch/arm/include/asm/soc.h                      |   65 +++++++++++++++++++=
+++
 arch/arm/kernel/setup.c                         |   30 ++++++++++
 arch/arm/kernel/smp.c                           |   51 ++++++++++++++++-
 arch/arm/mach-exynos4/core.h                    |    9 +++
 arch/arm/mach-exynos4/cpu.c                     |    8 +++
 arch/arm/mach-exynos4/hotplug.c                 |    8 ++-
 arch/arm/mach-exynos4/mach-armlex4210.c         |    3 +
 arch/arm/mach-exynos4/mach-nuri.c               |    3 +
 arch/arm/mach-exynos4/mach-origen.c             |    3 +
 arch/arm/mach-exynos4/mach-smdk4212.c           |    3 +
 arch/arm/mach-exynos4/mach-smdkv310.c           |    4 +
 arch/arm/mach-exynos4/mach-universal_c210.c     |    3 +
 arch/arm/mach-exynos4/platsmp.c                 |   25 +++++++-
 arch/arm/mach-msm/Makefile                      |    2 +-
 arch/arm/mach-msm/board-msm8960.c               |    3 +
 arch/arm/mach-msm/board-msm8x60.c               |    7 ++
 arch/arm/mach-msm/core.c                        |   17 ++++++
 arch/arm/mach-msm/core.h                        |    9 +++
 arch/arm/mach-msm/hotplug.c                     |    8 ++-
 arch/arm/mach-msm/platsmp.c                     |   24 +++++++-
 arch/arm/mach-omap2/board-4430sdp.c             |    1 +
 arch/arm/mach-omap2/board-omap4panda.c          |    1 +
 arch/arm/mach-omap2/include/mach/omap4-common.h |   14 +++++
 arch/arm/mach-omap2/omap-hotplug.c              |    6 +-
 arch/arm/mach-omap2/omap-smp.c                  |   24 +++++++-
 arch/arm/mach-omap2/omap4-common.c              |    7 ++
 arch/arm/mach-realview/core.c                   |    7 ++
 arch/arm/mach-realview/core.h                   |    9 +++
 arch/arm/mach-realview/hotplug.c                |    6 +-
 arch/arm/mach-realview/platsmp.c                |   24 +++++++-
 arch/arm/mach-realview/realview_eb.c            |    1 +
 arch/arm/mach-realview/realview_pb1176.c        |    1 +
 arch/arm/mach-realview/realview_pb11mp.c        |    1 +
 arch/arm/mach-realview/realview_pba8.c          |    1 +
 arch/arm/mach-realview/realview_pbx.c           |    1 +
 arch/arm/mach-shmobile/Makefile                 |    2 +-
 arch/arm/mach-shmobile/board-ag5evm.c           |    1 +
 arch/arm/mach-shmobile/hotplug.c                |    8 ++-
 arch/arm/mach-shmobile/include/mach/common.h    |    7 +-
 arch/arm/mach-shmobile/include/mach/sh73a0.h    |    6 ++
 arch/arm/mach-shmobile/platsmp.c                |   68 -------------------=
----
 arch/arm/mach-shmobile/setup-sh73a0.c           |    6 ++
 arch/arm/mach-shmobile/smp-sh73a0.c             |   35 ++++++++++-
 arch/arm/mach-tegra/board-dt.c                  |    2 +
 arch/arm/mach-tegra/board-harmony.c             |    2 +
 arch/arm/mach-tegra/board-paz00.c               |    2 +
 arch/arm/mach-tegra/board-seaboard.c            |    4 +
 arch/arm/mach-tegra/board-trimslice.c           |    2 +
 arch/arm/mach-tegra/common.c                    |    8 +++
 arch/arm/mach-tegra/common.h                    |   11 ++++
 arch/arm/mach-tegra/hotplug.c                   |    6 +-
 arch/arm/mach-tegra/platsmp.c                   |   26 +++++++-
 arch/arm/mach-ux500/board-mop500.c              |    3 +
 arch/arm/mach-ux500/board-u5500.c               |    1 +
 arch/arm/mach-ux500/hotplug.c                   |    8 ++-
 arch/arm/mach-ux500/include/mach/setup.h        |    9 +++
 arch/arm/mach-ux500/platsmp.c                   |   23 ++++++-
 arch/arm/mach-vexpress/core.h                   |   10 +++
 arch/arm/mach-vexpress/hotplug.c                |    6 +-
 arch/arm/mach-vexpress/platsmp.c                |   24 +++++++-
 arch/arm/mach-vexpress/v2m.c                    |    9 +++
 arch/arm/plat-versatile/include/plat/platsmp.h  |   14 +++++
 arch/arm/plat-versatile/platsmp.c               |    4 +-
 65 files changed, 564 insertions(+), 149 deletions(-)
 create mode 100644 arch/arm/include/asm/soc.h
 create mode 100644 arch/arm/mach-exynos4/core.h
 create mode 100644 arch/arm/mach-msm/core.c
 create mode 100644 arch/arm/mach-msm/core.h
 delete mode 100644 arch/arm/mach-shmobile/platsmp.c
 create mode 100644 arch/arm/mach-tegra/common.h
 create mode 100644 arch/arm/plat-versatile/include/plat/platsmp.h




>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.174.1318255396.20020.linux-arm-kernel@lists.infradead.org>

- Added an SMP registration interface and moved all SMP structures to
  smp.c. The end result is much cleaner.
- Cleaned up patch 2 (left overse from a previous rework)
- NVIDIA/EXYNOS4 naming cleanup.


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.175.1318255397.20020.linux-arm-kernel@lists.infradead.org>

- Converted all SMP platforms
- Added some cleanup as a last patch


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.176.1318255397.20020.linux-arm-kernel@lists.infradead.org>

- Split the SMP ops between init and runtime operations in order to
  have separate lifetimes for the different structures. This is not
  perfect though, as it still allows an __init function to make it to
  a runtime structure (all smp_*_ops structures are __initdata in
  order to be able to discard them). Thanks to Nico for pointing this
  out.
- Use macros to hide the #ifdef-ery in the SoC descriptor init,
  courtesy of Arnd.


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.177.1318255397.20020.linux-arm-kernel@lists.infradead.org>

- Move the SMP ops out of the descriptor, which makes the structure
  init a bit cleaner (thanks to Arnd).
- Mark all structures __initdata and keep a copy of the used ones.
- Keep a global pointer for the SMP ops.

Marc Zyngier (10):
  ARM: SoC: Introduce per SoC descriptor
  ARM: SoC: Add per SoC SMP and CPU hotplug operations
  ARM: SoC: convert VExpress/RealView to SoC descriptor
  ARM: SoC: convert OMAP4 to SoC descriptor
  ARM: SoC: convert Tegra to SoC descriptor
  ARM: SoC: convert Exynos4 to SoC descriptor
  ARM: SoC: convert MSM SMP to SoC descriptor
  ARM: SoC: convert ux500 to SoC descriptor
  ARM: SoC: convert shmobile sh73a0 to SoC descriptor
  ARM: smp: Make SoC descriptor mandatory for SMP platforms

 arch/arm/include/asm/mach/arch.h                |    2 +
 arch/arm/include/asm/smp.h                      |   15 -----
 arch/arm/include/asm/soc.h                      |   64 +++++++++++++++++++=
+
 arch/arm/kernel/setup.c                         |    8 +++
 arch/arm/kernel/smp.c                           |   73 +++++++++++++++++++=
+++-
 arch/arm/mach-exynos4/core.h                    |   14 ++++
 arch/arm/mach-exynos4/cpu.c                     |    8 +++
 arch/arm/mach-exynos4/hotplug.c                 |    8 ++-
 arch/arm/mach-exynos4/mach-armlex4210.c         |    3 +
 arch/arm/mach-exynos4/mach-nuri.c               |    3 +
 arch/arm/mach-exynos4/mach-origen.c             |    3 +
 arch/arm/mach-exynos4/mach-smdk4x12.c           |    4 +
 arch/arm/mach-exynos4/mach-smdkv310.c           |    4 +
 arch/arm/mach-exynos4/mach-universal_c210.c     |    3 +
 arch/arm/mach-exynos4/platsmp.c                 |   25 +++++++-
 arch/arm/mach-msm/Makefile                      |    2 +-
 arch/arm/mach-msm/board-msm8960.c               |    3 +
 arch/arm/mach-msm/board-msm8x60.c               |    7 ++
 arch/arm/mach-msm/core.c                        |   17 +++++
 arch/arm/mach-msm/core.h                        |    9 +++
 arch/arm/mach-msm/hotplug.c                     |    8 ++-
 arch/arm/mach-msm/platsmp.c                     |   24 ++++++-
 arch/arm/mach-omap2/board-4430sdp.c             |    1 +
 arch/arm/mach-omap2/board-omap4panda.c          |    1 +
 arch/arm/mach-omap2/include/mach/omap4-common.h |   14 ++++
 arch/arm/mach-omap2/omap-hotplug.c              |    6 +-
 arch/arm/mach-omap2/omap-smp.c                  |   24 ++++++-
 arch/arm/mach-omap2/omap4-common.c              |    7 ++
 arch/arm/mach-realview/core.c                   |    7 ++
 arch/arm/mach-realview/core.h                   |    9 +++
 arch/arm/mach-realview/hotplug.c                |    6 +-
 arch/arm/mach-realview/platsmp.c                |   24 ++++++-
 arch/arm/mach-realview/realview_eb.c            |    1 +
 arch/arm/mach-realview/realview_pb1176.c        |    1 +
 arch/arm/mach-realview/realview_pb11mp.c        |    1 +
 arch/arm/mach-realview/realview_pba8.c          |    1 +
 arch/arm/mach-realview/realview_pbx.c           |    1 +
 arch/arm/mach-shmobile/Makefile                 |    2 +-
 arch/arm/mach-shmobile/board-ag5evm.c           |    1 +
 arch/arm/mach-shmobile/hotplug.c                |    8 ++-
 arch/arm/mach-shmobile/include/mach/common.h    |    7 +-
 arch/arm/mach-shmobile/include/mach/sh73a0.h    |    6 ++
 arch/arm/mach-shmobile/platsmp.c                |   68 -------------------=
--
 arch/arm/mach-shmobile/setup-sh73a0.c           |    6 ++
 arch/arm/mach-shmobile/smp-sh73a0.c             |   35 ++++++++++-
 arch/arm/mach-tegra/board-dt.c                  |    2 +
 arch/arm/mach-tegra/board-harmony.c             |    2 +
 arch/arm/mach-tegra/board-paz00.c               |    2 +
 arch/arm/mach-tegra/board-seaboard.c            |    4 +
 arch/arm/mach-tegra/board-trimslice.c           |    2 +
 arch/arm/mach-tegra/common.c                    |    8 +++
 arch/arm/mach-tegra/common.h                    |   11 ++++
 arch/arm/mach-tegra/hotplug.c                   |    6 +-
 arch/arm/mach-tegra/platsmp.c                   |   26 +++++++-
 arch/arm/mach-ux500/board-mop500.c              |    3 +
 arch/arm/mach-ux500/board-u5500.c               |    1 +
 arch/arm/mach-ux500/hotplug.c                   |    8 ++-
 arch/arm/mach-ux500/include/mach/setup.h        |    9 +++
 arch/arm/mach-ux500/platsmp.c                   |   23 ++++++-
 arch/arm/mach-vexpress/core.h                   |   10 +++
 arch/arm/mach-vexpress/hotplug.c                |    6 +-
 arch/arm/mach-vexpress/platsmp.c                |   24 ++++++-
 arch/arm/mach-vexpress/v2m.c                    |    9 +++
 arch/arm/plat-versatile/include/plat/platsmp.h  |   14 ++++
 arch/arm/plat-versatile/platsmp.c               |    4 +-
 65 files changed, 569 insertions(+), 149 deletions(-)
 create mode 100644 arch/arm/include/asm/soc.h
 create mode 100644 arch/arm/mach-exynos4/core.h
 create mode 100644 arch/arm/mach-msm/core.c
 create mode 100644 arch/arm/mach-msm/core.h
 delete mode 100644 arch/arm/mach-shmobile/platsmp.c
 create mode 100644 arch/arm/mach-tegra/common.h
 create mode 100644 arch/arm/plat-versatile/include/plat/platsmp.h




>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.180.1318325942.20020.linux-arm-kernel@lists.infradead.org>

design can go up to 1.5GHz. But only two of the 628's Sheeva cores run
at the full 1.5GHz. The third one is down-clocked to 624MHz, and
interesting design choice that saves on power but adds some extra
utility. In a sense, the 628 could be called a 2.5-core design."

Are we mistaken in thinking that sched_mc can not currently handle
this usecase? How would we 'tune' sched_mc to do this w/o playing with
cpu_power?

> Although I would really like to kill all those different
> sched_*_power_savings knobs and reduce it to one.
>
>> If the cpu_power is
>> higher than 1024, the cpu is no more seen out of capacity by the
>> load_balance as soon as a short process is running and teh main result
>> is that the small tasks will stay on the same cpu. This configuration
>> is mainly usefull for ARM dual core system when we want to power gate
>> one cpu. I use cyclictest to simulate such use case.
>
> Yeah, but that's wrong.

What is wrong - the use case simulation using cyclictest? Can you
suggest better tools?

Regards,
/Amit

[1] http://arstechnica.com/gadgets/news/2010/09/marvells-tri-core-chip-has-=
near-ps3-level-graphics.ars


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.184.1318475912.20020.linux-arm-kernel@lists.infradead.org>

that using pr_err() calls.

> +	if (pctldesc->name == NULL)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* If we're implementing pinmuxing, check the ops for sanity */
> +	if (pctldesc->pmxops) {
> +		ret = pinmux_check_ops(pctldesc->pmxops);
> +		if (ret) {
> +			pr_err("%s pinmux ops lacks necessary functions\n",
> +			       pctldesc->name);
> +			return ERR_PTR(ret);
> +		}
> +	}
> +
> +	pctldev = kzalloc(sizeof(struct pinctrl_dev), GFP_KERNEL);
> +	if (pctldev == NULL)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Initialize pin control device struct */
> +	pctldev->owner = pctldesc->owner;
> +	pctldev->desc = pctldesc;
> +	pctldev->driver_data = driver_data;
> +	INIT_RADIX_TREE(&pctldev->pin_desc_tree, GFP_KERNEL);
> +	spin_lock_init(&pctldev->pin_desc_tree_lock);
> +	INIT_LIST_HEAD(&pctldev->gpio_ranges);
> +	mutex_init(&pctldev->gpio_ranges_lock);
> +
> +	/* Register device */
> +	pctldev->dev.parent = dev;
> +	dev_set_name(&pctldev->dev, "pinctrl.%d",
> +		     atomic_inc_return(&pinmux_no) - 1);
> +	pctldev->dev.release = pinctrl_dev_release;
> +	ret = device_register(&pctldev->dev);
> +	if (ret != 0) {
> +		pr_err("error in device registration\n");
> +		put_device(&pctldev->dev);
> +		kfree(pctldev);
> +		goto out_err;
> +	}
> +	dev_set_drvdata(&pctldev->dev, pctldev);
> +
> +	/* Register all the pins */
> +	pr_debug("try to register %d pins on %s...\n",
> +		 pctldesc->npins, pctldesc->name);
> +	ret = pinctrl_register_pins(pctldev, pctldesc->pins, pctldesc->npins);
> +	if (ret) {
> +		pr_err("error during pin registration\n");
> +		pinctrl_free_pindescs(pctldev, pctldesc->pins,
> +				      pctldesc->npins);
> +		goto out_err;
> +	}
> +
> +	pinctrl_init_device_debugfs(pctldev);
> +	mutex_lock(&pinctrldev_list_mutex);
> +	list_add(&pctldev->node, &pinctrldev_list);
> +	mutex_unlock(&pinctrldev_list_mutex);
> +	pinmux_hog_maps(pctldev);
> +	return pctldev;
> +
> +out_err:
> +	put_device(&pctldev->dev);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(pinctrl_register);
> +


I think this is pretty close to ready.  If you address the comments
I've made above then you can add my Acked-by:

Acked-by: Grant Likely <grant.likely@secretlab.ca>




>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.185.1318476496.20020.linux-arm-kernel@lists.infradead.org>

looks like that pull request has been withdrawn (hope I am not missing
anything here). Without Nico's series, and gic dt support for exynos4
support requiring this patch, all other workarounds to replace this
patch does not seem be correct.

So is it acceptable to retain this patch and later rework/drop the
exynos4 specific ioremap along with Nico's vmalloc patch series when
it is merged.

Thanks,
Thomas.

>
> Regards,
> Thomas.
>
>>
>> Rob
>>
>


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.186.1318504194.20020.linux-arm-kernel@lists.infradead.org>

find a big problem with it other than it brings the entire IIO
subsystem along, including the userspace interfaces I guess.

The circumstances seem to suggest that drivers/iio/adc should
be moved down to drivers/adc without the rest of the iio
stuff, with a in-kernel API only and then have iio use that
(this is probably true for some more drivers in IIO like
dac, accel, addac, gyro...).

So the concept of IIO stuff would change from the
userspace-first centric view to the kernelspace-first
centric, with optional userspace interfaces in the form
of IIO.

I'm not sure about what Jonathan thinks about that
though.

Yours,
Linus Walleij


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.187.1318522224.20020.linux-arm-kernel@lists.infradead.org>

clock initialization will apply to all i.MX51 based platforms.
Am I right ?
If so, I think clock init shouldn't be done here because it's platform
dependant: one might for example choose to use 32k quartz instead of
24Mhz external oscillator as clock reference. i.MX51 supports this.
For example on my board I do:
    mx51_clocks_init(32768, 32768*1024, 0, 0);

Regards,
Julien


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.190.1318588382.20020.linux-arm-kernel@lists.infradead.org>

features of clocks in current mainline git.
Back to the clk group, I have a patch based on Sascha's work. 
http://git.linaro.org/gitweb?p=people/riczhao/linux-2.6.git;a=shortlog;h=refs/heads/imx-clk

Thanks
Richard
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 



>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.191.1318631183.20020.linux-arm-kernel@lists.infradead.org>

useless, because this is actually true with u-Boot.  Making 
AUTO_ZRELADDR the default allows for cleaning up zreladdr away, but that 
will break "make uImage".  I've yet to find the best way around that.

> > With AUTO_ZRELADDR=y you _still_ can load zImage to a different location 
> > from where the decompressed kernel ends up.
> 
> You are correct for some values of 'different location' but not all -
> and how can we know _what_ people are doing?  We don't.
> 
> #ifdef CONFIG_AUTO_ZRELADDR
>                 @ determine final kernel image address
>                 mov     r4, pc
>                 and     r4, r4, #0xf8000000
>                 add     r4, r4, #TEXT_OFFSET
> #else
>                 ldr     r4, =zreladdr
> #endif
> 
> So this means the decompressor _must_ run within the first 128MB chunk
> of memory for the resulting kernel to be correctly placed at expected
> place - at the beginning of system memory + TEXT_OFFSET.
> 
> Can we know that this is always the case?  I don't think so.

This is certainly the case for a big chunk of legacy ARM machines that 
don't have more than 128MB of RAM.  Discontigous memory banks may break 
that assumption but that's still a large limiting factor.

> Can we expect there to be regressions if we force AUTO_ZRELADDR=y?  We'd
> be stupid not to expect them.

They should be expected indeed.  However we must weight the benefits 
against the possible regressions.

For example, on X86 they decided at some point that the zImage would no 
longer include the floppy boot sector with kernel loading code.  This 
was an explicit regression because simply copying zImage to a floppy and 
sticking that floppy into a PC no longer boots the kernel.  I'm sure 
some people were affected by that, and the official word was that you 
now have to use a proper boot loader, period.

So far, I've never seen any ARM machine where the kernel is loaded more 
than 64MB away from start of RAM.  And that 64MB happened only once and 
that was from my own doing.  Most people load zImage much closer to 
start of RAM, and almost all of them simply load zImage at zreladdr.  
Or worse, they wrap it into a uImage, load it higher thinking it is 
good, and u-Boot copies it to zreladdr because that's what 'make uImage' 
uses, forcing zImage to make a second copy.

Between you and I, we've seen quite a lot of ARM setups after all those 
years. We should be able to guess the probability for causing regression 
with AUTO_ZRELADDR=y by default.  Personally I'd say that, while not 
impossible, the probability is close to zero for 99% of the cases.


Nicolas


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.193.1318951721.20020.linux-arm-kernel@lists.infradead.org>

internally enable io-pad wakeups for uarts if they have rx-pad pins
set as wakeup capabale.

Use the io-ring wakeup mechanism after uart clock gating and leave
the PM_WKST set for uart to default reset values cleanup the
code in serial.c which was handling PM_WKST reg.
Irq_chaing(PRM_DRIVER) is used to wakeup uart after uart clocks are gated
using pad wakeup mechanism.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c                  |   96 +++---------------------
 arch/arm/plat-omap/include/plat/omap-serial.h |    2 +
 drivers/tty/serial/omap-serial.c              |   15 ++++
 3 files changed, 29 insertions(+), 84 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 8c6dc85..6b3f0bd 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -56,10 +56,6 @@ struct omap_uart_state {
 	int num;
 	int can_sleep;
 
-	void __iomem *wk_st;
-	void __iomem *wk_en;
-	u32 wk_mask;
-
 	int clocked;
 
 	struct list_head node;
@@ -114,26 +110,6 @@ static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
 	omap_device_idle(uart->pdev);
 }
 
-static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
-{
-	/* Set wake-enable bit */
-	if (uart->wk_en && uart->wk_mask) {
-		u32 v = __raw_readl(uart->wk_en);
-		v |= uart->wk_mask;
-		__raw_writel(v, uart->wk_en);
-	}
-}
-
-static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
-{
-	/* Clear wake-enable bit */
-	if (uart->wk_en && uart->wk_mask) {
-		u32 v = __raw_readl(uart->wk_en);
-		v &= ~uart->wk_mask;
-		__raw_writel(v, uart->wk_en);
-	}
-}
-
 static void omap_uart_block_sleep(struct omap_uart_state *uart)
 {
 	omap_uart_enable_clocks(uart);
@@ -163,65 +139,17 @@ int omap_uart_can_sleep(void)
 	return can_sleep;
 }
 
-static void omap_uart_idle_init(struct omap_uart_state *uart)
+static void omap_uart_enable_wakeup(struct platform_device *pdev, bool enable)
 {
-	int ret;
-
-	uart->can_sleep = 0;
-	omap_uart_smart_idle_enable(uart, 0);
+	struct omap_device *od = to_omap_device(pdev);
 
-	if (cpu_is_omap34xx() && !cpu_is_ti816x()) {
-		u32 mod = (uart->num > 1) ? OMAP3430_PER_MOD : CORE_MOD;
-		u32 wk_mask = 0;
+	if (!od)
+		return;
 
-		/* XXX These PRM accesses do not belong here */
-		uart->wk_en = OMAP34XX_PRM_REGADDR(mod, PM_WKEN1);
-		uart->wk_st = OMAP34XX_PRM_REGADDR(mod, PM_WKST1);
-		switch (uart->num) {
-		case 0:
-			wk_mask = OMAP3430_ST_UART1_MASK;
-			break;
-		case 1:
-			wk_mask = OMAP3430_ST_UART2_MASK;
-			break;
-		case 2:
-			wk_mask = OMAP3430_ST_UART3_MASK;
-			break;
-		case 3:
-			wk_mask = OMAP3630_ST_UART4_MASK;
-			break;
-		}
-		uart->wk_mask = wk_mask;
-	} else if (cpu_is_omap24xx()) {
-		u32 wk_mask = 0;
-		u32 wk_en = PM_WKEN1, wk_st = PM_WKST1;
-
-		switch (uart->num) {
-		case 0:
-			wk_mask = OMAP24XX_ST_UART1_MASK;
-			break;
-		case 1:
-			wk_mask = OMAP24XX_ST_UART2_MASK;
-			break;
-		case 2:
-			wk_en = OMAP24XX_PM_WKEN2;
-			wk_st = OMAP24XX_PM_WKST2;
-			wk_mask = OMAP24XX_ST_UART3_MASK;
-			break;
-		}
-		uart->wk_mask = wk_mask;
-		if (cpu_is_omap2430()) {
-			uart->wk_en = OMAP2430_PRM_REGADDR(CORE_MOD, wk_en);
-			uart->wk_st = OMAP2430_PRM_REGADDR(CORE_MOD, wk_st);
-		} else if (cpu_is_omap2420()) {
-			uart->wk_en = OMAP2420_PRM_REGADDR(CORE_MOD, wk_en);
-			uart->wk_st = OMAP2420_PRM_REGADDR(CORE_MOD, wk_st);
-		}
-	} else {
-		uart->wk_en = NULL;
-		uart->wk_st = NULL;
-		uart->wk_mask = 0;
-	}
+	if (enable)
+		omap_hwmod_enable_wakeup(od->hwmods[0]);
+	else
+		omap_hwmod_disable_wakeup(od->hwmods[0]);
 }
 
 /*
@@ -244,6 +172,8 @@ static void omap_uart_set_forceidle(struct platform_device *pdev)
 }
 
 #else
+static void omap_uart_enable_wakeup(struct platform_device *pdev, bool enable)
+{}
 static void omap_uart_set_noidle(struct platform_device *pdev) {}
 static void omap_uart_set_forceidle(struct platform_device *pdev) {}
 static void omap_uart_block_sleep(struct omap_uart_state *uart)
@@ -459,6 +389,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	omap_up.get_context_loss_count = omap_pm_get_dev_context_loss_count;
 	omap_up.set_forceidle = omap_uart_set_forceidle;
 	omap_up.set_noidle = omap_uart_set_noidle;
+	omap_up.enable_wakeup = omap_uart_enable_wakeup;
 
 	/* Enable the MDR1 errata for OMAP3 */
 	if (cpu_is_omap34xx() && !cpu_is_ti816x())
@@ -493,15 +424,12 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	omap_hwmod_idle(uart->oh);
 
 	omap_device_enable(uart->pdev);
-	omap_uart_idle_init(uart);
-	omap_hwmod_enable_wakeup(uart->oh);
 	omap_device_idle(uart->pdev);
 
 	omap_uart_block_sleep(uart);
 	console_unlock();
 
-	if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads) ||
-		(pdata->wk_en && pdata->wk_mask))
+	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
 		device_init_wakeup(&pdev->dev, true);
 }
 
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index f9baf01..d58f081 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -69,6 +69,7 @@ struct omap_uart_port_info {
 	u32 (*get_context_loss_count)(struct device *);
 	void (*set_forceidle)(struct platform_device *);
 	void (*set_noidle)(struct platform_device *);
+	void (*enable_wakeup)(struct platform_device *, bool);
 };
 
 struct uart_omap_dma {
@@ -123,6 +124,7 @@ struct uart_omap_port {
 	unsigned long		port_activity;
 	u32			context_loss_cnt;
 	u32			errata;
+	u8			wakeups_enabled;
 };
 
 #endif /* __OMAP_SERIAL_H__ */
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 4d020fb..3101130 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1495,9 +1495,24 @@ static int serial_omap_runtime_suspend(struct device *dev)
 	if (!up)
 		return -EINVAL;
 
+	if (!pdata->enable_wakeup)
+		return 0;
+
 	if (pdata->get_context_loss_count)
 		up->context_loss_cnt = pdata->get_context_loss_count(dev);
 
+	if (device_may_wakeup(dev)) {
+		if (!up->wakeups_enabled) {
+			pdata->enable_wakeup(up->pdev, true);
+			up->wakeups_enabled = true;
+		}
+	} else {
+		if (up->wakeups_enabled) {
+			pdata->enable_wakeup(up->pdev, false);
+			up->wakeups_enabled = false;
+		}
+	}
+
 	/* Errata i291 */
 	if (up->use_dma && pdata->set_forceidle)
 		pdata->set_forceidle(up->pdev);
-- 
1.7.4.1



>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.201.1320241773.20020.linux-arm-kernel@lists.infradead.org>

halts. I think the option was therefore left hardcoded to make it clear
it wasn't expected to work. Later Zaurii models could do either but
required some manual poking of registers to make it happen iirc.

Regardless, you can probably clean this up as you suggest now.

Cheers,

Richard



>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.204.1320394777.20020.linux-arm-kernel@lists.infradead.org>

set the voltage of the RTS pin (as in the crisv10.c driver); the delay will be
understood by looking only at the value of delay_rts_before_send and 
delay_rts_after_send.

Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
Signed-off-by: Darron Black <darron@griffin.net>
---
 Documentation/serial/serial-rs485.txt |   14 +++++++++++---
 drivers/tty/serial/atmel_serial.c     |   20 +++++---------------
 drivers/tty/serial/crisv10.c          |   10 ++--------
 include/linux/serial.h                |   14 ++++++++------
 4 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/Documentation/serial/serial-rs485.txt b/Documentation/serial/serial-rs485.txt
index 079cb3d..d3a7388 100644
--- a/Documentation/serial/serial-rs485.txt
+++ b/Documentation/serial/serial-rs485.txt
@@ -97,15 +97,23 @@
 
 	struct serial_rs485 rs485conf;
 
-	/* Set RS485 mode: */
+	/* Enable RS485 mode: */
 	rs485conf.flags |= SER_RS485_ENABLED;
 
+	/* Set voltage value for RTS pin equal to 1 when sending: */
+	rs485conf.flags |= SER_RS485_RTS_ON_SEND;
+	/* or, set voltage value for RTS pin equal to 0 when sending: */
+	rs485conf.flags &= ~(SER_RS485_RTS_ON_SEND);
+
+	/* Set voltage value for RTS pin equal to 1 after sending: */
+	rs485conf.flags |= SER_RS485_RTS_AFTER_SEND;
+	/* or, set voltage value for RTS pin equal to 0 after sending: */
+	rs485conf.flags &= ~(SER_RS485_RTS_AFTER_SEND);
+
 	/* Set rts delay before send, if needed: */
-	rs485conf.flags |= SER_RS485_RTS_BEFORE_SEND;
 	rs485conf.delay_rts_before_send = ...;
 
 	/* Set rts delay after send, if needed: */
-	rs485conf.flags |= SER_RS485_RTS_AFTER_SEND;
 	rs485conf.delay_rts_after_send = ...;
 
 	/* Set this flag if you want to receive data even whilst sending data */
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 4a0f86f..23aa677 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -228,7 +228,7 @@ void atmel_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
 		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
-		if (rs485conf->flags & SER_RS485_RTS_AFTER_SEND)
+		if ((rs485conf->delay_rts_after_send) > 0)
 			UART_PUT_TTGR(port, rs485conf->delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
 	} else {
@@ -304,9 +304,9 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
 
 	if (atmel_port->rs485.flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
-		if (atmel_port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+		if ((atmel_port->rs485.delay_rts_after_send) > 0)
 			UART_PUT_TTGR(port,
-					atmel_port->rs485.delay_rts_after_send);
+			    atmel_port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
 	} else {
 		dev_dbg(port->dev, "Setting UART to RS232\n");
@@ -1228,9 +1228,9 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	if (atmel_port->rs485.flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
-		if (atmel_port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+		if ((atmel_port->rs485.delay_rts_after_send) > 0)
 			UART_PUT_TTGR(port,
-					atmel_port->rs485.delay_rts_after_send);
+			    atmel_port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
 	} else {
 		dev_dbg(port->dev, "Setting UART to RS232\n");
@@ -1447,16 +1447,6 @@ static void __devinit atmel_of_init_port(struct atmel_uart_port *atmel_port,
 		rs485conf->delay_rts_after_send = rs485_delay[1];
 		rs485conf->flags = 0;
 
-		if (rs485conf->delay_rts_before_send == 0 &&
-		    rs485conf->delay_rts_after_send == 0) {
-			rs485conf->flags |= SER_RS485_RTS_ON_SEND;
-		} else {
-			if (rs485conf->delay_rts_before_send)
-				rs485conf->flags |= SER_RS485_RTS_BEFORE_SEND;
-			if (rs485conf->delay_rts_after_send)
-				rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
-		}
-
 		if (of_get_property(np, "rs485-rx-during-tx", NULL))
 			rs485conf->flags |= SER_RS485_RX_DURING_TX;
 
diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index b743504..1dfba7b 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -3234,9 +3234,8 @@ rs_write(struct tty_struct *tty,
 		e100_disable_rx(info);
 		e100_enable_rx_irq(info);
 #endif
-		if ((info->rs485.flags & SER_RS485_RTS_BEFORE_SEND) &&
-			(info->rs485.delay_rts_before_send > 0))
-				msleep(info->rs485.delay_rts_before_send);
+		if (info->rs485.delay_rts_before_send > 0)
+			msleep(info->rs485.delay_rts_before_send);
 	}
 #endif /* CONFIG_ETRAX_RS485 */
 
@@ -3693,10 +3692,6 @@ rs_ioctl(struct tty_struct *tty,
 
 		rs485data.delay_rts_before_send = rs485ctrl.delay_rts_before_send;
 		rs485data.flags = 0;
-		if (rs485data.delay_rts_before_send != 0)
-			rs485data.flags |= SER_RS485_RTS_BEFORE_SEND;
-		else
-			rs485data.flags &= ~(SER_RS485_RTS_BEFORE_SEND);
 
 		if (rs485ctrl.enabled)
 			rs485data.flags |= SER_RS485_ENABLED;
@@ -4531,7 +4526,6 @@ static int __init rs_init(void)
 		/* Set sane defaults */
 		info->rs485.flags &= ~(SER_RS485_RTS_ON_SEND);
 		info->rs485.flags |= SER_RS485_RTS_AFTER_SEND;
-		info->rs485.flags &= ~(SER_RS485_RTS_BEFORE_SEND);
 		info->rs485.delay_rts_before_send = 0;
 		info->rs485.flags &= ~(SER_RS485_ENABLED);
 #endif
diff --git a/include/linux/serial.h b/include/linux/serial.h
index 97ff8e2..5a9fd4a 100644
--- a/include/linux/serial.h
+++ b/include/linux/serial.h
@@ -207,13 +207,15 @@ struct serial_icounter_struct {
 
 struct serial_rs485 {
 	__u32	flags;			/* RS485 feature flags */
-#define SER_RS485_ENABLED		(1 << 0)
-#define SER_RS485_RTS_ON_SEND		(1 << 1)
-#define SER_RS485_RTS_AFTER_SEND	(1 << 2)
-#define SER_RS485_RTS_BEFORE_SEND	(1 << 3)
+#define SER_RS485_ENABLED		(1 << 0)	/* If enabled */
+#define SER_RS485_RTS_ON_SEND		(1 << 1)	/* Voltage value for
+							   RTS pin when
+							   sending */
+#define SER_RS485_RTS_AFTER_SEND	(1 << 2)	/* Voltage value for
+							   RTS pin after sent*/
 #define SER_RS485_RX_DURING_TX		(1 << 4)
-	__u32	delay_rts_before_send;	/* Milliseconds */
-	__u32	delay_rts_after_send;	/* Milliseconds */
+	__u32	delay_rts_before_send;	/* Delay before send (milliseconds) */
+	__u32	delay_rts_after_send;	/* Delay after send (milliseconds) */
 	__u32	padding[5];		/* Memory is cheap, new structs
 					   are a royal PITA .. */
 };
-- 
1.7.1



>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.205.1320425904.20020.linux-arm-kernel@lists.infradead.org>

- Drop the EXYNOS4 specific handler and rely on the non-banked
  GIC support instead.
- Add support for IRQ domains in the GIC handler.
- Add support for imx6q and highbank.


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.206.1320425905.20020.linux-arm-kernel@lists.infradead.org>

- Add forgotten patch to make global handler and MULTI_IRQ_HANDLER
  mutually exclusive.
- Introduce handle_IPI(), which is similar to do_IP() and callable
  from C code.

Marc Zyngier (17):
  ARM: Make global handler and CONFIG_MULTI_IRQ_HANDLER mutually
    exclusive
  ARM: mxc: rename gic_handle_irq to avoid name clash
  ARM: GIC: Add global gic_handle_irq() function
  ARM: mxc: convert smp platforms to global gic_handle_irq()
  ARM: highbank: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: RealView: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: VExpress: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: msm: convert SMP platforms to CONFIG_MULTI_IRQ_HANDLER
  ARM: exynos4: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: tegra2: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: ux500: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: shmobile: convert smp platforms to gic_handle_irq()
  ARM: cns3xxx: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: zynq: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: omap2/3: Add global omap2/3_intc_handle_irq() functions
  ARM: omap2plus: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: GIC: Make MULTI_IRQ_HANDLER mandatory

 arch/arm/common/Kconfig                           |    1 +
 arch/arm/common/gic.c                             |   31 ++++-
 arch/arm/include/asm/hardware/entry-macro-gic.S   |   60 ---------
 arch/arm/include/asm/hardware/gic.h               |    2 +-
 arch/arm/kernel/entry-armv.S                      |    7 +-
 arch/arm/mach-cns3xxx/cns3420vb.c                 |    2 +
 arch/arm/mach-cns3xxx/include/mach/entry-macro.S  |    2 -
 arch/arm/mach-exynos4/cpu.c                       |    1 +
 arch/arm/mach-exynos4/include/mach/entry-macro.S  |   74 -----------
 arch/arm/mach-exynos4/mach-armlex4210.c           |    2 +
 arch/arm/mach-exynos4/mach-nuri.c                 |    2 +
 arch/arm/mach-exynos4/mach-origen.c               |    2 +
 arch/arm/mach-exynos4/mach-smdk4x12.c             |    3 +
 arch/arm/mach-exynos4/mach-smdkv310.c             |    3 +
 arch/arm/mach-exynos4/mach-universal_c210.c       |    2 +
 arch/arm/mach-highbank/highbank.c                 |    1 +
 arch/arm/mach-highbank/include/mach/entry-macro.S |    2 -
 arch/arm/mach-msm/board-msm8960.c                 |    2 +
 arch/arm/mach-msm/board-msm8x60.c                 |    4 +
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   17 ---
 arch/arm/mach-msm/include/mach/entry-macro-vic.S  |   37 ------
 arch/arm/mach-msm/include/mach/entry-macro.S      |   27 ++++-
 arch/arm/mach-omap2/Kconfig                       |    2 +
 arch/arm/mach-omap2/board-2430sdp.c               |    1 +
 arch/arm/mach-omap2/board-3430sdp.c               |    1 +
 arch/arm/mach-omap2/board-3630sdp.c               |    1 +
 arch/arm/mach-omap2/board-4430sdp.c               |    2 +
 arch/arm/mach-omap2/board-am3517crane.c           |    1 +
 arch/arm/mach-omap2/board-am3517evm.c             |    1 +
 arch/arm/mach-omap2/board-apollon.c               |    1 +
 arch/arm/mach-omap2/board-cm-t35.c                |    2 +
 arch/arm/mach-omap2/board-cm-t3517.c              |    1 +
 arch/arm/mach-omap2/board-devkit8000.c            |    1 +
 arch/arm/mach-omap2/board-generic.c               |    1 +
 arch/arm/mach-omap2/board-h4.c                    |    1 +
 arch/arm/mach-omap2/board-igep0020.c              |    2 +
 arch/arm/mach-omap2/board-ldp.c                   |    1 +
 arch/arm/mach-omap2/board-n8x0.c                  |    3 +
 arch/arm/mach-omap2/board-omap3beagle.c           |    1 +
 arch/arm/mach-omap2/board-omap3evm.c              |    1 +
 arch/arm/mach-omap2/board-omap3logic.c            |    2 +
 arch/arm/mach-omap2/board-omap3pandora.c          |    1 +
 arch/arm/mach-omap2/board-omap3stalker.c          |    1 +
 arch/arm/mach-omap2/board-omap3touchbook.c        |    1 +
 arch/arm/mach-omap2/board-omap4panda.c            |    2 +
 arch/arm/mach-omap2/board-overo.c                 |    1 +
 arch/arm/mach-omap2/board-rm680.c                 |    1 +
 arch/arm/mach-omap2/board-rx51.c                  |    1 +
 arch/arm/mach-omap2/board-zoom.c                  |    2 +
 arch/arm/mach-omap2/include/mach/entry-macro.S    |  137 -----------------=
----
 arch/arm/mach-omap2/irq.c                         |   50 ++++++++
 arch/arm/mach-pxa/include/mach/entry-macro.S      |   36 ------
 arch/arm/mach-realview/include/mach/entry-macro.S |    2 -
 arch/arm/mach-realview/realview_eb.c              |    1 +
 arch/arm/mach-realview/realview_pb1176.c          |    1 +
 arch/arm/mach-realview/realview_pb11mp.c          |    1 +
 arch/arm/mach-realview/realview_pba8.c            |    1 +
 arch/arm/mach-realview/realview_pbx.c             |    1 +
 arch/arm/mach-shmobile/Makefile                   |    1 -
 arch/arm/mach-shmobile/board-ag5evm.c             |    2 +-
 arch/arm/mach-shmobile/entry-gic.S                |   18 ---
 arch/arm/mach-shmobile/include/mach/common.h      |    1 -
 arch/arm/mach-shmobile/include/mach/entry-macro.S |    9 --
 arch/arm/mach-tegra/board-dt.c                    |    2 +
 arch/arm/mach-tegra/board-harmony.c               |    2 +
 arch/arm/mach-tegra/board-paz00.c                 |    2 +
 arch/arm/mach-tegra/board-seaboard.c              |    4 +
 arch/arm/mach-tegra/board-trimslice.c             |    2 +
 arch/arm/mach-tegra/include/mach/entry-macro.S    |   22 +---
 arch/arm/mach-ux500/board-mop500.c                |    4 +
 arch/arm/mach-ux500/board-u5500.c                 |    2 +
 arch/arm/mach-ux500/include/mach/entry-macro.S    |    2 -
 arch/arm/mach-vexpress/include/mach/entry-macro.S |    2 -
 arch/arm/mach-vexpress/v2m.c                      |    2 +
 arch/arm/mach-zynq/common.c                       |    1 +
 arch/arm/mach-zynq/include/mach/entry-macro.S     |    3 -
 arch/arm/plat-mxc/Makefile                        |    1 -
 arch/arm/plat-mxc/gic.c                           |   41 ------
 arch/arm/plat-mxc/include/mach/common.h           |    1 -
 arch/arm/plat-mxc/include/mach/entry-macro.S      |   14 --
 arch/arm/plat-omap/include/plat/irqs.h            |    2 +
 81 files changed, 196 insertions(+), 494 deletions(-)
 delete mode 100644 arch/arm/include/asm/hardware/entry-macro-gic.S
 delete mode 100644 arch/arm/mach-msm/include/mach/entry-macro-qgic.S
 delete mode 100644 arch/arm/mach-msm/include/mach/entry-macro-vic.S
 delete mode 100644 arch/arm/mach-shmobile/entry-gic.S
 delete mode 100644 arch/arm/plat-mxc/gic.c
