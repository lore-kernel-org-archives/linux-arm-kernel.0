From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 31 Jul 2013 16:38:09 -0700
Subject: Enable arm_global_timer for Zynq brakes boot
In-Reply-To: <51F99747.4060901@linaro.org>
References: <20130722201348.GI453@xsjandreislx>
 <0735ab8c-0f80-4b64-b2b2-8d4553482c2a@CO9EHSMHS013.ehs.local>
 <51F66565.7010600@linaro.org>
 <8d56935e-2a20-46c7-b80a-f779572dd839@CO1EHSMHS014.ehs.local>
 <51F77D93.4030505@linaro.org> <51F97842.6050200@linaro.org>
 <068436c6-ff98-428f-8875-bb1c6f86466b@TX2EHSMHS008.ehs.local>
 <51F97CE3.9030306@linaro.org>
 <15e19315-ce88-4d3c-bad9-0a37d9e52f6b@CO1EHSMHS007.ehs.local>
 <51F99747.4060901@linaro.org>
Message-ID: <a48f159a-e88c-42fa-b76b-662302d3a585@AM1EHSMHS003.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 01:01:27AM +0200, Daniel Lezcano wrote:
> On 08/01/2013 12:18 AM, S??ren Brinkmann wrote:
> > On Wed, Jul 31, 2013 at 11:08:51PM +0200, Daniel Lezcano wrote:
> >> On 07/31/2013 10:58 PM, S??ren Brinkmann wrote:
> >>> On Wed, Jul 31, 2013 at 10:49:06PM +0200, Daniel Lezcano wrote:
> >>>> On 07/31/2013 12:34 AM, S??ren Brinkmann wrote:
> >>>>> On Tue, Jul 30, 2013 at 10:47:15AM +0200, Daniel Lezcano wrote:
> >>>>>> On 07/30/2013 02:03 AM, S??ren Brinkmann wrote:
> >>>>>>> Hi Daniel,
> >>>>>>>
> >>>>>>> On Mon, Jul 29, 2013 at 02:51:49PM +0200, Daniel Lezcano wrote:
> >>>>>>> (snip)
> >>>>>>>>
> >>>>>>>> the CPUIDLE_FLAG_TIMER_STOP flag tells the cpuidle framework the local
> >>>>>>>> timer will be stopped when entering to the idle state. In this case, the
> >>>>>>>> cpuidle framework will call clockevents_notify(ENTER) and switches to a
> >>>>>>>> broadcast timer and will call clockevents_notify(EXIT) when exiting the
> >>>>>>>> idle state, switching the local timer back in use.
> >>>>>>>
> >>>>>>> I've been thinking about this, trying to understand how this makes my
> >>>>>>> boot attempts on Zynq hang. IIUC, the wrongly provided TIMER_STOP flag
> >>>>>>> would make the timer core switch to a broadcast device even though it
> >>>>>>> wouldn't be necessary. But shouldn't it still work? It sounds like we do
> >>>>>>> something useless, but nothing wrong in a sense that it should result in
> >>>>>>> breakage. I guess I'm missing something obvious. This timer system will
> >>>>>>> always remain a mystery to me.
> >>>>>>>
> >>>>>>> Actually this more or less leads to the question: What is this
> >>>>>>> 'broadcast timer'. I guess that is some clockevent device which is
> >>>>>>> common to all cores? (that would be the cadence_ttc for Zynq). Is the
> >>>>>>> hang pointing to some issue with that driver?
> >>>>>>
> >>>>>> If you look at the /proc/timer_list, which timer is used for broadcasting ?
> >>>>>
> >>>>> So, the correct run results (full output attached).
> >>>>>
> >>>>> The vanilla kernel uses the twd timers as local timers and the TTC as
> >>>>> broadcast device:
> >>>>> 	Tick Device: mode:     1                                                         
> >>>>> 	Broadcast device  
> >>>>> 	Clock Event Device: ttc_clockevent
> >>>>>
> >>>>> When I remove the offending CPUIDLE flag and add the DT fragment to
> >>>>> enable the global timer, the twd timers are still used as local timers
> >>>>> and the broadcast device is the global timer:
> >>>>> 	Tick Device: mode:     1                                                         
> >>>>> 	Broadcast device                                                                 
> >>>>> 	Clock Event Device: arm_global_timer
> >>>>>
> >>>>> Again, since boot hangs in the actually broken case, I don't see way to
> >>>>> obtain this information for that case.
> >>>>
> >>>> Can't you use the maxcpus=1 option to ensure the system to boot up ?
> >>>
> >>> Right, that works. I forgot about that option after you mentioned, that
> >>> it is most likely not that useful.
> >>>
> >>> Anyway, this are those sysfs files with an unmodified cpuidle driver and
> >>> the gt enabled and having maxcpus=1 set.
> >>>
> >>> /proc/timer_list:
> >>> 	Tick Device: mode:     1
> >>> 	Broadcast device
> >>> 	Clock Event Device: arm_global_timer
> >>> 	 max_delta_ns:   12884902005
> >>> 	 min_delta_ns:   1000
> >>> 	 mult:           715827876
> >>> 	 shift:          31
> >>> 	 mode:           3
> >>
> >> Here the mode is 3 (CLOCK_EVT_MODE_ONESHOT)
> >>
> >> The previous timer_list output you gave me when removing the offending
> >> cpuidle flag, it was 1 (CLOCK_EVT_MODE_SHUTDOWN).
> >>
> >> Is it possible you try to get this output again right after onlining the
> >> cpu1 in order to check if the broadcast device switches to SHUTDOWN ?
> > 
> > How do I do that? I tried to online CPU1 after booting with maxcpus=1
> > and that didn't end well:
> > 	# echo 1 > online && cat /proc/timer_list 
> 
> Hmm, I was hoping to have a small delay before the kernel hangs but
> apparently this is not the case... :(
> 
> I suspect the global timer is shutdown at one moment but I don't
> understand why and when.
> 
> Can you add a stack trace in the "clockevents_shutdown" function with
> the clockevent device name ? Perhaps, we may see at boot time an
> interesting trace when it hangs.

I did this change:
	diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
	index 38959c8..3ab11c1 100644
	--- a/kernel/time/clockevents.c
	+++ b/kernel/time/clockevents.c
	@@ -92,6 +92,8 @@ void clockevents_set_mode(struct clock_event_device *dev,
	  */
	 void clockevents_shutdown(struct clock_event_device *dev)
	 {
	+       pr_info("ce->name:%s\n", dev->name);
	+       dump_stack();
	        clockevents_set_mode(dev, CLOCK_EVT_MODE_SHUTDOWN);
	        dev->next_event.tv64 = KTIME_MAX;
	 }

It is hit a few times during boot, so I attach a full boot log. I really
don't know what to look for, but I hope you can spot something in it. I
really appreciate you taking the time.

	Thanks,
	S??ren

-------------- next part --------------


U-Boot 2013.04 (Jun 19 2013 - 08:17:40)

I2C:   ready
Memory: ECC disabled
DRAM:  1 GiB
WARNING: Caches not enabled
MMC:   zynq_sdhci: 0
SF: Detected S25FL129P_64K with page size 128 KiB, total 32 MiB
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
	 ####################################
	 4.2 MiB/s
done
Bytes transferred = 2427120 (2508f0 hex)
Gem.e000b000:7 is connected to Gem.e000b000.  Reconnecting to Gem.e000b000
Gem.e000b000 Waiting for PHY auto negotiation to complete..... done
Using Gem.e000b000 device
TFTP from server 10.10.70.101; our IP address is 10.10.70.102
Filename 'devicetree.dtb'.
Load address: 0x2a00000
Loading: *#
	 672.9 KiB/s
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
	 4.4 MiB/s
done
Bytes transferred = 5284624 (50a310 hex)
## Booting kernel from Legacy Image at 03000000 ...
   Image Name:   Linux-3.11.0-rc3-00001-gc14f576-
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2427056 Bytes = 2.3 MiB
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

[    0.000000] Linux version 3.11.0-rc3-00001-gc14f576-dirty (sorenb at xsjandreislx) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-104) ) #144 SMP PREEMPT Wed Jul 31 16:31:16 PDT 2013

