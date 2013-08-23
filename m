From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Aug 2013 00:17:17 -0700
Subject: [PATCH] ARM: KVM: Bugfix: vgic_bytemap_get_reg per cpu regs
Message-ID: <1377242237-29930-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For bytemaps each IRQ field is 1 byte wide, so we pack 4 irq fields in
one word and since there are 32 private (per cpu) irqs, we have 8
private u32 fields on the vgic_bytemap struct.  We shift the offset from
the base of the register group right by 2, giving us the word index
instead of the field index.  But then there are 8 private words, not 4,
which is also why we subtract 8 words from the offset of the shared
words.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 17c5ac7..96d7aa4 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -149,7 +149,7 @@ static u32 *vgic_bytemap_get_reg(struct vgic_bytemap *x, int cpuid, u32 offset)
 {
 	offset >>= 2;
 	BUG_ON(offset > (VGIC_NR_IRQS / 4));
-	if (offset < 4)
+	if (offset < 8)
 		return x->percpu[cpuid] + offset;
 	else
 		return x->shared + offset - 8;
-- 
1.7.10.4
