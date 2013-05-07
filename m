From: holt@sgi.com (Robin Holt)
Date: Tue, 7 May 2013 04:51:45 -0500
Subject: How does commit 47ec340c not introduce a bug?
In-Reply-To: <CAN1soZyHx1XZzukunbKsj+v4h93MRQKjPPjJ3+i3u8BeBbhCGw@mail.gmail.com>
References: <20130507091734.GM3658@sgi.com>
 <20130507092428.GK23285@pengutronix.de>
 <CAN1soZyHx1XZzukunbKsj+v4h93MRQKjPPjJ3+i3u8BeBbhCGw@mail.gmail.com>
Message-ID: <20130507095145.GN3658@sgi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 07, 2013 at 05:35:28PM +0800, Haojian Zhuang wrote:
> On Tue, May 7, 2013 at 5:24 PM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > Hello,
> >
> > On Tue, May 07, 2013 at 04:17:34AM -0500, Robin Holt wrote:
> >> I noticed a warning while cross-compiling all arm defconfigs.
> >>
> >> The mmp2_defconfig gave this warning:
> >>
> >> drivers/video/backlight/max8925_bl.c: In function 'max8925_backlight_probe':
> >> drivers/video/backlight/max8925_bl.c:177:3: warning: statement with no effect [-Wunused-value]
> >>
> >> This appears to have been introduced by the above commit when !CONFIG_OF
> >>
> >> Looking at this more closely, I am not sure how this was ever intended
> >> to be handled or how the errors returned in the CONFIG_OF case were
> >> intended to be handled as the return from max8925_backlight_dt_init is
> >> always ignored.
> >>
> >> I think this needs some more attention, but do not feel like I know
> >> enough about it or have any means to test it to weigh in.
> >>
> >> Thanks,
> >> Robin
> >>
> >>
> >> commit 47ec340cb8e232671e7c4a4689ff32c3bdf329da
> >> Author: Qing Xu <qingx@marvell.com>
> >> Date:   Mon Feb 4 23:40:45 2013 +0800
> >>
> >>     mfd: max8925: Support dt for backlight
> >>
> >>     Add device tree support in max8925 backlight.
> >>
> >>     Signed-off-by: Qing Xu <qingx@marvell.com>
> >>     Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> >>     Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> >>
> >> diff --git a/drivers/video/backlight/max8925_bl.c b/drivers/video/backlight/max8925_bl.c
> >> index 2c9bce0..5ca11b0 100644
> >> --- a/drivers/video/backlight/max8925_bl.c
> >> +++ b/drivers/video/backlight/max8925_bl.c
> >> @@ -101,6 +101,29 @@ static const struct backlight_ops max8925_backlight_ops = {
> >>       .get_brightness = max8925_backlight_get_brightness,
> >>  };
> >>
> >> +#ifdef CONFIG_OF
> >> +static int max8925_backlight_dt_init(struct platform_device *pdev,
> >> +                           struct max8925_backlight_pdata *pdata)
> >> +{
> >> +     struct device_node *nproot = pdev->dev.parent->of_node, *np;
> >> +     int dual_string;
> >> +
> >> +     if (!nproot)
> >> +             return -ENODEV;
> >> +     np = of_find_node_by_name(nproot, "backlight");
> >> +     if (!np) {
> >> +             dev_err(&pdev->dev, "failed to find backlight node\n");
> >> +             return -ENODEV;
> >> +     }
> >> +
> >> +     of_property_read_u32(np, "maxim,max8925-dual-string", &dual_string);
> >> +     pdata->dual_string = dual_string;
> >> +     return 0;
> >> +}
> >> +#else
> >> +#define max8925_backlight_dt_init(x, y)      (-1)
> > It's probably best to make this:
> >
> > static inline max8925_backlight_dt_init(struct platform_device *pdev,
> >                                 struct max8925_backlight_pdata *pdata)
> > {
> >         return -ENODEV;
> > }
> >
> 
> I've submitted this patch to fix this issue for a long time.
> 
> Samuel,
> 
> Should I send it again?

It fixes nothing.  The return value is not used.  There is more to this
bug report than the -1.  You need to handle that error case.  Otherwise,
you could just change it into a void return.

Robin
