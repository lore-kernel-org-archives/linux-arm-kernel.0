From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 22 Oct 2010 14:22:13 +0900
Subject: [PATCH] ARM: SAMSUNG: Add the missed s3c_gpio_getpull() API
In-Reply-To: <4CC0BC09.5090803@fluff.org>
References: <1287648286-7202-1-git-send-email-kgene.kim@samsung.com>
	<4CC0BC09.5090803@fluff.org>
Message-ID: <002c01cb71a9$1789a720$469cf560$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks wrote:
> 
> On 21/10/10 09:04, Kukjin Kim wrote:
> > From: Daein Moon <moon9124@samsung.com>
> >
> > This patch adds the s3c_gpio_getpull() API that has been missed in the
> > plat-samsung/gpio-config.c and actullay there is its extern declaration
> > in plat/gpio-cfg.h.
> >
> > Signed-off-by: Daein Moon <moon9124@samsung.com>
> > Cc: Ben Dooks <ben-linux@fluff.org>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> > NOTE:
> > - already issued about this
> >
> >  arch/arm/plat-samsung/gpio-config.c                |   19
> +++++++++++++++++++
> >  .../plat-samsung/include/plat/gpio-cfg-helpers.h   |    6 ++++++
> >  2 files changed, 25 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/plat-samsung/gpio-config.c b/arch/arm/plat-
> samsung/gpio-config.c
> > index 8a37211..b732b77 100644
> > --- a/arch/arm/plat-samsung/gpio-config.c
> > +++ b/arch/arm/plat-samsung/gpio-config.c
> > @@ -111,6 +111,25 @@ int s3c_gpio_setpull(unsigned int pin,
s3c_gpio_pull_t
> pull)
> >  }
> >  EXPORT_SYMBOL(s3c_gpio_setpull);
> >
> > +s3c_gpio_pull_t s3c_gpio_getpull(unsigned int pin)
> > +{
> > +	struct s3c_gpio_chip *chip = s3c_gpiolib_getchip(pin);
> > +	unsigned long flags;
> > +	int offset;
> > +	u32 pup = 0;
> 
> would the result of s3c_gpio_do_getpull() should be a s3c_gpio_pull_t?
> 
Yes, righit.

Mr. Moon,
Could you please update your patch as per Ben's comment?

> > +	if (chip) {
> > +		offset = pin - chip->chip.base;
> > +
> > +		s3c_gpio_lock(chip, flags);
> > +		pup = s3c_gpio_do_getpull(chip, offset);
> > +		s3c_gpio_unlock(chip, flags);
> > +	}
> > +
> > +	return (__force s3c_gpio_pull_t)pup;
> > +}
> > +EXPORT_SYMBOL(s3c_gpio_getpull);

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
