From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 14 May 2015 20:35:35 +0200
Subject: [PATCH 1/2] rtc: add rtc-lpc24xx driver
In-Reply-To: <20150514181953.GC23600@jcartwri.amer.corp.natinst.com>
References: <1431624875-20990-1-git-send-email-manabian@gmail.com>
 <1431624875-20990-2-git-send-email-manabian@gmail.com>
 <20150514181953.GC23600@jcartwri.amer.corp.natinst.com>
Message-ID: <CAGhQ9Vxsgka_qWCN053JoT_PrbSrjsMzE7X0enTxJdmRvaJg=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 May 2015 at 20:19, Josh Cartwright <joshc@ni.com> wrote:
> Hello Joachim,
>
> Just a quick comment/question below.
>
> On Thu, May 14, 2015 at 07:34:34PM +0200, Joachim Eastwood wrote:
>> Add driver for the RTC found on NXP LPC24xx/178x/18xx/43xx devices.
>> The RTC provides calendar and clock functionality together with
>> periodic tick and alarm interrupt support.
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> ---
> [..]
>> +
>> +static const struct of_device_id lpc24xx_rtc_match[] = {
>> +     { .compatible = "nxp,lpc1788-rtc", .data = (void *)HAVE_CALIBRATION},
>> +     { }
>> +};
>> +MODULE_DEVICE_TABLE(of, lpc24xx_rtc_match);
>> +
>> +static int lpc24xx_rtc_probe(struct platform_device *pdev)
>> +{
>> +     const struct of_device_id *match;
>> +     struct lpc24xx_rtc *rtc;
>> +     struct resource *res;
>> +     u32 rtc_ccr = 0;
>> +     int irq, ret;
>> +
> [..]
>> +
>> +     /* Clear the counter increment state */
>> +     rtc_writel(rtc, LPC24XX_ILR, LPC24XX_RTCCIF);
>> +
>> +     if (rtc->features & HAVE_PRESCALER) {
>> +             /* Clock source is 32k oscillator */
>> +             rtc_ccr = LPC24XX_CLKSRC;
>> +             rtc_writel(rtc, LPC24XX_CCR, rtc_ccr);
>> +
>> +             /* Set prescaler to divide by 1 */
>> +             rtc_writel(rtc, LPC24XX_PREINT, 0);
>> +             rtc_writel(rtc, LPC24XX_PREFRAC, 0);
>> +     }
>> +
>> +     if (rtc->features & HAVE_SUBSECOND) {
>> +             /* Disable sub-second interrupt */
>> +             rtc_writel(rtc, LPC24XX_CISS, 0);
>> +     }
>
> Neither HAVE_PRESCALER, nor HAVE_SUBSECOND are used for the claimed
> supported RTC, so this is effectively dead code.  Was this something you
> intended to add later?  Some remnant of the rework?

The features are only available on the old LPC24xx-series which isn't
in mainline so, yeah, this can be removed. I'll send out a new version
in a couple of days removing all of the LPC24xx support.

Thanks for looking.

regards,
Joachim Eastwood
