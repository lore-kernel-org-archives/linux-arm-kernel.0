From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 1 Feb 2011 12:34:14 +0100
Subject: [PATCH] mmci: restrict DMA usage to large,
	even multiblock	transfers
In-Reply-To: <20110201105408.GA31216@n2100.arm.linux.org.uk>
References: <1296556873-2730-1-git-send-email-linus.walleij@linaro.org>
	<20110201105408.GA31216@n2100.arm.linux.org.uk>
Message-ID: <4D47EFB6.5090509@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> On Tue, Feb 01, 2011 at 11:41:13AM +0100, Linus Walleij wrote:
>> This will restrict the use of DMA to only cover multi-block
>> transfers of blocks that are evenly divisible with the FIFO
>> halfsize (8 4-byte words, 32 bytes). This will be true for any
>> normal, large MMC file transfer, falling back to PIO mode for
>> any smallish reads.


> Russell King - ARM Linux wrote:
> That's a very bad idea.  If it's an ARM primecell, and we (by some magical
> reason) are using DMA, we want to always use DMA for transfers larger than
> the FIFO depth.  If we switch to PIO mode, we will see FIFO overruns/
> underruns if the CPU can't keep up with the data rate.
> 
> So I think you actually want:
> 
> 	if (host->size >= variant->fifosize &&
> 	    !mmci_dma_start_data(host, datactrl))
> 		return;

Getting FIFO overrun/underruns is then as of today already the case when 
running PIO for ARM primecell. To prevent this; you probably now that 
already, hardware flow control is implemented in ST version of the ARM 
primecell.

For performance gain I think the threshold should probably not be less 
than a 512 bytes block, but of course performance test needs to verify this.

Maybe a better option would be to specify a dma_threshold value in the 
variant struct. Thus the value can differ between what version of the 
ARM primcell we are using.

Finally I would prefer to move this "threshold" check into the
mmci_dma_start_data function instead, since there anyway can be other 
reasons to why we want to fall back to PIO mode. Better to do that from 
one place.

/Ulf Hansson
