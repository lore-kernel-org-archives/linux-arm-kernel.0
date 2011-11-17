From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Nov 2011 17:00:59 +0000
Subject: [PATCH v7 01/11] ARM: mmp: fix build error on gpio
In-Reply-To: <CAMPhdO-27ZMV+z5b8j1NEPmUMHx=6cOe0dxvDgbM+2KGeAWXKg@mail.gmail.com>
References: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
 <201111171516.24237.arnd@arndb.de>
 <CAMPhdO-27ZMV+z5b8j1NEPmUMHx=6cOe0dxvDgbM+2KGeAWXKg@mail.gmail.com>
Message-ID: <201111171700.59750.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 November 2011, Eric Miao wrote:
> On Thu, Nov 17, 2011 at 11:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 09 November 2011, Haojian Zhuang wrote:
> >> Parameters of GPIO_REG() should be assigned as volatile.
> >>
> >> arch/arm/plat-pxa/include/plat/gpio.h: In function ?gpio_get_value?:
> >> arch/arm/plat-pxa/include/plat/gpio.h:12:21: error: invalid operands to
> >> binary & (have ?void *? and ?int?)
> >> arch/arm/plat-pxa/include/plat/gpio.h: In function ?gpio_set_value?:
> >> arch/arm/plat-pxa/include/plat/gpio.h:21:4: error: lvalue required as
> >> left operand of assignment
> >> arch/arm/plat-pxa/include/plat/gpio.h:23:4: error: lvalue required as
> >> left operand of assignment
> >>
> >> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> >> ---
> >>  arch/arm/mach-mmp/include/mach/gpio-pxa.h |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-mmp/include/mach/gpio-pxa.h b/arch/arm/mach-mmp/include/mach/gpio-pxa.h
> >> index d14eeaf..99b4ce1 100644
> >> --- a/arch/arm/mach-mmp/include/mach/gpio-pxa.h
> >> +++ b/arch/arm/mach-mmp/include/mach/gpio-pxa.h
> >> @@ -7,7 +7,7 @@
> >>  #define GPIO_REGS_VIRT (APB_VIRT_BASE + 0x19000)
> >>
> >>  #define BANK_OFF(n)    (((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
> >> -#define GPIO_REG(x)    (GPIO_REGS_VIRT + (x))
> >> +#define GPIO_REG(x)    (*(volatile u32 *)(GPIO_REGS_VIRT + (x)))
> >>
> >>  #define NR_BUILTIN_GPIO                IRQ_GPIO_NUM
> >
> > Note that this is not the correct fix, it just restores the previous
> > state after I broke the original code in an "evil" merge commit
> > that tried to merge the gpio branch with my patch that changed the
> > mmio annotations.
> >
> > Anyway, everything seems fine now, since patch 9/11 removes the code
> > either way.
> 
> Yeah, but having a patch here really helps to make a buildable
> state of the history.
> 
> Shall I go ahead and send the GIT PULL with this patch? or you have
> another idea?

Actually it turns out that Russell has already sent an identical
fix upstream, and that has made it into 3.2-rc1, so I think it should
be fine now without your patch.

	Arnd
