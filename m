From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Nov 2014 10:39:09 +0000
Subject: [PATCH NEXT] irqchip: gic: fix compilation of asm code depending
 on arm-gic.h
In-Reply-To: <1417170975-1163-1-git-send-email-marc.zyngier@arm.com>
References: <1417170975-1163-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20141128103908.GB7144@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 10:36:15AM +0000, Marc Zyngier wrote:
> Commit 01f17a66be97 (irqchip: gic: Remove warning by including
> linux/irqdomain.h) indeed fixed an annoying warning in the ARM
> code, but also broke the compilation of arm64 defconfig and
> any other defconfig that includes KVM support in a rather
> spectacular way:
> 
> http://lists.linaro.org/pipermail/kernel-build-reports/2014-November/006475.html
> 
> Moving the #include directive to a spot that is not going to
> be used by assembly code fixes the issue.
> 
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  include/linux/irqchip/arm-gic.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

arm64 allmodconfig is dead in the water without this fix.

Will

> diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
> index d1b2263..71d706d 100644
> --- a/include/linux/irqchip/arm-gic.h
> +++ b/include/linux/irqchip/arm-gic.h
> @@ -10,8 +10,6 @@
>  #ifndef __LINUX_IRQCHIP_ARM_GIC_H
>  #define __LINUX_IRQCHIP_ARM_GIC_H
>  
> -#include <linux/irqdomain.h>
> -
>  #define GIC_CPU_CTRL			0x00
>  #define GIC_CPU_PRIMASK			0x04
>  #define GIC_CPU_BINPOINT		0x08
> @@ -93,6 +91,8 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <linux/irqdomain.h>
> +
>  struct device_node;
>  
>  extern struct irq_chip gic_arch_extn;
> -- 
> 2.1.3
> 
> 
