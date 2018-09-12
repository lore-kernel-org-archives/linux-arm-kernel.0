From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 12 Sep 2018 13:17:57 +0200
Subject: [PATCH v12 0/6] Driver for at91 usart in spi mode
In-Reply-To: <20180912105407.GR4185@dell>
References: <20180911153621.GP2494@piout.net>
 <CAMuHMdV+=EgAYogwNHbY=RExkGox_+YSeHV6pJtQb6g6PzD-CQ@mail.gmail.com>
 <20180911181838.GI4185@dell> <20180911185839.GA25212@piout.net>
 <20180911224418.GK4185@dell> <20180911225440.GL4185@dell>
 <20180912073355.GB2557@piout.net> <20180912084143.GN4185@dell>
 <CAMuHMdWefU0pw=c9TKOa+wGHchpg8JRfE0OnC4+wKDt-qrbH1A@mail.gmail.com>
 <20180912105407.GR4185@dell>
Message-ID: <20180912111757.GC2760@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2018 11:54:07+0100, Lee Jones wrote:
> On Wed, 12 Sep 2018, Geert Uytterhoeven wrote:
> > On Wed, Sep 12, 2018 at 10:41 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > On Wed, 12 Sep 2018, Alexandre Belloni wrote:
> > > > On 11/09/2018 23:54:40+0100, Lee Jones wrote:
> > > > > > > http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6438-32-bit-ARM926-Embedded-Microprocessor-SAM9G45_Datasheet.pdf
> > > > > > >
> > > > > > > USART doc starting p572, registers p621.
> > > > >
> > > > > After looking at the datasheet, I don't see any reason why one of the
> > > > > two drivers can't be selected using different compatible strings.
> > > >
> > > > Because there is only one IP and we don't use the device tree to selecet
> > > > linux specific drivers.
> > >
> > > We do it all the time.  There are loads of MFDs (def: same IP, with
> > > different functions) which have separate compatibles for their various
> > > functions.  If you wish this IP to operate as an SPI controller, it
> > > should have an SPI compatible, if you wish it to operate as a U(S)ART,
> > > then it should have a UART compatible.  It's what we do for most of
> > > the other MFDs in the kernel.
> > 
> > There is a big difference: MFD functions are(more or less) independent
> > functions, which can be used at the same time. It makes perfect sense for a
> > single IP block that has both SPI and UART interfaces, that can be used at
> > the same time.
> > 
> > In this case, there is a single piece of hardware that can perform
> > different functions, but not at the same time. Performing a different
> > function means configuring the hardware for that function, hence using a
> > different driver (from a different subsystem).
> 
> Yes, I can see that PoV.
> 
> But ... we can't have it both ways.  *Either* it's a true MFD, in
> which case it can/should have 2 separate compatible strings which can
> be specified directly from the DT.  *Or* it's not an MFD.  In the
> latter case, which I think we're all agreeing on (else we'd have 2
> compatible strings), MFD is not the place to handle this (my original
> point).
> 

If that is what bothers you, then let's move it out of mfd.

> So ... this is a USART device which can do SPI, right?
> 
> My current thinking is that; as this is a USART device first &
> foremost, the USART should be probed in the first instance regardless,
> then if SPI mode is specified it (the USART driver) registers the SPI
> platform driver (as MFD does currently) and exits gracefully, allowing
> the SPI driver to take over.
> 
> Spanner in the works: is it physically possible to change the mode at
> run-time?  :s

Yes it is possible but on Linux that will not happen without probing
the drivers again. I think DT overlays will be the only possible use
case because on SPI, you'd still have to provide nodes for the connected
SPI devices.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
