From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 13 Jul 2016 20:15:45 +0200
Subject: [bug report] ARM: pxa: use generic gpio operation instead of gpio
 register
In-Reply-To: <20160713145405.GA28563@mwanda> (Dan Carpenter's message of "Wed,
 13 Jul 2016 17:54:05 +0300")
References: <20160713145405.GA28563@mwanda>
Message-ID: <87inw92ylq.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> Hello Haojian Zhuang,
>
> The patch 9bf448c66d4b: "ARM: pxa: use generic gpio operation instead
> of gpio register" from Oct 17, 2011, leads to the following static
> checker warning:

Hi Dan,

I don't think Haojian still works for Marvell anymore, I added his current
address I'm aware of (MAINTAINER is our friend).


> arch/arm/mach-pxa/spitz_pm.c
>    168  static unsigned long spitz_charger_wakeup(void)
>    169  {
>    170          unsigned long ret;
>    171          ret = ((!gpio_get_value(SPITZ_GPIO_KEY_INT)
>    172                  << GPIO_bit(SPITZ_GPIO_KEY_INT))
>                            ^^^^^^^^
> We're double shifting here.  It's clearly wrong, but I'm not sure what
> the correct thing would be.
You're perfectly right.
It was correct before the patch, because GPLR0 is a register, ie:
   return (~GPLR0 & GPIO_bit(SPITZ_GPIO_KEY_INT)) | (GPLR0 &
   GPIO_bit(SPITZ_GPIO_SYNC));

But the change should have been:
+       ret = !gpio_get_value(SPITZ_GPIO_KEY_INT)
+               | !gpio_get_value(SPITZ_GPIO_SYNC);

> arch/arm/mach-pxa/corgi_pm.c
>    134  static unsigned long corgi_charger_wakeup(void)
>    135  {
>    136          unsigned long ret;
>    137  
>    138          ret = (!gpio_get_value(CORGI_GPIO_AC_IN) << GPIO_bit(CORGI_GPIO_AC_IN))
>                                                             ^^^^^^^^
>    139                  | (!gpio_get_value(CORGI_GPIO_KEY_INT)
>    140                  << GPIO_bit(CORGI_GPIO_KEY_INT))
>                            ^^^^^^^^
>    141                  | (!gpio_get_value(CORGI_GPIO_WAKEUP)
>    142                  << GPIO_bit(CORGI_GPIO_WAKEUP));

Same thing here:
+       ret = !gpio_get_value(CORGI_GPIO_AC_IN)
+               | !gpio_get_value(CORGI_GPIO_KEY_INT)
+               | !gpio_get_value(CORGI_GPIO_WAKEUP);

I will make a patch for this, thanks for the report.

Cheers.

-- 
Robert
