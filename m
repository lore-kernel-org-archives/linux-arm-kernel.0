From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Feb 2013 19:56:50 +0200
Subject: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
In-Reply-To: <20130214171253.GC7144@atomide.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com>
Message-ID: <20130214175650.GA25891@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 14, 2013 at 09:12:53AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [130214 03:19]:
> > Currently the omap-serial driver will not
> > work properly if booted via DT with CPUIDLE
> > enabled because it depends on function pointers
> > provided by hwmod to change its own SYSCONFIG
> > register.
> > 
> > Remove that relyance on hwmod by moving SYSCONFIG
> > handling to driver itself. Note that this also
> > fixes a possible corner case bug where we could
> > be putting UART in Force Idle mode if we called
> > omap_serial_enable_wakeup(up, false) after setting
> > NOIDLE to the idle mode. This is because hwmod
> > has no protection against that situation.

Any comments to these last two sentences ?

> I agree the sysconfig stuff should be handled in the drivers.
> But considering that we need to also reset or idle hardware
> that may not have a driver loaded, it's best to put the
> reset/idle function in to the driver specific header as
> an inline function.

that is likely to cause quite a few isues, don't you think?

hwmod depending on driver code to reset particular IPs ? Seems like we
need a generic device_reset() hook which can be called by platform code,
no ? Not sure if that would help a lot though.

> This way the hwmod code can idle or reset the unclaimed
> hardware in a late_initcall.

The problem with this:

my_driver.h:

static inline void my_driver_reset(struct my_driver *drv)
{
	writel(drv->regs, SYSS, RESET);
}

how will hwmod provide drv pointer ? Even if we use void __iomem * it
would mean that hwmod would have to a) access driver's ioremaped area or
b) ioremap() the same area again.

Note sure if any of those are acceptable.

> And probably the handling of sysconfig bits should be
> done using a common header in include/linux/omap-hwmod.h
> or something so it can be shared between drivers.

That could be done, though I think the header name could be different.
Maybe it could match the document which define those registers, let me
just check if we're allowed to use that publicly :-p

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130214/64fab5bb/attachment-0001.sig>
