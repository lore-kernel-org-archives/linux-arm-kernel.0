From: olof@lixom.net (Olof Johansson)
Date: Mon, 27 May 2013 23:18:28 -0700
Subject: [PATCH 2/9] ARM: shmobile: add GPIO IRQ macro
In-Reply-To: <CANqRtoTUyaqfK3Droq3EuMZy-p2gzzTtcSTp=wiSM-3j0f4+Dg@mail.gmail.com>
References: <1369648773-7941-1-git-send-email-horms+renesas@verge.net.au>
 <1369648773-7941-3-git-send-email-horms+renesas@verge.net.au>
 <20130528040729.GN13532@quad.lixom.net>
 <CANqRtoTUyaqfK3Droq3EuMZy-p2gzzTtcSTp=wiSM-3j0f4+Dg@mail.gmail.com>
Message-ID: <20130528061828.GA20031@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 02:53:04PM +0900, Magnus Damm wrote:
> Hi Olof,
> 
> On Tue, May 28, 2013 at 1:07 PM, Olof Johansson <olof@lixom.net> wrote:
> > On Mon, May 27, 2013 at 06:59:26PM +0900, Simon Horman wrote:
> >> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >>
> >> R-Car series gpio_rcar driver can control GPIO IRQ today.
> >> It needs base IRQ number for gpio_rcar_config :: .irq_base
> >> This patch adds macro for GPIO IRQ.
> >> This patch was tested on Bock-W board
> >>
> >> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >> ---
> >>  arch/arm/mach-shmobile/include/mach/irqs.h |    5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/arch/arm/mach-shmobile/include/mach/irqs.h b/arch/arm/mach-shmobile/include/mach/irqs.h
> >> index b2074e2..d241bfd 100644
> >> --- a/arch/arm/mach-shmobile/include/mach/irqs.h
> >> +++ b/arch/arm/mach-shmobile/include/mach/irqs.h
> >> @@ -16,4 +16,9 @@
> >>  #define IRQPIN_BASE          2000
> >>  #define irq_pin(nr)          ((nr) + IRQPIN_BASE)
> >>
> >> +/* GPIO IRQ */
> >> +#define _GPIO_IRQ_BASE               2500
> >> +#define GPIO_IRQ_BASE(x)     (_GPIO_IRQ_BASE + (32 * x))
> >> +#define GPIO_IRQ(x, y)               (_GPIO_IRQ_BASE + (32 * x) + y)
> >> +
> >>  #endif /* __ASM_MACH_IRQS_H */
> >
> > Hmm. It'd be real nice to see some effort on moving this over to sparse
> > irq instead. That'll be needed for full device tree conversion anyway. And
> > with that, the static irq bases will be gone, so drivers and some of
> > the platform code will need to be adjusted accordingly.
> 
> I believe we've been doing sparse IRQ for ages, this is just to make
> non-DT stuff more readable.
> 
> Or was there some particular other interface you wanted us to use for
> non-DT board code?

Sorry, terminology confusion on my side. Most other platforms sorted
this out when they moved to sparse irq, removing most hardcoded interrupt
numbers at the same time and handling it through DT. But since shmobile
still has a ways to go on DT conversion things are a bit different.

Either way, once things have been converted fully to DT, most of these
static numberings can/should be possible to remove.


-Olof
