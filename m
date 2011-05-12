From: per.forlin@linaro.org (Per Forlin)
Date: Thu, 12 May 2011 10:36:33 +0200
Subject: [PATCH] mmci: sync DATAEND irq with dma transfer done
In-Reply-To: <BANLkTimrsn1MxY+L7_yt0b1LXmaXxpMHPg@mail.gmail.com>
References: <1303203754-1731-1-git-send-email-linus.walleij@stericsson.com>
	<20110419092049.GC22799@n2100.arm.linux.org.uk>
	<BANLkTik4mmJzYsOit-5vNzchtHVUyEL+jg@mail.gmail.com>
	<20110419120344.GG22799@n2100.arm.linux.org.uk>
	<BANLkTimrsn1MxY+L7_yt0b1LXmaXxpMHPg@mail.gmail.com>
Message-ID: <BANLkTin7_4ijP92u4Zd55zWaMEbv=zbOgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 6:29 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Apr 19, 2011 at 2:03 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Tue, Apr 19, 2011 at 02:00:17PM +0200, Linus Walleij wrote:
>>>
>>> On a high-speeded ux500 the DATAEND IRQ will assert before the
>>> DMA data is actually finished, thus if we start hammering in the next
>>> request we break an ongoing transfer. :-(
>>
>> Yes, you've already said that in the past. ?And this is partly why we
>> have this code in the dma unmap:
>>
>> ? ? ? ?/* Wait up to 1ms for the DMA to complete */
>> ? ? ? ?for (i = 0; ; i++) {
>> ? ? ? ? ? ? ? ?status = readl(host->base + MMCISTATUS);
>> ? ? ? ? ? ? ? ?if (!(status & MCI_RXDATAAVLBLMASK) || i >= 100)
>> ? ? ? ? ? ? ? ? ? ? ? ?break;
>> ? ? ? ? ? ? ? ?udelay(10);
>> ? ? ? ?}
>>
>> So, we wait until the DMA has drained the FIFO before we fire off the
>> next request - or even unmap the DMA buffer. ?Should the DMA fail to
>> drain the FIFO in a reasonable time, we timeout and disable DMA.
>>
>> Again, I ask, why is this not sufficient to cover the case where the
>> data end IRQ occurs before the DMA engine has completed the transfer -
>> which is likely to take a very short time indeed.
>
> It doesn't help, we have really tested this and at high speed transfers
> (especially if we use Per Fridens speed-up patches) apparently
> the flag RXDATAAVLBL goes to zero before the block is really
> finished.
>
I haven't really done any specific testing on this. Ulf has reproduced
it without my "speed-up" patches an old version of mmci before the DMA
was in mainline, not sure if it's done on the current mmci. I run data
test (dt) for hours without running into this. But my main concern is
more about verifying the changes I make in the mmc framework by
running cross platform tests (u8500, u5500, pandaboard ...). My focus
hasn't been about testing potential race conditions in the mmci driver
on ux500. I am willingly to test this dma race condition if there are
any doubts whether it still exists or not.

> Yours,
> Linus Walleij
Regards,
Per
