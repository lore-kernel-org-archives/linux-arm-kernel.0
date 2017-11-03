From: ryder.lee@mediatek.com (Ryder Lee)
Date: Fri, 3 Nov 2017 19:52:47 +0800
Subject: [GIT PULL] Mediatek: 32-bit DT update for v4.15
In-Reply-To: <CAK8P3a1doHCH4ucC1AUR5HiH5qvMXeoqsav-9dsvhM2KPh3FNw@mail.gmail.com>
References: <c7145c00-b2b9-780c-0bfd-15f7d8a08dd6@gmail.com>
 <CAK8P3a3NWwoe0mX45WrFONyiHt9eWTTMziEc+rjqSfr5QZv8xQ@mail.gmail.com>
 <1509423579.10793.10.camel@mtkswgap22>
 <e8fdd9a9-ce13-8804-aea0-46becc6f9730@gmail.com>
 <CAK8P3a0+9fChSbObS9boR8okHtO8u8_hr2Te+RjfRD0T54QYWQ@mail.gmail.com>
 <1509673038.19220.19.camel@mtkswgap22>
 <CAK8P3a1doHCH4ucC1AUR5HiH5qvMXeoqsav-9dsvhM2KPh3FNw@mail.gmail.com>
Message-ID: <1509709967.15691.25.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-11-03 at 10:40 +0100, Arnd Bergmann wrote:
> On Fri, Nov 3, 2017 at 2:37 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> >> Ryder, can you be more specific how the interrupts are wired up?
> >> Is there one IRQ per slot that is connected to all of IntA/IntB/IntC/IntD
> >> and gets propagated through the bridges like that, or is it something else?
> >
> > Yes, that's what I mean - we only have one IRQ which is connected to all
> > INTx for each slot, and I'm not sure if there is any better way to solve
> > this problem.
> 
> Ok. Your parent interrupt-map seems entirely reasonable for that case as far
> as I can tell (maybe someone else can find a problem):
> 
> +               interrupt-map-mask = <0xf800 0 0 0>;
> +               interrupt-map = <0x0000 0 0 0 &sysirq GIC_SPI 193
> IRQ_TYPE_LEVEL_LOW>,
> +                               <0x0800 0 0 0 &sysirq GIC_SPI 194
> IRQ_TYPE_LEVEL_LOW>,
> +                               <0x1000 0 0 0 &sysirq GIC_SPI 195
> IRQ_TYPE_LEVEL_LOW>;
> 
> However, I can't find any other example of a machine using
> interrupt-map-mask = <0xf800 0 0 0>; in the kernel tree, so it's possible
> that we have a parser bug. We do have other boards that list all four
> interrupts for each slot, and that seems to work fine. Can you try this
> map in the parent while leaving out the chilren?
> 
>                interrupt-map-mask = <0xf800 0 0 7>;
>                interrupt-map = <0x0000 0 0 1 &sysirq GIC_SPI 193
> IRQ_TYPE_LEVEL_LOW>,
>                                         <0x0000 0 0 2 &sysirq GIC_SPI
> 193 IRQ_TYPE_LEVEL_LOW>,
>                                         <0x0000 0 0 3 &sysirq GIC_SPI
> 193 IRQ_TYPE_LEVEL_LOW>,
>                                         <0x0000 0 0 4 &sysirq GIC_SPI
> 193 IRQ_TYPE_LEVEL_LOW>,
>                                         <0x0800 0 0 1 &sysirq GIC_SPI
> 194 IRQ_TYPE_LEVEL_LOW>,
>                                         <0x0800 0 0 2 &sysirq GIC_SPI
> 194 IRQ_TYPE_LEVEL_LOW>,
>                                         <0x0800 0 0 3 &sysirq GIC_SPI
> 194 IRQ_TYPE_LEVEL_LOW>,
>                                         <0x0800 0 0 4 &sysirq GIC_SPI
> 194 IRQ_TYPE_LEVEL_LOW>,
>                                         <0x1000 0 0 1 &sysirq GIC_SPI
> 195 IRQ_TYPE_LEVEL_LOW>,
>                                         <0x1000 0 0 2 &sysirq GIC_SPI
> 195 IRQ_TYPE_LEVEL_LOW>,
>                                         <0x1000 0 0 3 &sysirq GIC_SPI
> 195 IRQ_TYPE_LEVEL_LOW>,
>                                         <0x1000 0 0 4 &sysirq GIC_SPI
> 195 IRQ_TYPE_LEVEL_LOW>;
> 
> This should have the exact same effect as what you have in your tree,
> but if that works,
> we can merge that version and try to figure out why the kernel thinks
> they are different.

I've tried this approach by using the 4-ports network card and got the
result:
pcieport 0000:00:01.0: assign IRQ: got 220
pcieport 0000:00:01.0: assigning IRQ 220
pcieport 0000:00:01.0: enabling device (0140 -> 0142)
pcieport 0000:00:01.0: enabling bus mastering
pcieport 0000:00:01.0: Signaling PME with IRQ 220
....
igb 0000:01:00.0: assign IRQ: got 221
igb 0000:01:00.0: assigning IRQ 221
igb 0000:01:00.1: assign IRQ: got 221
igb 0000:01:00.1: assigning IRQ 221
igb 0000:01:00.2: assign IRQ: got 221
igb 0000:01:00.2: assigning IRQ 221
igb 0000:01:00.3: assign IRQ: got 221
igb 0000:01:00.3: assigning IRQ 221

I think slot 1 should share its IRQ (220) with every device in the
hierarchy below this root port.

Ryder.
