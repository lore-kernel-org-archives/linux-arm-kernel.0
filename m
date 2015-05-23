From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 23 May 2015 10:18:47 +0200
Subject: [PATCH v8 14/16] ARM: dts: Introduce STM32F429 MCU
In-Reply-To: <1432289231.3929.60.camel@pengutronix.de>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <2282066.NWoIT9ZyLc@wuerfel>
 <CALszF6CaO_yuNiSDuDV+4d2NRe_+32j=zcSE1HPhB1UH59cW9w@mail.gmail.com>
 <13641152.Yt4ZI3oT6L@wuerfel>
 <CALszF6CK5ezrO6D=4zr6zEPC7VanzbQjnZJwKOZekEZ5L4D-Dg@mail.gmail.com>
 <1432285588.3929.28.camel@pengutronix.de>
 <20150522091822.GF8557@lukather>
 <1432289231.3929.60.camel@pengutronix.de>
Message-ID: <20150523081847.GJ8557@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Fri, May 22, 2015 at 12:07:11PM +0200, Philipp Zabel wrote:
> Am Freitag, den 22.05.2015, 11:18 +0200 schrieb Maxime Ripard:
> > On Fri, May 22, 2015 at 11:06:28AM +0200, Philipp Zabel wrote:
> > > > In the probe function, it would check the number of reg resources.
> > > > If a single resource is passed, it would take it, else it would look
> > > > the one named "reset".
> > > > The driver and bindings would be the same for the two families, and
> > > > the bindings would be backward compatible with sunxi ones.
> > > > 
> > > > Philip, Arnd, what do you think?
> > > 
> > > I'm not a fan of describing the register layout in the device tree as
> > > detailed as the sunxi bindings do. I'd prefer the reg property to
> > > describe the device's register address space with one entry per
> > > contiguous block of registers.
> > 
> > That's exactly what we do.
> 
> Sorry, what I mean is 'as detailed as reusing the sunxi bindings for
> stm32xx here would do'. I don't know enough about the Allwinner register
> layouts to form an opinion.
> 
> The STM32F427xx/STM32F429xx manual, Table 13. "STM32F427xx and
> STM32F429xx register boundary addresses" contains this entry:
>     Bus    Boundary address       Peripheral
>     AHB1   0x40023800-0x400238bf  RCC
> 
> And that's how I'd expect it to be described by the device tree:
> 
>     rcc: rcc at 40023800 {
>         compatible = "st,stm32-rcc";
>         reg = <0x40023800 0xc0>;
>     };

It's pretty much what we do already. The thing is that our reset
controllers are intertwined with our clock ones, so our reset
controllers are usually taking only a few registers, and we can't use
more than that since we have clocks in the registers around.

> Instead of "reg = <0x40023810 0x20>" for the resets. Where in the
> address range the reset, clock gate and clock configuration registers
> reside could be derived from the compatible value.

I agree on that, and if a generic solution was to be made like this,
we could definitely use it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150523/6b8a563a/attachment-0001.sig>
