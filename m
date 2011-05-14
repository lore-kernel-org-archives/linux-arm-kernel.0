From: lost.distance@yahoo.com (Paul Parsons)
Date: Sat, 14 May 2011 23:32:10 +0100 (BST)
Subject: [PATCH] pxa/hx4700: Fix basic suspend/resume
In-Reply-To: <20110514201824.GA16305@rainbow>
Message-ID: <319615.71439.qm@web29015.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

> Erm, do you have some special 2.6.39-rc7? :) I can't see in
> mine
> any .suspend/.resume callbacks defined in asic3.c for
> tmio_mmc cell.

Now neither can I. Strange. Maybe I noticed that the functions asic3_mmc_enable and asic3_mmc_disable were already in the table and looked no further. Or maybe I applied the patch and forgot, or thought it had failed. Whatever the reason, I just applied it for real and it works; mmc now behaves itself after suspend/resume. Someone needs to submit that patch.

> Ah, so mmc works for you in 2.6.39-rc7?? Nice to hear!
> Wonder why it
> doesn't work for me. I suspect this may be connected to the
> fact that
> I boot from WinCE using HaRET - probably Windows leaves
> controller in
> some inconsistent state and driver doesn't reset hardware
> properly.

Maybe. I'm using the SDG bootloader v1.2.5 and have long since dumped WinCE. In fact I patched the bootloader to change the flash partitions and free up the 0.5Mb of flash (between 0.5Mb and 1.0Mb) used for the WinCE registry or something. Thus I can no longer use WinCE even if I wanted to.

> As for "Spurious irq, disabling!" messages, I'm seeing them
> for a long
> time - since pr_debug was turned into pr_warning in commit
> 311f3ac768
> ("mmc: add DMA support to tmio_mmc driver, when used on
> SuperH")
> So I suspect this issue (if it's issue at all) has always
> been there, just
> unseen before that commit. Not sure what causes those
> spurious interrupts -
> maybe it's some specific of TMIO hardware in ASIC3?

Today I found what causes the spurious interrupts. It's a race condition caused by the interrupt handler looping in a while loop.

At the end of a multiple read operation the handler clears the final RXRDY status bit in one iteration and then clears the DATAEND status bit in the next iteration. However the DATAEND interrupt is still queued in the system somewhere and can't be delivered until the handler has returned. So whether the handler detects spurious interrupts depends on how quickly the DATAEND follows the final RXRDY. Similarly for multiple writes.

Try this quick hack:

--- clean-2.6.39-rc7/drivers/mmc/host/tmio_mmc_pio.c	2011-05-11 00:54:17.651289833 +0100
+++ linux-2.6.39-rc7/drivers/mmc/host/tmio_mmc_pio.c	2011-05-14 22:51:30.661074153 +0100
@@ -603,7 +603,7 @@ static irqreturn_t tmio_mmc_irq(int irq,
 		goto out;
 	}
 
-	while (ireg) {
+	if (ireg) {
 		/* Card insert / remove attempts */
 		if (ireg & (TMIO_STAT_CARD_INSERT | TMIO_STAT_CARD_REMOVE)) {
 			tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_CARD_INSERT |

Regards,
Paul
