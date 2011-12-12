From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 12 Dec 2011 13:51:13 +0100
Subject: [PATCH 2/4] rtc-s3c: make room for more variants in devicetree
 block
In-Reply-To: <CAJuYYwSvk1_tvNvukn-BQ4Z3JEeD15djs9xP_=jWz4vG-xs_nw@mail.gmail.com>
References: <201112091046.26563.heiko@sntech.de>
 <201112091050.11095.heiko@sntech.de>
 <CAJuYYwSvk1_tvNvukn-BQ4Z3JEeD15djs9xP_=jWz4vG-xs_nw@mail.gmail.com>
Message-ID: <201112121351.14362.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

thanks for your review and you are of course right with both your suggestions. 
I will submit a v2 series shortly, implementing these suggestions.

Heiko

Am Sonntag, 11. Dezember 2011, 06:47:43 schrieb Thomas Abraham:
> Hi Heiko,
> 
> On 9 December 2011 15:20, Heiko St?bner <heiko@sntech.de> wrote:
> > Use the data field of of_device_id to hold the type for
> > s3c_cpu_type.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  drivers/rtc/rtc-s3c.c |   27 +++++++++++++++++++++------
> >  1 files changed, 21 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> > index 175067a..71807a6 100644
> > --- a/drivers/rtc/rtc-s3c.c
> > +++ b/drivers/rtc/rtc-s3c.c
> > @@ -428,11 +428,18 @@ static int __devexit s3c_rtc_remove(struct
> > platform_device *dev) return 0;
> >  }
> 
> This patch looks fine but the number of #ifdef's can be reduced in
> this patch as below.
> 
> static const struct of_device_id s3c_rtc_dt_match[];
> 
> static inline int s3c_rtc_get_driver_data(struct platfrom_device *pdev)
> {
> #ifdef CONFIG_OF
>          if (pdev->dev.of_node) {
>                  const struct of_device_id *match;
>                  match = of_match_node(s3c_rtc_dt_match,
> pdev->dev.of_node); return match->data;
>          }
> #endif
>          return platform_get_device_id(pdev)->driver_data;
> }
> 
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id s3c_rtc_dt_match[];
> > +#endif
> > +
> >  static int __devinit s3c_rtc_probe(struct platform_device *pdev)
> >  {
> >        struct rtc_device *rtc;
> >        struct rtc_time rtc_tm;
> >        struct resource *res;
> > +#ifdef CONFIG_OF
> > +       const struct of_device_id *match;
> > +#endif
> 
> *match not required here.
> 
> >        int ret;
> > 
> >        pr_debug("%s: probe=%p\n", __func__, pdev);
> > @@ -509,12 +516,15 @@ static int __devinit s3c_rtc_probe(struct
> > platform_device *pdev) }
> > 
> >  #ifdef CONFIG_OF
> > -       if (pdev->dev.of_node)
> > -               s3c_rtc_cpu_type =
> > of_device_is_compatible(pdev->dev.of_node, -                      
> > "samsung,s3c6410-rtc") ? TYPE_S3C64XX : TYPE_S3C2410; -       else
> > +       if (pdev->dev.of_node) {
> > +               match = of_match_node(s3c_rtc_dt_match,
> > pdev->dev.of_node); +               s3c_rtc_cpu_type = match->data;
> > +       } else {
> >  #endif
> >                s3c_rtc_cpu_type =
> > platform_get_device_id(pdev)->driver_data; +#ifdef CONFIG_OF
> > +       }
> > +#endif
> 
> This gets replaced with
> 
>         s3c_rtc_cpu_type = s3c_rtc_get_driver_data(pdev);
> 
> >        /* Check RTC Time */
> > 
> > @@ -638,8 +648,13 @@ static int s3c_rtc_resume(struct platform_device
> > *pdev)
> > 
> >  #ifdef CONFIG_OF
> >  static const struct of_device_id s3c_rtc_dt_match[] = {
> > -       { .compatible = "samsung,s3c2410-rtc" },
> > -       { .compatible = "samsung,s3c6410-rtc" },
> > +       {
> > +               .compatible = "samsung,s3c2410-rtc"
> > +               .data = TYPE_S3C2410,
> > +       }, {
> > +               .compatible = "samsung,s3c6410-rtc"
> > +               .data = TYPE_S3C64XX,
> > +       },
> >        {},
> >  };
> >  MODULE_DEVICE_TABLE(of, s3c_rtc_dt_match);
> > --
> > 1.7.5.4
> 
> Patch looks fine except the #ifdef's which can be reduced.
> Reviewed-by: Thomas Abraham <thomas.abraham@linaro.org>
> 
> Regards,
> Thomas.
