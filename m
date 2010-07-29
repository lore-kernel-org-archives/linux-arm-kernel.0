From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Jul 2010 10:55:25 +0900
Subject: [PATCH 3/3] rtc: rtc-s3c: Add BCD register initialization codes
In-Reply-To: <4C50744C.6010501@simtec.co.uk>
References: <1279702666-13021-1-git-send-email-kgene.kim@samsung.com>
	<1279702666-13021-4-git-send-email-kgene.kim@samsung.com>
	<4C50744C.6010501@simtec.co.uk>
Message-ID: <007701cb2ec1$1fe5a2a0$5fb0e7e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks wrote:
> 
> On 21/07/10 09:57, Kukjin Kim wrote:
> > From: Taekgyun Ko <taeggyun.ko@samsung.com>
> >
> > RTC needs to be initialized when BCD registers have invalid value.
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
> > +				writeb(0, s3c_rtc_base + i);
> 
> This is something we should probably do for all SoCs.

Yeah...ok...will move it.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
