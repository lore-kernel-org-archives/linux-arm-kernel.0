From: balbi@ti.com (Felipe Balbi)
Date: Fri, 12 Jul 2013 15:10:31 +0300
Subject: [PATCH] arm: omap2plus: unidle devices which are about to probe
In-Reply-To: <51DFEF59.1010509@ti.com>
References: <20130711092612.GG23892@arwen.pp.htv.fi>
 <1373537788-30413-1-git-send-email-balbi@ti.com>
 <51DFEF59.1010509@ti.com>
Message-ID: <20130712121031.GB17053@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 02:58:17PM +0300, Grygorii Strashko wrote:
> On 07/11/2013 01:16 PM, Felipe Balbi wrote:
> >in order to make HWMOD and pm_runtime agree on the
> >initial state of the device, we will unidle the device
> >and call pm_runtime_set_active() to tell pm_runtime
> >that the device is really active.
> >
> >By the time driver's probe() is reached, a call to
> >pm_runtime_get_sync() will not cause driver's
> >->runtime_resume() method to be called at first, only
> >after a successful ->runtime_suspend().
> >
> >Note that we must prevent pm_runtime transitions while
> >driver is probing otherwise drivers would be suspended
> >as soon as they call pm_runtime_use_autosuspend(). By
> >calling pm_runtime_forbid() before probe() and
> >pm_runtime_allow() after probe() we 'fix' that detail.
> >
> >Note that this patch was inspired by PCI's pci_pm_init().
> 
> NAK. This is a hack.

hack is your flag to check if the driver is "initialized". pff

> In addition to what I've mentioned in
> http://www.spinics.net/lists/arm-kernel/msg258061.html there are
> following issues:
> 1) this patch disables call to PM runtime callbacks for all

no, it does not. It forbids pm runtime transitions during probe.

> OMAP drivers which is wrong - I've found, for example, that
> omap-usb-host.c driver enables TLL in some configurations in its
> .runtime_resume():
> 
> usbhs_runtime_resume()
> |-omap_tll_enable()

which is wrong. PM runtime callbacks are supposed to be use for,
surprise, PM!

> 2) even with this fix the restore context issue will not be fixed for
> *non* console UARTs. Just try:
> #echo 0xDEAD > dev/ttyO3 // checked on OMAP4 SDP

that I have not checked, but then again, with that you're not calling
set_termios() anyway.

> 3) I've checked most of OMAP drivers and all of them solve such kind
> of problem internally (SPI, MMC, I2C, etc.)

and you see no problem with that ? Repeating the same thing over and
over again ?

> 4) See inline
> >
> >Signed-off-by: Felipe Balbi <balbi@ti.com>
> >---
> >
> >boot tested on top of today's Linus master
> >6d128e1e72bf082542e85f72e6b7ddd704193588 with OMAP4
> >panda. Reached console prompt and, after setting a
> >proper autosuspend delay, consoles autosuspend just
> >fine.
> >
> >It needs to be tested on other platforms.
> >
> >ps: note that we also call pm_runtime_set_suspended(dev)
> >from our late_initcall() to disable devices so that pm_runtime
> >and HWMOD continue to aggree on device's state.
> >
> >  arch/arm/mach-omap2/omap_device.c | 44 +++++++++++++++++++++++++++++++++++----
> >  1 file changed, 40 insertions(+), 4 deletions(-)
> >
> >diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> >index 5cc9287..cb1fc1d 100644
> >--- a/arch/arm/mach-omap2/omap_device.c
> >+++ b/arch/arm/mach-omap2/omap_device.c
> >@@ -178,6 +178,26 @@ odbfd_exit:
> >  	return ret;
> >  }
> >
> >+static void omap_device_pm_init(struct platform_device *pdev)
> >+{
> >+	omap_device_enable(pdev);
> >+	pm_runtime_forbid(&pdev->dev);
> It's wrong to use pm_runtime_forbid() - pm_runtime_get_noresume()
> should be used instead.

how come ? What makes you think pm_runtime_get_noresume() is the right
thing here ? 

> pm_runtime_forbid()
> |-rpm_resume()

so what ? flags is zero.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130712/316a3665/attachment.sig>
