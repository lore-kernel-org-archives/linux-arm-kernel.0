From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 23 Jul 2010 16:04:49 +0900
Subject: [PATCH 3/3] rtc: rtc-s3c: Add BCD register initialization codes
In-Reply-To: <4C47074C.703@ru.mvista.com>
References: <1279702666-13021-1-git-send-email-kgene.kim@samsung.com>
	<1279702666-13021-4-git-send-email-kgene.kim@samsung.com>
	<4C47074C.703@ru.mvista.com>
Message-ID: <004301cb2a35$6d3b30a0$47b191e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov wrote:
> 
> Hello.
> 
Hi :-)

> Kukjin Kim wrote:
> 
> > From: Taekgyun Ko <taeggyun.ko@samsung.com>
> 
> > RTC needs to be initialized when BCD registers have invalid value.
> 
> > Signed-off-by: Taekgyun Ko <taeggyun.ko@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> [...]
> > diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> > index 2040017..e96e109 100644
> > --- a/drivers/rtc/rtc-s3c.c
> > +++ b/drivers/rtc/rtc-s3c.c
> > @@ -536,10 +536,20 @@ static int __devinit s3c_rtc_probe(struct
> platform_device *pdev)
> >
> >  	s3c_rtc_cpu_type = platform_get_device_id(pdev)->driver_data;
> >
> > -	if (s3c_rtc_cpu_type == TYPE_S3C64XX)
> > +	if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
> >  		rtc->max_user_freq = 32768;
> > -	else
> > +
> > +		/* Check RTC Time */
> > +
> > +		for (i = S3C2410_RTCSEC; i <= S3C2410_RTCYEAR; i += 0x4) {
> > +			tmp = readb(s3c_rtc_base + i);
> > +
> > +			if (((tmp & 0xf) > 0x9) || (((tmp >> 4) & 0xf) >
0x9))
> 
>    There is no need to have parens around > operations.
> 
Ok...you're right. will fix it.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
