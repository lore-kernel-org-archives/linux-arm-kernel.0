From: balbi@ti.com (Felipe Balbi)
Date: Fri, 1 Mar 2013 08:36:43 +0200
Subject: [PATCH v9 8/9] usb: chipidea: tell platform layer the ci core
 probe's result
In-Reply-To: <87mwuowt3h.fsf@ashishki-desk.ger.corp.intel.com>
References: <20130226094234.GC26189@arwen.pp.htv.fi>
 <20130227022202.GA20402@nchen-desktop>
 <20130227121238.GE8016@arwen.pp.htv.fi>
 <20130228031118.GA19387@nchen-desktop>
 <20130228072617.GB6154@arwen.pp.htv.fi>
 <20130228083143.GB19516@nchen-desktop>
 <20130228084933.GG6544@arwen.pp.htv.fi>
 <871uc0yeau.fsf@ashishki-desk.ger.corp.intel.com>
 <20130228104240.GA22736@arwen.pp.htv.fi>
 <87mwuowt3h.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20130301063643.GD3120@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 28, 2013 at 01:55:30PM +0200, Alexander Shishkin wrote:
> >> >> > > > > > > If the probe fails, the ci13xxx_add_device will not return error,
> >> >> > > > > > > (bus_probe_device doesn't has return value)
> >> >> > > > > > > therefore, the platform layer can't know whether core's probe
> >> >> > > > > > > is successful or not, if platform layer goes on using core's struct
> >> >> > > > > > > which is initialized at core's probe, the error will occur.
> >> >> > > > > > > 
> >> >> > > > > > > This error is showed when I only compile gadget, the host-only
> >> >> > > > > > > controller reports "no supported roles", and fails probe, but imx
> >> >> > > > > > > platform code doesn't know it, and goes on using core's private data.
> >> >> > > > > > > 
> >> >> > > > > > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> >> >> > > > > > 
> >> >> > > > > > this just tells you that platform code shouldn't be using the driver
> >> >> > > > > > directly. passing probe_retval via platform_data is an abomination, fix
> >> >> > > > > > the real problem instead, whatever it is.
> >> >> > > > > 
> >> >> > > > > So you suggest the platform glue layer should not use core driver's data
> >> >> > > > > directly, eg, for your dwc3, the platform glue layer should not use
> >> >> > > > > struct dwc3 *dwc directly? 
> >> >> > > > 
> >> >> > > > yes, and it doesn't. Ever.
> >> >> > > > 
> >> >> > > 
> >> >> > > If the dwc3 core fails to probe, but controller core clk is still on, is it
> >> >> > > a valid case?
> >> >> > 
> >> >> > of course not, but then again, core clk shouldn't be handled by glue
> >> >> > layer. You need to figure out who owns the clock, if it feeds DWC3 why
> >> >> > would you clk_get() and clk_prepare_enable() from glue ? Makes no sense.
> >> >> > 
> >> >> 
> >> >> Sorry? I can't find clk_prepare_enable at dwc3/core.c, but at dwc3 core, it
> >> >> try to access register at probe, unless platform layer open the clock, how
> >> >> can the core visit the core register.
> >> >
> >> > Is it really this difficult to figure out ? Fair enough, below are all
> >> > the details:
> >> >
> >> > To understand the reason why dwc3/core.c doesn't know about struct clk,
> >> > you need to consider where the driver was originally written; it was
> >> > written on an OMAP platform (actually first on a virtual model OMAP -
> >> > somewhat like QEMU -, than on a PCIe FPGA prototype of the IP, then
> >> > ARM-based FPGA prototype, then OMAP5, none of which needed explicit
> >> > clock control, see below).
> >> >
> >> > OMAP's PM is written in such a way that a pm_runtime_get() will enable
> >> > the device the all clocks necessary to be usable. Since OMAP would never
> >> > need to use clocks directly and I would never be able to test that code,
> >> > I decided not to add it.
> >> >
> >> > Now, if dwc3-exynos needs it, the sane thing to do would be add struct
> >> > clk knowledge to dwc3/core.c but make it optional. If there are no
> >> > clocks available, don't bail out.
> >> 
> >> I'm not too familiar with the multitudes of platforms out there, but my
> >> simple question is: why can't we have pm runtime take care of
> >> enabling/disabling the clocks so that we don't have to do it in drivers?
> >
> > that's what OMAP does.
> >
> >> Seems obvious that a platform/SoC/board should know about it's clock
> >> tree structure, so why doesn't the platform code then take care of all
> >> the dirty details?
> >
> > it might seem that way, but it's not that obvious ;-) Some platforms
> > have a single clock, some will split interface and functional clocks, in
> > some cases, you have extra optional clocks which might be needed during
> > certain use cases or to implement erratas at locations that only driver
> > knows.
> 
> Then drivers could use platform fixup callbacks. Curious how many

ugh, I just puked in my mouth a little bit...

> drivers out there do proper handling of interface vs functional
> clocks. Something tells me that the common pattern will be "enable all

that, in itself, is no argument against explicitly handling clocks. Bugs
are bugs and will always exist, instead of hiding the problem, we should
fix them ;-)

> clocks with lots of line of boilerplate copied from that other driver"
> in probe() and "disable all" in remove().

for a first iteration, you're likely right. When we get to a point where
driver is really stable we can start trying to optimize runtime power
consumption by fiddling with clocks.

If we're not going to access a device's register, why would you keep
interface clock running ? That's where e.g. runtime_pm fails to give us
a good solution. There's no (easy) way to tell pm_domain code that it
can gate interface clock but not functional clock.

> > Well, how quickly can Exynos be changed to handle clocks without
> > driver's knowledge ?
> 
> Motivation for the platforms to change should come from the general
> direction of linux kernel maintainers, in order for the change to
> happen. :)
> 
> But yes, for the time being, you're right, we'll probably have to just
> cope with it.

exactly. Just because XYZ wants clocks to be handled all via pm_domain,
it doesn't mean we can switch to that overnight. On top of that there
are situations such as the one describe above.

> > Also, I'm a lot more 'at ease' when I see the driver explicitly handling
> > all of its resources. The whole "let's hide XYZ from driver because
> > driver authors never get things right" always causes problems. Specially
> > in the ARM land where there's no standardization at all.
> 
> I think it's going to be like that as long as developers are working in
> "hack it and ship it and let somebody else figure out APIs" routine. I

that's why we need capable maintainers. Sometimes things will fall
through the cracks, sure, but in most cases we should be blocking
"hack and ship" during code review ;-)

> understand that some drivers will always need to call into clock
> framework directly, but other should have an option not to if their
> operation doesn't depend on it.

right, so that's why I asked to add struct clk knowledge to dwc3 but
make it optional: OMAP doesn't need it, PCIe doesn't need it; only
exynos (currently) needs it.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130301/da110f05/attachment-0001.sig>
