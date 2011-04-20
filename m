From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2011 19:17:27 +0200
Subject: [PATCH] mmci: sync DATAEND irq with dma transfer done
In-Reply-To: <BANLkTikr5B5YH+is18gYceCM1thjHgT-yQ@mail.gmail.com>
References: <1303203754-1731-1-git-send-email-linus.walleij@stericsson.com>
	<20110419092049.GC22799@n2100.arm.linux.org.uk>
	<BANLkTik4mmJzYsOit-5vNzchtHVUyEL+jg@mail.gmail.com>
	<20110419120344.GG22799@n2100.arm.linux.org.uk>
	<BANLkTimrsn1MxY+L7_yt0b1LXmaXxpMHPg@mail.gmail.com>
	<BANLkTikr5B5YH+is18gYceCM1thjHgT-yQ@mail.gmail.com>
Message-ID: <BANLkTik05ERLa83Lah5Fx2HO+91bb9Q7Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 6:46 PM, Vitaly Wool <vitalywool@gmail.com> wrote:
>>
>> My rough guess (after looking at the VHDL code) is that
>> RXDATAVLBL flag goes low when the FIFO is empty, but that
>> doesn't mean that the DMA handshake logic is out of its send/recieve
>> state and thus we screw it up if we hammer in another transfer before
>> it has had time to deassert the single/burst request signals and go to
>> idle state. This can only be seen by the side effect of the DMA
>> transfer actually terminating, and the DMA engine calling its
>> callback.
>
> From what you are saying, RXDATAAVLBL seems to be equal to
> !RXFIFOEMPTY in your case.

Yes that is exactly what the VHDL says:

RXDATAAVL <= not(FifoEmpty) [roughly]

> Did you try to change the former to the
> latter to see how it works?

It's equivalent, neither FIFO watermark is connected to the
state of the DMA request signals...

What we need is a DMAXFERCOMPLETE flag so we know that
the DMA state machine is really finished. Sadly the hardware lacks
such a status flag, so there is no way to know that the DMA state
machine is finished by looking at any status registers in the
MMCI block.

We are thus reliant on the other end of the bitpipe telling us
it's finished.

Yours,
Linus Walleij
