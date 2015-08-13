From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Aug 2015 15:37:30 +0100
Subject: [PATCH 1/2] drivers: PL061: add support for platform driver
 probing
In-Reply-To: <1439468713.1661643.355247625.1CF96E47@webmail.messagingengine.com>
References: <1438585198-8764-1-git-send-email-zhaoshenglong@huawei.com>
 <1438585198-8764-2-git-send-email-zhaoshenglong@huawei.com>
 <CACRpkdY6ZfB-gnnr49He+BYELy4fhiV0g5jkEHhyVsJOc_SBFw@mail.gmail.com>
 <1438614811.2338188.346456017.5D258EC5@webmail.messagingengine.com>
 <CACRpkdYmeXvXCrJPxCJCDfCG_=MmopmyAe5mgCPoB_S02ERTLg@mail.gmail.com>
 <1439468713.1661643.355247625.1CF96E47@webmail.messagingengine.com>
Message-ID: <20150813143730.GP7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 01:25:13PM +0100, Graeme Gregory wrote:
> 
> 
> On Thu, 13 Aug 2015, at 01:14 PM, Linus Walleij wrote:
> > On Mon, Aug 3, 2015 at 5:13 PM, Graeme Gregory <gg@slimlogic.co.uk>
> > wrote:
> > > On Mon, 3 Aug 2015, at 01:40 PM, Linus Walleij wrote:
> > >> On Mon, Aug 3, 2015 at 8:59 AM, Shannon Zhao <zhaoshenglong@huawei.com>
> > >> wrote:
> > >>
> > >> > From: Shannon Zhao <shannon.zhao@linaro.org>
> > >> >
> > >> > Since PL061 currently only supports AMBA driver, to support using GPIO
> > >> > PL061 by DT or ACPI, it needs to add support for platform driver.
> > >> > A DT binding is provided with this patch, ACPI support is added in a
> > >> > separate one.
> > >> >
> > >> > Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
> > >> > Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> > >>
> > >> I already stated in 0/2 what the problem is with this, and it's obviously
> > >> adding
> > >> a huge codechunk, very similar to the AMBA probe path.
> > >>
> > >> We need to investigate if ACPI can just spawn AMBA/PrimeCell type devices
> > >> instead.
> > >
> > > AMBA DT support is a hideous hack, we had kind of hoped to avoid doing
> > > that in ACPI.
> > 
> > Define what you mean with "hideous hack".
> > 
> drivers/of/platform.c search for #ifdef CONFIG_ARM_AMBA

The way that AMBA support was added to OF was not something I was involved
in.  Don't make the mistake of saying "we're only supporting platform
devices in ACPI because the OF implementation is messed up".

> > I think it is elegant. It combines the DT aspect of telling where the
> > device is with the Plug-and-play aspect of reading the 0xB105F00D
> > magic in the PrimeCells very nicely. With an optional override
> > mechanism. It's nice.

It's also the _right_ way to deal with buses with different properties
from platform devices, especially where some can be probed and identified
via hardware-encoded IDs.

> I have no objection to AMBA devices that are children of an AMBA bus
> object. Its the hack above that is nasty!  It is also un-scalable as it
> sets the precedent that the platform.c in both DT and ACPI should learn
> about all the different types of device probing.

What's actually the nasty thing is that DT and ACPI are wedded to platform
devices, which pushes people down the path of more platform device usage,
when in fact they should be creating their own bus classes.

> > > If you notice ARM already updated pl011 driver to support platform
> > > device type probing this seems to be the way to go.
> > 
> > Just because there is a precedent does not mean it is good.

Exactly.

> > Continuing with this adds 100+ lines of hairy initialization to
> > every AMBA driver.

And that's utterly insane.

> > What needs to happen is stop this and make ACPI spawn
> > AMBA devices for PrimeCells, and move the serial port over
> > to that.
> > 
> > A compromise may be to have something that probes a list
> > of these platform devices in drivers/acpi/ and spawn a
> > corresponding AMBA device for it. It will still save codelines in
> > all other subsystems and lower maintenance for the
> > subsystem maintainers.

Even that isn't nice... but I guess as the madness will be contained
within ACPI, it'll be ACPI's problem to maintain, so up to them how to
deal with it provided the code is contained within ACPI. :)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
