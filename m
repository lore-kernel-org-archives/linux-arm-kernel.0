From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Jul 2012 00:08:58 +0800
Subject: MX28 poweroff issue
In-Reply-To: <20120704151944.GB18739@n2100.arm.linux.org.uk>
References: <201207040030.36713.marex@denx.de>
 <CAOMZO5Ab-Zibnn-tVfTz5BNJsqJer88jZLVa5Een9DDZ3tdssg@mail.gmail.com>
 <20120704093823.8e74d48bc8d9918a9c80fbcf@kinali.ch>
 <201207041631.30107.marex@denx.de>
 <20120704151944.GB18739@n2100.arm.linux.org.uk>
Message-ID: <20120705160855.GA20175@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2012 at 04:19:44PM +0100, Russell King - ARM Linux wrote:
> On Wed, Jul 04, 2012 at 04:31:29PM +0200, Marek Vasut wrote:
> > Dear Attila Kinali,
> > 
> > > On Wed, 4 Jul 2012 00:14:12 -0300
> > > 
> > > Fabio Estevam <festevam@gmail.com> wrote:
> > > > On a mx27 (also ARM926EJS) I do not see this problem.
> > > 
> > > I have the same issue on the mx23 (using 3.5-rc5):
> > 
> > Thank you, all of you who tested it on random devices and pointed out stuff :-)
> > 
> > Shawn, do you have any suggestions on how to proceed? Shall we use Russells 
> > approach?
> 
> If it's specific to mx28 and mx23 and nothing else, the cause needs to
> be found.  Maybe we need it tested on other (non-MX) platforms too?

Though people reported that imx27 does not have the problem, I'm not
so sure about it's a mach-mxs (mx23 and mx28) specific issue.  I have
not figured it out why imx27 does not run into it, but I got some
finding here.

Let's look at the dump again.

[   59.840000] System halted.
[   84.100000] BUG: soft lockup - CPU#0 stuck for 23s! [halt:584]
...
[   84.100000] [<c0070cd4>] (watchdog_timer_fn+0x114/0x14c) from [<c004052c>]
(__run_hrtimer+0x7c/0x1ec)

It reports the issue eventually in function watchdog_timer_fn
(kernel/watchdog.c):

/* watchdog kicker functions */
static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
{
	...

        /* check for a softlockup
         * This is done by making sure a high priority task is
         * being scheduled.  The task touches the watchdog to
         * indicate it is getting cpu time.  If it hasn't then
         * this is a good indication some task is hogging the cpu
         */
        duration = is_softlockup(touch_ts);
        if (unlikely(duration)) {
                /*
                 * If a virtual machine is stopped by the host it can look to
                 * the watchdog like a soft lockup, check to see if the host
                 * stopped the vm before we issue the warning
                 */
                if (kvm_check_and_clear_guest_paused())
                        return HRTIMER_RESTART;

                /* only warn once */
                if (__this_cpu_read(soft_watchdog_warn) == true)
                        return HRTIMER_RESTART;

                printk(KERN_EMERG "BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
                        smp_processor_id(), duration,
                        current->comm, task_pid_nr(current));

	...
}

As Russell already said, interrupts are not disabled on halt.  The
mxs_timer_irq handler eventually triggers this watchdog, as the cpu
gets stuck on that while(1) on halt.

I'm not sure if the change below is the right fix, but it does remove
the issue for mach-mxs.

Regards,
Shawn

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 19c95ea..e41edea 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -247,7 +247,8 @@ void machine_shutdown(void)
 void machine_halt(void)
 {
        machine_shutdown();
-       while (1);
+       while (1)
+               msleep(1);
 }
