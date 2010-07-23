From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 23 Jul 2010 16:34:43 +0900
Subject: [rtc-linux] [PATCH 3/3] rtc: rtc-s3c: Add BCD register
	initialization codes
In-Reply-To: <AANLkTinHlD1fC_Es6P7mcX4-_STNoYxV4wmsKe6KAw_N@mail.gmail.com>
References: <1279702666-13021-1-git-send-email-kgene.kim@samsung.com>
	<1279702666-13021-4-git-send-email-kgene.kim@samsung.com>
	<AANLkTinHlD1fC_Es6P7mcX4-_STNoYxV4wmsKe6KAw_N@mail.gmail.com>
Message-ID: <006501cb2a39$8b06eb20$a114c160$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wan ZongShun wrote:
> 
> 2010/7/21 Kukjin Kim <kgene.kim@samsung.com>:
> > From: Taekgyun Ko <taeggyun.ko@samsung.com>
> >
> > RTC needs to be initialized when BCD registers have invalid value.
> 
> Do you mean that the hardware register does not have default value?
> Any results if no initialized value here?
> 
Hi,

Yes..I mean that it has no default value.
As you know, it has to be keep the previous time value after reset..and the reset value is not defined.

So added check that functionality, because if it has no valid BCD value, RTC time does not move on.
Of course, if we set time at that time, RTC works well...I mean just need initialize that.

> >
> > Signed-off-by: Taekgyun Ko <taeggyun.ko@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> >  drivers/rtc/rtc-s3c.c |   14 ++++++++++++--
> >  1 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> > index 2040017..e96e109 100644
> > --- a/drivers/rtc/rtc-s3c.c
> > +++ b/drivers/rtc/rtc-s3c.c
> > @@ -536,10 +536,20 @@ static int __devinit s3c_rtc_probe(struct
> platform_device *pdev)
> >
> >        s3c_rtc_cpu_type = platform_get_device_id(pdev)->driver_data;
> >
> > -       if (s3c_rtc_cpu_type == TYPE_S3C64XX)
> > +       if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
> >                rtc->max_user_freq = 32768;
> > -       else
> > +
> > +               /* Check RTC Time */
> > +
> > +               for (i = S3C2410_RTCSEC; i <= S3C2410_RTCYEAR; i += 0x4) {
> > +                       tmp = readb(s3c_rtc_base + i);
> > +
> > +                       if (((tmp & 0xf) > 0x9) || (((tmp >> 4) & 0xf) > 0x9))
> > +                               writeb(0, s3c_rtc_base + i);
> > +               }
> > +       } else {
> >                rtc->max_user_freq = 128;
> > +       }
> >
> >        platform_set_drvdata(pdev, rtc);
> >
> > --
> > 1.6.2.5
> >


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
