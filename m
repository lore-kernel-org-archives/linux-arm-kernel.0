From: russ.dill@gmail.com (Russ Dill)
Date: Wed, 25 Apr 2012 21:36:40 -0700
Subject: [PATCH-V4 3/3] ARM: OMAP: Make OMAP clocksource source selection
 using kernel param
In-Reply-To: <1335260749-25877-4-git-send-email-hvaibhav@ti.com>
References: <1335260749-25877-1-git-send-email-hvaibhav@ti.com>
 <1335260749-25877-4-git-send-email-hvaibhav@ti.com>
Message-ID: <CA+Bv8XYemH3zW48id_ZAvC2gU_uZMFei6dMO1GUog_YTvFBV2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 2:45 AM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
> Current OMAP code supports couple of clocksource options based
> on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz).
> So there can be 3 options -
>
> 1. 32KHz sync-timer
> 2. Sys_clock based (e.g 13/19.2/26/38.4 MHz) gptimer
> 3. 32KHz based gptimer.
>
> The optional gptimer based clocksource was added so that it can
> give the high precision than sync-timer, so expected usage was 2
> and not 3.
> Unfortunately option 2, clocksource doesn't meet the requirement of
> free-running clock as per clocksource need. It stops in low power states
> when sys_clock is cut. That makes gptimer based clocksource option
> useless for OMAP2/3/4 devices with sys_clock as a clock input.
> Option 3 will still work but it is no better than 32K sync-timer
> based clocksource.
>
> So ideally we can kill the gptimer based clocksource option but there
> are some OMAP based derivative SoCs like AM33XX which doesn't have
> 32K sync-timer hardware IP and need to fallback on 32KHz based gptimer
> clocksource.
> Considering above, make sync-timer and gptimer clocksource runtime
> selectable so that both OMAP and AMXXXX continue to use the same code.
>
> Also, in order to precisely configure/setup sched_clock for given
> clocksource, decision has to be made early enough in boot sequence.
>
> So, the solution is,
>
> Use kernel parameter ("clocksource=") to override
> default 32k_sync-timer, in addition to this, we also use hwmod database
> lookup mechanism, through which at run-time we can identify availability
> of 32k-sync timer on the device, else fall back to gptimer.
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Cc: Ming Lei <tom.leiming@gmail.com>

This fails to boot on my Mistral am37x-evm with omap2plus_defconfig

