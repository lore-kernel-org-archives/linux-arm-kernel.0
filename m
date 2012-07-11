From: kim.phillips@freescale.com (Kim Phillips)
Date: Tue, 10 Jul 2012 19:02:21 -0500
Subject: [PATCH v2] rtc: snvs: add Freescale rtc-snvs driver
In-Reply-To: <20120710023226.GA19649@S2101-09.ap.freescale.net>
References: <1341416294-3194-1-git-send-email-shawn.guo@linaro.org>
 <20120705182829.d13d6992406e02e1024552e3@freescale.com>
 <20120706002254.GB20175@S2101-09.ap.freescale.net>
 <20120706175634.a98fb53a9a1fdf40bd4febb3@freescale.com>
 <20120709065116.GB11635@S2101-09.ap.freescale.net>
 <20120709194514.e6a854441fa69a54fadc296d@freescale.com>
 <20120710023226.GA19649@S2101-09.ap.freescale.net>
Message-ID: <20120710190221.0f26b6f158257b00c40e6a4e@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Jul 2012 10:32:29 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> On Mon, Jul 09, 2012 at 07:45:14PM -0500, Kim Phillips wrote:
> > I'm not sure if this is appropriate vs. having common arch code
> > publish SNVS devices; see e.g., the other fsl,* devices in
> > arch/powerpc/platforms/85xx/common.c:mpc85xx_common_ids[].
> > 
> This is completely beyond the scope of the patch, which merely adds
> a driver for snvs-lp-rtc device.  But the driver does not know how
> the device is created, and it does not need to know.
> 
> > Either way, I'd like to get support without having to manually tweak
> > the device tree, i.e., the patch doesn't work as-is.
> > 
> As I already said, the patch only adds a driver for snvs-lp-rtc.  It
> should not care about how snvs-lp-rtc device is created on particular
> platform.  The patch does work as-is for imx6q, which is the target
> of the patch so far.

how, without the "simple-bus" addition to the sec_mon compatibles
list in the imx6 device tree (which isn't present in this patch)?

> > btw, testing on a p4080r2 produces a soft lockup:
> > 
> > root at p4080ds:~# modprobe rtc-snvs
> > snvs_rtc ffe314034.sec_mon_rtc_lp: rtc core: registered ffe314034.sec_mon_r as rtc1
> > root at p4080ds:~# hwclock -w -f /dev/rtc1 
> > BUG: soft lockup - CPU#0 stuck for 23s! [kworker/0:0:4]
> > Modules linked in: rtc_snvs nfsd exportfs
> > irq event stamp: 54
> > hardirqs last  enabled at (53): [<c04f90dc>] _raw_spin_unlock_irq+0x30/0x58
> > hardirqs last disabled at (54): [<c04f8808>] _raw_spin_lock_irq+0x24/0x70
> > softirqs last  enabled at (0): [<c001eff8>] copy_process+0x2f4/0xde4
> > softirqs last disabled at (0): [<  (null)>]   (null)
> > NIP: f10b80b4 LR: f10b8074 CTR: 00000003
> > REGS: ee071d70 TRAP: 0901   Not tainted  (3.5.0-rc5-00099-gd8715a7-dirty)
> > MSR: 00029002 <CE,EE,ME>  CR: 42042022  XER: 00000000
> > TASK = ee06f470[4] 'kworker/0:0' THREAD: ee070000 CPU: 0
> > GPR00: 00000000 ee071e20 ee06f470 c04f9058 00000001 f10b8074 00000000 00000002 
> > GPR08: 00000001 f10bc054 00000000 00000000 c04f901c 
> > NIP [f10b80b4] snvs_rtc_alarm_irq_enable+0xb4/0xf8 [rtc_snvs]
> > LR [f10b8074] snvs_rtc_alarm_irq_enable+0x74/0xf8 [rtc_snvs]
> > Call Trace:
> > [ee071e20] [f10b8074] snvs_rtc_alarm_irq_enable+0x74/0xf8 [rtc_snvs] (unreliable)
> > [ee071e40] [c038c118] rtc_timer_do_work+0x184/0x20c
> > [ee071f10] [c003fc4c] process_one_work+0x1d4/0x48c
> > [ee071f50] [c0040d4c] worker_thread+0x184/0x358
> > [ee071f90] [c0046458] kthread+0x84/0x88
> > [ee071ff0] [c000d434] kernel_thread+0x4c/0x68
> > Instruction dump:
> > 7c0004ac 7d404c2c 0c0a0000 4c00012c 7c0004ac 7c004c2c 0c000000 4c00012c 
> > 7f8a0000 409effdc 7c0004ac 7c004c2c <0c000000> 4c00012c 7c0004ac 7d604c2c 
> > 
> > I debugged it to the innermost loop of rtc_write_sync_lp(), where
> > count2 and count3 are always equal.  Should there be a timeout in
> > that loop?  Do you know if this is because the machine isn't
> > in trusted mode?  Any other hints appreciated.
> > 
> This is probably because readl/writel does not work on powerpc.
> I experienced the same thing when working on fsl_ssi driver.
> 
> My patch only targets imx6q right now.

interesting.  When I add

+#define readl in_be32
+#define writel(val, addr)             out_be32(addr, val)

to the top of the driver, the soft-lockup moves to
rtc_read_lp_counter().  I'm trying to verify if I have the right h/w
revision.

Kim
