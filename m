From: ryder.lee@mediatek.com (Ryder Lee)
Date: Tue, 9 Jan 2018 17:12:27 +0800
Subject: [GIT PULL] Mediatek: 32-bit DT update for v4.15
In-Reply-To: <1509846112.26038.22.camel@mtkswgap22>
References: <c7145c00-b2b9-780c-0bfd-15f7d8a08dd6@gmail.com>
 <CAK8P3a3NWwoe0mX45WrFONyiHt9eWTTMziEc+rjqSfr5QZv8xQ@mail.gmail.com>
 <1509423579.10793.10.camel@mtkswgap22>
 <e8fdd9a9-ce13-8804-aea0-46becc6f9730@gmail.com>
 <CAK8P3a0+9fChSbObS9boR8okHtO8u8_hr2Te+RjfRD0T54QYWQ@mail.gmail.com>
 <1509673038.19220.19.camel@mtkswgap22>
 <CAK8P3a1doHCH4ucC1AUR5HiH5qvMXeoqsav-9dsvhM2KPh3FNw@mail.gmail.com>
 <1509709967.15691.25.camel@mtkswgap22>
 <CAK8P3a1oP98K3mzK3MfFvJ27y5fgYsTnOdPpjukQGXOLAQYhyA@mail.gmail.com>
 <1509846112.26038.22.camel@mtkswgap22>
Message-ID: <1515489147.11551.39.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Fri, 2017-11-03 at 16:21 +0100, Arnd Bergmann wrote:
> On Fri, Nov 3, 2017 at 12:52 PM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> > On Fri, 2017-11-03 at 10:40 +0100, Arnd Bergmann wrote:
> >> On Fri, Nov 3, 2017 at 2:37 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> 
> >> This should have the exact same effect as what you have in your tree,
> >> but if that works,
> >> we can merge that version and try to figure out why the kernel thinks
> >> they are different.
> >
> > I've tried this approach by using the 4-ports network card and got the
> > result:
> > pcieport 0000:00:01.0: assign IRQ: got 220
> > pcieport 0000:00:01.0: assigning IRQ 220
> > pcieport 0000:00:01.0: enabling device (0140 -> 0142)
> > pcieport 0000:00:01.0: enabling bus mastering
> > pcieport 0000:00:01.0: Signaling PME with IRQ 220
> > ....
> > igb 0000:01:00.0: assign IRQ: got 221
> > igb 0000:01:00.0: assigning IRQ 221
> > igb 0000:01:00.1: assign IRQ: got 221
> > igb 0000:01:00.1: assigning IRQ 221
> > igb 0000:01:00.2: assign IRQ: got 221
> > igb 0000:01:00.2: assigning IRQ 221
> > igb 0000:01:00.3: assign IRQ: got 221
> > igb 0000:01:00.3: assigning IRQ 221
> >
> > I think slot 1 should share its IRQ (220) with every device in the
> > hierarchy below this root port.
> 
> Agreed, that is what I expected, too. I've looked at the of_pci_irq.c
> in more detail but couldn't come up with what happened. Can you
> try running with this patch or something like that to figure out where
> it takes the wrong turn?
> 
> https://pastebin.com/MrMzwcmw
> 

Hi Arnd,

I guess the problem is the first device attached to downstream side of a
link must be device 0 - it means that the 'slot' portion of pdev->devfn
should be 0 when PCIe enumeration. That's why we always mismatch to
interrupt-map = <0x0000 0 0 ... GIC_SPI 193 ...>

However, if we want to list all four interrupts for each slot, that
could work if fallback to device tree parsing:

https://elixir.free-electrons.com/linux/v4.15-rc7/source/drivers/of/of_pci_irq.c#L89

Then replace 'pdev->devfn' with 'of_pci_get_devfn(out_irq->np)'

But I still not sure the proper way to solve it.

Ryder.