## Booting kernel from Legacy Image at 80007fc0 ...
   Image Name:   Linux-3.4.0-rc3-ktest-11789-gea1
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3360576 Bytes = 3.2 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   XIP Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.4.0-rc3-ktest-11789-gea133e0
(russ at russ-laptop) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) )
#9 SMP Wed Apr 25 21:13:16 MST 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine: OMAP3 EVM
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/1000 MHz
[    0.000000] PERCPU: Embedded 8 pages/cpu @c0e0c000 s11456 r8192 d13120 u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 64768
[    0.000000] Kernel command line: console=ttyO0,115200n8
root=/dev/nfs nfsroot=192.168.1.143:/var/datastore/exports/192.168.1.20,nolock
rw ip=dhcp
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 255MB = 255MB total
[    0.000000] Memory: 246504k/246504k available, 15640k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05cced4   (5908 kB)
[    0.000000]       .init : 0xc05cd000 - 0xc061acc0   ( 312 kB)
[    0.000000]       .data : 0xc061c000 - 0xc06b0cd8   ( 596 kB)
[    0.000000]        .bss : 0xc06b0cfc - 0xc0c050e0   (5457 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:474
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns,
wraps every 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.000549] Calibrating delay loop... 996.74 BogoMIPS (lpj=3891200)
[    0.062561] pid_max: default: 32768 minimum: 301
[    0.062988] Security Framework initialized
[    0.063140] Mount-cache hash table entries: 512
[    0.066223] CPU: Testing write buffer coherency: ok
[    0.066772] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.066802] Setting up static identity map for 0x804220e0 - 0x80422150
[    0.067871] Brought up 1 CPUs
[    0.067871] SMP: Total of 1 processors activated (996.74 BogoMIPS).
[    0.080902] dummy:
[    0.082183] NET: Registered protocol family 16
[    0.082977] GPMC revision 5.0
[    0.083099] gpmc: irq-20 could not claim: err -22
[    0.089172] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.089477] OMAP GPIO hardware version 2.5
[    0.090148] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.091064] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.091918] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.092742] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
[    0.093566] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
[    0.098327] omap_mux_init: Add partition: #1: core, flags: 0
[    0.111450] Reprogramming SDRC clock to 400000000 Hz
[    0.111450] dpll3_m2_clk rate change failed: -22
[    0.113220] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.121795]  omap-mcbsp.2: alias fck already exists
[    0.122253]  omap-mcbsp.3: alias fck already exists
[    0.124908] OMAP DMA hardware revision 5.0
[    0.164764] bio: create slab <bio-0> at 0
[    0.167022] fixed-dummy:
[    0.170562] SCSI subsystem initialized
[    0.171844] omap2_mcspi omap2_mcspi.1: master is unqueued, this is deprecated
[    0.174468] omap2_mcspi omap2_mcspi.2: master is unqueued, this is deprecated
[    0.175201] omap2_mcspi omap2_mcspi.3: master is unqueued, this is deprecated
[    0.175872] omap2_mcspi omap2_mcspi.4: master is unqueued, this is deprecated
[    0.177795] usbcore: registered new interface driver usbfs
[    0.178436] usbcore: registered new interface driver hub
[    0.178833] usbcore: registered new device driver usb
[    0.180572] omap_i2c omap_i2c.1: bus 1 rev1.4.0 at 2600 kHz
[    0.186676] twl 1-0048: PIH (irq 7) chaining IRQs 320..328
[    0.187042] twl 1-0048: power (irq 325) chaining IRQs 328..335
[    0.189025] twl4030_gpio twl4030_gpio: gpio (irq 320) chaining IRQs 336..353
[    0.189971] gpiochip_add: registered GPIOs 192 to 211 on device: twl4030
[    0.196807] VIO: 1800 mV normal standby
[    0.198272] vdd_mpu_iva: 600 <--> 1450 mV normal
[    0.199584] vdd_core: 600 <--> 1450 mV normal
[    0.200836] VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
[    0.202392] VDAC: 1800 mV normal standby
[    0.204376] VPLL2: 1800 mV normal standby
[    0.205841] VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
[    0.206573] omap_i2c omap_i2c.2: bus 2 rev1.4.0 at 400 kHz
[    0.219024] omap_i2c omap_i2c.3: bus 3 rev1.4.0 at 400 kHz
[    0.224121] Switching to clocksource 32k_counter
[    0.289855] NET: Registered protocol family 2
[    0.290496] IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.291809] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[    0.292083] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.294799] TCP: Hash tables configured (established 8192 bind 8192)
[    0.294860] TCP: reno registered
[    0.294860] UDP hash table entries: 128 (order: 1, 10240 bytes)
[    0.295074] UDP-Lite hash table entries: 128 (order: 1, 10240 bytes)
[    0.295684] NET: Registered protocol family 1
[    0.296600] RPC: Registered named UNIX socket transport module.
[    0.296630] RPC: Registered udp transport module.
[    0.296630] RPC: Registered tcp transport module.
[    0.296661] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.297210] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.395935] VFS: Disk quotas dquot_6.5.2
[    0.396148] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.397125] NFS: Registering the id_resolver key type
[    0.398223] jffs2: version 2.2. (NAND) (SUMMARY)  ? 2001-2006 Red Hat, Inc.
[    0.398895] msgmni has been set to 481
[    0.401031] io scheduler noop registered
[    0.401062] io scheduler deadline registered
[    0.401214] io scheduler cfq registered (default)
[    0.402923] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.407135] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 72) is a OMAP UART0
[    1.098785] console [ttyO0] enabled
[    1.103515] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 73) is a OMAP UART1
[    1.111846] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq = 74) is a OMAP UART2
[    1.120056] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq = 80) is a OMAP UART3
[    1.147613] brd: module loaded
[    1.162567] loop: module loaded
[    1.170898] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.178222] OneNAND driver initializing
[    1.186126] smsc911x: Driver version 2008-10-21
[    1.196441] smsc911x-mdio: probed
[    1.200103] smsc911x smsc911x.0: eth0: attached PHY driver [SMSC
LAN8700] (mii_bus:phy_addr=smsc911x-0:01, irq=-1)
[    1.211242] smsc911x smsc911x.0: eth0: MAC Address: 00:50:c2:d9:d1:09
[    1.218811] usbcore: registered new interface driver asix
[    1.224822] usbcore: registered new interface driver cdc_ether
[    1.231231] usbcore: registered new interface driver net1080
[    1.237487] usbcore: registered new interface driver cdc_subset
[    1.244018] usbcore: registered new interface driver zaurus
[    1.250244] usbcore: registered new interface driver cdc_ncm
[    1.257537] usbcore: registered new interface driver cdc_wdm
[    1.263519] Initializing USB Mass Storage driver...
[    1.268981] usbcore: registered new interface driver usb-storage
[    1.275299] USB Mass Storage support registered.
[    1.280853] usbcore: registered new interface driver libusual
[    1.287261] usbcore: registered new interface driver usbtest
[    1.294189] mousedev: PS/2 mouse device common for all mice
[    1.301727] input: TWL4030 Keypad as
/devices/platform/omap_i2c.1/i2c-1/1-004a/twl4030_keypad/input/input0
[    1.316802] ads7846 spi1.0: touchscreen, irq 271
[    1.323455] input: ADS7846 Touchscreen as
/devices/platform/omap2_mcspi.1/spi_master/spi1/spi1.0/input/input1
[    1.336853] input: twl4030_pwrbutton as
/devices/platform/omap_i2c.1/i2c-1/1-0049/twl4030_pwrbutton/input/input2
[    1.348815] twl_rtc twl_rtc: Enabling TWL-RTC
[    1.356140] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    1.363494] i2c /dev entries driver
[    1.369476] Driver for 1-wire Dallas network protocol.
[    1.376983] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
[    1.384918] twl4030_wdt twl4030_wdt: Failed to register misc device
[    1.391510] twl4030_wdt: probe of twl4030_wdt failed with error -16
Timed out after 300 seconds


