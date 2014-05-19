From: ritesh.harjani@gmail.com (ritesh.harjani at gmail.com)
Date: Mon, 19 May 2014 16:04:25 +0530
Subject: [PATCH 1/1] arm64: TLB maintainance: Implement flush_kern_tlb_page
In-Reply-To: <1400495665-48279-1-git-send-email-ritesh.harjani@gmail.com>
References: <1400495665-48279-1-git-send-email-ritesh.harjani@gmail.com>
Message-ID: <1400495665-48279-2-git-send-email-ritesh.harjani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ritesh Harjani <ritesh.harjani@gmail.com>

Implement flush_kern_tlb_page mentioned in the header
comment of arch/arm64/include/asm/tlbflush.h

Signed-off-by: Ritesh Harjani <ritesh.harjani@gmail.com>
---
 arch/arm64/include/asm/tlbflush.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 8b48203..92d0588 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -98,6 +98,16 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
 	dsb();
 }
 
+static inline void flush_kern_tlb_page(unsigned long kaddr)
+{
+	unsigned long addr = kaddr >> 12;
+
+	dsb();
+	asm("tlbi	vae1is, %0" : : "r" (addr));
+	dsb();
+	isb();
+}
+
 /*
  * Convert calls to our calling convention.
  */
-- 
1.8.1.3
