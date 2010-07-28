From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 28 Jul 2010 13:49:53 +0900
Subject: [rtc-linux] [PATCH 2/2] rtc: rtc-s3c: Updates RTC driver for	clock
	enabling support
In-Reply-To: <AANLkTimCd-4mqW6vt1f+xVVzMdzOqD0RwzLu3-Ue41gs@mail.gmail.com>
References: <1279702501-6803-1-git-send-email-kgene.kim@samsung.com>
	<1279702501-6803-3-git-send-email-kgene.kim@samsung.com>
	<AANLkTikGjzmHxCX6_s5Z-ZXkoyPbtF28uCyE1VqdGPvb@mail.gmail.com>
	<AANLkTikEanSQBeFoqpMxR3tWxWTci_ytNsEhe9VS9ygg@mail.gmail.com>
	<AANLkTin=bqMRLYgAd4NvVnKZi1PWAGPqQSsZDPxvitfh@mail.gmail.com>
	<007a01cb2e0e$6760ad40$362207c0$%kim@samsung.com>
	<AANLkTimCd-4mqW6vt1f+xVVzMdzOqD0RwzLu3-Ue41gs@mail.gmail.com>
Message-ID: <009601cb2e10$5420c7e0$fc6257a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Wan ZongShun
> Sent: Wednesday, July 28, 2010 1:42 PM
> To: rtc-linux at googlegroups.com
> Cc: a.zummo at towertech.it; linux-samsung-soc at vger.kernel.org; Atul Dahiya;
> p_gortmaker at yahoo.com; Atul Dahiya; ben-linux at fluff.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [rtc-linux] [PATCH 2/2] rtc: rtc-s3c: Updates RTC driver for clock
> enabling support
> 
> 2010/7/28 Kukjin Kim <kgene.kim@samsung.com>:
> > Wan ZongShun wrote:
> >>
> >> 2010/7/22 Atul Dahiya <atuldahiya84@gmail.com>:
> >> > On Thu, Jul 22, 2010 at 11:39 AM, Wan ZongShun <mcuos.com@gmail.com>
> >> wrote:
> >> >>
> >> >> 2010/7/21 Kukjin Kim <kgene.kim@samsung.com>:
> >> >> > From: Atul Dahiya <atul.dahiya@samsung.com>
> >> >> >
> >> >> > This Patch updates existing Samsung RTC driver for clock enabling
> support.
> >> >> >
> >> >> > Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
> >> >> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> >> >> > ---
> >> >> >  drivers/rtc/rtc-s3c.c |   22 ++++++++++++++++++++++
> >> >> >  1 files changed, 22 insertions(+), 0 deletions(-)
> >> >> >
> >> >> > diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> >> >> > index 70b68d3..c032a15 100644
> >> >> > --- a/drivers/rtc/rtc-s3c.c
> >> >> > +++ b/drivers/rtc/rtc-s3c.c
> >> >> > @@ -1,5 +1,8 @@
> >> >> >  /* drivers/rtc/rtc-s3c.c
> >> >> >  *
> >> >> > + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> >> >> > + *             http://www.samsung.com/
> >> >> > + *
> >> >> >  * Copyright (c) 2004,2006 Simtec Electronics
> >> >> >  *     Ben Dooks, <ben@simtec.co.uk>
> >> >> >  *     http://armlinux.simtec.co.uk/
> >> >> > @@ -39,6 +42,7 @@ enum s3c_cpu_type {
> >> >> >
> >> >> >  static struct resource *s3c_rtc_mem;
> >> >> >
> >> >> > +static struct clk *rtc_clk;
> >> >> >  static void __iomem *s3c_rtc_base;
> >> >> >  static int s3c_rtc_alarmno = NO_IRQ;
> >> >> >  static int s3c_rtc_tickno  = NO_IRQ;
> >> >> > @@ -431,6 +435,10 @@ static int __devexit s3c_rtc_remove(struct
> >> platform_device *dev)
> >> >> >        s3c_rtc_setpie(&dev->dev, 0);
> >> >> >        s3c_rtc_setaie(0);
> >> >> >
> >> >> > +       clk_disable(rtc_clk);
> >> >> > +       clk_put(rtc_clk);
> >> >> > +       rtc_clk = NULL;
> >> >> > +
> >> >> >        iounmap(s3c_rtc_base);
> >> >> >        release_resource(s3c_rtc_mem);
> >> >> >        kfree(s3c_rtc_mem);
> >> >> > @@ -488,6 +496,16 @@ static int __devinit s3c_rtc_probe(struct
> >> platform_device *pdev)
> >> >> >                goto err_nomap;
> >> >> >        }
> >> >> >
> >> >> > +       rtc_clk = clk_get(&pdev->dev, "rtc");
> >> >>
> >> >> Do you really need the second argument? I think the bus clock for
> >> >> a device should be findable with NULL for s3c platform..
> >> >
> >> > No, actually  clk_get() function for s3c platform searches on the
> >> > basis of second parameter passed
> >> > so need to pass the second argument here.
> >>
> >> Okay, good patch!
> >>
> >> Acked-by: Wan ZongShun <mcuos.com@gmail.com>
> >>
> > Thanks for your review and ack.
> >
> > As I asked to Alessandro, does this goes through what subsystem go to
> upstream?
> >
> After you get ack, Samsung git tree or Andrew's mm git tree can do it.
> Thanks!
> 
Ok...will apply this for next merge window with your ack.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
