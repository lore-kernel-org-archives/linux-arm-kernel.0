From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 30 Apr 2013 07:49:27 -0700
Subject: [PATCH 06/15] ARM: KVM: enforce maximum size for identity mapped code
In-Reply-To: <1367333376-30983-1-git-send-email-cdall@cs.columbia.edu>
References: <1367333376-30983-1-git-send-email-cdall@cs.columbia.edu>
Message-ID: <1367333376-30983-7-git-send-email-cdall@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

We're about to move to an init procedure where we rely on the
fact that the init code fits in a single page. Make sure we
align the idmap text on a vector alignment, and that the code is
not bigger than a single page.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@cs.columbia.edu>
---
 arch/arm/kernel/vmlinux.lds.S |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index b571484..a871b8e 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -20,7 +20,7 @@
 	VMLINUX_SYMBOL(__idmap_text_start) = .;				\
 	*(.idmap.text)							\
 	VMLINUX_SYMBOL(__idmap_text_end) = .;				\
-	ALIGN_FUNCTION();						\
+	. = ALIGN(32);							\
 	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;			\
 	*(.hyp.idmap.text)						\
 	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
@@ -315,3 +315,8 @@ SECTIONS
  */
 ASSERT((__proc_info_end - __proc_info_begin), "missing CPU support")
 ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
+/*
+ * The HYP init code can't be more than a page long.
+ * The above comment applies as well.
+ */
+ASSERT(((__hyp_idmap_text_end - __hyp_idmap_text_start) <= PAGE_SIZE), "HYP init code too big")
-- 
1.7.9.5