> ---
> ?arch/arm/mach-omap1/timer32k.c ? ? ? ? ? | ? ?6 ++-
> ?arch/arm/mach-omap2/timer.c ? ? ? ? ? ? ?| ? 99 +++++++++++++++++++++------
> ?arch/arm/plat-omap/counter_32k.c ? ? ? ? | ?108 +++++++++++++++---------------
> ?arch/arm/plat-omap/include/plat/common.h | ? ?2 +-
> ?4 files changed, 138 insertions(+), 77 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
> index 325b9a0..6262e11 100644
> --- a/arch/arm/mach-omap1/timer32k.c
> +++ b/arch/arm/mach-omap1/timer32k.c
> @@ -71,6 +71,7 @@
>
> ?/* 16xx specific defines */
> ?#define OMAP1_32K_TIMER_BASE ? ? ? ? ? 0xfffb9000
> +#define OMAP1_32KSYNC_TIMER_BASE ? ? ? 0xfffbc400
> ?#define OMAP1_32K_TIMER_CR ? ? ? ? ? ? 0x08
> ?#define OMAP1_32K_TIMER_TVR ? ? ? ? ? ?0x00
> ?#define OMAP1_32K_TIMER_TCR ? ? ? ? ? ?0x04
> @@ -184,7 +185,10 @@ static __init void omap_init_32k_timer(void)
> ?*/
> ?bool __init omap_32k_timer_init(void)
> ?{
> - ? ? ? omap_init_clocksource_32k();
> + ? ? ? u32 pbase;
> +
> + ? ? ? pbase = cpu_is_omap16xx() ? OMAP1_32KSYNC_TIMER_BASE : NULL;
> + ? ? ? omap_init_clocksource_32k(pbase, SZ_1K);
> ? ? ? ?omap_init_32k_timer();
>
> ? ? ? ?return true;
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index ecec873..2afc4ab 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -243,22 +243,8 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
> ?}
>
> ?/* Clocksource code */
> -
> -#ifdef CONFIG_OMAP_32K_TIMER
> -/*
> - * When 32k-timer is enabled, don't use GPTimer for clocksource
> - * instead, just leave default clocksource which uses the 32k
> - * sync counter. ?See clocksource setup in plat-omap/counter_32k.c
> - */
> -
> -static void __init omap2_gp_clocksource_init(int unused, const char *dummy)
> -{
> - ? ? ? omap_init_clocksource_32k();
> -}
> -
> -#else
> -
> ?static struct omap_dm_timer clksrc;
> +static bool use_gptimer_clksrc;
>
> ?/*
> ?* clocksource
> @@ -285,7 +271,33 @@ static u32 notrace dmtimer_read_sched_clock(void)
> ?}
>
> ?/* Setup free-running counter for clocksource */
> -static void __init omap2_gp_clocksource_init(int gptimer_id,
> +static int __init omap2_sync32k_clocksource_init(void)
> +{
> + ? ? ? int ret;
> + ? ? ? struct omap_hwmod *oh;
> + ? ? ? struct resource res;
> + ? ? ? const char *oh_name = "counter_32k";
> +
> + ? ? ? oh = omap_hwmod_lookup(oh_name);
> + ? ? ? if (!oh || oh->slaves_cnt == 0)
> + ? ? ? ? ? ? ? return -ENODEV;
> +
> + ? ? ? ret = omap_hwmod_get_resource_byname(oh, IORESOURCE_MEM, NULL, &res);
> + ? ? ? if (ret) {
> + ? ? ? ? ? ? ? pr_warn("%s: failed to get counter_32k resource (%d)\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? __func__, ret);
> + ? ? ? ? ? ? ? return ret;
> + ? ? ? }
> +
> + ? ? ? ret = omap_init_clocksource_32k(res.start, resource_size(&res));
> + ? ? ? if (ret)
> + ? ? ? ? ? ? ? pr_warn("%s: failed to initialize counter_32k (%d)\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? __func__, ret);
> +
> + ? ? ? return ret;
> +}
> +
> +static void __init omap2_gptimer_clocksource_init(int gptimer_id,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?const char *fck_source)
> ?{
> ? ? ? ?int res;
> @@ -293,9 +305,6 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
> ? ? ? ?res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);
> ? ? ? ?BUG_ON(res);
>
> - ? ? ? pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
> - ? ? ? ? ? ? ? gptimer_id, clksrc.rate);
> -
> ? ? ? ?__omap_dm_timer_load_start(&clksrc,
> ? ? ? ? ? ? ? ? ? ? ? ?OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
> ? ? ? ?setup_sched_clock(dmtimer_read_sched_clock, 32, clksrc.rate);
> @@ -303,15 +312,36 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
> ? ? ? ?if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
> ? ? ? ? ? ? ? ?pr_err("Could not register clocksource %s\n",
> ? ? ? ? ? ? ? ? ? ? ? ?clocksource_gpt.name);
> + ? ? ? else
> + ? ? ? ? ? ? ? pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
> + ? ? ? ? ? ? ? ? ? ? ? gptimer_id, clksrc.rate);
> +}
> +
> +static void __init omap2_clocksource_init(int gptimer_id,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? const char *fck_source)
> +{
> + ? ? ? /*
> + ? ? ? ?* First give preference to kernel parameter configuration
> + ? ? ? ?* by user (clocksource="gp timer").
> + ? ? ? ?*
> + ? ? ? ?* In case of missing kernel parameter for clocksource,
> + ? ? ? ?* first check for availability for 32k-sync timer, in case
> + ? ? ? ?* of failure in finding 32k_counter module or registering
> + ? ? ? ?* it as clocksource, execution will fallback to gp-timer.
> + ? ? ? ?*/
> + ? ? ? if (use_gptimer_clksrc == true)
> + ? ? ? ? ? ? ? omap2_gptimer_clocksource_init(gptimer_id, fck_source);
> + ? ? ? else if (omap2_sync32k_clocksource_init())
> + ? ? ? ? ? ? ? /* Fall back to gp-timer code */
> + ? ? ? ? ? ? ? omap2_gptimer_clocksource_init(gptimer_id, fck_source);
> ?}
> -#endif
>
> ?#define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src, ? ? ? ? ? ? ? ? \
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?clksrc_nr, clksrc_src) ? ? ? ? ? ? ? ? ?\
> ?static void __init omap##name##_timer_init(void) ? ? ? ? ? ? ? ? ? ? ? \
> ?{ ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> ? ? ? ?omap2_gp_clockevent_init((clkev_nr), clkev_src); ? ? ? ? ? ? ? ?\
> - ? ? ? omap2_gp_clocksource_init((clksrc_nr), clksrc_src); ? ? ? ? ? ? \
> + ? ? ? omap2_clocksource_init((clksrc_nr), clksrc_src); ? ? ? ? ? ? ? ?\
> ?}
>
> ?#define OMAP_SYS_TIMER(name) ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> @@ -342,7 +372,7 @@ static DEFINE_TWD_LOCAL_TIMER(twd_local_timer,
> ?static void __init omap4_timer_init(void)
> ?{
> ? ? ? ?omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE);
> - ? ? ? omap2_gp_clocksource_init(2, OMAP4_MPU_SOURCE);
> + ? ? ? omap2_clocksource_init(2, OMAP4_MPU_SOURCE);
> ?#ifdef CONFIG_LOCAL_TIMERS
> ? ? ? ?/* Local timers are not supprted on OMAP4430 ES1.0 */
> ? ? ? ?if (omap_rev() != OMAP4430_REV_ES1_0) {
> @@ -510,3 +540,28 @@ static int __init omap2_dm_timer_init(void)
> ? ? ? ?return 0;
> ?}
> ?arch_initcall(omap2_dm_timer_init);
> +
> +/**
> + * omap2_override_clocksource - clocksource override with user configuration
> + *
> + * Allows user to override default clocksource, using kernel parameter
> + * ? clocksource="gp timer"
> + *
> + * Note that, here we are using same standard kernel parameter "clocksource=",
> + * and not introducing any OMAP specific interface.
> + */
> +static int __init omap2_override_clocksource(char *str)
> +{
> + ? ? ? if (!str)
> + ? ? ? ? ? ? ? return 0;
> + ? ? ? /*
> + ? ? ? ?* For OMAP architecture, we only have two options
> + ? ? ? ?* ? ?- sync_32k (default)
> + ? ? ? ?* ? ?- gp timer
> + ? ? ? ?*/
> + ? ? ? if (!strcmp(str, "gp timer"))
> + ? ? ? ? ? ? ? use_gptimer_clksrc = true;
> +
> + ? ? ? return 0;
> +}
> +early_param("clocksource", omap2_override_clocksource);
> diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
> index 5068fe5..3e3cdab 100644
> --- a/arch/arm/plat-omap/counter_32k.c
> +++ b/arch/arm/plat-omap/counter_32k.c
> @@ -27,19 +27,20 @@
>
> ?#include <plat/clock.h>
>
> +/* OMAP2_32KSYNCNT_CR_OFF: offset of 32ksync counter register */
> +#define OMAP2_32KSYNCNT_CR_OFF ? ? ? ? 0x10
> +
> ?/*
> ?* 32KHz clocksource ... always available, on pretty most chips except
> ?* OMAP 730 and 1510. ?Other timers could be used as clocksources, with
> ?* higher resolution in free-running counter modes (e.g. 12 MHz xtal),
> ?* but systems won't necessarily want to spend resources that way.
> ?*/
> -static void __iomem *timer_32k_base;
> -
> -#define OMAP16XX_TIMER_32K_SYNCHRONIZED ? ? ? ? ? ? ? ?0xfffbc410
> +static void __iomem *sync32k_cnt_reg;
>
> ?static u32 notrace omap_32k_read_sched_clock(void)
> ?{
> - ? ? ? return timer_32k_base ? __raw_readl(timer_32k_base) : 0;
> + ? ? ? return sync32k_cnt_reg ? __raw_readl(sync32k_cnt_reg) : 0;
> ?}
>
> ?/**
> @@ -59,7 +60,7 @@ void read_persistent_clock(struct timespec *ts)
> ? ? ? ?struct timespec *tsp = &persistent_ts;
>
> ? ? ? ?last_cycles = cycles;
> - ? ? ? cycles = timer_32k_base ? __raw_readl(timer_32k_base) : 0;
> + ? ? ? cycles = sync32k_cnt_reg ? __raw_readl(sync32k_cnt_reg) : 0;
> ? ? ? ?delta = cycles - last_cycles;
>
> ? ? ? ?nsecs = clocksource_cyc2ns(delta, persistent_mult, persistent_shift);
> @@ -68,54 +69,55 @@ void read_persistent_clock(struct timespec *ts)
> ? ? ? ?*ts = *tsp;
> ?}
>
> -int __init omap_init_clocksource_32k(void)
> +/**
> + * omap_init_clocksource_32k - setup and register counter 32k as a
> + * kernel clocksource
> + * @pbase: base addr of counter_32k module
> + * @size: size of counter_32k to map
> + *
> + * Returns 0 upon success or negative error code upon failure.
> + *
> + */
> +int __init omap_init_clocksource_32k(u32 pbase, unsigned long size)
> ?{
> - ? ? ? static char err[] __initdata = KERN_ERR
> - ? ? ? ? ? ? ? ? ? ? ? "%s: can't register clocksource!\n";
> -
> - ? ? ? if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
> - ? ? ? ? ? ? ? u32 pbase;
> - ? ? ? ? ? ? ? unsigned long size = SZ_4K;
> - ? ? ? ? ? ? ? void __iomem *base;
> - ? ? ? ? ? ? ? struct clk *sync_32k_ick;
> -
> - ? ? ? ? ? ? ? if (cpu_is_omap16xx()) {
> - ? ? ? ? ? ? ? ? ? ? ? pbase = OMAP16XX_TIMER_32K_SYNCHRONIZED;
> - ? ? ? ? ? ? ? ? ? ? ? size = SZ_1K;
> - ? ? ? ? ? ? ? } else if (cpu_is_omap2420())
> - ? ? ? ? ? ? ? ? ? ? ? pbase = OMAP2420_32KSYNCT_BASE + 0x10;
> - ? ? ? ? ? ? ? else if (cpu_is_omap2430())
> - ? ? ? ? ? ? ? ? ? ? ? pbase = OMAP2430_32KSYNCT_BASE + 0x10;
> - ? ? ? ? ? ? ? else if (cpu_is_omap34xx())
> - ? ? ? ? ? ? ? ? ? ? ? pbase = OMAP3430_32KSYNCT_BASE + 0x10;
> - ? ? ? ? ? ? ? else if (cpu_is_omap44xx())
> - ? ? ? ? ? ? ? ? ? ? ? pbase = OMAP4430_32KSYNCT_BASE + 0x10;
> - ? ? ? ? ? ? ? else
> - ? ? ? ? ? ? ? ? ? ? ? return -ENODEV;
> -
> - ? ? ? ? ? ? ? /* For this to work we must have a static mapping in io.c for this area */
> - ? ? ? ? ? ? ? base = ioremap(pbase, size);
> - ? ? ? ? ? ? ? if (!base)
> - ? ? ? ? ? ? ? ? ? ? ? return -ENODEV;
> -
> - ? ? ? ? ? ? ? sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
> - ? ? ? ? ? ? ? if (!IS_ERR(sync_32k_ick))
> - ? ? ? ? ? ? ? ? ? ? ? clk_enable(sync_32k_ick);
> -
> - ? ? ? ? ? ? ? timer_32k_base = base;
> -
> - ? ? ? ? ? ? ? /*
> - ? ? ? ? ? ? ? ?* 120000 rough estimate from the calculations in
> - ? ? ? ? ? ? ? ?* __clocksource_updatefreq_scale.
> - ? ? ? ? ? ? ? ?*/
> - ? ? ? ? ? ? ? clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 32768, NSEC_PER_SEC, 120000);
> -
> - ? ? ? ? ? ? ? if (clocksource_mmio_init(base, "32k_counter", 32768, 250, 32,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? clocksource_mmio_readl_up))
> - ? ? ? ? ? ? ? ? ? ? ? printk(err, "32k_counter");
> -
> - ? ? ? ? ? ? ? setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
> + ? ? ? int ret;
> + ? ? ? void __iomem *base;
> + ? ? ? struct clk *sync32k_ick;
> +
> + ? ? ? if (!pbase || !size)
> + ? ? ? ? ? ? ? return -ENODEV;
> + ? ? ? /*
> + ? ? ? ?* For this to work we must have a static mapping in io.c
> + ? ? ? ?* for this area
> + ? ? ? ?*/
> + ? ? ? base = ioremap(pbase, size);
> + ? ? ? if (!base) {
> + ? ? ? ? ? ? ? pr_err("32k_counter: failed to map base addr\n");
> + ? ? ? ? ? ? ? return -ENODEV;
> ? ? ? ?}
> - ? ? ? return 0;
> +
> + ? ? ? sync32k_ick = clk_get(NULL, "omap_32ksync_ick");
> + ? ? ? if (!IS_ERR(sync32k_ick))
> + ? ? ? ? ? ? ? clk_enable(sync32k_ick);
> +
> + ? ? ? sync32k_cnt_reg = base + OMAP2_32KSYNCNT_CR_OFF;
> +
> + ? ? ? /*
> + ? ? ? ?* 120000 rough estimate from the calculations in
> + ? ? ? ?* __clocksource_updatefreq_scale.
> + ? ? ? ?*/
> + ? ? ? clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
> + ? ? ? ? ? ? ? ? ? ? ? 32768, NSEC_PER_SEC, 120000);
> +
> + ? ? ? ret = clocksource_mmio_init(base, "32k_counter", 32768, 250, 32,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? clocksource_mmio_readl_up);
> + ? ? ? if (ret) {
> + ? ? ? ? ? ? ? pr_err("32k_counter: can't register clocksource\n");
> + ? ? ? ? ? ? ? return ret;
> + ? ? ? }
> +
> + ? ? ? setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
> + ? ? ? pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
> +
> + ? ? ? return ret;
> ?}
> diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
> index a557b84..eed5335 100644
> --- a/arch/arm/plat-omap/include/plat/common.h
> +++ b/arch/arm/plat-omap/include/plat/common.h
> @@ -30,7 +30,7 @@
> ?#include <plat/i2c.h>
> ?#include <plat/omap_hwmod.h>
>
> -extern int __init omap_init_clocksource_32k(void);
> +extern int __init omap_init_clocksource_32k(u32 pbase, unsigned long size);
>
> ?extern void __init omap_check_revision(void);
>
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
