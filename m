From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Jul 2018 10:19:47 +0200
Subject: [PATCH 1/3 v4] ARM: dts: Modernize the Vexpress PL111 integration
In-Reply-To: <b00c3b85-1368-f62b-efda-d23ce27e6f9c@arm.com>
References: <20180709075232.30678-1-linus.walleij@linaro.org>
 <b00c3b85-1368-f62b-efda-d23ce27e6f9c@arm.com>
Message-ID: <CACRpkdYpQkY9yfnsKV5=nbbh5f3mpU2u6xQ1r33-cNO7YHtcUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 11:46 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 09/07/18 08:52, Linus Walleij wrote:

> Still get below warnings, not sure if I need to upgrade my DTC ?
>
> vexpress-v2f-1xv7-ca53x2.dtb: Warning (graph_child_address):
> /smb at 8000000/motherboard/iofpga at 3,00000000/i2c at 160000/dvi-transmitter at 39/ports:
> graph node has single child node 'port at 0', #address-cells/#size-cells
> are not necessary
> rtsm_ve-aemv8a.dtb: Warning (graph_child_address):
> /smb at 8000000/motherboard/iofpga at 3,00000000/i2c at 160000/dvi-transmitter at 39/ports:
> graph node has single child node 'port at 0', #address-cells/#size-cells
> are not necessary

Yeah I looked at it as you said I decided to drop the amendments and I'm
just ever more confused.

> > - Fixed up the CA53 DTS: use the right chip select base
> >   at 0x18000000.
>
> I really hate this as it make maintenance difficult, but I don't have
> good alternative, so I am fine as it is for now :)

Yeah :/

I wish I could fix this but the changes are already daunting and scary
as they are without going in and trying to fix how the CMA DMA
allocator does its job as well (I admit I am scared of that code).

> > - Fixed up the Real-Time Systems Models Virtual Executive
> >   RTSMv8 AEM VE:
> >   - Added the I2C interface (whether implemented in the
> >     emulator or not)
>
> It doesn't work. This change is breaking the working CLCD on the models.
> I just tested and CLCD driver returns

Yeah not surprised... with QEMU I had to go in and add the I2C
bridge as it was not modeled.

I think the solution is to add a "simple" panel without bridge
for this as it is properly modeling what the hardware in the
RTSM looks like. Looking into it.

> >   - Fixed the chip select of the memory node to the right
> >     memory base 0x18000000.
>
> See, this keeps happening.

Yeah, I looked them over again and again, it gets wrong because
I put a human to do a machine's job... The chipselect setting is
in a non-obvious place in one file and the base that corresponds
to in a different file and it gets a bit confused.

I hope I have them all right now.

Yours,
Linus Walleij
