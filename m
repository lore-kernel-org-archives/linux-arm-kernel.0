From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Jun 2014 11:49:20 +0100
Subject: [PATCHv3 1/4] arm64: head.S: remove unnecessary function alignment
In-Reply-To: <1403174963-10730-1-git-send-email-mark.rutland@arm.com>
References: <1403174963-10730-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1403174963-10730-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently __turn_mmu_on is aligned to 64 bytes to ensure that it doesn't
span any page boundary, which simplifies the idmap and spares us
requiring an additional page table to map half of the function. In
keeping with other important requirements in architecture code, this
fact is undocumented.

Additionally, as the function consists of three instructions totalling
12 bytes with no literal pool data, a smaller alignment of 16 bytes
would be sufficient.

This patch reduces the alignment to 16 bytes and documents the
underlying reason for the alignment. This reduces the required alignment
of the entire .head.text section from 64 bytes to 16 bytes, though it
may still be aligned to a larger value depending on TEXT_OFFSET.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/kernel/head.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index a96d3a6..7ec7817 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -456,8 +456,13 @@ ENDPROC(__enable_mmu)
  *  x27 = *virtual* address to jump to upon completion
  *
  * other registers depend on the function called upon completion
+ *
+ * We align the entire function to the smallest power of two larger than it to
+ * ensure it fits within a single block map entry. Otherwise were PHYS_OFFSET
+ * close to the end of a 512MB or 1GB block we might require an additional
+ * table to map the entire function.
  */
-	.align	6
+	.align	4
 __turn_mmu_on:
 	msr	sctlr_el1, x0
 	isb
-- 
1.9.1
