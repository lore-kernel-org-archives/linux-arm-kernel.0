From: ebiggers3@gmail.com (Eric Biggers)
Date: Tue, 17 Jul 2018 10:09:26 -0700
Subject: [PATCH] crypto: arm64/sha256 - increase cra_priority of scalar
 implementations
Message-ID: <20180717170926.90689-1-ebiggers3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Biggers <ebiggers@google.com>

Commit b73b7ac0a774 ("crypto: sha256_generic - add cra_priority") gave
sha256-generic and sha224-generic a cra_priority of 100, to match the
convention for generic implementations.  But sha256-arm64 and
sha224-arm64 also have priority 100, so their order relative to the
generic implementations became ambiguous.

Therefore, increase their priority to 125 so that they have higher
priority than the generic implementations but lower priority than the
NEON implementations which have priority 150.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm64/crypto/sha256-glue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/crypto/sha256-glue.c b/arch/arm64/crypto/sha256-glue.c
index f1b4f4420ca1..4aedeaefd61f 100644
--- a/arch/arm64/crypto/sha256-glue.c
+++ b/arch/arm64/crypto/sha256-glue.c
@@ -67,7 +67,7 @@ static struct shash_alg algs[] = { {
 	.descsize		= sizeof(struct sha256_state),
 	.base.cra_name		= "sha256",
 	.base.cra_driver_name	= "sha256-arm64",
-	.base.cra_priority	= 100,
+	.base.cra_priority	= 125,
 	.base.cra_blocksize	= SHA256_BLOCK_SIZE,
 	.base.cra_module	= THIS_MODULE,
 }, {
@@ -79,7 +79,7 @@ static struct shash_alg algs[] = { {
 	.descsize		= sizeof(struct sha256_state),
 	.base.cra_name		= "sha224",
 	.base.cra_driver_name	= "sha224-arm64",
-	.base.cra_priority	= 100,
+	.base.cra_priority	= 125,
 	.base.cra_blocksize	= SHA224_BLOCK_SIZE,
 	.base.cra_module	= THIS_MODULE,
 } };
-- 
2.18.0.203.gfac676dfb9-goog
