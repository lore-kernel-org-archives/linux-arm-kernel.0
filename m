From: geoff@infradead.org (Geoff Levand)
Date: Tue, 09 Sep 2014 22:49:04 +0000
Subject: [PATCH 01/13] arm64: Add ESR_EL2_EC macros to hyp-stub
In-Reply-To: <cover.1410302383.git.geoff@infradead.org>
References: <cover.1410302383.git.geoff@infradead.org>
Message-ID: <5e1b1892eb3ecc3bccff47766675c24c650a1a14.1410302383.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To improve the readability of the el1_sync routine in hyp-stub.S replace the
numeric immediate values with preprocessor macros ESR_EL2_EC_SHIFT and
ESR_EL2_EC_HVC64.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/kernel/hyp-stub.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index a272f33..2d960a9 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -52,10 +52,13 @@ ENDPROC(__hyp_stub_vectors)
 
 	.align 11
 
+#define ESR_EL2_EC_SHIFT	26
+#define ESR_EL2_EC_HVC64	0x16
+
 el1_sync:
 	mrs	x1, esr_el2
-	lsr	x1, x1, #26
-	cmp	x1, #0x16
+	lsr	x1, x1, #ESR_EL2_EC_SHIFT
+	cmp	x1, #ESR_EL2_EC_HVC64
 	b.ne	2f				// Not an HVC trap
 	cbz	x0, 1f
 	msr	vbar_el2, x0			// Set vbar_el2
-- 
1.9.1
