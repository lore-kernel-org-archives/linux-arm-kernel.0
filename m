From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  9 Aug 2012 18:48:44 +0200
Subject: LPAE for outer caches functiopns (was Re: [RFC 3/6] arm: cache-l2x0:
 add support for Aurora L2 cache ctrl)
In-Reply-To: <20120808151946.GE4579@mudshark.cambridge.arm.com>
References: <20120808151946.GE4579@mudshark.cambridge.arm.com>
Message-ID: <1344530925-25857-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

You will find an updated version of this patch with LPAE support. I've
tested with and without LPAE selected.

Now I get some warning during compilation: "initialization from
incompatible pointer type [enabled by default]"

It is because the outer_cache_fns struct still embed functions with
unsigned long for address instead of phys_addr_t. You are aware of
it, as you started to work on it with your patch "ARM: 6671/1: LPAE:
use phys_addr_t instead of unsigned long in outercache functions".

So a first step would be to update the definitions in struct
outer_cache_fns and also in the files using this prototype, I found
only 4 files:

git grep -w  outer_.*_range arch/arm | grep = | cut -f 1| uniq
arch/arm/mm/cache-feroceon-l2.c:
arch/arm/mm/cache-l2x0.c:
arch/arm/mm/cache-tauros2.c:
arch/arm/mm/cache-xsc3l2.c:

But it is not enough we also fixed the call to theses functions:
git grep -w  outer_.*_range arch/arm | grep -v = | cut -f 1 -d: | uniq
arch/arm/include/asm/outercache.h
arch/arm/kernel/smp.c
arch/arm/kernel/suspend.c
arch/arm/mach-exynos/platsmp.c
arch/arm/mach-highbank/highbank.c
arch/arm/mach-msm/platsmp.c
arch/arm/mach-omap2/omap-secure.c
arch/arm/mach-ux500/platsmp.c
arch/arm/mm/dma-mapping.c
arch/arm/mm/fault-armv.c
arch/arm/plat-versatile/platsmp.c

Most of them use __pa or directly __virt_to_phys, so once the patch
"[PATCH 03/22] ARM: LPAE: use phys_addr_t on virt <--> phys
conversion" will be merged the correct type will be used.

Finally the last file which need some change will be
arch/arm/mm/dma-mapping.c.

Does it sound correct?

If it does, then I can prepare a patch for it.

Regards,

Gregory
