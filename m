From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 14 Mar 2014 20:14:49 +0800
Subject: [PATCH 1/2] ARM: DT: fix gic interrupt controller documentation
In-Reply-To: <CAJ+vNU2YYbsH8iOWJ_B-vcHdfWYW1oFsWY_=YEd-ojJASOZgtQ@mail.gmail.com>
References: <1394732405-2260-1-git-send-email-tharvey@gateworks.com>
 <1394732405-2260-2-git-send-email-tharvey@gateworks.com>
 <5321EE81.1030207@wwwdotorg.org>
 <20140313182554.GA15990@obsidianresearch.com>
 <CAJ+vNU2YYbsH8iOWJ_B-vcHdfWYW1oFsWY_=YEd-ojJASOZgtQ@mail.gmail.com>
Message-ID: <20140314121448.GB813@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 03:25:50PM -0700, Tim Harvey wrote:
> On Thu, Mar 13, 2014 at 11:25 AM, Jason Gunthorpe
> <jgunthorpe@obsidianresearch.com> wrote:
> > On Thu, Mar 13, 2014 at 11:44:33AM -0600, Stephen Warren wrote:
> >> On 03/13/2014 11:40 AM, Tim Harvey wrote:
> >> > When using interrupt-maps, the size of a map entry is #address-cells +
> >> >  #interrupt-cells for the parent interrupt controller.  For the ARM GIC
> >> > address-cells should be 0 as this is not used.
> >> >
> >> > This patch fixes the example by correctly specifying #address-cells = 0.
> >>
> >> If the #address-cells property is required (well, or even optional...)
> >> in the node, shouldn't it be included in the list of required/optional
> >> properties above, and not solely included in the example?
> >
> > AFAIK, #address-cells = 0 is the same as not including a
> > #address-cells at all.
> >
> > Omitting entirely is what other interrupt-controller bindings are
> > doing, so I'd just drop mention of #address-cells completely.
> >
> > Jason
> 
> Jason / Stephen,
> 
> Yes, it does indeed default to 0 if not specified.  For arm-gic it
> would appear #address-cells must be 0, so should we remove all places
> its set explicitly to 0 in dts as wel as the example in
> Documentation/devicetree/bindings?
> 
> Looking through arch/arm/boot/dts I'm seeing other dts configs using
> 'arm,cortex-a9-gic' which I'm guessing are equally as wrong as the
> imx6 situation:
>  - arch/arm/boot/dts/highbank.dts
>  - arch/arm/boot/dts/sh73a0.dtsi
> 
> I'm also seeing a number of places where its set explicitly to 0:
>  - Documentation/devicetree/bindings/arm/gic.txt
>  - Documentation/devicetree/bindings/arm/vexpress.txt
>  - arch/arm/boot/dts/bcm11351.dtsi
>  - arch/arm/boot/dts/hi3620.dtsi
>  - arch/arm/boot/dts/imx6qdl.dtsi
>  - arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> 
> If I extend this search to the other compatible gic interrupt
> controllers implemented in drivers/irqchip/irq-gic.c
> (arm,cortex-a15-gic, qcom,msm-8660-qgic, qcom,msm-qgic2) I find even
> more examples where #address-cells is set explicitly to 0 or to 1 (and
> I would believe a value of 1 is invalid, just as it is in my case).
> 
> I'm happy to broaden my patch, but I certainly want to make sure I'm
> doing the right thing with it, as I don't have the ability to test all
> the other devicetree configs and am by no means a devicetree expert.
> 
> Recommendations?

Copy Rob, who might want to comment a bit.

My understanding is that #address-cells and #size-cells are only valid
for a node that may have child nodes.  Will gic node possibly get any
child node?

Shawn