[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=18c5387d

[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache

[    0.000000] Machine: Xilinx Zynq Platform, model: Zynq ZC706 Development Board

[    0.000000] bootconsole [earlycon0] enabled

[    0.000000] cma: CMA: reserved 16 MiB at 2e800000

[    0.000000] Memory policy: ECC disabled, Data cache writealloc

[    0.000000] PERCPU: Embedded 9 pages/cpu @c148e000 s14720 r8192 d13952 u36864

[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260624

[    0.000000] Kernel command line: console=ttyPS0,115200 earlyprintk

[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)

[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)

[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)

[    0.000000] Memory: 1005068K/1048576K available (4849K kernel code, 305K rwdata, 1556K rodata, 334K init, 5699K bss, 43508K reserved, 270336K highmem)

[    0.000000] Virtual kernel memory layout:

[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)

[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)

[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)

[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)

[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)

[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)

[    0.000000]       .text : 0xc0008000 - 0xc0649930   (6407 kB)

[    0.000000]       .init : 0xc064a000 - 0xc069d980   ( 335 kB)

[    0.000000]       .data : 0xc069e000 - 0xc06ea4d8   ( 306 kB)

[    0.000000]        .bss : 0xc06ea4d8 - 0xc0c7b2e4   (5700 kB)

[    0.000000] Preemptible hierarchical RCU implementation.

[    0.000000] 	RCU lockdep checking is enabled.

[    0.000000] 	Additional per-CPU info printed with stalls.

[    0.000000] 	RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.

[    0.000000] NR_IRQS:16 nr_irqs:16 16

[    0.000000] slcr mapped to f0004000

[    0.000000] Zynq clock init

[    0.000000] sched_clock: 32 bits at 333MHz, resolution 3ns, wraps every 12884ms

[    0.000000] ce->name:arm_global_timer

[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.11.0-rc3-00001-gc14f576-dirty #144

[    0.000000] [<c0016a88>] (unwind_backtrace+0x0/0x128) from [<c0012d58>] (show_stack+0x20/0x24)

[    0.000000] [<c0012d58>] (show_stack+0x20/0x24) from [<c045bd70>] (dump_stack+0x80/0xc4)

[    0.000000] [<c045bd70>] (dump_stack+0x80/0xc4) from [<c00754e4>] (clockevents_shutdown+0x28/0x48)

[    0.000000] [<c00754e4>] (clockevents_shutdown+0x28/0x48) from [<c0075840>] (clockevents_exchange_device+0x94/0xb8)

[    0.000000] [<c0075840>] (clockevents_exchange_device+0x94/0xb8) from [<c0075fa0>] (tick_check_new_device+0xc8/0x11c)

[    0.000000] [<c0075fa0>] (tick_check_new_device+0xc8/0x11c) from [<c007510c>] (clockevents_register_device+0xc0/0x134)

[    0.000000] [<c007510c>] (clockevents_register_device+0xc0/0x134) from [<c0075748>] (clockevents_config_and_register+0x2c/0x30)

[    0.000000] [<c0075748>] (clockevents_config_and_register+0x2c/0x30) from [<c0370764>] (gt_clockevents_init+0x8c/0xb4)

[    0.000000] [<c0370764>] (gt_clockevents_init+0x8c/0xb4) from [<c0675d64>] (global_timer_of_register+0x1e4/0x294)

[    0.000000] [<c0675d64>] (global_timer_of_register+0x1e4/0x294) from [<c0675724>] (clocksource_of_init+0x2c/0x54)

[    0.000000] [<c0675724>] (clocksource_of_init+0x2c/0x54) from [<c0652b98>] (zynq_timer_init+0x14/0x18)

[    0.000000] [<c0652b98>] (zynq_timer_init+0x14/0x18) from [<c064dec8>] (time_init+0x24/0x34)

[    0.000000] [<c064dec8>] (time_init+0x24/0x34) from [<c064a774>] (start_kernel+0x1cc/0x32c)

[    0.000000] [<c064a774>] (start_kernel+0x1cc/0x32c) from [<00008074>] (0x8074)

[    0.000000] ce->name:ttc_clockevent

[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.11.0-rc3-00001-gc14f576-dirty #144

[    0.000000] [<c0016a88>] (unwind_backtrace+0x0/0x128) from [<c0012d58>] (show_stack+0x20/0x24)

[    0.000000] [<c0012d58>] (show_stack+0x20/0x24) from [<c045bd70>] (dump_stack+0x80/0xc4)

[    0.000000] [<c045bd70>] (dump_stack+0x80/0xc4) from [<c00754e4>] (clockevents_shutdown+0x28/0x48)

[    0.000000] [<c00754e4>] (clockevents_shutdown+0x28/0x48) from [<c0075840>] (clockevents_exchange_device+0x94/0xb8)

[    0.000000] [<c0075840>] (clockevents_exchange_device+0x94/0xb8) from [<c00766c4>] (tick_install_broadcast_device+0x88/0xcc)

[    0.000000] [<c00766c4>] (tick_install_broadcast_device+0x88/0xcc) from [<c0075fe4>] (tick_check_new_device+0x10c/0x11c)

[    0.000000] [<c0075fe4>] (tick_check_new_device+0x10c/0x11c) from [<c007510c>] (clockevents_register_device+0xc0/0x134)

[    0.000000] [<c007510c>] (clockevents_register_device+0xc0/0x134) from [<c0075748>] (clockevents_config_and_register+0x2c/0x30)

[    0.000000] [<c0075748>] (clockevents_config_and_register+0x2c/0x30) from [<c0675acc>] (ttc_timer_init+0x2d4/0x388)

[    0.000000] [<c0675acc>] (ttc_timer_init+0x2d4/0x388) from [<c0675724>] (clocksource_of_init+0x2c/0x54)

[    0.000000] [<c0675724>] (clocksource_of_init+0x2c/0x54) from [<c0652b98>] (zynq_timer_init+0x14/0x18)

[    0.000000] [<c0652b98>] (zynq_timer_init+0x14/0x18) from [<c064dec8>] (time_init+0x24/0x34)

[    0.000000] [<c064dec8>] (time_init+0x24/0x34) from [<c064a774>] (start_kernel+0x1cc/0x32c)

[    0.000000] [<c064a774>] (start_kernel+0x1cc/0x32c) from [<00008074>] (0x8074)

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

[    0.347737] Calibrating delay loop... 1325.46 BogoMIPS (lpj=6627328)

[    0.385250] pid_max: default: 32768 minimum: 301

[    0.388286] Mount-cache hash table entries: 512

[    0.399390] CPU: Testing write buffer coherency: ok

[    0.399540] ftrace: allocating 16043 entries in 48 pages

[    0.439854] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000

[    0.440069] ce->name:local_timer

[    0.443330] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.11.0-rc3-00001-gc14f576-dirty #144

[    0.451622] [<c0016a88>] (unwind_backtrace+0x0/0x128) from [<c0012d58>] (show_stack+0x20/0x24)

[    0.460207] [<c0012d58>] (show_stack+0x20/0x24) from [<c045bd70>] (dump_stack+0x80/0xc4)

[    0.468285] [<c045bd70>] (dump_stack+0x80/0xc4) from [<c00754e4>] (clockevents_shutdown+0x28/0x48)

[    0.477224] [<c00754e4>] (clockevents_shutdown+0x28/0x48) from [<c0075840>] (clockevents_exchange_device+0x94/0xb8)

[    0.487628] [<c0075840>] (clockevents_exchange_device+0x94/0xb8) from [<c0075fa0>] (tick_check_new_device+0xc8/0x11c)

[    0.498206] [<c0075fa0>] (tick_check_new_device+0xc8/0x11c) from [<c007510c>] (clockevents_register_device+0xc0/0x134)

[    0.508870] [<c007510c>] (clockevents_register_device+0xc0/0x134) from [<c0075748>] (clockevents_config_and_register+0x2c/0x30)

[    0.520307] [<c0075748>] (clockevents_config_and_register+0x2c/0x30) from [<c001585c>] (twd_timer_setup+0x1bc/0x1fc)

[    0.530798] [<c001585c>] (twd_timer_setup+0x1bc/0x1fc) from [<c00146a0>] (percpu_timer_setup+0xa4/0xc8)

[    0.540184] [<c00146a0>] (percpu_timer_setup+0xa4/0xc8) from [<c064e804>] (smp_prepare_cpus+0x58/0x84)

[    0.549464] [<c064e804>] (smp_prepare_cpus+0x58/0x84) from [<c064a934>] (kernel_init_freeable+0x60/0x1d0)

[    0.559008] [<c064a934>] (kernel_init_freeable+0x60/0x1d0) from [<c04562d4>] (kernel_init+0x1c/0xf4)

[    0.568124] [<c04562d4>] (kernel_init+0x1c/0xf4) from [<c000efc8>] (ret_from_fork+0x14/0x20)

[    0.576545] ce->name:ttc_clockevent

[    0.580068] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.11.0-rc3-00001-gc14f576-dirty #144

[    0.588341] [<c0016a88>] (unwind_backtrace+0x0/0x128) from [<c0012d58>] (show_stack+0x20/0x24)

[    0.596937] [<c0012d58>] (show_stack+0x20/0x24) from [<c045bd70>] (dump_stack+0x80/0xc4)

[    0.605019] [<c045bd70>] (dump_stack+0x80/0xc4) from [<c00754e4>] (clockevents_shutdown+0x28/0x48)

[    0.613964] [<c00754e4>] (clockevents_shutdown+0x28/0x48) from [<c00770dc>] (tick_device_uses_broadcast+0x198/0x1e4)

[    0.624453] [<c00770dc>] (tick_device_uses_broadcast+0x198/0x1e4) from [<c0075db8>] (tick_setup_device+0xb8/0x100)

[    0.634773] [<c0075db8>] (tick_setup_device+0xb8/0x100) from [<c0075fc8>] (tick_check_new_device+0xf0/0x11c)

[    0.644577] [<c0075fc8>] (tick_check_new_device+0xf0/0x11c) from [<c007510c>] (clockevents_register_device+0xc0/0x134)

[    0.655241] [<c007510c>] (clockevents_register_device+0xc0/0x134) from [<c0075748>] (clockevents_config_and_register+0x2c/0x30)

[    0.666679] [<c0075748>] (clockevents_config_and_register+0x2c/0x30) from [<c001585c>] (twd_timer_setup+0x1bc/0x1fc)

[    0.677169] [<c001585c>] (twd_timer_setup+0x1bc/0x1fc) from [<c00146a0>] (percpu_timer_setup+0xa4/0xc8)

[    0.686549] [<c00146a0>] (percpu_timer_setup+0xa4/0xc8) from [<c064e804>] (smp_prepare_cpus+0x58/0x84)

[    0.695833] [<c064e804>] (smp_prepare_cpus+0x58/0x84) from [<c064a934>] (kernel_init_freeable+0x60/0x1d0)

[    0.705377] [<c064a934>] (kernel_init_freeable+0x60/0x1d0) from [<c04562d4>] (kernel_init+0x1c/0xf4)

[    0.714495] [<c04562d4>] (kernel_init+0x1c/0xf4) from [<c000efc8>] (ret_from_fork+0x14/0x20)

[    0.722917] ce->name:arm_global_timer

[    0.726612] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.11.0-rc3-00001-gc14f576-dirty #144

[    0.734881] [<c0016a88>] (unwind_backtrace+0x0/0x128) from [<c0012d58>] (show_stack+0x20/0x24)

[    0.743479] [<c0012d58>] (show_stack+0x20/0x24) from [<c045bd70>] (dump_stack+0x80/0xc4)

[    0.751563] [<c045bd70>] (dump_stack+0x80/0xc4) from [<c00754e4>] (clockevents_shutdown+0x28/0x48)

[    0.760503] [<c00754e4>] (clockevents_shutdown+0x28/0x48) from [<c0075840>] (clockevents_exchange_device+0x94/0xb8)

[    0.770912] [<c0075840>] (clockevents_exchange_device+0x94/0xb8) from [<c00766c4>] (tick_install_broadcast_device+0x88/0xcc)

[    0.782091] [<c00766c4>] (tick_install_broadcast_device+0x88/0xcc) from [<c0075fe4>] (tick_check_new_device+0x10c/0x11c)

[    0.792926] [<c0075fe4>] (tick_check_new_device+0x10c/0x11c) from [<c007514c>] (clockevents_register_device+0x100/0x134)

[    0.803762] [<c007514c>] (clockevents_register_device+0x100/0x134) from [<c0075748>] (clockevents_config_and_register+0x2c/0x30)

[    0.815286] [<c0075748>] (clockevents_config_and_register+0x2c/0x30) from [<c001585c>] (twd_timer_setup+0x1bc/0x1fc)

[    0.825777] [<c001585c>] (twd_timer_setup+0x1bc/0x1fc) from [<c00146a0>] (percpu_timer_setup+0xa4/0xc8)

[    0.835156] [<c00146a0>] (percpu_timer_setup+0xa4/0xc8) from [<c064e804>] (smp_prepare_cpus+0x58/0x84)

[    0.844441] [<c064e804>] (smp_prepare_cpus+0x58/0x84) from [<c064a934>] (kernel_init_freeable+0x60/0x1d0)

[    0.853986] [<c064a934>] (kernel_init_freeable+0x60/0x1d0) from [<c04562d4>] (kernel_init+0x1c/0xf4)

[    0.863102] [<c04562d4>] (kernel_init+0x1c/0xf4) from [<c000efc8>] (ret_from_fork+0x14/0x20)

[    0.871662] Setting up static identity map for 0xc0462780 - 0xc04627d8

[    0.935967] CPU1: Booted secondary processor

[    0.936001] ce->name:arm_global_timer

[    0.936015] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.11.0-rc3-00001-gc14f576-dirty #144

[    0.936063] [<c0016a88>] (unwind_backtrace+0x0/0x128) from [<c0012d58>] (show_stack+0x20/0x24)

[    0.936093] [<c0012d58>] (show_stack+0x20/0x24) from [<c045bd70>] (dump_stack+0x80/0xc4)

[    0.936120] [<c045bd70>] (dump_stack+0x80/0xc4) from [<c00754e4>] (clockevents_shutdown+0x28/0x48)

[    0.936140] [<c00754e4>] (clockevents_shutdown+0x28/0x48) from [<c0075840>] (clockevents_exchange_device+0x94/0xb8)

[    0.936160] [<c0075840>] (clockevents_exchange_device+0x94/0xb8) from [<c0075fa0>] (tick_check_new_device+0xc8/0x11c)

[    0.936180] [<c0075fa0>] (tick_check_new_device+0xc8/0x11c) from [<c007510c>] (clockevents_register_device+0xc0/0x134)

[    0.936199] [<c007510c>] (clockevents_register_device+0xc0/0x134) from [<c0075748>] (clockevents_config_and_register+0x2c/0x30)

[    0.936227] [<c0075748>] (clockevents_config_and_register+0x2c/0x30) from [<c0370764>] (gt_clockevents_init+0x8c/0xb4)

[    0.936247] [<c0370764>] (gt_clockevents_init+0x8c/0xb4) from [<c03708e8>] (gt_cpu_notify+0x3c/0x68)

[    0.936278] [<c03708e8>] (gt_cpu_notify+0x3c/0x68) from [<c00552e4>] (notifier_call_chain+0xd8/0x110)

[    0.936301] [<c00552e4>] (notifier_call_chain+0xd8/0x110) from [<c0055340>] (__raw_notifier_call_chain+0x24/0x2c)

[    0.936321] [<c0055340>] (__raw_notifier_call_chain+0x24/0x2c) from [<c002758c>] (__cpu_notify+0x3c/0x58)

[    0.936337] [<c002758c>] (__cpu_notify+0x3c/0x58) from [<c00275c8>] (cpu_notify+0x20/0x24)

[    0.936354] [<c00275c8>] (cpu_notify+0x20/0x24) from [<c0027dd0>] (notify_cpu_starting+0x58/0x60)

[    0.936373] [<c0027dd0>] (notify_cpu_starting+0x58/0x60) from [<c0014a94>] (secondary_start_kernel+0xf4/0x144)

[    0.936390] [<c0014a94>] (secondary_start_kernel+0xf4/0x144) from [<000081ec>] (0x81ec)

[    0.936404] ce->name:arm_global_timer

[    0.936415] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.11.0-rc3-00001-gc14f576-dirty #144

[    0.936441] [<c0016a88>] (unwind_backtrace+0x0/0x128) from [<c0012d58>] (show_stack+0x20/0x24)

[    0.936464] [<c0012d58>] (show_stack+0x20/0x24) from [<c045bd70>] (dump_stack+0x80/0xc4)

[    0.936486] [<c045bd70>] (dump_stack+0x80/0xc4) from [<c00754e4>] (clockevents_shutdown+0x28/0x48)

[    0.936507] [<c00754e4>] (clockevents_shutdown+0x28/0x48) from [<c00770dc>] (tick_device_uses_broadcast+0x198/0x1e4)

[    0.936526] [<c00770dc>] (tick_device_uses_broadcast+0x198/0x1e4) from [<c0075db8>] (tick_setup_device+0xb8/0x100)

[    0.936545] [<c0075db8>] (tick_setup_device+0xb8/0x100) from [<c0075fc8>] (tick_check_new_device+0xf0/0x11c)

[    0.936564] [<c0075fc8>] (tick_check_new_device+0xf0/0x11c) from [<c007510c>] (clockevents_register_device+0xc0/0x134)

[    0.936584] [<c007510c>] (clockevents_register_device+0xc0/0x134) from [<c0075748>] (clockevents_config_and_register+0x2c/0x30)

[    0.936608] [<c0075748>] (clockevents_config_and_register+0x2c/0x30) from [<c0370764>] (gt_clockevents_init+0x8c/0xb4)

[    0.936627] [<c0370764>] (gt_clockevents_init+0x8c/0xb4) from [<c03708e8>] (gt_cpu_notify+0x3c/0x68)

[    0.936652] [<c03708e8>] (gt_cpu_notify+0x3c/0x68) from [<c00552e4>] (notifier_call_chain+0xd8/0x110)

[    0.936673] [<c00552e4>] (notifier_call_chain+0xd8/0x110) from [<c0055340>] (__raw_notifier_call_chain+0x24/0x2c)

[    0.936692] [<c0055340>] (__raw_notifier_call_chain+0x24/0x2c) from [<c002758c>] (__cpu_notify+0x3c/0x58)

[    0.936708] [<c002758c>] (__cpu_notify+0x3c/0x58) from [<c00275c8>] (cpu_notify+0x20/0x24)

[    0.936725] [<c00275c8>] (cpu_notify+0x20/0x24) from [<c0027dd0>] (notify_cpu_starting+0x58/0x60)

[    0.936744] [<c0027dd0>] (notify_cpu_starting+0x58/0x60) from [<c0014a94>] (secondary_start_kernel+0xf4/0x144)

[    0.936760] [<c0014a94>] (secondary_start_kernel+0xf4/0x144) from [<000081ec>] (0x81ec)

[    1.022967] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001

[    1.023071] ce->name:local_timer

[    1.024254] Brought up 2 CPUs

[    1.024267] SMP: Total of 2 processors activated (2657.48 BogoMIPS).

[    1.024272] CPU: All CPU(s) started in SVC mode.

[    1.383534] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.11.0-rc3-00001-gc14f576-dirty #144

[    1.391814] [<c0016a88>] (unwind_backtrace+0x0/0x128) from [<c0012d58>] (show_stack+0x20/0x24)

[    1.400405] [<c0012d58>] (show_stack+0x20/0x24) from [<c045bd70>] (dump_stack+0x80/0xc4)

[    1.408485] [<c045bd70>] (dump_stack+0x80/0xc4) from [<c00754e4>] (clockevents_shutdown+0x28/0x48)

[    1.417425] [<c00754e4>] (clockevents_shutdown+0x28/0x48) from [<c0075840>] (clockevents_exchange_device+0x94/0xb8)

[    1.427831] [<c0075840>] (clockevents_exchange_device+0x94/0xb8) from [<c0075fa0>] (tick_check_new_device+0xc8/0x11c)

[    1.438410] [<c0075fa0>] (tick_check_new_device+0xc8/0x11c) from [<c007510c>] (clockevents_register_device+0xc0/0x134)

[    1.449073] [<c007510c>] (clockevents_register_device+0xc0/0x134) from [<c0075748>] (clockevents_config_and_register+0x2c/0x30)

[    1.460511] [<c0075748>] (clockevents_config_and_register+0x2c/0x30) from [<c001585c>] (twd_timer_setup+0x1bc/0x1fc)

[    1.471003] [<c001585c>] (twd_timer_setup+0x1bc/0x1fc) from [<c00146a0>] (percpu_timer_setup+0xa4/0xc8)

[    1.480375] [<c00146a0>] (percpu_timer_setup+0xa4/0xc8) from [<c0014ab8>] (secondary_start_kernel+0x118/0x144)

[    1.490350] [<c0014ab8>] (secondary_start_kernel+0x118/0x144) from [<000081ec>] (0x81ec)

[    1.498430] ce->name:arm_global_timer

[    1.502125] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.11.0-rc3-00001-gc14f576-dirty #144

[    1.510397] [<c0016a88>] (unwind_backtrace+0x0/0x128) from [<c0012d58>] (show_stack+0x20/0x24)

[    1.518993] [<c0012d58>] (show_stack+0x20/0x24) from [<c045bd70>] (dump_stack+0x80/0xc4)

[    1.527077] [<c045bd70>] (dump_stack+0x80/0xc4) from [<c00754e4>] (clockevents_shutdown+0x28/0x48)

[    1.536020] [<c00754e4>] (clockevents_shutdown+0x28/0x48) from [<c00770dc>] (tick_device_uses_broadcast+0x198/0x1e4)

[    1.546511] [<c00770dc>] (tick_device_uses_broadcast+0x198/0x1e4) from [<c0075db8>] (tick_setup_device+0xb8/0x100)

[    1.556829] [<c0075db8>] (tick_setup_device+0xb8/0x100) from [<c0075fc8>] (tick_check_new_device+0xf0/0x11c)

[    1.566634] [<c0075fc8>] (tick_check_new_device+0xf0/0x11c) from [<c007510c>] (clockevents_register_device+0xc0/0x134)

[    1.577299] [<c007510c>] (clockevents_register_device+0xc0/0x134) from [<c0075748>] (clockevents_config_and_register+0x2c/0x30)

[    1.588737] [<c0075748>] (clockevents_config_and_register+0x2c/0x30) from [<c001585c>] (twd_timer_setup+0x1bc/0x1fc)

[    1.599227] [<c001585c>] (twd_timer_setup+0x1bc/0x1fc) from [<c00146a0>] (percpu_timer_setup+0xa4/0xc8)

[    1.608600] [<c00146a0>] (percpu_timer_setup+0xa4/0xc8) from [<c0014ab8>] (secondary_start_kernel+0x118/0x144)

[    1.618576] [<c0014ab8>] (secondary_start_kernel+0x118/0x144) from [<000081ec>] (0x81ec)

[    1.630233] devtmpfs: initialized

[    1.648505] NET: Registered protocol family 16

[    1.654412] DMA: preallocated 256 KiB pool for atomic coherent allocations

[    1.667327] L310 cache controller enabled

[    1.667364] l2x0: 8 ways, CACHE_ID 0x410000c8, AUX_CTRL 0x72360000, Cache size: 524288 B

[    1.681910] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.

[    1.684424] hw-breakpoint: maximum watchpoint size is 4 bytes.

[    1.763691] bio: create slab <bio-0> at 0

[    1.768952] SCSI subsystem initialized

[    1.771737] usbcore: registered new interface driver usbfs

[    1.773326] usbcore: registered new interface driver hub

[    1.778916] usbcore: registered new device driver usb

[    1.793685] Switched to clocksource arm_global_timer

[    1.968760] NET: Registered protocol family 2

[    1.974238] TCP established hash table entries: 8192 (order: 4, 65536 bytes)

[    1.976164] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)

[    1.986656] TCP: Hash tables configured (established 8192 bind 8192)

[    1.989016] TCP: reno registered

[    1.992002] UDP hash table entries: 512 (order: 3, 40960 bytes)

[    1.998476] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)

[    2.006030] NET: Registered protocol family 1

[    2.010481] RPC: Registered named UNIX socket transport module.

[    2.014689] RPC: Registered udp transport module.

[    2.019326] RPC: Registered tcp transport module.

[    2.024133] RPC: Registered tcp NFSv4.1 backchannel transport module.

[    2.031730] Trying to unpack rootfs image as initramfs...

[    2.854186] Freeing initrd memory: 5160K (dfaf5000 - dffff000)

[    2.867362] bounce pool size: 64 pages

[    2.871434] jffs2: version 2.2. (NAND) (SUMMARY)  ?? 2001-2006 Red Hat, Inc.

[    2.873772] msgmni has been set to 1477

[    2.897430] io scheduler noop registered

[    2.897463] io scheduler deadline registered

[    2.900325] io scheduler cfq registered (default)

[    2.915035] e000?[    2.917021] console [ttyPS0] enabled, bootconsole disabled
[    2.917021] console [ttyPS0] enabled, bootconsole disabled

[    2.961088] brd: module loaded
[    2.985608] loop: module loaded
[    3.007560] usbcore: registered new interface driver usb-storage
[    3.015956] mousedev: PS/2 mouse device common for all mice
[    3.024029] i2c /dev entries driver
[    3.031288] cpuidle: using governor ladder
[    3.035357] cpuidle: using governor menu
[    3.039170] Xilinx Zynq CpuIdle Driver started
[    3.044929] sdhci: Secure Digital Host Controller Interface driver
[    3.050969] sdhci: Copyright(c) Pierre Ossman
[    3.055475] sdhci-pltfm: SDHCI platform and OF driver helper
[    3.063301] usbcore: registered new interface driver usbhid
[    3.068990] usbhid: USB HID core driver
[    3.073385] TCP: cubic registered
[    3.076686] NET: Registered protocol family 17
[    3.081129] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    3.088817] Registering SWP/SWPB emulation handler
[    3.098336] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    3.138029] Freeing unused kernel memory: 332K (c064a000 - c069d000)

Welcome to [1mBuildroot 2013.08-git[0m!
