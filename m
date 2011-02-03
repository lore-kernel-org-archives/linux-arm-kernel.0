From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 3 Feb 2011 15:15:25 +0100
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <20110124133513.GL16202@n2100.arm.linux.org.uk>
References: <1295618352-26432-1-git-send-email-pawel.moll@arm.com>
	<alpine.LFD.2.00.1101211456200.8580@xanadu.home>
	<20110124133513.GL16202@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinqauiy4RcWsAZqk8JoAE8+WqL6rakKsb-9nakt@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following up on this:

2011/1/24 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Jan 24, 2011 at 12:27:16PM -0000, Pawel Moll wrote:
>> So - we'll try to enlarge FIFO. For the moment - playing with interrupts
>> affinity seem to be a viable workaround.
>
> I don't think enlarging the FIFO will help too much. ?The issue is
> whether the CPU can keep up with the data rate coming off the card.
> If it can't, then no matter how large the FIFO is, it will eventually
> overflow.
>
> The real answer is to avoid PIO mode, and use DMA support. ?However,
> I've had problems using DMA on the ARM development boards. ?You can
> find details my DMA issues internally within ARM by talking to Catalin.

I fully agree with Russell, MMC by nature begs to be used with DMA.
Hopefully PL330 does not have all the basic problems found in
PL080/PL081, yet Samsung (som version) and ST-Ericsson Nomadik
does use the PL080, albeit in modified versions.

> The alternative answer, I believe implemented by some of ARMs silicon
> partners, is to turn the card clock off when the FIFO becomes full/empty
> to stop it sending more data. ?I think this violates some of the MMC/SD
> requirements, but it seems to work for the silicon partners just fine.

One of these fixes does not exclude the other.

We have this "hardware flow control" in U300, Nomadik and Ux500.
Basically the clock to the card is simply gated if the FIFO risk
to over/underflow.

To be precise, it gates the MCIFBCLK, MCICLKOUT and
MCICLK to the card when either RX FIFO is full and DPSM
is enabled, or TX FIFO is empty and DPSM is enabled.
We do not mess with the internal MCLK clock.

We have some experience in not even DMA being quick enough to
avoid overflows under all conditions, making it necessary to clock
down the host undesirably low. Increasing FIFO depth will
actually help to some extent in this case.

For example: the SD spec permits us to clock the card at something
like 23 MHz and with 4 data lines and a standard 64 byte (16 word)
FIFO this will fill up in 2.8 microseconds. So that, or rather half of
it 1.3 us, is the maximum allowed interupt latency, unless you clock
down the card.

The system IRQ latency is a swamp of heuristics unless you have
things like FIQ or realtime patches as mentioned.

And as mentioned by Russell one way to mitigate the effect
that would also benefit current Versatiles and RealViews would
be to dynamically recalibrate the card clock with some
error-feedback loop. (Would be pretty cool actually!)

Yours,
Linus Walleij
