From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 6 Nov 2014 10:11:58 +0100
Subject: [PATCH 2/4] dmaengine: device tree bindings for PL08x
In-Reply-To: <201409161821.26348.arnd@arndb.de>
References: <1410507442-32451-1-git-send-email-linus.walleij@linaro.org>
 <201409161821.26348.arnd@arndb.de>
Message-ID: <CACRpkdZ_R26-PnUycjkvvK3ZuU=2KvupHmvK+H+kUD-Ty=rtqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 6:21 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 12 September 2014, Linus Walleij wrote:

>> This introduces device tree bindings for the PL08x DMA controllers
>> when used with fixed signal assignment per channel, i.e. if each
>> channel on the PL08x is assigned precisely one burst/single signal
>> set.
(...)
> If the mux handling is really simple, we could it part of the
> pl08 driver and key it off the compatible string -- for any
> of the known variants that use a mux, we then have the driver
> implement the muxing directly.

I am also leaning toward this solution. Probably moving the
mux handling to a separate file and Kconfig symbol with some
header stubs that get compiled out unless explicitly enabled.

> Or it could be done the other way round: Have a binding for the
> mux that implements the generic dma binding, and a driver for
> it that registers with of_dma and forwards any
> dma_request_slave_channel() call to the underlying driver.
> That would even make the mux driver independent of pl08.

Yeah that is the big hammer. This is what we did for IRQ line
muxes in drivers/irqchip/irq-crossbar.c, but maybe it's overkill.

>> +Optional sub-nodes:
>> +The slave transfer channels are assigned in consecutive order and
>> +identified by one child node per channel, assuming a fixed-signal
>> +per channel assignment and each with the following properties:
>> +
>> +Required properties:
>> +- signal: the name of the on-chip signal line handled by this channel
>> +- bus-interface-ahb1 or bus-interface-ahb2: tells the driver which
>> +  bus interface(s) that is eligible for this specific channel. At least
>> +  one of the interfaces must be specified, it is perfectly legal to
>> +  specify both if the hardware supports using either interface.
>
> I'd really like to avoid this and move all of it into the dma specifier.
> I understand where you are coming from with this given the existing
> code, but I'd rather change the driver code to allow a simpler binding.
>
>> +     saa0 at dmac0 {
>> +             signal = "saa0";
>> +             bus-interface-ahb1;
>> +     };
>
> The main value-add this gives you is a name of the signal, but nobody else
> does this, and it seems this is only an artifact of the way the driver today
> matches devices that come from platform data.
>
> If you want it just for migration purposes, we can probably put the names
> in the platform, but the bus-interface-* should IMHO be expressed in the
> dma specifier, the same way we do for the designware part.

The main requirement is telling which master to use for each
channel, really, I can do without the naming (though it is very helpful
for debugging).

I don't know how to provide a specifier for eligible bus interfaces
in some elegant way with the DMA specifier, I could of course use
two cells containing a plain number, specifying 0 for any interface,
1 for ahb1 and 2 for ahb2 like that:

#define BUS_AHB_ANY 0
#define BUS_AHB1 1
#define BUS_AHB2 2

uart1: uart at 101fb000 {
        compatible = "arm,pl011", "arm,primecell";
        (...)
        dmas = <&dmac1 22 BUS_AHB1>,
               <&dmac1 23 BUS_AHB1>;
        dma-names = "rx", "tx";
};

The problem is that this is just so wrong: the bus master arbitration
is a property of the DMA controller, not the consuming device. The DMA
controller side is where the lines to the external buses are connected,
and it is performing the work on behalf of the device.

This way the knowledge is put in the totally wrong place. People get
the impression that this is a property of the consumer...

When it comes to the actual DMA signal line that is more natural to
have in the specifier.

Yours,
Linus Walleij
