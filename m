From: petr.cvek@tul.cz (Petr Cvek)
Date: Fri, 10 Mar 2017 01:49:12 +0100
Subject: [BUG] dmaengine: pxa_dma: + mmc: pxamci: race condition with DMA
 error on tx channel
In-Reply-To: <877f3zwwgo.fsf@belgarion.home>
References: <e749aff1-0ffc-c9ed-42b2-82397b4e8ba2@tul.cz>
 <877f3zwwgo.fsf@belgarion.home>
Message-ID: <feb39d00-d40d-f935-751c-8119f40b4df4@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 8.3.2017 v 17:43 Robert Jarzmik napsal(a):
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
> Hi Petr,
>> I wasn't able to track the problem to a single patch as the problem occurs at
>> random time (from the boot to like a half an hour) and it's maybe dependent on a
>> level of a battery charge (maybe because of kernel log writes of charging
>> messages).
> Mmmh, long reproduction time, that will be bad.

Sent log is for a machine which finally died when I tried to start an X server. These debug printks slow it down.

>> It seems that most occurrency is during writes on an SD card. Using an SDHC
>> card decreases the time to fail. After failure the OS is unavailable (rootfs
>> in on the card).
> Okay, let me try to make write loop on my SD card to see if I manage to
> reproduce this.
> 

I tried to enable and disable soundcard (other part which is using DMA), but it does not have any effect. Concurrent interrupts may have.

>> From my poking in the kernel source code it seems there is a probability that pxamci_irq() takes longer to call and its subsequent call pxamci_data_done() isn't fast enough to set [1]
>> 	host->data = NULL;
> 
>> From the DMA side, the DMA done interrupt is generated:
>> 	pxad_chan_handler() -> vchan_cookie_complete()
>> ...where a tasklet for vchan_complete() is scheduled
> At least that seems to hint the DMA part is sound so for.
> The bothering part is the log error "mmc0: DMA error on tx channel". I would
> need a bit of guidance here, with the same log with [1] applied.
> 

Probably some cooperation of the DMA engine and the PXA MMC (like that other mail I've sent to you with UDC and g_webcam). I made another version of debug kernel with my own asserts:

In pxamci_dma_irq() before dmaengine_tx_status() call I've put:

pr_info("!!!cookie=%x complete=%x used=%x\n", 
	host->dma_cookie,chan->completed_cookie,chan->cookie);

It gets called only ONCE, just before failure, which values like this:
	cookie=372 complete=371 used=372

vchan_cyclic_callback() is called only with the soundcard in my machine IMO. I first thought there is regression with vd_completed in pxad_chan_handler() being changed during vchan_cyclic_callback() but it seems not.

pxad_tx_status() returns DMA_IN_PROGRESS before the failure.

>> , where finally with interrupts enabled (can pxamci_irq() be called here?) the
>> callback pxamci_dma_irq() is called.
> When DMA completes, there is a tiny window, before pxamci_dma_irq() is called,
> when pxamci_irq() can be called, yes. As soon as the spinlock is taken in
> pxamci_dma_irq() is taken, no more races.
> 

Does pxamci_dma_irq() depend on pxamci_irq() -> pxamci_data_done() NULLing host->data?

>> From my tests it seems at this point [2] the host->data is always NULL and rest
>> of the callback is never called. It is called once with a nonempty host->data
>> only just before the failure.
>>
>> During the testing I put udelay(100) at the start of pxamci_dma_irq() and fail
>> occurred after like 2 hours (when I for the first time tapped the touchscreen -
>> higher CPU usage and interrupts).
> Mmm I would need more data here.
> 
> The biggest help I could get would be the pxa dma traces here :
> echo -n 'file pxa_dma.c +p' > /sys/kernel/debug/dynamic_debug/control
> echo -n 'file virt-dma.c +p' > /sys/kernel/debug/dynamic_debug/control
> 
> And then capture the last traces and send them to me.

Last traces before the failure are in the attachment. It was copied (by a continual dmesg dump) from a ssh terminal over infraport (/var/log/messages gets corrupted after MMC DMA error).

> 
> Cheers.
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: dmesg_mmc.log
Type: text/x-log
Size: 28818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170310/9ee74ab3/attachment-0001.bin>
