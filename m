From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Fri, 20 Jan 2017 21:36:18 +0530
Subject: [PATCH 1/4] ARM: mmu: decouple VECTORS_BASE from Kconfig
In-Reply-To: <20170119142424.GZ27312@n2100.armlinux.org.uk>
References: <20170118203525.6246-1-afzal.mohd.ma@gmail.com>
 <20170118203739.6400-1-afzal.mohd.ma@gmail.com>
 <20170119142424.GZ27312@n2100.armlinux.org.uk>
Message-ID: <20170120160618.GA3865@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 19, 2017 at 02:24:24PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 19, 2017 at 02:07:39AM +0530, afzal mohammed wrote:

> > +++ b/arch/arm/include/asm/memory.h

> > +#define VECTORS_BASE		0xffff0000
> 
> This should be UL(0xffff0000)

> > -			MLK(UL(CONFIG_VECTORS_BASE), UL(CONFIG_VECTORS_BASE) +
> > -				(PAGE_SIZE)),
> > +			MLK(UL(VECTORS_BASE), UL(VECTORS_BASE) + (PAGE_SIZE)),
> 
> which means you don't need it here, which will then fix the build error
> reported by the 0-day builder.

Seems there is some confusion here,

VECTORS_BASE definition above in memory.h is enclosed within
CONFIG_MMU. Robot used a no-MMU defconfig, it didn't get a
VECTORS_BASE definition at this patch, causing the build error. Our
dear robot mentioned that my HEAD didn't break build, but
bisectability is broken at this point.

With "PATCH 3/4 ARM: nommu: display vectors base", the above is
changed to
        #ifdef CONFIG_MMU
                MLK(UL(VECTORS_BASE), UL(VECTORS_BASE) + (PAGE_SIZE)),
        #else
                ...
        #endif
thus making the series build again for no-MMU

One option to keep bisectability would be to squash this with PATCH
3/4, but i think a better & natural solution would be define
VECTORS_BASE outside of
        #ifdef CONFIG_MMU
        ...
        #else
        ...
        #endif
and then in PATCH 3/4, move VECTORS_BASE to be inside
        #ifdef CONFIG_MMU
        ...
        #else

Regards
afzal
