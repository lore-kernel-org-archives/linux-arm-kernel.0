From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 8 Aug 2013 10:22:46 -0700
Subject: Enable arm_global_timer for Zynq brakes boot
In-Reply-To: <20130808171650.GH27325@e106331-lin.cambridge.arm.com>
References: <068436c6-ff98-428f-8875-bb1c6f86466b@TX2EHSMHS008.ehs.local>
 <51F97CE3.9030306@linaro.org>
 <15e19315-ce88-4d3c-bad9-0a37d9e52f6b@CO1EHSMHS007.ehs.local>
 <51F99747.4060901@linaro.org>
 <a48f159a-e88c-42fa-b76b-662302d3a585@AM1EHSMHS003.ehs.local>
 <51FA9AE8.1060004@linaro.org>
 <1c83c081-60c6-49e3-a85c-f64dd5be0e60@CH1EHSMHS030.ehs.local>
 <51FA9F54.3060704@linaro.org>
 <c44e700d-64da-487b-a975-1263d7505371@CH1EHSMHS043.ehs.local>
 <20130808171650.GH27325@e106331-lin.cambridge.arm.com>
Message-ID: <2ce85f6c-36a8-4fb8-8e70-693e87de4e18@VA3EHSMHS028.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 06:16:50PM +0100, Mark Rutland wrote:
> On Thu, Aug 08, 2013 at 06:11:26PM +0100, S??ren Brinkmann wrote:
> > Hi Daniel,
> > 
> > On Thu, Aug 01, 2013 at 07:48:04PM +0200, Daniel Lezcano wrote:
> > > On 08/01/2013 07:43 PM, S??ren Brinkmann wrote:
> > > > On Thu, Aug 01, 2013 at 07:29:12PM +0200, Daniel Lezcano wrote:
> > > >> On 08/01/2013 01:38 AM, S??ren Brinkmann wrote:
> > > >>> On Thu, Aug 01, 2013 at 01:01:27AM +0200, Daniel Lezcano wrote:
> > > >>>> On 08/01/2013 12:18 AM, S??ren Brinkmann wrote:
> > > >>>>> On Wed, Jul 31, 2013 at 11:08:51PM +0200, Daniel Lezcano wrote:
> > > >>>>>> On 07/31/2013 10:58 PM, S??ren Brinkmann wrote:
> > > >>>>>>> On Wed, Jul 31, 2013 at 10:49:06PM +0200, Daniel Lezcano wrote:
> > > >>>>>>>> On 07/31/2013 12:34 AM, S??ren Brinkmann wrote:
> > > >>>>>>>>> On Tue, Jul 30, 2013 at 10:47:15AM +0200, Daniel Lezcano wrote:
> > > >>>>>>>>>> On 07/30/2013 02:03 AM, S??ren Brinkmann wrote:
> > > >>>>>>>>>>> Hi Daniel,
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> On Mon, Jul 29, 2013 at 02:51:49PM +0200, Daniel Lezcano wrote:
> > > >>>>>>>>>>> (snip)
> > > >>>>>>>>>>>>
> > > >>>>>>>>>>>> the CPUIDLE_FLAG_TIMER_STOP flag tells the cpuidle framework the local
> > > >>>>>>>>>>>> timer will be stopped when entering to the idle state. In this case, the
> > > >>>>>>>>>>>> cpuidle framework will call clockevents_notify(ENTER) and switches to a
> > > >>>>>>>>>>>> broadcast timer and will call clockevents_notify(EXIT) when exiting the
> > > >>>>>>>>>>>> idle state, switching the local timer back in use.
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> I've been thinking about this, trying to understand how this makes my
> > > >>>>>>>>>>> boot attempts on Zynq hang. IIUC, the wrongly provided TIMER_STOP flag
> > > >>>>>>>>>>> would make the timer core switch to a broadcast device even though it
> > > >>>>>>>>>>> wouldn't be necessary. But shouldn't it still work? It sounds like we do
> > > >>>>>>>>>>> something useless, but nothing wrong in a sense that it should result in
> > > >>>>>>>>>>> breakage. I guess I'm missing something obvious. This timer system will
> > > >>>>>>>>>>> always remain a mystery to me.
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> Actually this more or less leads to the question: What is this
> > > >>>>>>>>>>> 'broadcast timer'. I guess that is some clockevent device which is
> > > >>>>>>>>>>> common to all cores? (that would be the cadence_ttc for Zynq). Is the
> > > >>>>>>>>>>> hang pointing to some issue with that driver?
> > > >>>>>>>>>>
> > > >>>>>>>>>> If you look at the /proc/timer_list, which timer is used for broadcasting ?
> > > >>>>>>>>>
> > > >>>>>>>>> So, the correct run results (full output attached).
> > > >>>>>>>>>
> > > >>>>>>>>> The vanilla kernel uses the twd timers as local timers and the TTC as
> > > >>>>>>>>> broadcast device:
> > > >>>>>>>>>     Tick Device: mode:     1
> > > >>>>>>>>>     Broadcast device
> > > >>>>>>>>>     Clock Event Device: ttc_clockevent
> > > >>>>>>>>>
> > > >>>>>>>>> When I remove the offending CPUIDLE flag and add the DT fragment to
> > > >>>>>>>>> enable the global timer, the twd timers are still used as local timers
> > > >>>>>>>>> and the broadcast device is the global timer:
> > > >>>>>>>>>     Tick Device: mode:     1
> > > >>>>>>>>>     Broadcast device
> > > >>>>>>>>>     Clock Event Device: arm_global_timer
> > > >>>>>>>>>
> > > >>>>>>>>> Again, since boot hangs in the actually broken case, I don't see way to
> > > >>>>>>>>> obtain this information for that case.
> > > >>>>>>>>
> > > >>>>>>>> Can't you use the maxcpus=1 option to ensure the system to boot up ?
> > > >>>>>>>
> > > >>>>>>> Right, that works. I forgot about that option after you mentioned, that
> > > >>>>>>> it is most likely not that useful.
> > > >>>>>>>
> > > >>>>>>> Anyway, this are those sysfs files with an unmodified cpuidle driver and
> > > >>>>>>> the gt enabled and having maxcpus=1 set.
> > > >>>>>>>
> > > >>>>>>> /proc/timer_list:
> > > >>>>>>>       Tick Device: mode:     1
> > > >>>>>>>       Broadcast device
> > > >>>>>>>       Clock Event Device: arm_global_timer
> > > >>>>>>>        max_delta_ns:   12884902005
> > > >>>>>>>        min_delta_ns:   1000
> > > >>>>>>>        mult:           715827876
> > > >>>>>>>        shift:          31
> > > >>>>>>>        mode:           3
> > > >>>>>>
> > > >>>>>> Here the mode is 3 (CLOCK_EVT_MODE_ONESHOT)
> > > >>>>>>
> > > >>>>>> The previous timer_list output you gave me when removing the offending
> > > >>>>>> cpuidle flag, it was 1 (CLOCK_EVT_MODE_SHUTDOWN).
> > > >>>>>>
> > > >>>>>> Is it possible you try to get this output again right after onlining the
> > > >>>>>> cpu1 in order to check if the broadcast device switches to SHUTDOWN ?
> > > >>>>>
> > > >>>>> How do I do that? I tried to online CPU1 after booting with maxcpus=1
> > > >>>>> and that didn't end well:
> > > >>>>>         # echo 1 > online && cat /proc/timer_list
> > > >>>>
> > > >>>> Hmm, I was hoping to have a small delay before the kernel hangs but
> > > >>>> apparently this is not the case... :(
> > > >>>>
> > > >>>> I suspect the global timer is shutdown at one moment but I don't
> > > >>>> understand why and when.
> > > >>>>
> > > >>>> Can you add a stack trace in the "clockevents_shutdown" function with
> > > >>>> the clockevent device name ? Perhaps, we may see at boot time an
> > > >>>> interesting trace when it hangs.
> > > >>>
> > > >>> I did this change:
> > > >>>   diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
> > > >>>   index 38959c8..3ab11c1 100644
> > > >>>   --- a/kernel/time/clockevents.c
> > > >>>   +++ b/kernel/time/clockevents.c
> > > >>>   @@ -92,6 +92,8 @@ void clockevents_set_mode(struct clock_event_device *dev,
> > > >>>     */
> > > >>>    void clockevents_shutdown(struct clock_event_device *dev)
> > > >>>    {
> > > >>>   +       pr_info("ce->name:%s\n", dev->name);
> > > >>>   +       dump_stack();
> > > >>>           clockevents_set_mode(dev, CLOCK_EVT_MODE_SHUTDOWN);
> > > >>>           dev->next_event.tv64 = KTIME_MAX;
> > > >>>    }
> > > >>>
> > > >>> It is hit a few times during boot, so I attach a full boot log. I really
> > > >>> don't know what to look for, but I hope you can spot something in it. I
> > > >>> really appreciate you taking the time.
> > > >>
> > > >> Thanks for the traces.
> > > >
> > > > Sure.
> > > >
> > > >>
> > > >> If you try without the ttc_clockevent configured in the kernel (but with
> > > >> twd and gt), does it boot ?
> > > >
> > > > Absence of the TTC doesn't seem to make any difference. It hangs at the
> > > > same location.
> > >
> > > Ok, IMO there is a problem with the broadcast device registration (may
> > > be vs twd).
> > 
> > I have an idea, but no real evidence to prove it:
> > Some of the registers in the arm_global_timer are banked per CPU. I.e.
> > some code must be executed on the CPU the timer is associated with
> > (struct clock_event_device.cpumask) to have the intended effect
> > As far as I can tell, there is no guarantee, that the set_mode()
> > and program_next_event() calls execute on the correct CPU.
> 
> I believe the core clockevents code enforces that, or all other percpu
> clockevent_device drivers would be horrifically broken.

Well, I have some evidence. I booted into the system (bootlog attached).
It seems to be luck to not deadlock.
In between I also had some additional print statements in the global
timer driver which seemed to back up my suspicion.

This is the ugly hack I added to the clockevents core:

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 38959c8..419c973 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -59,6 +59,20 @@ u64 clockevent_delta2ns(unsigned long latch, struct clock_event_device *evt)
 }
 EXPORT_SYMBOL_GPL(clockevent_delta2ns);
 
+struct ce_set_mode_args {
+	struct clock_event_device *dev;
+	enum clock_event_mode mode;
+};
+
+static struct ce_set_mode_args ce_mode_args;
+
+static void ce_set_mode_xcall(void *info)
+{
+	struct ce_set_mode_args *args = info;
+
+	args->dev->set_mode(args->mode, args->dev);
+}
+
 /**
  * clockevents_set_mode - set the operating mode of a clock event device
  * @dev:	device to modify
@@ -70,7 +84,10 @@ void clockevents_set_mode(struct clock_event_device *dev,
 				 enum clock_event_mode mode)
 {
 	if (dev->mode != mode) {
-		dev->set_mode(mode, dev);
+		ce_mode_args.mode = mode;
+		ce_mode_args.dev = dev;
+		smp_call_function_any(dev->cpumask, ce_set_mode_xcall,
+				&ce_mode_args, 1);
 		dev->mode = mode;
 
 		/*
@@ -96,6 +113,20 @@ void clockevents_shutdown(struct clock_event_device *dev)
 	dev->next_event.tv64 = KTIME_MAX;
 }
 
+struct ce_prog_eve_args {
+	struct clock_event_device *dev;
+	unsigned long clc;
+};
+
+static struct ce_prog_eve_args ce_prog_eve_args;
+
+static void  ce_prog_event_xcall(void *info)
+{
+	struct ce_prog_eve_args *args = info;
+
+	args->dev->set_next_event(args->clc, args->dev);
+}
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST
 
 /* Limit min_delta to a jiffie */
@@ -141,6 +172,7 @@ static int clockevents_program_min_delta(struct clock_event_device *dev)
 	unsigned long long clc;
 	int64_t delta;
 	int i;
+	int cpu;
 
 	for (i = 0;;) {
 		delta = dev->min_delta_ns;
@@ -151,8 +183,11 @@ static int clockevents_program_min_delta(struct clock_event_device *dev)
 
 		dev->retries++;
 		clc = ((unsigned long long) delta * dev->mult) >> dev->shift;
-		if (dev->set_next_event((unsigned long) clc, dev) == 0)
-			return 0;
+		ce_prog_eve_args.clc = clc;
+		ce_prog_eve_args.dev = dev;
+		smp_call_function_any(dev->cpumask, ce_prog_event_xcall,
+				&ce_prog_eve_args, 1);
+		return 0;
 
 		if (++i > 2) {
 			/*
@@ -179,6 +214,7 @@ static int clockevents_program_min_delta(struct clock_event_device *dev)
 {
 	unsigned long long clc;
 	int64_t delta;
+	int ret;
 
 	delta = dev->min_delta_ns;
 	dev->next_event = ktime_add_ns(ktime_get(), delta);
@@ -188,7 +224,13 @@ static int clockevents_program_min_delta(struct clock_event_device *dev)
 
 	dev->retries++;
 	clc = ((unsigned long long) delta * dev->mult) >> dev->shift;
-	return dev->set_next_event((unsigned long) clc, dev);
+	ce_prog_eve_args.clc = clc;
+	ce_prog_eve_args.dev = dev;
+	smp_call_function_any(dev->cpumask, ce_prog_event_xcall,
+			&ce_prog_eve_args, 1);
+	ret = 0;
+
+	return ret;
 }
 
 #endif /* CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST */
@@ -230,7 +272,11 @@ int clockevents_program_event(struct clock_event_device *dev, ktime_t expires,
 	delta = max(delta, (int64_t) dev->min_delta_ns);
 
 	clc = ((unsigned long long) delta * dev->mult) >> dev->shift;
-	rc = dev->set_next_event((unsigned long) clc, dev);
+	ce_prog_eve_args.clc = clc;
+	ce_prog_eve_args.dev = dev;
+	smp_call_function_any(dev->cpumask, ce_prog_event_xcall,
+			&ce_prog_eve_args, 1);
+	rc = 0;
 
 	return (rc && force) ? clockevents_program_min_delta(dev) : rc;
 }


 	S??ren

-------------- next part --------------


U-Boot 2013.04 (Jun 19 2013 - 08:17:40)

I2C:   ready
Memory: ECC disabled
DRAM:  1 GiB
WARNING: Caches not enabled
MMC:   zynq_sdhci: 0
SF: Detected N25Q128A with page size 128 KiB, total 32 MiB
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
Net:   Gem.e000b000
Hit any key to stop autoboot:  3  2  1  0 
TFTPing Linux to RAM...
Gem.e000b000 Waiting for PHY auto negotiation to complete..... done
Using Gem.e000b000 device
TFTP from server 10.10.70.101; our IP address is 10.10.70.102
Filename 'uImage'.
Load address: 0x3000000
Loading: *#################################################################
	 #################################################################
	 #####################################
	 4.1 MiB/s
done
Bytes transferred = 2449256 (255f68 hex)
Gem.e000b000:7 is connected to Gem.e000b000.  Reconnecting to Gem.e000b000
Gem.e000b000 Waiting for PHY auto negotiation to complete..... done
Using Gem.e000b000 device
TFTP from server 10.10.70.101; our IP address is 10.10.70.102
Filename 'devicetree.dtb'.
Load address: 0x2a00000
Loading: *#
	 127.9 KiB/s
done
Bytes transferred = 2759 (ac7 hex)
Gem.e000b000:7 is connected to Gem.e000b000.  Reconnecting to Gem.e000b000
Gem.e000b000 Waiting for PHY auto negotiation to complete..... done
Using Gem.e000b000 device
TFTP from server 10.10.70.101; our IP address is 10.10.70.102
Filename 'uramdisk.image.gz'.
Load address: 0x2000000
Loading: *#################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 ###################################
	 4.2 MiB/s
done
Bytes transferred = 5284624 (50a310 hex)
## Booting kernel from Legacy Image at 03000000 ...
   Image Name:   Linux-3.11.0-rc3-00001-gceefecf-
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2449192 Bytes = 2.3 MiB
   Load Address: 00008000
   Entry Point:  00008000
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at 02000000 ...
   Image Name:   
   Image Type:   ARM Linux RAMDisk Image (gzip compressed)
   Data Size:    5284560 Bytes = 5 MiB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 02a00000
   Booting using the fdt blob at 0x02a00000
   Loading Kernel Image ... OK
OK
   Loading Ramdisk to 1faf5000, end 1ffff2d0 ... OK
   Loading Device Tree to 1faf1000, end 1faf4ac6 ... OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0

[    0.000000] Linux version 3.11.0-rc3-00001-gceefecf-dirty (sorenb at xsjandreislx) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-104) ) #93 SMP PREEMPT Thu Aug 8 10:12:39 PDT 2013

[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=18c5387d

[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache

[    0.000000] Machine: Xilinx Zynq Platform, model: Zynq ZC706 Development Board

[    0.000000] bootconsole [earlycon0] enabled

[    0.000000] cma: CMA: reserved 16 MiB at 2e800000

[    0.000000] Memory policy: ECC disabled, Data cache writealloc

[    0.000000] PERCPU: Embedded 9 pages/cpu @c149c000 s14720 r8192 d13952 u36864

[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260624

[    0.000000] Kernel command line: console=ttyPS0,115200 earlyprintk

[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)

[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)

[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)

[    0.000000] Memory: 1005012K/1048576K available (4887K kernel code, 307K rwdata, 1564K rodata, 338K init, 5699K bss, 43564K reserved, 270336K highmem)

[    0.000000] Virtual kernel memory layout:

[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)

[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)

[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)

[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)

[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)

[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)

[    0.000000]       .text : 0xc0008000 - 0xc065513c   (6453 kB)

[    0.000000]       .init : 0xc0656000 - 0xc06aa980   ( 339 kB)

[    0.000000]       .data : 0xc06ac000 - 0xc06f8c20   ( 308 kB)

[    0.000000]        .bss : 0xc06f8c20 - 0xc0c89aa4   (5700 kB)

[    0.000000] Preemptible hierarchical RCU implementation.

[    0.000000] 	RCU lockdep checking is enabled.

[    0.000000] 	Additional per-CPU info printed with stalls.

[    0.000000] 	RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.

[    0.000000] NR_IRQS:16 nr_irqs:16 16

[    0.000000] slcr mapped to f0004000

[    0.000000] Zynq clock init

[    0.000000] sched_clock: 32 bits at 333MHz, resolution 3ns, wraps every 12884ms

[    0.000000] ------------[ cut here ]------------

[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/smp.c:244 smp_call_function_single+0xac/0x1e8()

[    0.000000] Modules linked in:

[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.11.0-rc3-00001-gceefecf-dirty #93

[    0.000000] [<c0016a88>] (unwind_backtrace+0x0/0x128) from [<c0012d58>] (show_stack+0x20/0x24)

[    0.000000] [<c0012d58>] (show_stack+0x20/0x24) from [<c0465858>] (dump_stack+0x80/0xc4)

[    0.000000] [<c0465858>] (dump_stack+0x80/0xc4) from [<c0023a80>] (warn_slowpath_common+0x78/0x9c)

[    0.000000] [<c0023a80>] (warn_slowpath_common+0x78/0x9c) from [<c0023ad0>] (warn_slowpath_null+0x2c/0x34)

[    0.000000] [<c0023ad0>] (warn_slowpath_null+0x2c/0x34) from [<c0084d58>] (smp_call_function_single+0xac/0x1e8)

[    0.000000] [<c0084d58>] (smp_call_function_single+0xac/0x1e8) from [<c008552c>] (smp_call_function_any+0xe0/0x11c)

[    0.000000] [<c008552c>] (smp_call_function_any+0xe0/0x11c) from [<c0075458>] (clockevents_set_mode+0x40/0x7c)

[    0.000000] [<c0075458>] (clockevents_set_mode+0x40/0x7c) from [<c00754b4>] (clockevents_shutdown+0x20/0x30)

[    0.000000] [<c00754b4>] (clockevents_shutdown+0x20/0x30) from [<c0075850>] (clockevents_exchange_device+0x94/0xb8)

[    0.000000] [<c0075850>] (clockevents_exchange_device+0x94/0xb8) from [<c0075fb0>] (tick_check_new_device+0xc8/0x11c)

[    0.000000] [<c0075fb0>] (tick_check_new_device+0xc8/0x11c) from [<c007515c>] (clockevents_register_device+0xc0/0x134)

[    0.000000] [<c007515c>] (clockevents_register_device+0xc0/0x134) from [<c0075758>] (clockevents_config_and_register+0x2c/0x30)

[    0.000000] [<c0075758>] (clockevents_config_and_register+0x2c/0x30) from [<c037a24c>] (gt_clockevents_init+0x8c/0xb4)

[    0.000000] [<c037a24c>] (gt_clockevents_init+0x8c/0xb4) from [<c06820bc>] (global_timer_of_register+0x1e4/0x294)

[    0.000000] [<c06820bc>] (global_timer_of_register+0x1e4/0x294) from [<c0681a7c>] (clocksource_of_init+0x2c/0x54)

[    0.000000] [<c0681a7c>] (clocksource_of_init+0x2c/0x54) from [<c065eb98>] (zynq_timer_init+0x14/0x18)

[    0.000000] [<c065eb98>] (zynq_timer_init+0x14/0x18) from [<c0659ec8>] (time_init+0x24/0x34)

[    0.000000] [<c0659ec8>] (time_init+0x24/0x34) from [<c0656774>] (start_kernel+0x1cc/0x32c)

[    0.000000] [<c0656774>] (start_kernel+0x1cc/0x32c) from [<00008074>] (0x8074)

[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---

[    0.000000] ttc0 #0 at f0006000, irq=43

[    0.000000] Console: colour dummy device 80x30

[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar

[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8

[    0.000000] ... MAX_LOCK_DEPTH:          48

[    0.000000] ... MAX_LOCKDEP_KEYS:        8191

[    0.000000] ... CLASSHASH_SIZE:          4096

[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384

[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768

[    0.000000] ... CHAINHASH_SIZE:          16384

[    0.000000]  memory used by lock dependency info: 3695 kB

[    0.000000]  per task-struct memory footprint: 1152 bytes

[    0.269533] Calibrating delay loop... 1325.46 BogoMIPS (lpj=6627328)

[    0.312154] pid_max: default: 32768 minimum: 301

[    0.315192] Mount-cache hash table entries: 512

[    0.326370] CPU: Testing write buffer coherency: ok

[    0.326521] ftrace: allocating 16144 entries in 48 pages

[    0.367009] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000

[    0.367298] Setting up static identity map for 0xc046c318 - 0xc046c370

[    0.430300] CPU1: Booted secondary processor

[    0.517282] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001

[    0.518605] Brought up 2 CPUs

[    0.526120] SMP: Total of 2 processors activated (2657.48 BogoMIPS).

[    0.532544] CPU: All CPU(s) started in SVC mode.

[    0.541709] devtmpfs: initialized

[    0.560097] NET: Registered protocol family 16

[    0.566004] DMA: preallocated 256 KiB pool for atomic coherent allocations

[    0.579037] L310 cache controller enabled

[    0.579074] l2x0: 8 ways, CACHE_ID 0x410000c8, AUX_CTRL 0x72360000, Cache size: 524288 B

[    0.593862] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.

[    0.596377] hw-breakpoint: maximum watchpoint size is 4 bytes.

[    0.676943] bio: create slab <bio-0> at 0

[    0.682624] SCSI subsystem initialized

[    0.685426] usbcore: registered new interface driver usbfs

[    0.687002] usbcore: registered new interface driver hub

[    0.692621] usbcore: registered new device driver usb

[    0.707311] Switched to clocksource arm_global_timer

[    0.882154] NET: Registered protocol family 2

[    0.887819] TCP established hash table entries: 8192 (order: 4, 65536 bytes)

[    0.889741] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)

[    0.899642] TCP: Hash tables configured (established 8192 bind 8192)

[    0.902596] TCP: reno registered

[    0.905581] UDP hash table entries: 512 (order: 3, 40960 bytes)

[    0.912006] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)

[    0.919667] NET: Registered protocol family 1

[    0.924041] RPC: Registered named UNIX socket transport module.

[    0.928796] RPC: Registered udp transport module.

[    0.932906] RPC: Registered tcp transport module.

[    0.937728] RPC: Registered tcp NFSv4.1 backchannel transport module.

[    0.945378] Trying to unpack rootfs image as initramfs...

[    1.766936] Freeing initrd memory: 5160K (dfaf5000 - dffff000)

[    1.779937] bounce pool size: 64 pages

[    1.784050] jffs2: version 2.2. (NAND) (SUMMARY)  ?? 2001-2006 Red Hat, Inc.

[    1.786266] msgmni has been set to 1476

[    1.810310] io scheduler noop registered

[    1.810343] io scheduler deadline registered

[    1.813214] io scheduler cfq registered (default)

[    1.833806] e000?[    1.835799] console [ttyPS0] enabled, bootconsole disabled
[    1.835799] console [ttyPS0] enabled, bootconsole disabled

[    1.879905] brd: module loaded
[    1.904214] loop: module loaded
[    1.924904] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.932898] usbcore: registered new interface driver usb-storage
[    1.941629] mousedev: PS/2 mouse device common for all mice
[    1.949576] i2c /dev entries driver
[    1.956841] cpuidle: using governor ladder
[    1.960931] cpuidle: using governor menu
[    1.964752] Xilinx Zynq CpuIdle Driver started
[    1.970481] sdhci: Secure Digital Host Controller Interface driver
[    1.976524] sdhci: Copyright(c) Pierre Ossman
[    1.981168] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.989126] usbcore: registered new interface driver usbhid
[    1.994567] usbhid: USB HID core driver
[    1.999236] TCP: cubic registered
[    2.002456] NET: Registered protocol family 17
[    2.006950] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    2.014555] Registering SWP/SWPB emulation handler
[    2.023942] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    2.063376] Freeing unused kernel memory: 336K (c0656000 - c06aa000)

Welcome to [1mBuildroot 2013.08-git[0m!

Starting Media Directory...                                                    
Starting File System Check on Root Device...                                   
Starting Remount API VFS...                                                    
Started Runtime Directory                                              [[1;32m  OK  [0m]
Started Lock Directory                                                 [[1;32m  OK  [0m]
Started Set Up Additional Binary Formats                               [[1;32m  OK  [0m]
Starting Apply Kernel Variables...                                             
Starting Journal Service...                                                    
Started Journal Service                                                [[1;32m  OK  [0m]
Started POSIX Message Queue File System                                [[1;32m  OK  [0m]
Started Huge Pages File System                                         [[1;32m  OK  [0m]
Started Security File System                                           [[1;32m  OK  [0m]
Starting Debug File System...                                                  
Started Load Kernel Modules                                            [[1;32m  OK  [0m]
Started FUSE Control File System                                       [[1;32m  OK  [0m]
Started Configuration File System                                      [[1;32m  OK  [0m]
Starting Setup Virtual Console...                                              
Starting udev Coldplug all Devices...                                          
Starting udev Kernel Device Manager...                                         
Started Media Directory                                                [[1;32m  OK  [0m]
[   14.455828] udevd[470]: starting version 182
Started udev Kernel Device Manager                                     [[1;32m  OK  [0m]
Started File System Check on Root Device                               [[1;32m  OK  [0m]
Started Remount API VFS                                                [[1;32m  OK  [0m]
Started Apply Kernel Variables                                         [[1;32m  OK  [0m]
Started Debug File System                                              [[1;32m  OK  [0m]
Started Setup Virtual Console                                          [[1;32m  OK  [0m]
Starting Remount Root FS...                                                    
Started Remount Root FS                                                [[1;32m  OK  [0m]
Starting Load Random Seed...                                                   
Starting Recreate Volatile Files and Directories...                            
Started udev Coldplug all Devices                                      [[1;32m  OK  [0m]
Started Load Random Seed                                               [[1;32m  OK  [0m]
Started Recreate Volatile Files and Directories                        [[1;32m  OK  [0m]
Starting Permit User Sessions...                                               
Starting Login Service...                                                      
Starting D-Bus System Message Bus...                                           
Started Permit User Sessions                                           [[1;32m  OK  [0m]
Starting Serial Getty on ttyPS0...                                             
Started Serial Getty on ttyPS0                                         [[1;32m  OK  [0m]
Started D-Bus System Message Bus                                       [[1;32m  OK  [0m]
Started Login Service                                                  [[1;32m  OK  [0m]


Zynq Busybox System

zynq login: root
Password: 
# ls
# cat /proc/int
# cat /proc/interrupts [J
           CPU0       CPU1       
 27:        262          1       GIC  27  gt
 29:        739        732       GIC  29  twd
 43:          0          0       GIC  43  ttc_clockevent
 82:        217          0       GIC  82  xuartps
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0         51  Timer broadcast interrupts
IPI2:       1236       1291  Rescheduling interrupts
IPI3:          0          0  Function call interrupts
IPI4:         86         76  Single function call interrupts
IPI5:          0          0  CPU stop interrupts
Err:          0
# cat /proc/tim
# cat /proc/timer_[Jl
# cat /proc/timer_list [J
Timer List Version: v0.7
HRTIMER_MAX_CLOCK_BASES: 4
now at 87282945949 nsecs

cpu: 0
 clock 0:
  .base:       c149c718
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: <c149e670>, menu_hrtimer_notify, S:01, hrtimer_start, swapper/0/0
 # expires at 87283071244-87283071244 nsecs [in 125988 to 125988 nsecs]
 #1: <c149cac8>, tick_sched_timer, S:01, hrtimer_start, swapper/0/0
 # expires at 96080000000-96080000000 nsecs [in 8797054744 to 8797054744 nsecs]
 clock 1:
  .base:       c149c750
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     0 nsecs
active timers:
 clock 2:
  .base:       c149c788
  .index:      2
  .resolution: 1 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
 clock 3:
  .base:       c149c7c0
  .index:      3
  .resolution: 1 nsecs
  .get_time:   ktime_get_clocktai
  .offset:     0 nsecs
active timers:
  .expires_next   : 87283238554 nsecs
  .hres_active    : 1
  .nr_events      : 782
  .nr_retries     : 1
  .nr_hangs       : 0
  .max_hang_time  : 0 nsecs
  .nohz_mode      : 2
  .last_tick      : 87280000000 nsecs
  .tick_stopped   : 1
  .idle_jiffies   : 4294946023
  .idle_calls     : 1543
  .idle_sleeps    : 253
  .idle_entrytime : 87283083871 nsecs
  .idle_waketime  : 87283074220 nsecs
  .idle_exittime  : 87274123411 nsecs
  .idle_sleeptime : 84313098543 nsecs
  .iowait_sleeptime: 0 nsecs
  .last_jiffies   : 4294946024
  .next_jiffies   : 4294946904
  .idle_expires   : 96080000000 nsecs
jiffies: 4294946024

cpu: 1
 clock 0:
  .base:       c14a5718
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: <c14a5ac8>, tick_sched_timer, S:01, hrtimer_start_range_ns, swapper/1/0
 # expires at 87290000000-87290000000 nsecs [in 7054744 to 7054744 nsecs]
 #1: <ed886d80>, timerfd_tmrproc, S:01, hrtimer_start, systemd/1
 # expires at 102213360049-102213360049 nsecs [in 14930414793 to 14930414793 nsecs]
 clock 1:
  .base:       c14a5750
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     0 nsecs
active timers:
 clock 2:
  .base:       c14a5788
  .index:      2
  .resolution: 1 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
 clock 3:
  .base:       c14a57c0
  .index:      3
  .resolution: 1 nsecs
  .get_time:   ktime_get_clocktai
  .offset:     0 nsecs
active timers:
  .expires_next   : 87290000000 nsecs
  .hres_active    : 1
  .nr_events      : 787
  .nr_retries     : 0
  .nr_hangs       : 0
  .max_hang_time  : 0 nsecs
  .nohz_mode      : 2
  .last_tick      : 86900000000 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 4294945985
  .idle_calls     : 1208
  .idle_sleeps    : 180
  .idle_entrytime : 87275940901 nsecs
  .idle_waketime  : 86909367960 nsecs
  .idle_exittime  : 87273080476 nsecs
  .idle_sleeptime : 84847843417 nsecs
  .iowait_sleeptime: 0 nsecs
  .last_jiffies   : 4294946023
  .next_jiffies   : 4294946024
  .idle_expires   : 123360000000 nsecs
jiffies: 4294946024

Tick Device: mode:     1
Broadcast device
Clock Event Device: arm_global_timer
 max_delta_ns:   12884902005
 min_delta_ns:   1000
 mult:           715827876
 shift:          31
 mode:           3
 next_event:     96080000000 nsecs
 set_next_event: gt_clockevent_set_next_event
 set_mode:       gt_clockevent_set_mode
 event_handler:  tick_handle_oneshot_broadcast
 retries:        0

tick_broadcast_mask: 00000003
tick_broadcast_oneshot_mask: 00000000

Tick Device: mode:     1
Per CPU device: 0
Clock Event Device: local_timer
 max_delta_ns:   12884902005
 min_delta_ns:   1000
 mult:           715827876
 shift:          31
 mode:           3
 next_event:     87283401937 nsecs
 set_next_event: twd_set_next_event
 set_mode:       twd_set_mode
 event_handler:  hrtimer_interrupt
 retries:        0

Tick Device: mode:     1
Per CPU device: 1
Clock Event Device: local_timer
 max_delta_ns:   12884902005
 min_delta_ns:   1000
 mult:           715827876
 shift:          31
 mode:           3
 next_event:     87290000000 nsecs
 set_next_event: twd_set_next_event
 set_mode:       twd_set_mode
 event_handler:  hrtimer_interrupt
 retries:        0

# Dependency failed. Aborted start of Serial Getty on getty              [[1;31m ABORT[0m]
