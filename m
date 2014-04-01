From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  1 Apr 2014 15:47:39 +0200
Subject: [PATCH v3 7/7] arm64/crypto: add voluntary preemption to Crypto
 Extensions GHASH
In-Reply-To: <1396360059-31949-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1396360059-31949-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1396360059-31949-8-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Crypto Extensions based GHASH implementation uses the NEON register file,
and hence runs with preemption disabled. This patch adds a TIF_NEED_RESCHED
check to its inner loop so we at least give up the CPU voluntarily when if we
are running in process context and have been tagged for preemption by the
scheduler.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/ghash-ce-core.S | 10 ++++++----
 arch/arm64/crypto/ghash-ce-glue.c | 33 +++++++++++++++++++++++++--------
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/crypto/ghash-ce-core.S b/arch/arm64/crypto/ghash-ce-core.S
index 1ca719ce9323..14240c6dc343 100644
--- a/arch/arm64/crypto/ghash-ce-core.S
+++ b/arch/arm64/crypto/ghash-ce-core.S
@@ -32,8 +32,9 @@
 	.align		3
 
 	/*
-	 * void pmull_ghash_update(int blocks, u64 dg[], const char *src,
-	 *			   struct ghash_key const *k, const char *head)
+	 * int pmull_ghash_update(int blocks, u64 dg[], const char *src,
+	 *			  struct ghash_key const *k, const char *head,
+	 * 			  struct thread_info *ti)
 	 */
 ENTRY(pmull_ghash_update)
 	ld1		{DATA.16b}, [x1]
@@ -89,8 +90,9 @@ CPU_LE(	rev64		IN1.16b, IN1.16b	)
 	eor		T1.16b, T1.16b, T2.16b
 	eor		DATA.16b, DATA.16b, T1.16b
 
-	cbnz		w0, 0b
+	cbz		w0, 2f
+	b_if_no_resched	x5, x7, 0b
 
-	st1		{DATA.16b}, [x1]
+2:	st1		{DATA.16b}, [x1]
 	ret
 ENDPROC(pmull_ghash_update)
diff --git a/arch/arm64/crypto/ghash-ce-glue.c b/arch/arm64/crypto/ghash-ce-glue.c
index b92baf3f68c7..4df64832617d 100644
--- a/arch/arm64/crypto/ghash-ce-glue.c
+++ b/arch/arm64/crypto/ghash-ce-glue.c
@@ -33,8 +33,9 @@ struct ghash_desc_ctx {
 	u32 count;
 };
 
-asmlinkage void pmull_ghash_update(int blocks, u64 dg[], const char *src,
-				   struct ghash_key const *k, const char *head);
+asmlinkage int pmull_ghash_update(int blocks, u64 dg[], const char *src,
+				  struct ghash_key const *k, const char *head,
+				  struct thread_info *ti);
 
 static int ghash_init(struct shash_desc *desc)
 {
@@ -54,6 +55,7 @@ static int ghash_update(struct shash_desc *desc, const u8 *src,
 
 	if ((partial + len) >= GHASH_BLOCK_SIZE) {
 		struct ghash_key *key = crypto_shash_ctx(desc->tfm);
+		struct thread_info *ti = NULL;
 		int blocks;
 
 		if (partial) {
@@ -64,14 +66,29 @@ static int ghash_update(struct shash_desc *desc, const u8 *src,
 			len -= p;
 		}
 
+		/*
+		 * Pass current's thread info pointer to pmull_ghash_update()
+		 * below if we want it to play nice under preemption.
+		 */
+		if ((IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY) ||
+		     IS_ENABLED(CONFIG_PREEMPT)) && !in_interrupt())
+			ti = current_thread_info();
+
 		blocks = len / GHASH_BLOCK_SIZE;
 		len %= GHASH_BLOCK_SIZE;
 
-		kernel_neon_begin_partial(6);
-		pmull_ghash_update(blocks, ctx->digest, src, key,
-				   partial ? ctx->buf : NULL);
-		kernel_neon_end();
-		src += blocks * GHASH_BLOCK_SIZE;
+		do {
+			int rem;
+
+			kernel_neon_begin_partial(6);
+			rem = pmull_ghash_update(blocks, ctx->digest, src, key,
+						 partial ? ctx->buf : NULL, ti);
+			kernel_neon_end();
+
+			src += (blocks - rem) * GHASH_BLOCK_SIZE;
+			blocks = rem;
+			partial = 0;
+		} while (unlikely(ti && blocks > 0));
 	}
 	if (len)
 		memcpy(ctx->buf + partial, src, len);
@@ -89,7 +106,7 @@ static int ghash_final(struct shash_desc *desc, u8 *dst)
 		memset(ctx->buf + partial, 0, GHASH_BLOCK_SIZE - partial);
 
 		kernel_neon_begin_partial(6);
-		pmull_ghash_update(1, ctx->digest, ctx->buf, key, NULL);
+		pmull_ghash_update(1, ctx->digest, ctx->buf, key, NULL, NULL);
 		kernel_neon_end();
 	}
 	put_unaligned_be64(ctx->digest[1], dst);
-- 
1.8.3.2
