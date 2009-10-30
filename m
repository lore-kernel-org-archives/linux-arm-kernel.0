From: jiujin.hong@mid-fun.com (tommy)
Date: Fri, 30 Oct 2009 18:13:40 +0800
Subject: about s3c64xx-ac97 irq and mmc interrupt trigger
Message-ID: <1256897620.7327.2.camel@tommy-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,all!

Several days ago ,i have a post ,as following!

"HI,all!
I have met a big error in s3c6410 linux2.6.24.2 BSP ,the same as the
following

"
Kernel MMC/SD developers,


I've been encountering some problems when I abruptly remove SD card
during data transfer (song playback ... more so when the amount of
transfer is huge)
The kernel gets stuck in mmc_request function in the loops below
if (!mq) {
printk(KERN_ERR "MMC: killing requests for dead queue ");
while ((req = elv_next_request(q)) != NULL) {
do {
ret = end_that_request_chunk(req, 0,
req->current_nr_sectors << 9);
} while (ret);
}
return;
}
elv_next_requests returns the current request which is then ended with
end_that_request_chunk, however the request is never dequeued. As a
result, every
iteration of the while returns the same request and this "while"
becomes an infinite loop with the same req being returned each time

I added a call to blkdev_dequeue_request(req); after the do_while but
within the while and with this change the while loop always ends but I
observed that the kernel MMC stack sometimes(infrequent though) does
not respond to mmc_detect_change upon the next card insertion.

I'm running an ARM9 port of 2.6.24.7 kernel on a custom board with a
custom SD host controller and always use 4 bit transfer mode

Any help/info or similar experiences would be of real help.
"

Later i use __blk_end_request to replace end_that_request_chunk,can make
this issue better!
Now i reconsider this question,maybe a driver or hardware issue in BSP ?
Because i read  2.6.24.7-kernel pxa2xx-ac97.c code, i found the
following code :

static irqreturn_t pxa2xx_ac97_irq(int irq, void *dev_id)
{
	long status;

	status = GSR;
	if (status) {
		GSR = status;
		gsr_bits |= status;
		wake_up(&gsr_wq);

#ifdef CONFIG_PXA27x
		/* Although we don't use those we still need to clear them
		   since they tend to spuriously trigger when MMC is used
		   (hardware bug? go figure)... */
		MISR = MISR_EOC;
		PISR = PISR_EOC;
		MCSR = MCSR_EOC;
#endif

		return IRQ_HANDLED;
	}

	return IRQ_NONE;
}

does samsung-s3c64xx BSP kernel (just for 2.6.24.2) s3c64xx-ac97.c also
need similiar as 

#ifdef CONFIG_S3C64XX
		/* Although we don't use those we still need to clear them
		   since they tend to spuriously trigger when MMC is used
		   (hardware bug? go figure)... */
		MISR = MISR_EOC;/* DMA End-of-Chain (exclusive clear)=== Modem In
Status Register */
		PISR = PISR_EOC;/* DMA End-of-Chain (exclusive clear) === /* PCM In
Status Register */
*/
		MCSR = MCSR_EOC; /* DMA End-of-Chain (exclusive clear) ==Mic In Status
Register*/
#endif


to avoid mmc interrupt trigger ?


Tommy@China
