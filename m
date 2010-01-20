From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 20 Jan 2010 16:33:08 -0500
Subject: Question: locomo_{read/write}l macros
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909020E8DFF@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

Is there a reason why the locomo stuff is using custom
macros for {read/write}l access?

In arch/arm/include/asm/hardware/locomo.h:

#define locomo_writel(val,addr)	({ *(volatile u16 *)(addr) = (val); })
#define locomo_readl(addr)	(*(volatile u16 *)(addr))

It appears that these are just non-typesafe versions of the
__raw_{read/write}w macros in arch/arm/include/asm/io.h:

#define __raw_writew(v,a)	(__chk_io_ptr(a), *(volatile unsigned short __force *)(a) = (v))
#define __raw_readw(a)		(__chk_io_ptr(a), *(volatile unsigned short __force *)(a))

Is there any reason not to change them all (other than
having to then fix all the callers to be typesafe)?

It appears the only users are in:

arch/arm/common/locomo.c
arch/arm/include/asm/hardware/locomo.h
drivers/input/keyboard/locomokbd.c
drivers/leds/leds-locomo.c
drivers/video/backlight/locomolcd.c

Thanks,
Hartley
