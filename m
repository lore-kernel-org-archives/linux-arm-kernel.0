From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jan 2012 17:28:45 +0000
Subject: [PATCH] ARM: imx6: fix v7_invalidate_l1 by adding I-Cache
 invalidation
In-Reply-To: <CAB4PhKexxJM+rWhgdQfu9vB16KVT6QpN1ye4kH88pNiLnEyL+Q@mail.gmail.com>
References: <1325237200-10610-1-git-send-email-shawn.guo@linaro.org>
 <CAB4PhKexxJM+rWhgdQfu9vB16KVT6QpN1ye4kH88pNiLnEyL+Q@mail.gmail.com>
Message-ID: <20120103172845.GD2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2011 at 06:47:05PM +0800, Jason Liu wrote:
> I looked the code: arch/arm/mm/proc-v7.S:
> 
> #ifdef HARVARD_CACHE
>         mcr     p15, 0, r10, c7, c5, 0          @ I+BTB cache invalidate
> #endif
>         dsb
> #ifdef CONFIG_MMU
>         mcr     p15, 0, r10, c8, c7, 0          @ invalidate I + D TLBs
>         mcr     p15, 0, r10, c2, c0, 2          @ TTB control register
>         ALT_SMP(orr     r4, r4, #TTB_FLAGS_SMP)
>         ALT_UP(orr      r4, r4, #TTB_FLAGS_UP)
>         mcr     p15, 0, r4, c2, c0, 1           @ load TTB1
> 
> It seems that it will try to invalidate when HARVARD_CACHE define. But
> HARVARD_CACHE only defined in v6, why?

It's probably a mistake caused when copying proc-v6.S to proc-v7.S and
editing it - which I believe is how proc-v7.S was created.  Suggest you
ask Catalin to find out more details.
