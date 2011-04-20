From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2011 18:29:40 +0200
Subject: [PATCH] mmci: sync DATAEND irq with dma transfer done
In-Reply-To: <20110419120344.GG22799@n2100.arm.linux.org.uk>
References: <1303203754-1731-1-git-send-email-linus.walleij@stericsson.com>
	<20110419092049.GC22799@n2100.arm.linux.org.uk>
	<BANLkTik4mmJzYsOit-5vNzchtHVUyEL+jg@mail.gmail.com>
	<20110419120344.GG22799@n2100.arm.linux.org.uk>
Message-ID: <BANLkTimrsn1MxY+L7_yt0b1LXmaXxpMHPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 2:03 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Apr 19, 2011 at 02:00:17PM +0200, Linus Walleij wrote:
>>
>> On a high-speeded ux500 the DATAEND IRQ will assert before the
>> DMA data is actually finished, thus if we start hammering in the next
>> request we break an ongoing transfer. :-(
>
> Yes, you've already said that in the past. ?And this is partly why we
> have this code in the dma unmap:
>
> ? ? ? ?/* Wait up to 1ms for the DMA to complete */
> ? ? ? ?for (i = 0; ; i++) {
> ? ? ? ? ? ? ? ?status = readl(host->base + MMCISTATUS);
> ? ? ? ? ? ? ? ?if (!(status & MCI_RXDATAAVLBLMASK) || i >= 100)
> ? ? ? ? ? ? ? ? ? ? ? ?break;
> ? ? ? ? ? ? ? ?udelay(10);
> ? ? ? ?}
>
> So, we wait until the DMA has drained the FIFO before we fire off the
> next request - or even unmap the DMA buffer. ?Should the DMA fail to
> drain the FIFO in a reasonable time, we timeout and disable DMA.
>
> Again, I ask, why is this not sufficient to cover the case where the
> data end IRQ occurs before the DMA engine has completed the transfer -
> which is likely to take a very short time indeed.

It doesn't help, we have really tested this and at high speed transfers
(especially if we use Per Fridens speed-up patches) apparently
the flag RXDATAAVLBL goes to zero before the block is really
finished.

My rough guess (after looking at the VHDL code) is that
RXDATAVLBL flag goes low when the FIFO is empty, but that
doesn't mean that the DMA handshake logic is out of its send/recieve
state and thus we screw it up if we hammer in another transfer before
it has had time to deassert the single/burst request signals and go to
idle state. This can only be seen by the side effect of the DMA
transfer actually terminating, and the DMA engine calling its
callback.

Our version is not that far away from the pure ARM versions
so I think this problem is actually present in an unmodified
PL180 as well.

Yours,
Linus Walleij
