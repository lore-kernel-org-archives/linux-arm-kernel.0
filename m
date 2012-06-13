From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 13 Jun 2012 10:34:01 -0400 (EDT)
Subject: [PATCH] ARM: irq: add a mach/fiq.h inclusion for SPARSE_IRQ build
In-Reply-To: <1339592253-25142-1-git-send-email-shawn.guo@linaro.org>
References: <1339592253-25142-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <alpine.LFD.2.02.1206131024480.23555@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Jun 2012, Shawn Guo wrote:

> The commit a2be01b (ARM: only include mach/irqs.h for !SPARSE_IRQ)
> makes mach/irqs.h only be included for !SPARSE_IRQ build.  There are
> a nubmer of platforms have FIQ_START defined in mach/irqs.h.
> 
>   arch/arm/mach-at91/include/mach/irqs.h:#define FIQ_START AT91_ID_FIQ
>   arch/arm/mach-rpc/include/mach/irqs.h:#define FIQ_START         64
>   arch/arm/mach-s3c24xx/include/mach/irqs.h:#define FIQ_START             IRQ_EINT0
>   arch/arm/plat-mxc/include/mach/irqs.h:#define FIQ_START 0
>   arch/arm/plat-omap/include/plat/irqs.h:#define FIQ_START                1024
> 
> If SPARSE_IRQ is enabled for any of these platforms, the following
> compile error will be seen.
> 
>   arch/arm/kernel/fiq.c: In function ?enable_fiq?:
>   arch/arm/kernel/fiq.c:127:19: error: ?FIQ_START? undeclared (first use in this function)
>   arch/arm/kernel/fiq.c:127:19: note: each undeclared identifier is reported only once for each function it appears in
>   arch/arm/kernel/fiq.c: In function ?disable_fiq?:
>   arch/arm/kernel/fiq.c:132:20: error: ?FIQ_START? undeclared (first use in this function)
> 
> So before we can remove the reference to FIQ_START in fiq.c, we need
> a way out.  The patch adds a mach/fiq.h inclusion for SPARSE_IRQ build
> in asm/irq.h, so that platform can have a chance to provide FIQ_START.

This is a step backward.  Please let's get rid of FIQ_START instead.
This should be removed from enable_fiq() and disable_fiq(), and the 
arguments to those functions should use the absolute IRQ number instead.  
for instance, there is FIQ_FLOPPYDATA in mach-rpc/include/mach/irqs.h 
which could be defined as 64 instead of 0, etc.


Nicolas
