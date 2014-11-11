From: joel.schopp@amd.com (Joel Schopp)
Date: Tue, 11 Nov 2014 01:32:04 -0500
Subject: [PATCH] efi-entry.S: add dsb and isb
Message-ID: <20141111063204.1506.57655.stgit@joelaarch64.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a dsb and isb after the instruction flush before the data cache and
mm offing.  Without this patch I am seeing synchronous exceptions occur
every few boots.

Signed-off-by: Joel Schopp <joel.schopp@amd.com>
Tested-by: Tom Lendacky <Thomas.Lendacky@amd.com>
---
 arch/arm64/kernel/efi-entry.S |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
index 619b1dd..7d95eda 100644
--- a/arch/arm64/kernel/efi-entry.S
+++ b/arch/arm64/kernel/efi-entry.S
@@ -76,6 +76,12 @@ ENTRY(efi_stub_entry)
 	bl	__flush_dcache_area
 	ic	ialluis
 
+	/* We need to sync again after the instruction cache sync
+	 * and before turning off the dcache and mmu
+	 */
+	dsb	sy
+	isb
+
 	/* Turn off Dcache and MMU */
 	mrs	x0, CurrentEL
 	cmp	x0, #CurrentEL_EL2
