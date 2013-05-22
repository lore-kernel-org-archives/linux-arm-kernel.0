From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 May 2013 16:08:10 +0200
Subject: [PATCH] regulator: ab8500-ext: Don't register without
 initialisation data
In-Reply-To: <CACRpkdYHiwbGonH80aJfHxP6F+hLb+_KdCr_g5ae1Yr-v=WcxA@mail.gmail.com>
References: <1369226853-16978-1-git-send-email-lee.jones@linaro.org>
 <1369226853-16978-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdYHiwbGonH80aJfHxP6F+hLb+_KdCr_g5ae1Yr-v=WcxA@mail.gmail.com>
Message-ID: <201305221608.10759.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 May 2013, Linus Walleij wrote:
> > diff --git a/drivers/regulator/ab8500-ext.c b/drivers/regulator/ab8500-ext.c
> > index b4d4547..8421537 100644
> > --- a/drivers/regulator/ab8500-ext.c
> > +++ b/drivers/regulator/ab8500-ext.c
> > @@ -334,6 +334,12 @@ int ab8500_ext_regulator_init(struct platform_device *pdev)
> >                 return -EINVAL;
> >         }
> >
> > +       /* have any external regulators been specified? */
> > +       if (pdata->num_ext_regulator == 0) {
> > +               dev_warn(&pdev->dev, "Not using external regulators\n");
> > +               return 0;
> > +       }
> 
> dev_warn() is really when we warn about something really nasty, worse
> than dev_err(). It seems dev_info() is more apropriate.

Are you confusing it with dev_crit()?

This is how the levels are defined, and "warning" is less urgent than "error":

#define KERN_EMERG      KERN_SOH "0"    /* system is unusable */
#define KERN_ALERT      KERN_SOH "1"    /* action must be taken immediately */
#define KERN_CRIT       KERN_SOH "2"    /* critical conditions */
#define KERN_ERR        KERN_SOH "3"    /* error conditions */
#define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
#define KERN_NOTICE     KERN_SOH "5"    /* normal but significant condition */
#define KERN_INFO       KERN_SOH "6"    /* informational */
#define KERN_DEBUG      KERN_SOH "7"    /* debug-level messages */

	Arnd
