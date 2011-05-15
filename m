From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 15 May 2011 17:14:16 +0400
Subject: [PATCH] pxa/hx4700: Fix basic suspend/resume
In-Reply-To: <319615.71439.qm@web29015.mail.ird.yahoo.com>
References: <20110514201824.GA16305@rainbow>
	<319615.71439.qm@web29015.mail.ird.yahoo.com>
Message-ID: <20110515131416.GA3954@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23:32 Sat 14 May     , Paul Parsons wrote:
> Today I found what causes the spurious interrupts. It's a race condition caused by the interrupt handler looping in a while loop.
> 
> At the end of a multiple read operation the handler clears the final RXRDY status bit in one iteration and then clears the DATAEND status bit in the next iteration. However the DATAEND interrupt is still queued in the system somewhere and can't be delivered until the handler has returned. So whether the handler detects spurious interrupts depends on how quickly the DATAEND follows the final RXRDY. Similarly for multiple writes.
> 
> Try this quick hack:
> 
> --- clean-2.6.39-rc7/drivers/mmc/host/tmio_mmc_pio.c	2011-05-11 00:54:17.651289833 +0100
> +++ linux-2.6.39-rc7/drivers/mmc/host/tmio_mmc_pio.c	2011-05-14 22:51:30.661074153 +0100
> @@ -603,7 +603,7 @@ static irqreturn_t tmio_mmc_irq(int irq,
>  		goto out;
>  	}
>  
> -	while (ireg) {
> +	if (ireg) {
>  		/* Card insert / remove attempts */
>  		if (ireg & (TMIO_STAT_CARD_INSERT | TMIO_STAT_CARD_REMOVE)) {
>  			tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_CARD_INSERT |
> 

Well, it really seems to make all those "Spurious IRQ" messages disappear.
(and btw, MMC magically started to work for me in -rc7. Probably that were
some earlier -rc's that didn't work and issue was fixed in -rc7. Or maybe
I'm just lucky today)

I think it's worth to submit it to tmio_mmc maintainers along with the
description of this situation on ASIC3. Even if it won't be accepted,
it'll make them aware of the problem and maybe some clean solution could
be worked out then.

-- 
Best regards,
Dmitry "MAD" Artamonow
