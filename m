From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Apr 2011 14:00:17 +0200
Subject: [PATCH] mmci: sync DATAEND irq with dma transfer done
In-Reply-To: <20110419092049.GC22799@n2100.arm.linux.org.uk>
References: <1303203754-1731-1-git-send-email-linus.walleij@stericsson.com>
	<20110419092049.GC22799@n2100.arm.linux.org.uk>
Message-ID: <BANLkTik4mmJzYsOit-5vNzchtHVUyEL+jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 11:20 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Apr 19, 2011 at 11:02:34AM +0200, Linus Walleij wrote:
>> From: Ulf Hansson <ulf.hansson@stericsson.com>
>>
>> The end of a dma job must be synced with a DATAEND irq. This will
>> prevent the mmci driver from ending the mmc request before the
>> dma driver is completely done. By using DMA_PREP_INTERRUPT we
>> register a callback function which will is called when from the
>> dma driver when the dma transfer is completed.
>
> Why is what we currently do not sufficient?

On a high-speeded ux500 the DATAEND IRQ will assert before the
DMA data is actually finished, thus if we start hammering in the next
request we break an ongoing transfer. :-(

> This will break the detection of dead DMA controllers like on the ARM
> reference platforms, as I've said before.

Yeah ... I'm trying to think of something clever, can we put a
bool sync_dma_job in the vendor data and only activate this
for ux500 and U300 ST variants where we know DMA always
works then?

The only thing I worry about is if the plain vanilla PL180 would
exhibit the same behaviour when used with high-speed DMA, then
we're effectively deactivating a bugfix for it.

Linus
