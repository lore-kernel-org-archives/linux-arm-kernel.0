From: petr.cvek@tul.cz (Petr Cvek)
Date: Sun, 26 Mar 2017 04:43:18 +0200
Subject: [BUG] dmaengine: pxa_dma: + mmc: pxamci: race condition with DMA
 error on tx channel
In-Reply-To: <871stzh8bx.fsf@belgarion.home>
References: <e749aff1-0ffc-c9ed-42b2-82397b4e8ba2@tul.cz>
 <877f3zwwgo.fsf@belgarion.home> <feb39d00-d40d-f935-751c-8119f40b4df4@tul.cz>
 <871stzh8bx.fsf@belgarion.home>
Message-ID: <ab2c9dcb-1718-46da-2f31-1f4721719b01@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 14.3.2017 v 22:11 Robert Jarzmik napsal(a):
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
> Ok Petr, I've been trying for days to reproduce without any luck.

Hi,

I think I was able to finally find the problem with the PXA MCI and DMA. It seems to be a problem with a race condition with vchan_complete() tasklet.

The pxa_dma driver handles IRQ with pxad_chan_handler(), which calls vchan_cookie_complete(), which schedules the vchan_complete() tasklet. 

Starting the tasklet may take a long time. The race condition appeared during the heavy IRQ load. During that time, the pxamci driver can start another data write transmit. This another transmit with again schedule the tasklet. But as tasklet schedules are not cumulative, it will (probably) add item to a list. 

After some time the tasklet is finally scheduled and for every item in the list the callback pxamci_dma_irq() is called. And there is the main problem, the pxamci_dma_irq() is using __actual__ transmit variables (e.g. host->data). My debug printk shows the code tests a cookie of the actual transmit, which may be in a DMA_IN_PROGRESS state (every failure is during this state).

Solution:

I commented the error handling parts of the callback function and the driver works, but it is only for the testing purposes, there can be a partially filled FIFO (BUF_PART_FULL) which will not be handled. Problem is the driver won't wait on the completion before starting a new transmission. But this waiting on completion will probably slow down the MMC communication :-/.

The best thing would be to handle the partial buffer somewhere else and get rid of the callback completely. If it is possible, probably not as I assume the partially filled buffer will not create pxamci interrupt? In the other case then maybe in pxamci_data_done()?

Log:

	[ 2669.917946] dma dma0chan1: pxad_chan_handler(): checking txd c18c2f20[135f]: completed=1 dcsr=0x2000000c
		^^^ schedules the tasklet
	[ 2669.924255] dma dma0chan1: pxad_chan_handler(): checking txd c1a6b740[1360]: completed=1 dcsr=0x2000000c
		^^^ reschedule the tasklet
	[ 2669.934441] dma dma0chan1: pxad_chan_handler(): checking txd c1a6b880[1361]: completed=1 dcsr=0x2000000c
		^^^ reschedule the tasklet
	[ 2669.944893] dma dma0chan1: pxad_chan_handler(): checking txd c1a78ba0[1362]: completed=1 dcsr=0x2000000c
		^^^ reschedule the tasklet
	[ 2670.081114] ###pre
		^^^ tasklet has finally started
	[ 2670.081187] ###post
		^^^ first item of the list, callback
	[ 2670.081369] !!!cookie=1364 complete=1363 used=1364 ... status=1
		^^^ There it would fail with "DMA error on tx channel"
	[ 2670.081608] ###post
		^^^ The second item of the list
	[ 2670.081678] !!!cookie=1364 complete=1363 used=1364 ... status=1
		^^^ Again called with the same host->data, notice same cookie, status=1 == DMA_IN_PROGRESS (always)

The full log and used debug patch are attached. The machine is PXA272 @ 416MHz, during logging (over irda or usb ssh console) I created multiple interrupt sources by touching a touchscreen and pressing GPIO buttons. A higher bug occurrence was observed with sync-written files of unusual lengths:

	while : ; do
	dd if=/dev/urandom bs=7777 count=11 of=/tmp/file conv=fsync
	done

> 
> I had a look at your traces, and I'd like something else when it happens :
>  1) The patch I provided earlier applied

Yeah it is DMA_IN_PROGRESS in the "bug" case and a few DMA_COMPLETE in the "normal" case, but I don't know if it is a valid value due to the race condition "aliasing". Anyway the status value is written in the "!!!cookie=" printk.

>  2) This done (the 'cat' after the bug) :
> 	mount -t debugfs none /sys/kernel/debug/
> 	cat /sys/kernel/debug/pxa-dma.0/channels/4/[sd]*
> 

This wasn't possible as everything freezes on the vanilla kernel and with my debug patch the DMA transactions just continue.

Cheers,
Petr

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-DMA-MMC-debugs.patch
Type: text/x-patch
Size: 3144 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170326/e1a9b1c9/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: dmesg_mmc4_final.log
Type: text/x-log
Size: 25014 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170326/e1a9b1c9/attachment-0003.bin>
