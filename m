From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Aug 2018 15:57:27 +0100
Subject: [PATCH 09/37] KVM: arm64: vgic-its: Remove VLA usage
In-Reply-To: <20180813145755.16566-1-marc.zyngier@arm.com>
References: <20180813145755.16566-1-marc.zyngier@arm.com>
Message-ID: <20180813145755.16566-10-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kees Cook <keescook@chromium.org>

In the quest to remove all stack VLA usage from the kernel[1], this
switches to using a maximum size and adds sanity checks. Additionally
cleans up some of the int-vs-u32 usage and adds additional bounds checking.
As it currently stands, this will always be 8 bytes until the ABI changes.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA at mail.gmail.com

Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: kvmarm at lists.cs.columbia.edu
Signed-off-by: Kees Cook <keescook@chromium.org>
[maz: dropped WARN_ONs]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 4ed79c939fb4..1d88010f6b61 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -168,8 +168,14 @@ struct vgic_its_abi {
 	int (*commit)(struct vgic_its *its);
 };
 
+#define ABI_0_ESZ	8
+#define ESZ_MAX		ABI_0_ESZ
+
 static const struct vgic_its_abi its_table_abi_versions[] = {
-	[0] = {.cte_esz = 8, .dte_esz = 8, .ite_esz = 8,
+	[0] = {
+	 .cte_esz = ABI_0_ESZ,
+	 .dte_esz = ABI_0_ESZ,
+	 .ite_esz = ABI_0_ESZ,
 	 .save_tables = vgic_its_save_tables_v0,
 	 .restore_tables = vgic_its_restore_tables_v0,
 	 .commit = vgic_its_commit_v0,
@@ -183,7 +189,7 @@ inline const struct vgic_its_abi *vgic_its_get_abi(struct vgic_its *its)
 	return &its_table_abi_versions[its->abi_rev];
 }
 
-int vgic_its_set_abi(struct vgic_its *its, int rev)
+static int vgic_its_set_abi(struct vgic_its *its, u32 rev)
 {
 	const struct vgic_its_abi *abi;
 
@@ -1881,14 +1887,14 @@ typedef int (*entry_fn_t)(struct vgic_its *its, u32 id, void *entry,
  * Return: < 0 on error, 0 if last element was identified, 1 otherwise
  * (the last element may not be found on second level tables)
  */
-static int scan_its_table(struct vgic_its *its, gpa_t base, int size, int esz,
+static int scan_its_table(struct vgic_its *its, gpa_t base, int size, u32 esz,
 			  int start_id, entry_fn_t fn, void *opaque)
 {
 	struct kvm *kvm = its->dev->kvm;
 	unsigned long len = size;
 	int id = start_id;
 	gpa_t gpa = base;
-	char entry[esz];
+	char entry[ESZ_MAX];
 	int ret;
 
 	memset(entry, 0, esz);
-- 
2.18.0
