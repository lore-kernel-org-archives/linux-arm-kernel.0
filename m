From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Mon, 5 May 2014 20:44:48 +0000
Subject: [PATCH] rtc: rtc-at91rm9200: fix lost ACKUPD interrupt
In-Reply-To: <1399321388-15148-1-git-send-email-boris.brezillon@free-electrons.com>
References: <55cab9fba2ea4eed8f73591b37cc874b@BLUPR05MB037.namprd05.prod.outlook.com>
 <1399321388-15148-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <ab4d2f575d33406f996a119e6c433a79@BLUPR05MB037.namprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boris,

> -----Original Message-----
> From: Boris BREZILLON [mailto:boris.brezillon at free-electrons.com]
> Sent: Monday, May 05, 2014 4:23 PM
> To: Bryan Evenson
> Cc: Andrew Victor; Nicolas Ferre; Jean-Christophe Plagniol-Villard; linux-arm-
> kernel at lists.infradead.org; Alessandro Zummo; rtc-
> linux at googlegroups.com; linux-kernel at vger.kernel.org; Boris BREZILLON
> Subject: [PATCH] rtc: rtc-at91rm9200: fix lost ACKUPD interrupt
> 
> If an alarm interrupt raises just after the CR register is written and before the
> ACKUPD is unmasked the ACKUPD bit might be cleaned up without waking
> up the waiting thread.
> 
> Unmask the ACKUPD interrupt before writing the CR register so that the
> ACKUPD cannot be lost.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Reported-by: Bryan Evenson <bevenson@melinkcorp.com>
> ---
> Hello Bryan,
> 
> Could you try to apply this patch and tell me if it fixes your bug ?
> 

I'll incorporate the patch and see what happens.  I'll be able to let you know the results tomorrow morning.

Regards,
Bryan

> Best Regards,
> 
> Boris
> 
>  drivers/rtc/rtc-at91rm9200.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c index
> 3281c90..c16c423 100644
> --- a/drivers/rtc/rtc-at91rm9200.c
> +++ b/drivers/rtc/rtc-at91rm9200.c
> @@ -163,9 +163,9 @@ static int at91_rtc_settime(struct device *dev, struct
> rtc_time *tm)
> 
>  	/* Stop Time/Calendar from counting */
>  	cr = at91_rtc_read(AT91_RTC_CR);
> +	at91_rtc_write_ier(AT91_RTC_ACKUPD);
>  	at91_rtc_write(AT91_RTC_CR, cr | AT91_RTC_UPDCAL |
> AT91_RTC_UPDTIM);
> 
> -	at91_rtc_write_ier(AT91_RTC_ACKUPD);
>  	wait_for_completion(&at91_rtc_updated);	/* wait for ACKUPD
> interrupt */
>  	at91_rtc_write_idr(AT91_RTC_ACKUPD);
> 
> --
> 1.8.3.2
