From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 25 Apr 2018 17:13:41 +0100
Subject: [PATCH 2/3] KVM: arm/arm64: vgic: fix possible spectre-v1 in
 vgic_get_irq()
In-Reply-To: <20180425161342.38133-1-mark.rutland@arm.com>
References: <20180425161342.38133-1-mark.rutland@arm.com>
Message-ID: <20180425161342.38133-3-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's possible for userspace to control intid. Sanitize intid when using
it as an array index.

At the same time, sort the includes when adding <linux/nospec.h>.

Found by smatch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: kvmarm at lists.cs.columbia.edu
---
 virt/kvm/arm/vgic/vgic.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index e74baec76361..bd125563b15b 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -14,11 +14,13 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 #include <linux/list_sort.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
+#include <linux/nospec.h>
+
 #include <asm/kvm_hyp.h>
 
 #include "vgic.h"
@@ -101,12 +103,16 @@ struct vgic_irq *vgic_get_irq(struct kvm *kvm, struct kvm_vcpu *vcpu,
 			      u32 intid)
 {
 	/* SGIs and PPIs */
-	if (intid <= VGIC_MAX_PRIVATE)
+	if (intid <= VGIC_MAX_PRIVATE) {
+		intid = array_index_nospec(intid, VGIC_MAX_PRIVATE);
 		return &vcpu->arch.vgic_cpu.private_irqs[intid];
+	}
 
 	/* SPIs */
-	if (intid <= VGIC_MAX_SPI)
+	if (intid <= VGIC_MAX_SPI) {
+		intid = array_index_nospec(intid, VGIC_MAX_SPI);
 		return &kvm->arch.vgic.spis[intid - VGIC_NR_PRIVATE_IRQS];
+	}
 
 	/* LPIs */
 	if (intid >= VGIC_MIN_LPI)
-- 
2.11.0
