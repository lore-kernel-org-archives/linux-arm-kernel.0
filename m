From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Thu, 22 Dec 2011 23:49:08 +0400
Subject: [PATCH] pxa/hx4700: Fix PXA_GPIO_IRQ_BASE/IRQ_NUM values
In-Reply-To: <CAN1soZzwMQh7cMF_1QR5zzzy895qb+QkKP+AXp+7VnwCFykNgg@mail.gmail.com>
References: <1323728465.801.YahooMailClassic@web29018.mail.ird.yahoo.com>
 <CA+gwMcc3tbGXmFHQt=y7mwprXumh7sgMSE_e7B0L2LbQ-Hk2fg@mail.gmail.com>
 <20111221191901.GA18261@rainbow>
 <CAN1soZzwMQh7cMF_1QR5zzzy895qb+QkKP+AXp+7VnwCFykNgg@mail.gmail.com>
Message-ID: <20111222194907.GA29166@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:58 Thu 22 Dec     , Haojian Zhuang wrote:
> On Thu, Dec 22, 2011 at 3:19 AM, Dmitry Artamonow <mad_soft@inbox.ru> wrote:
> >
> > Yes, I also think increasing ARCH_NR_GPIO is the way to go.
> > BTW, there's a patchset floating around which moves such custom
> > settings of ARCH_NR_GPIO from mach/gpio.h into Kconfig variable:
> > http://lkml.indiana.edu/hypermail/linux/kernel/1111.0/01433.html
> >
> > I'm not sure though if it's going to be merged into 3.3
> >
> I think configuring ARCH_NR_GPIO is not a good solution. Since
> building one image
> is a target. While multiple archs are built together, what will happen?

Setting custom ARCH_NR_GPIO in mach/gpio.h does scale only inside one
sub-arch, but the patch from the set above which migrates ARCH_NR_GPIO to
arch/arm/include/asm/gpio.h and converts it into Kconfig variable should
help to select proper ARCH_NR_GPIO even for multi-arch kernels
(Kconfig's magic will ensure that proper maximal value of ARCH_NR_GPIO
is selected for each combination of platforms)

See the patch here:
http://lkml.indiana.edu/hypermail/linux/kernel/1111.0/01431.html

and Russell's explanation of Kconfig magic here:
http://lkml.indiana.edu/hypermail/linux/kernel/1111.0/01577.html

> 
> Maybe we need to change gpio like irq style. User could configure
> nr_gpio in machine
> description.

That's probably a good idea - I personally don't see much sense in
having some randomly chosen arbitrarily big ARCH_NR_GPIO anyway, so
it would be nice to have more advanced mechanisms in place of this.
But I'm not sure if keeping hx4700 broken until some good infrastructure
will come up is a good idea.

-- 
Best regards,
Dmitry "MAD" Artamonow
