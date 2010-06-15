From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Tue, 15 Jun 2010 22:14:59 +0200
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <4C170EE2.4010706@st.com>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
	<4C15C60E.6080404@st.com>
	<AANLkTim9n-p-Pw6FWvzQMBiAuB3h9ILq1Ya6XWk_0l-c@mail.gmail.com>
	<4C170EE2.4010706@st.com>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A025E5AE1ED@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Viresh]

> On 6/14/2010 7:09 PM, Linus Walleij wrote:
> > Hi Viresh, thanks a lot for reviewing this and I'd be *very* happy if
> > you could give it a spin on
> > the SPEAr as well!
> 
> I would be happy too linus, will do it in few weeks, right now we are
> running short of time.

Yeah I know that feeling ... anyway I will probably publish a few
more rounds of this before then.

> > In this case we multiplex the memcpy and slave transfers on the few
> > physical channels we have, but I haven't finally decided how to
> handle this:
> > perhaps we should always set on physical channel aside for memcpy
> > so this won't ever fail, and then this special memcpy device entry
> will help.
> >
> > Ideas? Use cases?
> 
> Hmmm. I am not sure, but i think we can't hard code a channel for some
> device.
> All channels should be available with both capabilities. If still there
> are
> some conditions (that you might know), where we need to hard code
> channels
> for devices, then this should come from plat data in some way.

Currently I don't hardcode anything, the physical channels
(on the PL081 only two!) will be multiplexed on a first-come
First-served basis. This is a bit problematic since if I start
a DMAengine memcpy test there is a real battle about the channels...
The memcpy test assumes it will always get a channel, see.

I could queue the transfers waiting for a physical channel to
become available but perhaps that's not so good either.

> I have few more doubts that i wanted to ask. Are following supported in
> your
> driver, we need them in SPEAr:
>  - Configure burst size of source or destination.

The PrimeCell extension supports this, do you need that in things
that are not PrimeCells? In that case we need to make them generic.

>  - Configure DMA Master for src or dest.

Right now I have an algorithm that will (on the PL080, the PL081
has only one master) try to select AHB1 for the memory and AHB2
for the device by checking if one address is fixed. If both or
none addresses are fixed it will simply select AHB1 for source
and AHB2 for destination.

Please elaborate on what algorithm you need for this!

>  - Transfer from Peripheral to Peripheral.

Not supported by DMAengine, but would be easy enough to add.

>  - Configure Width of src or dest peripheral.

Part of PrimeCell DMA API.

>  - Configure Flow controller of transfer.

Currently only done dynamically with DMA as the master for
Mem2mem, mem2per and per2mem. Mastering from the peripherals
is not supported. Do you have advanced features like that?

Anyway it can be passed in from platform data easily.

>  - Some callback for fixing Request line multiplexing just before
> 	initiating transfer.

This is part of this driver. RealView & versatile have exactly
this problem too.

>  - Multiple sg elements in slave_sg transfer. I think it is not
> supported.

No, but can be fixed quite easily.

>  - Control for autoincrement of addresses, both in case of memory and
> 	peripherals.

Right now the engine autoincrements the memory pointers if memory
is source/destination and both on mem2mem.

If you actually have peripherals that need increasing pointers it can
Probably be added.

Yours,
Linus Walleij
