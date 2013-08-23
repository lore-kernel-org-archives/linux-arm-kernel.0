From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Aug 2013 00:21:30 -0700
Subject: [RFC PATCH] ARM: KVM: vgic: Bump VGIC_NR_IRQS to 256
Message-ID: <1377242490-30132-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Versatile Express TC2 board, which we use as our main emulated
platform in QEMU, defines 160+32 == 192 interrupts, so limiting the
number of interrupts to 128 is not quite going to cut it for real board
emulation.

Note that this didn't use to be a problem because QEMU was buggy and
only defined 128 interrupts until recently.

  [ Sending this as an RFC, because I haven't convinced myself that
    this is even the right short-term fix.  On a longer-term we probably
    need a way for QEMU to tell the kernel how many IRQs it needs for a
    particular implementation of a CPU and a GIC, but on a shorter term
    we should at least support a real A15 configuration.  Note that this
    change increases the in-kernel memory consumption quite a bit,
    especially due to the irq-to-lr map, which could be reversed or
    turned into a hash table or list, at the sacrifice of some
    performance during world-switches to search the data structure. ]

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 include/kvm/arm_vgic.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 343744e..7e2d158 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -26,7 +26,7 @@
 #include <linux/types.h>
 #include <linux/irqchip/arm-gic.h>
 
-#define VGIC_NR_IRQS		128
+#define VGIC_NR_IRQS		256
 #define VGIC_NR_SGIS		16
 #define VGIC_NR_PPIS		16
 #define VGIC_NR_PRIVATE_IRQS	(VGIC_NR_SGIS + VGIC_NR_PPIS)
-- 
1.7.10.4
