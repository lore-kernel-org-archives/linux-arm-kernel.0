From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 15:13:30 +0100
Subject: [PATCH v4 02/32] arm64: KVM: HYP mode idmap support
In-Reply-To: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368540840-26750-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the necessary infrastructure for identity-mapped HYP page
tables. Idmap-ed code must be in the ".hyp.idmap.text" linker
section.

The rest of the HYP ends up in ".hyp.text".

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 3fae2be..9635391 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -17,6 +17,19 @@ ENTRY(stext)
 
 jiffies = jiffies_64;
 
+#define HYPERVISOR_TEXT					\
+	/*						\
+	 * Force the alignment to be compatible with	\
+	 * the vectors requirements			\
+	 */						\
+	. = ALIGN(2048);				\
+	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;	\
+	*(.hyp.idmap.text)				\
+	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;	\
+	VMLINUX_SYMBOL(__hyp_text_start) = .;		\
+	*(.hyp.text)					\
+	VMLINUX_SYMBOL(__hyp_text_end) = .;
+
 SECTIONS
 {
 	/*
@@ -49,6 +62,7 @@ SECTIONS
 			TEXT_TEXT
 			SCHED_TEXT
 			LOCK_TEXT
+			HYPERVISOR_TEXT
 			*(.fixup)
 			*(.gnu.warning)
 		. = ALIGN(16);
@@ -124,3 +138,9 @@ SECTIONS
 	STABS_DEBUG
 	.comment 0 : { *(.comment) }
 }
+
+/*
+ * The HYP init code can't be more than a page long.
+ */
+ASSERT(((__hyp_idmap_text_start + PAGE_SIZE) >= __hyp_idmap_text_end),
+       "HYP init code too big")
-- 
1.8.2.3
