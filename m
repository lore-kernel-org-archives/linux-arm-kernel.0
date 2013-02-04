From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 4 Feb 2013 17:37:01 +0000
Subject: [PATCH 2/4] ARM: mach-shmobile: r8a7779: Allow initialisation
 of GIC by DT
In-Reply-To: <510BCE09.7050302@gmail.com>
References: <1359597051-32700-1-git-send-email-horms+renesas@verge.net.au>
 <1359597051-32700-3-git-send-email-horms+renesas@verge.net.au>
 <20130131123213.GB7235@e106331-lin.cambridge.arm.com>
 <20130201001119.GO10312@verge.net.au>
 <20130201003410.GA30007@verge.net.au>
 <20130201105849.GB21191@e106331-lin.cambridge.arm.com>
 <510BCE09.7050302@gmail.com>
Message-ID: <20130204173701.GE28464@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 02:15:37PM +0000, Rob Herring wrote:
> On 02/01/2013 04:58 AM, Mark Rutland wrote:
> > On Fri, Feb 01, 2013 at 12:34:10AM +0000, Simon Horman wrote:
> >> On Fri, Feb 01, 2013 at 09:11:19AM +0900, Simon Horman wrote:
> >>> On Thu, Jan 31, 2013 at 12:32:13PM +0000, Mark Rutland wrote:
> >>>> Hi Simon,
> >>>>
> >>>> On Thu, Jan 31, 2013 at 01:50:49AM +0000, Simon Horman wrote:
> 
> >>>>> +
> >>>>> +        gic: interrupt-controller at f0001000 {
> >>>>> +                compatible = "arm,cortex-a9-gic";
> >>>>> +                #interrupt-cells = <3>;
> >>>>> +                #address-cells = <1>;
> >>>>
> >>>> Why is #address-cells needed here (and without #size-cells)? I see it's in the
> >>>> binding document example, but I can't figure out why.
> >>>
> >>> Its here because I copied the example.
> >>> I will see about removing it from here.
> > 
> > Rob, Grant, do either of you know if there's a reason for this that we've
> > missed?
> > 
> > The gic doesn't have any direct children, and this doesn't seem to be
> > some decvicetree interrupt-controller magic.
> 
> If you look at of_irq_map_raw, there are cases that look at
> #address-cells. Those appear to be only when you have an interrupt-map
> though.

Aah. So this is some devicetree magic after all. Thanks for looking into it.

> > 
> > If this is superfluous, how about the patch below?
> 
> The docs probably should state #addr-cells is only required with
> interrupt-map.

That'd be nice. It might limit the confusion we had here.

> 
> > 
> > I took a quick look at arch/arm/boot/dts/. Some gic nodes don't have
> > #address-cells, some have it but not #size-cells, and some have both. These
> > should probably be cleaned up too.
> 
> Some boards are using interrupt-map, so they may need #address-cells. So
> I'm inclined to leave things alone.

That would make sense.

Thanks,
Mark.
