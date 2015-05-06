From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  6 May 2015 15:54:32 +0200
Subject: [PATCH bugfix 2/2] crypto: arm64/sha2-ce - prevent asm code
 finalization in final() path
In-Reply-To: <1430920472-20416-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1430920472-20416-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1430920472-20416-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that the asm code finalization path is not triggered when
invoked via final(), since it already takes care of that itself.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/sha2-ce-glue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/crypto/sha2-ce-glue.c b/arch/arm64/crypto/sha2-ce-glue.c
index 1340e44c048b..7cd587564a41 100644
--- a/arch/arm64/crypto/sha2-ce-glue.c
+++ b/arch/arm64/crypto/sha2-ce-glue.c
@@ -75,6 +75,9 @@ static int sha256_ce_finup(struct shash_desc *desc, const u8 *data,
 
 static int sha256_ce_final(struct shash_desc *desc, u8 *out)
 {
+	struct sha256_ce_state *sctx = shash_desc_ctx(desc);
+
+	sctx->finalize = 0;
 	kernel_neon_begin_partial(28);
 	sha256_base_do_finalize(desc, (sha256_block_fn *)sha2_ce_transform);
 	kernel_neon_end();
-- 
1.9.1
