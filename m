From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 28 Nov 2014 11:49:44 -0500
Subject: [PATCH NEXT] irqchip: gic: fix compilation of asm code
 depending on arm-gic.h
In-Reply-To: <1417170975-1163-1-git-send-email-marc.zyngier@arm.com>
References: <1417170975-1163-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20141128164944.GP22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

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

I squashed this into the original fix with your S-o-b, and Will's Ack.
Pushing to irqchip/for-next shortly.

thx,

Jason.

------------8<----------------------
commit df870c78848aac4d953f61a8926a792de8133b9e
Author: Jason Cooper <jason@lakedaemon.net>
Date:   Thu Nov 27 18:27:49 2014 +0000

    irqchip: gic: Remove warning by including linux/irqdomain.h
    
    Commit
    
      853a33ce6932 irqchip: gic-v2m: Add support for ARM GICv2m MSI(-X) doorbell
    
    Introduced a series of warnings when building ARM multi_v7_defconfig:
    
      include/linux/irqchip/arm-gic.h:109:53: warning: its scope is only this definition or declaration, which is probably not what you want
      In file included from arch/arm/mach-ux500/pm.c:13:0:
      include/linux/irqchip/arm-gic.h:109:53: warning: 'struct irq_domain' declared inside parameter list
       int gicv2m_of_init(struct device_node *node, struct irq_domain *parent);
                                                           ^
    
    Fix this by adding the proper include.
    
    Signed-off-by: Jason Cooper <jason@lakedaemon.net>
    [ jac merged much more correct version from Marc into this patch ]
    Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
    Acked-by: Will Deacon <will.deacon@arm.com>
    Link: https://lkml.kernel.org/r/1417170975-1163-1-git-send-email-marc.zyngier at arm.com
    Signed-off-by: Jason Cooper <jason@lakedaemon.net>

diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 60b09ed58cae..71d706d5f169 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -91,6 +91,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/irqdomain.h>
+
 struct device_node;
 
 extern struct irq_chip gic_arch_extn;
