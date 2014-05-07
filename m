From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Wed, 7 May 2014 14:51:39 +0000
Subject: [PATCH v2] rtc: rtc-at91rm9200: fix uninterruptible wait for
 ACKUPD
In-Reply-To: <1399458490-11870-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1399458490-11870-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <957b209589094df48ddedbc57c6ccdfd@BLUPR05MB037.namprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boris,

> -----Original Message-----
> From: Boris BREZILLON [mailto:boris.brezillon at free-electrons.com]
> Sent: Wednesday, May 07, 2014 6:28 AM
> To: Bryan Evenson
> Cc: Andrew Victor; Nicolas Ferre; Jean-Christophe Plagniol-Villard; linux-arm-
> kernel at lists.infradead.org; Alessandro Zummo; rtc-
> linux at googlegroups.com; linux-kernel at vger.kernel.org; Boris BREZILLON;
> stable at vger.kernel.org
> Subject: [PATCH v2] rtc: rtc-at91rm9200: fix uninterruptible wait for ACKUPD
> 
> The rtc user must wait at least 1 sec between each time/calandar update
> (see atmel's datasheet chapter "Updating Time/Calendar").
> 
> Use the SECEV interrupt (as suggested by the datasheet) to wait for the RTC
> to be ready for new updates.
> 
> Cc: <stable@vger.kernel.org> # v3.10+
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Reported-by: Bryan Evenson <bevenson@melinkcorp.com>
> ---
> Hello,
> 
> This patch fixes a deadlock in an uninterruptible wait when the RTC is
> updated more than once every second.
> AFAICT the bug is here from the beginning, but I think we should at least
> backport this fix to 3.10 and the following longterm and stable releases.
> 
> Best Regards,
> 
> Boris

Hang on, I found a problem.  My system works fine on a soft reboot, but during a power cycle my system hangs.  Last thing I see to print is "Uncompressing Linux... done, booting the kernel."  If I removde the backup battery for the RTC my system boots just fine.  Luckily this is very repeatable on my system.  This looks similar to the early rtt-interrupt bug which was fixed about 7 months ago (linux-stable commits 6ce3ee9af1ad697c71766067ffa1a35352dfdcfd and 54f830b7337ed016b6708cf5a2ac297d4cee227d).  I confirmed that the kernel I'm using has the relevant fix applied from 7 months ago.  Did this fix reintroduce the early rtt-interrupt bug?

Let me know if you would like me to test anything or more information.

Regards,
Bryan

> 
> Changes since v1:
> - disable SECEV interrupt when the RTC is ready to accept new time updates
> 
>  drivers/rtc/rtc-at91rm9200.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c index
> 3281c90..44fe83e 100644
> --- a/drivers/rtc/rtc-at91rm9200.c
> +++ b/drivers/rtc/rtc-at91rm9200.c
> @@ -48,6 +48,7 @@ struct at91_rtc_config {
> 
>  static const struct at91_rtc_config *at91_rtc_config;  static
> DECLARE_COMPLETION(at91_rtc_updated);
> +static DECLARE_COMPLETION(at91_rtc_upd_rdy);
>  static unsigned int at91_alarm_year = AT91_RTC_EPOCH;  static void
> __iomem *at91_rtc_regs;  static int irq; @@ -161,6 +162,8 @@ static int
> at91_rtc_settime(struct device *dev, struct rtc_time *tm)
>  		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
>  		tm->tm_hour, tm->tm_min, tm->tm_sec);
> 
> +	wait_for_completion(&at91_rtc_upd_rdy);
> +
>  	/* Stop Time/Calendar from counting */
>  	cr = at91_rtc_read(AT91_RTC_CR);
>  	at91_rtc_write(AT91_RTC_CR, cr | AT91_RTC_UPDCAL |
> AT91_RTC_UPDTIM); @@ -183,7 +186,9 @@ static int
> at91_rtc_settime(struct device *dev, struct rtc_time *tm)
> 
>  	/* Restart Time/Calendar */
>  	cr = at91_rtc_read(AT91_RTC_CR);
> +	at91_rtc_write(AT91_RTC_SCCR, AT91_RTC_SECEV);
>  	at91_rtc_write(AT91_RTC_CR, cr & ~(AT91_RTC_UPDCAL |
> AT91_RTC_UPDTIM));
> +	at91_rtc_write_ier(AT91_RTC_SECEV);
> 
>  	return 0;
>  }
> @@ -290,8 +295,10 @@ static irqreturn_t at91_rtc_interrupt(int irq, void
> *dev_id)
>  	if (rtsr) {		/* this interrupt is shared!  Is it ours? */
>  		if (rtsr & AT91_RTC_ALARM)
>  			events |= (RTC_AF | RTC_IRQF);
> -		if (rtsr & AT91_RTC_SECEV)
> -			events |= (RTC_UF | RTC_IRQF);
> +		if (rtsr & AT91_RTC_SECEV) {
> +			complete(&at91_rtc_upd_rdy);
> +			at91_rtc_write_idr(AT91_RTC_SECEV);
> +		}
>  		if (rtsr & AT91_RTC_ACKUPD)
>  			complete(&at91_rtc_updated);
> 
> @@ -413,6 +420,11 @@ static int __init at91_rtc_probe(struct
> platform_device *pdev)
>  		return PTR_ERR(rtc);
>  	platform_set_drvdata(pdev, rtc);
> 
> +	/* enable SECEV interrupt in order to initialize at91_rtc_upd_rdy
> +	 * completion.
> +	 */
> +	at91_rtc_write_ier(AT91_RTC_SECEV);
> +
>  	dev_info(&pdev->dev, "AT91 Real Time Clock driver.\n");
>  	return 0;
>  }
> --
> 1.8.3.2
