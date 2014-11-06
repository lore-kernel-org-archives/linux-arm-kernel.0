From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 06 Nov 2014 10:50:42 +0100
Subject: [PATCH 2/4] dmaengine: device tree bindings for PL08x
In-Reply-To: <CACRpkdZ_R26-PnUycjkvvK3ZuU=2KvupHmvK+H+kUD-Ty=rtqQ@mail.gmail.com>
References: <1410507442-32451-1-git-send-email-linus.walleij@linaro.org>
 <201409161821.26348.arnd@arndb.de>
 <CACRpkdZ_R26-PnUycjkvvK3ZuU=2KvupHmvK+H+kUD-Ty=rtqQ@mail.gmail.com>
Message-ID: <8854726.ZIWJHAnVAn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 November 2014 10:11:58 Linus Walleij wrote:
> >> +     saa0 at dmac0 {
> >> +             signal = "saa0";
> >> +             bus-interface-ahb1;
> >> +     };
> >
> > The main value-add this gives you is a name of the signal, but nobody else
> > does this, and it seems this is only an artifact of the way the driver today
> > matches devices that come from platform data.
> >
> > If you want it just for migration purposes, we can probably put the names
> > in the platform, but the bus-interface-* should IMHO be expressed in the
> > dma specifier, the same way we do for the designware part.
> 
> The main requirement is telling which master to use for each
> channel, really, I can do without the naming (though it is very helpful
> for debugging).
> 
> I don't know how to provide a specifier for eligible bus interfaces
> in some elegant way with the DMA specifier, I could of course use
> two cells containing a plain number, specifying 0 for any interface,
> 1 for ahb1 and 2 for ahb2 like that:
> 
> #define BUS_AHB_ANY 0
> #define BUS_AHB1 1
> #define BUS_AHB2 2
> 
> uart1: uart at 101fb000 {
>         compatible = "arm,pl011", "arm,primecell";
>         (...)
>         dmas = <&dmac1 22 BUS_AHB1>,
>                <&dmac1 23 BUS_AHB1>;
>         dma-names = "rx", "tx";
> };
> 
> The problem is that this is just so wrong: the bus master arbitration
> is a property of the DMA controller, not the consuming device. The DMA
> controller side is where the lines to the external buses are connected,
> and it is performing the work on behalf of the device.
> 
> This way the knowledge is put in the totally wrong place. People get
> the impression that this is a property of the consumer...
> 
> When it comes to the actual DMA signal line that is more natural to
> have in the specifier.

Not sure about that, the approach you describe there sounds entirely
reasonable to me. The DMA specifier is not just a feature of the consumer
(the DMA slave) but of the connection between the consumer and the
controller (slave and master). This connection consists of the combination
of a request line and a bus master that is able to access the fifo
register, so it makes sense to list both here.

As far as I understand, the controller has to pick two master numbers
here: one for the memory side and one for the fifo side. The memory
side is a property of the dma engine, and that should always be the
same one, while the fifo side depends on the slave that is connected.

	Arnd
