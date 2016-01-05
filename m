From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  5 Jan 2016 10:18:52 +0100
Subject: [PATCH v2 2/2] arm64/module: avoid undefines shift behavior in
 reloc_data()
In-Reply-To: <1451985532-6487-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1451985532-6487-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1451985532-6487-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compilers may engage the improbability drive when encountering shifts
by a distance that is a multiple of the size of the operand type. Since
the required bounds check is very simple here, we can get rid of all the
fuzzy masking, shifting and comparing, and use the documented bounds
directly.

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/module.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 400141549b28..2c26a2381acc 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -72,15 +72,18 @@ static u64 do_reloc(enum aarch64_reloc_op reloc_op, void *place, u64 val)
 
 static int reloc_data(enum aarch64_reloc_op op, void *place, u64 val, int len)
 {
-	u64 imm_mask = (1 << len) - 1;
 	s64 sval = do_reloc(op, place, val);
 
 	switch (len) {
 	case 16:
 		*(s16 *)place = sval;
+		if (sval < S16_MIN || sval > U16_MAX)
+			return -ERANGE;
 		break;
 	case 32:
 		*(s32 *)place = sval;
+		if (sval < S32_MIN || sval > U32_MAX)
+			return -ERANGE;
 		break;
 	case 64:
 		*(s64 *)place = sval;
@@ -89,21 +92,6 @@ static int reloc_data(enum aarch64_reloc_op op, void *place, u64 val, int len)
 		pr_err("Invalid length (%d) for data relocation\n", len);
 		return 0;
 	}
-
-	/*
-	 * Extract the upper value bits (including the sign bit) and
-	 * shift them to bit 0.
-	 */
-	sval = (s64)(sval & ~(imm_mask >> 1)) >> (len - 1);
-
-	/*
-	 * Overflow has occurred if the value is not representable in
-	 * len bits (i.e the bottom len bits are not sign-extended and
-	 * the top bits are not all zero).
-	 */
-	if ((u64)(sval + 1) > 2)
-		return -ERANGE;
-
 	return 0;
 }
 
-- 
2.5.0
