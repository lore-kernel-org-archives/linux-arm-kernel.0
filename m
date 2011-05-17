From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Tue, 17 May 2011 15:21:31 +0100
Subject: [RFC PATCH v2 00/12] Consolidating GIC per-cpu interrupts
In-Reply-To: <4DCD64FC.4090703@ti.com>
References: <1304677997-26947-1-git-send-email-marc.zyngier@arm.com>
	<4DCD64FC.4090703@ti.com>
Message-ID: <1305642091.30788.47.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On Fri, 2011-05-13 at 22:36 +0530, Santosh Shilimkar wrote:
> Marc,
> 
> On 5/6/2011 4:03 PM, Marc Zyngier wrote:
> > The current GIC per-cpu interrupt (aka PPIs) suffers from a number of
> > problems:
> >
> > - It uses a completely separate scheme to handle the interrupts,
> >    mostly because the PPI concept doesn't really match the kernel view
> >    of an interrupt.
> > - Some low-level code gets duplicated, as usual...
> > - At least one platform (msm) has started implementing its own
> >    alternative scheme.
> >
> > The proposed solution is to let the GIC code expose the PPIs as
> > something that the kernel can manage. Instead of having a single
> > interrupt number shared on all cores, make the interrupt number be
> > different on each CPU.
> >
> > This enables the use of the normal kernel API (request_irq() and
> > friends) and the elimination of some low level code.
> >
> > This patch set is based on 2.6.39-rc6, and depends on Will Deacon's
> > GIC fasteoi patches. Tested on VExpress, PB-11MP, Pandaboard and
> > SMDK-S5PV310.
> >
> 
> Looks like, this series breaks system wide supsend. Please
> check.

Are you sure you're testing with v2? v1 is known to be broken with
CPU_HOTPLUG, but v2 should deal with it. Here is a suspend/resume cycle
on my Panda:

root at florentine-pogen:~# echo mem>/sys/power/state 
[  136.215667] PM: Syncing filesystems ... done.
[  136.220977] PM: Preparing system for mem sleep
[  136.226989] Freezing user space processes ... (elapsed 0.02 seconds) done.
[  136.257232] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
[  136.280670] PM: Entering mem sleep
[  136.332916] usb 1-1.1: unlink qh8-0001/dfb97460 start 2 [1/0 us]
[  136.339447] usb 1-1.1: usb suspend
[  136.363861] hub 1-1:1.0: hub_suspend
[  136.367614] usb 1-1: unlink qh256-0001/dfa846e0 start 1 [1/0 us]
[  136.373992] usb 1-1: usb suspend
[  136.395111] hub 1-0:1.0: hub_suspend
[  136.398864] usb usb1: bus suspend
[  136.402343] ehci-omap ehci-omap.0: suspend root hub
[  136.408477] PM: suspend of devices complete after 123.748 msecs
[  136.414703] PM: suspend devices took 0.132 seconds
[  136.420135] PM: late suspend of devices complete after 0.427 msecs
[  136.426605] Disabling non-boot CPUs ...
[  136.528137] CPU1: shutdown
[  138.320465] Enabling non-boot CPUs ...
[  138.324737] CPU1: Booted secondary processor
[  138.324737] CPU1: Unknown IPI message 0x1
[  138.332183] Switched to NOHz mode on CPU #1
[  138.527862] CPU1 is up
[  138.543518] PM: early resume of devices complete after 0.152 msecs

[  138.793670] usb usb1: usb resume
[  138.797058] ehci-omap ehci-omap.0: resume root hub
[  138.848022] hub 1-0:1.0: hub_resume
[  138.851684] hub 1-0:1.0: port 1: status 0507 change 0000
[  138.857299] usb 1-1: usb resume
[  138.894897] ehci-omap ehci-omap.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
[  138.926147] usb 1-1: finish resume
[  138.933868] hub 1-1:1.0: hub_resume
[  138.937591] hub 1-1:1.0: port 1: status 0507 change 0000
[  138.957489] ehci-omap ehci-omap.0: reused qh dfa846e0 schedule
[  138.963592] usb 1-1: link qh256-0001/dfa846e0 start 1 [1/0 us]
[  138.972991] usb 1-1.1: usb resume
[  139.037353] usb 1-1.1: finish resume
[  139.041259] ehci-omap ehci-omap.0: reused qh dfb97460 schedule
[  139.047363] usb 1-1.1: link qh8-0001/dfb97460 start 2 [1/0 us]
[  139.053649] PM: resume of devices complete after 503.509 msecs
[  139.059936] PM: resume devices took 0.515 seconds
[  139.064880] PM: Finishing wakeup.
[  139.068359] Restarting tasks ... 
[  139.071685] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
[  139.072631] done.
[  139.079681] hub 1-1:1.0: state 7 ports 5 chg 0000 evt 0002
root at florentine-pogen:~# 

Seems to be just fine here...

Cheers,

	M.
-- 
Reality is an implementation detail.
-- 
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
