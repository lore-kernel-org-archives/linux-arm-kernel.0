From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Nov 2011 08:49:31 +0000
Subject: [PATCH v5 03/11] ARM: pxa: rename gpio_to_irq and irq_to_gpio
In-Reply-To: <CAN1soZwTU6aJy2OP8Skj_pbLFXcWBEa7yyzrMpgcR+FfHAdx8Q@mail.gmail.com>
References: <1318858517-22494-1-git-send-email-haojian.zhuang@marvell.com>
 <1318858517-22494-4-git-send-email-haojian.zhuang@marvell.com>
 <20111027091702.GE19187@n2100.arm.linux.org.uk>
 <CAN1soZwTU6aJy2OP8Skj_pbLFXcWBEa7yyzrMpgcR+FfHAdx8Q@mail.gmail.com>
Message-ID: <20111107084931.GL12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2011 at 03:14:36PM +0800, Haojian Zhuang wrote:
> On Thu, Oct 27, 2011 at 5:17 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Oct 17, 2011 at 09:35:09PM +0800, Haojian Zhuang wrote:
> >> diff --git a/arch/arm/mach-mmp/include/mach/gpio.h b/arch/arm/mach-mmp/include/mach/gpio.h
> >> index 6812623..32b684a 100644
> >> --- a/arch/arm/mach-mmp/include/mach/gpio.h
> >> +++ b/arch/arm/mach-mmp/include/mach/gpio.h
> >> @@ -3,9 +3,6 @@
> >>
> >> ?#include <asm-generic/gpio.h>
> >>
> >> -#define gpio_to_irq(gpio) ? ?(IRQ_GPIO_START + (gpio))
> >> -#define irq_to_gpio(irq) ? ? ((irq) - IRQ_GPIO_START)
> >> -
> >
> > Doesn't this leave MMP without any definition for gpio_to_irq() ? ?This
> > is part of the gpiolib API and really should be implemented. ?If you're
> > not providing your own special version, it should be defined to
> > __gpio_to_irq() instead. ?(Same comment for PXA.)
> >
> Excuse me for response so late.
> 
> gpio_to_irq() was provided to share between arch-pxa and arch-mmp.
> Now it became the obstacle of building arch-pxa and arch-mmp together.
> 
> __gpio_to_irq() is defined in drivers/gpio/gpiolib.c. It makes use of
> gpio_chip->to_irq(). So I prefer to use __gpio_to_irq() as common interface.
> 
> Since some macro may use gpio_to_irq() in legacy pxa code, I define
> PXA_GPIO_TO_IRQ() and MMP_GPIO_TO_IRQ() to handle this.

__gpio_to_irq() is the gpiolib implementation.  gpio_to_irq() is the
interface which should be used to this function.
