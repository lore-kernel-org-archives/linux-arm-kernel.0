From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 May 2013 19:32:44 +0200
Subject: [PATCH v2 4/5] ARM: mmp: move irqs head file
In-Reply-To: <1369707707-30295-5-git-send-email-haojian.zhuang@gmail.com>
References: <1369707707-30295-1-git-send-email-haojian.zhuang@gmail.com>
 <1369707707-30295-5-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <201305281932.44663.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 May 2013, Haojian Zhuang wrote:
> Since irq-mmp driver includes <mach/irqs.h>, it blocks the multiple
> platform build. So move the head file into include/linux/irqchip/
> directory.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>

I disagree with simply moving the file. Let's check first what is actually
needed from it.

>  arch/arm/mach-mmp/aspenite.c                                         | 2 +-
>  arch/arm/mach-mmp/avengers_lite.c                                    | 2 +-
>  arch/arm/mach-mmp/brownstone.c                                       | 2 +-
>  arch/arm/mach-mmp/devices.c                                          | 2 +-
>  arch/arm/mach-mmp/flint.c                                            | 2 +-
>  arch/arm/mach-mmp/gplugd.c                                           | 2 +-
>  arch/arm/mach-mmp/jasper.c                                           | 2 +-
>  arch/arm/mach-mmp/mmp2.c                                             | 2 +-
>  arch/arm/mach-mmp/pm-mmp2.c                                          | 2 +-
>  arch/arm/mach-mmp/pm-pxa910.c                                        | 2 +-
>  arch/arm/mach-mmp/pxa168.c                                           | 2 +-
>  arch/arm/mach-mmp/pxa910.c                                           | 2 +-
>  arch/arm/mach-mmp/tavorevb.c                                         | 2 +-
>  arch/arm/mach-mmp/teton_bga.c                                        | 2 +-
>  arch/arm/mach-mmp/time.c                                             | 2 +-
>  arch/arm/mach-mmp/ttc_dkb.c                                          | 2 +-
>  drivers/gpio/gpio-pxa.c                                              | 3 +--
>  drivers/irqchip/irq-mmp.c                                            | 3 +--
>  arch/arm/mach-mmp/include/mach/irqs.h => include/linux/irqchip/mmp.h | 0
>  19 files changed, 18 insertions(+), 20 deletions(-)
>  rename arch/arm/mach-mmp/include/mach/irqs.h => include/linux/irqchip/mmp.h (100%)

My guess is that the long list of IRQ numbers is only needed for legacy
board files. That list would better be put into arch/arm/mach-mmp/irqs.h.

Try to move as much as you can from the include/linux/irqchip/mmp.h
file into that new header. Some constants (e.g irq base numbers
and mmio addresses) can be passed into the icu_init_irq/mmp2_init_icu
functions as arguments so you don't need them in the global header.

	Arnd
