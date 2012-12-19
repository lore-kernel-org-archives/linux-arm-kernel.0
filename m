From: pratikp@codeaurora.org (Pratik Patel)
Date: Wed, 19 Dec 2012 13:24:31 -0800
Subject: CoreSight framework and drivers
In-Reply-To: <50D1F37E.6000804@ti.com>
References: <1355858365-11849-1-git-send-email-pratikp@codeaurora.org>
 <20121219112314.GA26329@mudshark.cambridge.arm.com>
 <50D1F37E.6000804@ti.com>
Message-ID: <20121219212431.GC23594@pratikp-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 11:03:58AM -0600, Jon Hunter wrote:
> 
> On 12/19/2012 05:23 AM, Will Deacon wrote:
> > Hi Pratik,
> > 
> > On Tue, Dec 18, 2012 at 07:19:17PM +0000, pratikp at codeaurora.org wrote:
> >> This RFC is aimed at introducing CoreSight framework as well as
> >> individual CoreSight trace component drivers adhering to ARM
> >> CoreSight specification. Some prior discussion on this can be
> >> referred at [1].
> >>
> >> There are 3 kinds of CoreSight trace components:
> >>
> >> * Sources: Responsible for producing trace data to provide
> >>   visibility for the associated entity.
> >>
> >> * Links: Transport components that carry trace data.
> >>
> >> * Sinks: Collectors for storing trace data or acting as conduits
> >>   for off-chip trace data collection.
> >>
> >> These components can be connected in various topologies to suite
> >> a particular SoCs tracing needs.
> >>
> >> Framework is responsible for gathering and using the information
> >> about the registered CoreSight components and their connections
> >> to allow it to dynamically deduce the sequence of components
> >> representing a connection from a CoreSight source to the
> >> currently selected CoreSight sink. This helps the framework to
> >> program the correct set of components to satisfy user request.
> > 
> > From a million miles up, this looks like a sensible sort of design but I
> > really think you need to talk to Jon Hunter (he's at least on CC) about
> > this, especially where bindings are concerned. If we can get something that
> > you both agree on, then we can include the CTI with the other coresight
> > components and do a more in-depth review at that point.
> 
> I need to look at these in closer detail, but there are a couple
> high-level items that need to be aligned on which are ...
> 
> 1. Why not use the AMBA bus framework?
> 
> You mentioned before that "AMBA bus is for PrimeCell devices (class 0xF)
> as opposed to CoreSight devices (class 0x9)". I will not claim to be
> that familiar with primecell and coresight devices and there
> differences, but this statement does not help me understand why a new
> bus type is needed. Furthermore, the existing ETM and ETB driver in
> arch/arm/kernel/etm.c uses the AMBA bus today and so at least those
> coresight devices are able to use the AMBA bus type.
> 

Currently we use the CoreSight virtual bus to conveniently list
sysfs configuration attributes for all the registered CoreSight
devices.

For eg:
/sys/bus/coresight/devices/coresight-etm0/<attribute>
/sys/bus/coresight/devices/coresight-etm1/<attribute>
/sys/bus/coresight/devices/coresight-stm/<attribute>
/sys/bus/coresight/devices/coresight-tmc-etf/<attribute>
...
...

Some of the attributes are based on device type (i.e. source,
link or sink) so they will exist for all devices of that type
while some are device specific.

Maybe I am misunderstanding the question but are you suggesting
to register CoreSight devices to the AMBA bus instead of the
CoreSight core layer code?

Will Deacon mentioned earlier that AMBA framework can be changed
to accomodate devices with a different class but I am more
concerned with losing some of the stuff that the core layer code
does (eg. coresight_register, coresight_enable, coresight_disable
in coresight.c) if we register CoreSight drivers to the AMBA bus
without letting the core layer know about the device connections.

BTW, sorry the patches didn't get posted to the list since they
are apparently awaiting moderator approval.

> 2. What about the existing ETM/ETB drivers?
> 
> We have existing drivers for ETM and ETB in arch/arm/kernel/etm.c. We
> should either move those drivers to the drivers directory or replace
> them with the new one. However, no point in having two drivers for the
> same coresight device.
> 

Agree we should ensure we don't lose any existing functionality.

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
