From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 10 Jul 2014 10:27:10 +0200
Subject: [PATCH v3 3/4] ARM: EXYNOS: cpuidle: add secure firmware support
 to AFTR mode code
In-Reply-To: <1404926274-18411-4-git-send-email-b.zolnierkie@samsung.com>
References: <1404926274-18411-1-git-send-email-b.zolnierkie@samsung.com>
 <1404926274-18411-4-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <53BE4E5E.1080803@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.07.2014 19:17, Bartlomiej Zolnierkiewicz wrote:
> * Move cp15 registers saving to exynos_save_cp15() helper and add
>    additional helper usage to do_idle firmware method.
>
> * Use sysram_ns_base_addr + 0x24/0x20 addresses instead of the default
>    ones used by exynos_cpu_set_boot_vector() on boards with secure
>    firmware enabled.
>
> * Use do_idle firmware method instead of cpu_do_idle() on boards with
>    secure firmware enabled.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> v3:
> - make exynos_enter_aftr() return a value
> - add cp15 registers handling to do_idle firmware method
> - set sysram_ns_base_addr + 0x24/0x20 in do_idle firmware method
> - move calling of do_idle firmware method from cpuidle-exynos.c
>    to pm.c
>
>   arch/arm/mach-exynos/common.h    |  2 +-
>   arch/arm/mach-exynos/firmware.c  | 26 ++++++++++++++++++--------
>   arch/arm/mach-exynos/pm.c        | 11 +++++++++--
>   drivers/cpuidle/cpuidle-exynos.c |  6 +++---
>   4 files changed, 31 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index a6a200f..0829808 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -170,7 +170,7 @@ extern int  exynos_cpu_power_state(int cpu);
>   extern void exynos_cluster_power_down(int cluster);
>   extern void exynos_cluster_power_up(int cluster);
>   extern int  exynos_cluster_power_state(int cluster);
> -extern void exynos_enter_aftr(void);
> +extern int  exynos_enter_aftr(void);
>
>   extern void s5p_init_cpu(void __iomem *cpuid_addr);
>   extern unsigned int samsung_rev(void);
> diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
> index 53fbf5c..163f5b9 100644
> --- a/arch/arm/mach-exynos/firmware.c
> +++ b/arch/arm/mach-exynos/firmware.c
> @@ -24,13 +24,30 @@
>   #include "smc.h"
>
>   #define EXYNOS_SLEEP_MAGIC	0x00000bad
> +#define EXYNOS_AFTR_MAGIC	0xfcba0d10
>   #define EXYNOS_BOOT_ADDR	0x8
>   #define EXYNOS_BOOT_FLAG	0xc
>
> +/* For Cortex-A9 Diagnostic and Power control register */
> +static unsigned int cp15_power;
> +static unsigned int cp15_diag;
> +
> +static void exynos_save_cp15(void)
> +{
> +	/* Save Power control and Diagnostic registers */
> +	asm ("mrc p15, 0, %0, c15, c0, 0\n"
> +	     "mrc p15, 0, %1, c15, c0, 1\n"
> +		: "=r" (cp15_power), "=r" (cp15_diag) : : "cc");

Hi,

On Exynos3250 I encounter "Oops - undefined instruction" on this asm 
while entering AFTR:
[    2.277946] CPUidle CPU1: going off
[    2.278110] CPUidle CPU0: going AFTR
[    2.279478] Internal error: Oops - undefined instruction: 0 [#1] 
PREEMPT SMP ARM


Are you sure it should be called on each SoC?

Full dmesg attached.

Best regards,
Krzysztof


> +}
> +
>   static int exynos_do_idle(unsigned long mode)
>   {
>   	switch (mode) {
>   	case FW_DO_IDLE_AFTR:
> +		exynos_save_cp15();
> +		__raw_writel(virt_to_phys(exynos_cpu_resume),
> +			     sysram_ns_base_addr + 0x24);
> +		__raw_writel(EXYNOS_AFTR_MAGIC, sysram_ns_base_addr + 0x20);
>   		exynos_smc(SMC_CMD_CPU0AFTR, 0, 0, 0);
>   		break;
>   	case FW_DO_IDLE_SLEEP:
> @@ -76,10 +93,6 @@ static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
>   	return 0;
>   }
>
> -/* For Cortex-A9 Diagnostic and Power control register */
> -static unsigned int cp15_power;
> -static unsigned int cp15_diag;
> -
>   static int exynos_cpu_suspend(unsigned long arg)
>   {
>   	flush_cache_all();
> @@ -94,10 +107,7 @@ static int exynos_cpu_suspend(unsigned long arg)
>
>   static int exynos_suspend(void)
>   {
> -	/* Save Power control and Diagnostic registers */
> -	asm ("mrc p15, 0, %0, c15, c0, 0\n"
> -		"mrc p15, 0, %1, c15, c0, 1\n"
> -		: "=r" (cp15_power), "=r" (cp15_diag) : : "cc");
> +	exynos_save_cp15();
>
>   	writel(EXYNOS_SLEEP_MAGIC, sysram_ns_base_addr + EXYNOS_BOOT_FLAG);
>   	writel(virt_to_phys(cpu_resume),
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index c722454..af0d4bf 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -201,12 +201,19 @@ static void exynos_cpu_set_boot_vector(long flags)
>   	__raw_writel(flags, exynos_boot_vector_flag());
>   }
>
> -void exynos_enter_aftr(void)
> +int exynos_enter_aftr(void)
>   {
> +	int ret;
> +
>   	exynos_set_wakeupmask(0x0000ff3e);
> -	exynos_cpu_set_boot_vector(S5P_CHECK_AFTR);
>   	/* Set value of power down register for aftr mode */
>   	exynos_sys_powerdown_conf(SYS_AFTR);
> +
> +	ret = call_firmware_op(do_idle, FW_DO_IDLE_AFTR);
> +	if (ret == -ENOSYS)
> +		exynos_cpu_set_boot_vector(S5P_CHECK_AFTR);
> +
> +	return ret;
>   }
>
>   /* For Cortex-A9 Diagnostic and Power control register */
> diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cpuidle-exynos.c
> index 7c01512..c5b36d3 100644
> --- a/drivers/cpuidle/cpuidle-exynos.c
> +++ b/drivers/cpuidle/cpuidle-exynos.c
> @@ -18,12 +18,12 @@
>   #include <asm/suspend.h>
>   #include <asm/cpuidle.h>
>
> -static void (*exynos_enter_aftr)(void);
> +static int (*exynos_enter_aftr)(void);
>
>   static int idle_finisher(unsigned long flags)
>   {
> -	exynos_enter_aftr();
> -	cpu_do_idle();
> +	if (exynos_enter_aftr() == -ENOSYS)
> +		cpu_do_idle();
>
>   	return 1;
>   }
>



-------------- next part --------------
Elapsed time: 2.627 sec (0x7d44a4, 3125000Hz)
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.16.0-rc4-00098-geaa0e4daaabb-dirty (k.kozlowski at AMDC1943) (gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-12ubuntu1) ) #160 SMP PREEMPT Thu Jul 10 09:56:14 CEST 2014
[    0.000000] CPU: ARMv7 Processor [410fc073] revision 3 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Running under secure firmware.
[    0.000000] PERCPU: Embedded 9 pages/cpu @dfab1000 s14656 r8192 d14016 u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129794
[    0.000000] Kernel command line: console=ttySAC1,115200 loglevel=7 no_console_suspend init=/bin/sh root=/dev/mmcblk0p15 ro rootfstype=ext4 rootwait bootmode=normal  pwron.reason=ap:swrst,pmic:pwron sec_debug.enable=1 sec_debug.enable_user=0 softlockup_panic=0 sec_log=0x200000 at 0x46000000 lcdtype=0 oops=panic pmic_info=1875 sysscope=0xee000000 cordon=a4be4deb59d0e10ddccd45c2afebdd1b serialno=410094f7534ab063 tizenboot.emmc_checksum=3 tizenboot.odin=1 bootloader.ver=localbuild bootloader.fb=0x48000000 bootloader.log=0x11fd at 0x46001636
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] allocated 1046528 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] Memory: 500912K/523264K available (5340K kernel code, 390K rwdata, 1940K rodata, 282K init, 8511K bss, 22352K reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
[    0.000000]     vmalloc : 0xe0000000 - 0xff000000   ( 496 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xdff00000   ( 511 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc072454c   (7282 kB)
[    0.000000]       .init : 0xc0725000 - 0xc076b940   ( 283 kB)
[    0.000000]       .data : 0xc076c000 - 0xc07cdadc   ( 391 kB)
[    0.000000]        .bss : 0xc07cdadc - 0xc101daa4   (8512 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  RCU lockdep checking is enabled.
[    0.000000]  Offload RCU callbacks from all CPUs
[    0.000000]  Offload RCU callbacks from CPUs: 0-1.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000015] sched_clock: 64 bits at 24MHz, resolution 41ns, wraps every 2863311519744ns
[    0.001224] Console: colour dummy device 80x30
[    0.001280] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.001292] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.001304] ... MAX_LOCK_DEPTH:          48
[    0.001315] ... MAX_LOCKDEP_KEYS:        8191
[    0.001326] ... CLASSHASH_SIZE:          4096
[    0.001337] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.001349] ... MAX_LOCKDEP_CHAINS:      65536
[    0.001360] ... CHAINHASH_SIZE:          32768
[    0.001371]  memory used by lock dependency info: 5167 kB
[    0.001383]  per task-struct memory footprint: 1152 bytes
[    0.001435] Calibrating delay loop... 1384.44 BogoMIPS (lpj=3461120)
[    0.095032] pid_max: default: 32768 minimum: 301
[    0.095460] Security Framework initialized
[    0.095640] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.095662] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.099246] Initializing cgroup subsys memory
[    0.099560] Initializing cgroup subsys freezer
[    0.099678] Initializing cgroup subsys debug
[    0.099946] CPU: Testing write buffer coherency: ok
[    0.101558] CPU0: update cpu_capacity 1024
[    0.101579] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.101794] Setting up static identity map for 0x40512728 - 0x40512780
[    0.147987] CPU1: Software reset
[    0.148227] CPU1: Booted secondary processor
[    0.174989] CPU1: update cpu_capacity 1024
[    0.174998] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.175835] Brought up 2 CPUs
[    0.175865] SMP: Total of 2 processors activated.
[    0.175879] CPU: All CPU(s) started in SVC mode.
[    0.180386] devtmpfs: initialized
[    0.207275] VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 3
[    0.210686] pinctrl core: initialized pinctrl subsystem
[    0.214405] regulator-dummy: no parameters
[    0.275551] NET: Registered protocol family 16
[    0.276331] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.279469] cpuidle: using governor ladder
[    0.279500] cpuidle: using governor menu
[    0.302487] samsung-pinctrl 11000000.pinctrl: node initial-state does not have either config or function configurations
[    0.309420] samsung-pinctrl 11400000.pinctrl: node initial-state does not have either config or function configurations
[    0.324909] hw-breakpoint: Failed to enable monitor mode on CPU 0.
[    0.324962] EXYNOS3250 PMU Initialize
[    0.371635] V_EMMC_2.8V-fixed: 2800 mV
[    0.397883] max14577 7-0025: Device type: 2 (ID: 0xe, vendor: 0x5)
[    0.419854] SAFEOUT: 4900 mV
[    0.434087] CHARGER: 45 <--> 475 mA at 475 mA
[    0.447298] UNUSED_LDO1: 2700 mV
[    0.454790] UNUSED_LDO2: 800 <--> 3950 mV at 1800 mV
[    0.459814] i2c-gpio 138d0000.i2c: using pins 147 (SDA) and 148 (SCL)
[    0.460688] s3c-i2c 13860000.i2c: slave address 0x10
[    0.460717] s3c-i2c 13860000.i2c: bus frequency set to 97 KHz
[    0.469107] VAP_ALIVE_1.0V: 1000 mV
[    0.471929] VAP_M1_1.2V: 1200 mV
[    0.474480] VCC_AP_1.8V: 1800 mV
[    0.477202] VAP_AVDD_PLL1: 1800 mV
[    0.479719] VAP_PLL_ISO_1.0V: 1000 mV
[    0.482360] VAP_VMIPI_1.0V: 1000 mV
[    0.484944] VAP_AVDD_1.8V: 1800 mV
[    0.487823] VAP_USB_3.0V: 3000 mV
[    0.490440] V_LPDDR_1.2V: 1200 mV
[    0.492439] UNUSED_LDO10: 900 <--> 1100 mV at 1000 mV
[    0.495540] V_EMMC_1.8V: 1800 mV
[    0.499959] V_EMMC_2.8V: 2800 mV
[    0.503167] CAM_AVDD_2.8V: 2800 mV
[    0.505241] MOT_2.7V: 1800 <--> 2700 mV at 2700 mV
[    0.508272] TSP_AVDD_3.3V: 3300 mV
[    0.510835] LCD_VDD_3.3V: 3300 mV
[    0.514345] UNUSED_LDO17: 2800 mV
[    0.517396] CAM_AF_2.8V: 2800 mV
[    0.520497] TSP_VDD_1.8V: 1800 mV
[    0.523064] LCD_VDD_1.8V: 1800 mV
[    0.526080] CAM_IO_1.8V: 1800 mV
[    0.529113] CAM_DVDD_1.2V: 1200 mV
[    0.531781] HRM_VCC_1.8V: 1800 mV
[    0.536243] HRM_VCC_3.3V: 3300 mV
[    0.538250] UNUSED_LDO25: 1800 <--> 3375 mV at 3000 mV
[    0.540909] VAP_MIF_1.0V: 800 <--> 900 mV at 1000 mV
[    0.543458] VAP_ARM_1.0V: 850 <--> 1150 mV at 1000 mV
[    0.546008] VAP_INT3D_1.0V: 850 <--> 1000 mV at 1000 mV
[    0.548831] VCC_SUB_1.95V: 1950 mV
[    0.551473] VCC_SUB_1.35V: 1350 mV
[    0.553389] s3c-i2c 13860000.i2c: i2c-0: S3C I2C adapter
[    0.553877] s3c-i2c 13870000.i2c: slave address 0x10
[    0.553904] s3c-i2c 13870000.i2c: bus frequency set to 390 KHz
[    0.556047] s3c-i2c 13870000.i2c: i2c-1: S3C I2C adapter
[    0.556390] s3c-i2c 13880000.i2c: slave address 0x10
[    0.556417] s3c-i2c 13880000.i2c: bus frequency set to 390 KHz
[    0.558511] s3c-i2c 13880000.i2c: i2c-2: S3C I2C adapter
[    0.558841] Linux video capture interface: v2.00
[    0.569695] Advanced Linux Sound Architecture Driver Initialized.
[    0.573686] Bluetooth: Core ver 2.19
[    0.573868] NET: Registered protocol family 31
[    0.573884] Bluetooth: HCI device and connection manager initialized
[    0.573995] Bluetooth: HCI socket layer initialized
[    0.574032] Bluetooth: L2CAP socket layer initialized
[    0.574234] Bluetooth: SCO socket layer initialized
[    0.574298] NetLabel: Initializing
[    0.574312] NetLabel:  domain hash size = 128
[    0.574324] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.574557] NetLabel:  unlabeled traffic allowed by default
[    0.577734] Switched to clocksource mct-frc
[    0.734124] NET: Registered protocol family 2
[    0.737661] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.737880] TCP bind hash table entries: 4096 (order: 5, 147456 bytes)
[    0.739635] TCP: Hash tables configured (established 4096 bind 4096)
[    0.739825] TCP: reno registered
[    0.739860] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.740114] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.741448] NET: Registered protocol family 1
[    0.743311] hw perfevents: enabled with ARMv7 Cortex-A7 PMU driver, 5 counters available
[    0.748117] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.748471] audit: initializing netlink subsys (disabled)
[    0.748794] audit: type=2000 audit(0.745:1): initialized
[    0.786725] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.787693] fuse init (API version 7.23)
[    0.789158] msgmni has been set to 978
[    0.798360] io scheduler noop registered
[    0.799048] io scheduler cfq registered (default)
[    0.818115] dma-pl330 12680000.pdma: Loaded driver for PL330 DMAC-1315632
[    0.818142] dma-pl330 12680000.pdma:         DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[    0.834212] dma-pl330 12690000.pdma: Loaded driver for PL330 DMAC-1315632
[    0.834239] dma-pl330 12690000.pdma:         DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[    0.836003] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.856996] 13800000.serial: ttySAC0 at MMIO 0x13800000 (irq = 141, base_baud = 0) is a S3C6400/10
[    0.859297] 13810000.serial: ttySAC1 at MMIO 0x13810000 (irq = 142, base_baud = 0) is a S3C6400/10
[    1.731921] console [ttySAC1] enabled
[    1.737731] [drm] Initialized drm 1.1.0 20060810
[    1.743800] exynos-drm-ipp exynos-drm-ipp: drm ipp registered successfully.
[    1.758437] loop: module loaded
[    1.759097] s3c64xx-spi 13920000.spi: number of chip select lines not specified, assuming 1 chip select line
[    1.770034] s3c64xx-spi 13930000.spi: number of chip select lines not specified, assuming 1 chip select line
[    1.780267] s3c-rtc 10070000.rtc: rtc disabled, re-enabling
[    1.782554] s3c-rtc 10070000.rtc: rtc core: registered s3c as rtc0
[    1.787455] s3c-rtc 10070000.rtc: warning: invalid RTC value so initializing it
[    1.804233] s5m-rtc s2mps14-rtc: rtc core: registered s5m-rtc as rtc1
[    1.809492] max17040 1-0036: max17040_write_reg: err -111
[    1.811637] max17040 1-0036: MAX17040 Fuel-Gauge Ver 00
[    1.866540] Bluetooth: HCI UART driver ver 2.2
[    1.866649] Bluetooth: HCI H4 protocol initialized
[    1.870643] cpufreq_cpu0: failed to get cpu0 regulator: -19
[    1.878466] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[    1.889034] exynos_cpuidle exynos_cpuidle: Probing CPU idle driver
[    1.893591] Synopsys Designware Multimedia Card Interface Driver
[    1.899810] dwmmc_exynos 12510000.mshc: Using internal DMA controller.
[    1.904768] dwmmc_exynos 12510000.mshc: Version ID is 260a
[    1.910821] dwmmc_exynos 12510000.mshc: DW MMC controller at irq 174, 64 bit host data width, 128 deep fifo
[    1.948134] dwmmc_exynos 12510000.mshc: 1 slots initialized
[    1.949843] logger: created 256K log 'log_main'
[    1.954583] logger: created 256K log 'log_events'
[    1.958286] logger: created 256K log 'log_radio'
[    1.962519] logger: created 256K log 'log_system'
[    2.020709] mmc0: BKOPS_EN bit is not set
[    2.023202] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
[    2.029336] mmc_host mmc0: Bus speed (slot 0) = 100000000Hz (slot req 52000000Hz, actual 50000000HZ div = 1)
[    2.038976] mmc0: new DDR MMC card at address 0001
[    2.047969] mmcblk0: mmc0:0001 F5X5MA 3.64 GiB
[    2.052879] mmcblk0boot0: mmc0:0001 F5X5MA partition 1 4.00 MiB
[    2.054084] mmcblk0boot1: mmc0:0001 F5X5MA partition 2 4.00 MiB
[    2.060123] mmcblk0rpmb: mmc0:0001 F5X5MA partition 3 512 KiB
[    2.075249]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15
[    2.084082] max14577-muic max77836-muic: device ID : 0x75
[    2.095708]  mmcblk0boot1: unknown partition table
[    2.096300] oprofile: using timer interrupt.
[    2.099831]  mmcblk0boot0: unknown partition table
[    2.100197] TCP: cubic registered
[    2.100391] NET: Registered protocol family 17
[    2.100524] NET: Registered protocol family 15
[    2.111270] Bluetooth: RFCOMM TTY layer initialized
[    2.111325] Bluetooth: RFCOMM socket layer initialized
[    2.111380] Bluetooth: RFCOMM ver 1.11
[    2.111466] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    2.111491] Bluetooth: BNEP socket layer initialized
[    2.111506] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    2.111530] Bluetooth: HIDP socket layer initialized
[    2.114145] isp-power-domain: Power-off latency exceeded, new value 437375 ns
[    2.114471] lcd0-power-domain: Power-off latency exceeded, new value 293708 ns
[    2.114971] g3d-power-domain: Power-off latency exceeded, new value 470959 ns
[    2.115330] mfc-power-domain: Power-off latency exceeded, new value 327958 ns
[    2.115663] cam-power-domain: Power-off latency exceeded, new value 306333 ns
[    2.118149] registered taskstats version 1
[    2.122308] input: soc:gpio-keys at 0 as /devices/soc/soc:gpio-keys at 0/input/input0
[    2.198046] s3c-rtc 10070000.rtc: setting system clock to 2000-01-01 00:00:00 UTC (946684800)
[    2.207642] charger-manager soc:charger-manager@: Ignoring full-battery voltage threshold as it is not supplied
[    2.216557] charger-manager soc:charger-manager@: Ignoring full-battery full capacity threshold as it is not supplied
[    2.227147] charger-manager soc:charger-manager@: Cannot find power supply "max17040"
[    2.277946] CPUidle CPU1: going off
[    2.278110] CPUidle CPU0: going AFTR
[    2.279478] Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP ARM
[    2.286742] Modules linked in:
[    2.289783] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.16.0-rc4-00098-geaa0e4daaabb-dirty #160
[    2.298459] task: c0776da8 ti: c076c000 task.ti: c076c000
[    2.303846] PC is at exynos_do_idle+0x34/0x8c
[    2.308182] LR is at exynos_enter_aftr+0x38/0x58
[    2.312782] pc : [<c001f288>]    lr : [<c001fbc0>]    psr: 60000193
[    2.312782] sp : c076de84  ip : c0515a7c  fp : 00000000
[    2.324237] r10: c1010944  r9 : ded16440  r8 : 0000000f
[    2.329445] r7 : 00000007  r6 : 00000000  r5 : c076decc  r4 : 00000030
[    2.335955] r3 : c07cde7c  r2 : c07cde84  r1 : 00000001  r0 : 00000001
[    2.342467] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    2.349844] Control: 10c53c7d  Table: 4000406a  DAC: 00000015
[    2.355572] Process swapper/0 (pid: 0, stack limit = 0xc076c240)
[    2.361561] Stack: (0xc076de84 to 0xc076e000)
[    2.365906] de80:          c001f254 c001fbc0 c001fb88 c037f878 0000003f c001424c 5f494000
[    2.374064] dea0: c076decc 4001ed80 00000000 00000000 00000000 00000015 4000406a 10c53c7d
[    2.382224] dec0: 0000e440 00f00000 00000000 00000000 c037f864 c0785fc0 dfab3280 00000001
[    2.390383] dee0: ded16440 c1010944 ded1644c c0014338 0000000f c1010948 c0791148 c037f9b8
[    2.398542] df00: 879f9414 00000000 c07addc8 ffffffff dfab3280 ded16440 c1010944 c037d714
[    2.406701] df20: 879f9414 00000000 c076c000 c037f020 ffff0000 00000001 dfab3280 c076c000
[    2.414861] df40: ffffffff c07addc8 c1010944 c037f670 c07bd640 c0515e34 00000001 ded16450
[    2.423020] df60: dfab3284 dfab3280 c0515e34 00000001 c076c000 c077442c 00000000 c07addc8
[    2.431179] df80: c07bd640 c006dde0 00000001 c076a278 00000000 c07bc46c c076dfa4 c07748e8
[    2.439339] dfa0: c07cdb00 c075cc5c dfefc780 4000406a 410fc073 00000000 00000000 c006e230
[    2.447498] dfc0: c0776da8 c0725b1c ffffffff ffffffff c0725608 00000000 00000000 c075cc5c
[    2.455656] dfe0: 00000000 c07cdd14 c07743b0 c075cc58 c0778824 40008074 00000000 00000000
[    2.463824] [<c001f288>] (exynos_do_idle) from [<c001fbc0>] (exynos_enter_aftr+0x38/0x58)
[    2.471981] [<c001fbc0>] (exynos_enter_aftr) from [<c037f878>] (idle_aftr_finisher+0x14/0x20)
[    2.480486] [<c037f878>] (idle_aftr_finisher) from [<c001424c>] (cpu_suspend_abort+0x0/0x14)
[    2.488901] [<c001424c>] (cpu_suspend_abort) from [<00000000>] (  (null))
[    2.495673] Code: e3510001 1afffffb e59f204c e59f304c (ee1fcf10)
[    2.501748] ---[ end trace 62c07ace303a3fce ]---
[    2.506346] Kernel panic - not syncing: Fatal exception
[    3.645552] SMP: failed to stop secondary CPUs
[    3.645652] ---[ end Kernel panic - not syncing: Fatal exception
