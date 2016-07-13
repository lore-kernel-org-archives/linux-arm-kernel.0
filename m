From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 13 Jul 2016 17:54:05 +0300
Subject: [bug report] ARM: pxa: use generic gpio operation instead of gpio
 register
Message-ID: <20160713145405.GA28563@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Haojian Zhuang,

The patch 9bf448c66d4b: "ARM: pxa: use generic gpio operation instead
of gpio register" from Oct 17, 2011, leads to the following static
checker warning:

  arch/arm/mach-pxa/spitz_pm.c:172 spitz_charger_wakeup()
  warn: double left shift '!gpio_get_value(SPITZ_GPIO_KEY_INT) << (1 << ((SPITZ_GPIO_KEY_INT) & 31))'

  arch/arm/mach-pxa/corgi_pm.c:138 corgi_charger_wakeup()
  warn: double left shift '!gpio_get_value(CORGI_GPIO_AC_IN) << (1 << ((CORGI_GPIO_AC_IN) & 31))'

  arch/arm/mach-pxa/corgi_pm.c:140 corgi_charger_wakeup()
  warn: double left shift '!gpio_get_value(CORGI_GPIO_KEY_INT) << (1 << ((CORGI_GPIO_KEY_INT) & 31))'

  arch/arm/mach-pxa/corgi_pm.c:142 corgi_charger_wakeup()
  warn: double left shift '!gpio_get_value(CORGI_GPIO_WAKEUP) << (1 << ((CORGI_GPIO_WAKEUP) & 31))'

arch/arm/mach-pxa/spitz_pm.c
   168  static unsigned long spitz_charger_wakeup(void)
   169  {
   170          unsigned long ret;
   171          ret = ((!gpio_get_value(SPITZ_GPIO_KEY_INT)
   172                  << GPIO_bit(SPITZ_GPIO_KEY_INT))
                           ^^^^^^^^
We're double shifting here.  It's clearly wrong, but I'm not sure what
the correct thing would be.

   173                  | gpio_get_value(SPITZ_GPIO_SYNC));
   174          return ret;
   175  }

arch/arm/mach-pxa/corgi_pm.c
   134  static unsigned long corgi_charger_wakeup(void)
   135  {
   136          unsigned long ret;
   137  
   138          ret = (!gpio_get_value(CORGI_GPIO_AC_IN) << GPIO_bit(CORGI_GPIO_AC_IN))
                                                            ^^^^^^^^
   139                  | (!gpio_get_value(CORGI_GPIO_KEY_INT)
   140                  << GPIO_bit(CORGI_GPIO_KEY_INT))
                           ^^^^^^^^
   141                  | (!gpio_get_value(CORGI_GPIO_WAKEUP)
   142                  << GPIO_bit(CORGI_GPIO_WAKEUP));
                           ^^^^^^^^^
   143          return ret;
   144  }

regards,
dan carpenter
