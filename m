From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 26 Oct 2009 11:34:00 -0700
Subject: [PATCH v3 4/4] iop: implement sched_clock()
In-Reply-To: <19169.39885.258937.672777@pilspetsen.it.uu.se>
References: <19160.60691.72229.932486@pilspetsen.it.uu.se>
	<e9c3a7c20910221449i6a9f8bc6y6b3af1f2f7fe1c44@mail.gmail.com>
	<19168.55801.851167.570526@pilspetsen.it.uu.se>
	<19169.39885.258937.672777@pilspetsen.it.uu.se>
Message-ID: <1256582040.11080.14.camel@dwillia2-linux.ch.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-10-23 at 05:04 -0700, Mikael Pettersson wrote:
> Hmm, even with CONFIG_PRINTK_TIME I can't reproduce any crashes,
> all that happens is that sched_clock() returns 0 until shortly
> after the clocksource is initialized.
> 
> Do you have any local patches in that kernel, in particular anything
> that might depend on sched_clock()?
> 
> Can you send me your .config?
> 
> And finally, can you boot your kernel (with the sched_clock() patch)
> with Sascha Hauer's earlyprintk patch(*) applied and enabled(**), and
> capture the boot messages?
> 
> (*) http://lists.arm.linux.org.uk/lurker/message/20090129.153915.ed65e33d.en.html
> (**) CONFIG_DEBUG_LL=y and CONFIG_DEBUG_LL_CONSOLE=y, append "earlyprintk" to boot params

Very helpful, why is this patch not upstream?  We are getting an
undefined instruction error most likely due to the fact that access to
cp6 has not been established.  I suspect your bootloader is leaving cp6
access enabled when handing off to the kernel, while it is disabled in
mine.  We would need to delay sched_clock() usage until after the cp6
undefined instruction handler is registered which is after interrupts
are enabled (iop_init_cp6_handler()).

[    0.000000] Linux version 2.6.32-rc5 (dwillia2 at dwillia2-linux) (gcc version 4.3.2 (Sourcery G++ Lite 2008q3-72) ) #9 Mon Oct 26 10:44:28 MST 2009
[    0.000000] CPU: XScale-V3 based processor [69056819] revision 9 (ARMv5TE), cr=0000397f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Intel IQ81340MC
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] Truncating RAM at 00000000-7fffffff to -31ffffff (vmalloc region overlap).
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 203200
[    0.000000] Kernel command line: ip=bootp root=nfs console=ttyS0,115200 nfsroot=,tcp,v3,wsize=8192,rsize=8192 earlyprintk
[    0.000000] bootconsole [earlyser0] enabled
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 800MB = 800MB total
[    0.000000] Memory: 807168KB available (4172K code, 287K data, 144K init, 0K highmem)
[    0.000000] Internal error: Oops - undefined instruction: 0 [#1]
[    0.000000] last sysfs file: 
[    0.000000] Modules linked in:
[    0.000000] CPU: 0    Not tainted  (2.6.32-rc5 #9)
[    0.000000] PC is at sched_clock+0xc/0x44
[    0.000000] LR is at init_idle+0xa0/0x120
[    0.000000] pc : [<c0036f30>]    lr : [<c0024a64>]    psr: 800000d3
[    0.000000] sp : c0441f64  ip : c0441f7c  fp : c0441f78
[    0.000000] r10: c0336c50  r9 : c0446e00  r8 : c0469040
[    0.000000] r7 : 800000d3  r6 : c0442fd0  r5 : 00000000  r4 : 00000000
[    0.000000] r3 : 00000000  r2 : c04455c8  r1 : 00000000  r0 : 000f4240
[    0.000000] Flags: Nzcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[    0.000000] Control: 0400397f  Table: 00004018  DAC: 00000035
[    0.000000] Process swapper (pid: 0, stack limit = 0xc0440260)
[    0.000000] Stack: (0xc0441f64 to 0xc0442000)
[    0.000000] 1f60:          00000000 00000000 c0441f98 c0441f7c c0024a64 c0036f30 c0440000
[    0.000000] 1f80: 00000000 c0445608 00000000 c0441fd0 c0441f9c c0010a78 c00249d0 00000000
[    0.000000] 1fa0: 00000000 00000001 c0029224 c0468c00 c0027000 c0443c58 00025930 69056819
[    0.000000] 1fc0: 00025894 c0441ff4 c0441fd4 c0008a50 c0010894 c0008670 c0029224 0000397d
[    0.000000] 1fe0: c0468f0c c0029220 00000000 c0441ff8 00008034 c0008930 00000000 00000000
[    0.000000] Backtrace: 
[    0.000000] [<c0036f24>] (sched_clock+0x0/0x44) from [<c0024a64>] (init_idle+0xa0/0x120)
[    0.000000]  r5:00000000 r4:00000000
[    0.000000] [<c00249c4>] (init_idle+0x0/0x120) from [<c0010a78>] (sched_init+0x1f0/0x278)
[    0.000000]  r7:00000000 r6:c0445608 r5:00000000 r4:c0440000
[    0.000000] [<c0010888>] (sched_init+0x0/0x278) from [<c0008a50>] (start_kernel+0x12c/0x2c4)
[    0.000000] [<c0008924>] (start_kernel+0x0/0x2c4) from [<00008034>] (0x8034)
[    0.000000]  r6:c0029220 r5:c0468f0c r4:0000397d
[    0.000000] Code: e89da800 e1a0c00d e92dd830 e24cb004 (ee132619) 

The following patch works for me, but it presumes the order of irq
versus time init.

diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index 6c8a02a..d222561 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -39,7 +39,6 @@ static cycle_t iop_clocksource_read(struct clocksource *unused)
 static struct clocksource iop_clocksource = {
 	.name 		= "iop_timer1",
 	.rating		= 300,
-	.read		= iop_clocksource_read,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
@@ -70,9 +69,17 @@ static void __init iop_clocksource_set_hz(struct clocksource *cs, unsigned int h
  */
 unsigned long long sched_clock(void)
 {
-	cycle_t cyc = iop_clocksource_read(NULL);
 	struct clocksource *cs = &iop_clocksource;
+	cycle_t cyc;
 
+	/* wait for init */
+	if (unlikely(!cs->read))
+		return 0;
+
+	/* call iop_clocksource_read() instead of dereferencing
+	 * cs->read() to save an indirect branch penalty
+	 */
+	cyc = iop_clocksource_read(NULL);
 	return clocksource_cyc2ns(cyc, cs->mult, cs->shift);
 }
 
@@ -208,5 +215,6 @@ void __init iop_init_time(unsigned long tick_rate)
 	write_tcr1(0xffffffff);
 	write_tmr1(timer_ctl);
 	iop_clocksource_set_hz(&iop_clocksource, tick_rate);
+	iop_clocksource.read = iop_clocksource_read;
 	clocksource_register(&iop_clocksource);
 }
