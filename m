From: balbi@ti.com (Felipe Balbi)
Date: Fri, 15 Feb 2013 18:42:35 +0200
Subject: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
In-Reply-To: <20130215163031.GA5724@atomide.com>
References: <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130215101610.GR17852@n2100.arm.linux.org.uk>
 <511E3797.2070802@ti.com>
 <20130215132726.GT17852@n2100.arm.linux.org.uk>
 <511E38C3.7080404@ti.com> <20130215163031.GA5724@atomide.com>
Message-ID: <20130215164235.GA20840@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 15, 2013 at 08:30:32AM -0800, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130215 05:34]:
> > On Friday 15 February 2013 06:57 PM, Russell King - ARM Linux wrote:
> > >On Fri, Feb 15, 2013 at 06:56:47PM +0530, Santosh Shilimkar wrote:
> > >>Whats your view on use of arch_ioremap_caller() hook ? This can allow
> > >>us to avoid the dual ioremap() issue discussed here if the hook
> > >>maintains the list of mapped ios.
> > >>
> > >>I was even thinking of having such intelligence within the core
> > >>ioremap code but thought that might be too invasive.
> > >
> > >Why do you even need it?  There's no problem with ioremapping the same
> > >space multiple times (you end up with multiple mappings but that
> > >shouldn't be a problem, except for the additional space used.)
> > >
> > It just waste of iospace and Tony insisted to have just single ioremap()
> > hence all this discussion
> 
> The main goal is to avoid duplicating data both in hwmod and DT.
> That's pretty much solved as we can have the driver probe populate
> the common data for hwmod from DT as Santosh has already demonstrated.
> 
> Then we also want the driver specific idle and reset code to be done
> in the drivers rather than in hwmod and glue it together with hwmod
> using runtime PM. The biggest issue there is how do we reset and idle
> some piece of hardware for PM purposes when there's no driver loaded.

right, this will be a tough nut to crack.

I guess the only way would be reset all IPs early in the boot process,
before even creating the platform-devices. Can we do that ? I mean, from
omap_device_build_from_dt() we have access to address space of all
devices, through ti,hwmods we can figure out which hwmods are linked to
that particular device, so whenever you build a device, you could just
call _reset().

The only problem is that now omap_device_build_from_dt() is called after
we notify that a new device/driver pair has been registered with the
platform_bus, right ? So we would still need a way to call _reset() for
those which are on DTS but don't have a driver bound to them...

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130215/844a239f/attachment.sig>
