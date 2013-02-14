From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Feb 2013 21:27:19 +0200
Subject: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
In-Reply-To: <20130214181217.GA11806@atomide.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
Message-ID: <20130214192719.GB26679@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 14, 2013 at 10:12:17AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [130214 10:00]:
> > Hi,
> > 
> > On Thu, Feb 14, 2013 at 09:12:53AM -0800, Tony Lindgren wrote:
> > > * Felipe Balbi <balbi@ti.com> [130214 03:19]:
> > > > Currently the omap-serial driver will not
> > > > work properly if booted via DT with CPUIDLE
> > > > enabled because it depends on function pointers
> > > > provided by hwmod to change its own SYSCONFIG
> > > > register.
> > > > 
> > > > Remove that relyance on hwmod by moving SYSCONFIG
> > > > handling to driver itself. Note that this also
> > > > fixes a possible corner case bug where we could
> > > > be putting UART in Force Idle mode if we called
> > > > omap_serial_enable_wakeup(up, false) after setting
> > > > NOIDLE to the idle mode. This is because hwmod
> > > > has no protection against that situation.
> > 
> > Any comments to these last two sentences ?
> 
> Well I think all the driver handling should be done in
> the driver since we now have runtime PM.

cool.

> > > I agree the sysconfig stuff should be handled in the drivers.
> > > But considering that we need to also reset or idle hardware
> > > that may not have a driver loaded, it's best to put the
> > > reset/idle function in to the driver specific header as
> > > an inline function.
> > 
> > that is likely to cause quite a few isues, don't you think?
> > 
> > hwmod depending on driver code to reset particular IPs ? Seems like we
> > need a generic device_reset() hook which can be called by platform code,
> > no ? Not sure if that would help a lot though.
> > 
> > > This way the hwmod code can idle or reset the unclaimed
> > > hardware in a late_initcall.
> > 
> > The problem with this:
> > 
> > my_driver.h:
> > 
> > static inline void my_driver_reset(struct my_driver *drv)
> > {
> > 	writel(drv->regs, SYSS, RESET);
> > }
> > 
> > how will hwmod provide drv pointer ? Even if we use void __iomem * it
> > would mean that hwmod would have to a) access driver's ioremaped area or
> > b) ioremap() the same area again.
> 
> Well the ioremapping should only be done in the driver ideally.
> Currently we have a mess of both hwmod and driver doing the
> ioremapping.

right... and it only works because hwmod never calls
request_mem_region().

> So in the long run, let's assume only the driver ioremaps for
> most of the cases where there is a driver available.

makes sense.

> And only in the case there is no driver, hwmod can parse the address
> space from DT for the unclaimed hardware in the late_initcall.

sounds good. But then it means our DTS files should be 100% complete,
meaning that even for the IPs which we don't have drivers at all, we
should still provide DTS nodes.

In that case, does it make sense to teach DT about the actual structure
of OMAP's interconnect ? I mean:

ocp {
	l3 at xxxxxxxx {
		l4_per at xxxxxxxx {
			...
		};

		l4_wakeup at xxxxxxxx {
			...
		};

		...
	};
};

That would mean that even interconnect PM could move to a driver under
drivers/bus/{l3,l4_per,l4_wakeup,..}.c

> So the shared inline function should just take the __iomem * and
> size instead of *drv so both the driver and hwmod code can tinker
> with the autoidle bit.

Should hwmod be touching that in the long run ? It _does_ belong in the
device's address space

> > Note sure if any of those are acceptable.
> 
> Hmm what issues do you see in the above suggestion?

driver and hwmod accessing SYSC simultaneously for instance. Imagine
something like:

hwmod						driver
------						-------
1. starts device reset
2. polls RESET bit with X ms timeout		X' ms later starts reset
3. times out since reset restarts		polls RESET bit with X ms timeout
4. error!					reset completes

In such cases, what do we do ? There can be many such cases, don't
you think ?

> > > And probably the handling of sysconfig bits should be
> > > done using a common header in include/linux/omap-hwmod.h
> > > or something so it can be shared between drivers.
> > 
> > That could be done, though I think the header name could be different.
> > Maybe it could match the document which define those registers, let me
> > just check if we're allowed to use that publicly :-p
> 
> Cool yeah I have no preference where that header should be. Maybe
> something bus specific like include/linux/bus/omap-hwmod.h?

perhaps...

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130214/e04cee95/attachment-0001.sig>
