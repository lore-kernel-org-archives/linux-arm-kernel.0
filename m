From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 17 Feb 2016 16:40:44 +0000
Subject: [PATCH v2 12/17] arm64: KVM: vgic-v2: Make GICD_SGIR quicker to hit
In-Reply-To: <1455727249-24752-1-git-send-email-marc.zyngier@arm.com>
References: <1455727249-24752-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1455727249-24752-13-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GICD_SGIR register lives a long way from the beginning of
the handler array, which is searched linearly. As this is hit
pretty often, let's move it up. This saves us some precious
cycles when the guest is generating IPIs.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic-v2-emul.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/arm/vgic-v2-emul.c b/virt/kvm/arm/vgic-v2-emul.c
index 1390797..1b0bee0 100644
--- a/virt/kvm/arm/vgic-v2-emul.c
+++ b/virt/kvm/arm/vgic-v2-emul.c
@@ -321,6 +321,11 @@ static bool handle_mmio_sgi_clear(struct kvm_vcpu *vcpu,
 
 static const struct vgic_io_range vgic_dist_ranges[] = {
 	{
+		.base		= GIC_DIST_SOFTINT,
+		.len		= 4,
+		.handle_mmio	= handle_mmio_sgi_reg,
+	},
+	{
 		.base		= GIC_DIST_CTRL,
 		.len		= 12,
 		.bits_per_irq	= 0,
@@ -387,11 +392,6 @@ static const struct vgic_io_range vgic_dist_ranges[] = {
 		.handle_mmio	= handle_mmio_cfg_reg,
 	},
 	{
-		.base		= GIC_DIST_SOFTINT,
-		.len		= 4,
-		.handle_mmio	= handle_mmio_sgi_reg,
-	},
-	{
 		.base		= GIC_DIST_SGI_PENDING_CLEAR,
 		.len		= VGIC_NR_SGIS,
 		.handle_mmio	= handle_mmio_sgi_clear,
-- 
2.1.4
