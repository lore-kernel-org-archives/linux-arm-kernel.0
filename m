From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:09:14 +0200
Subject: [PULL 64/79] ARM: decompressor: Remove __hyp_get_vectors usage
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-65-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

When the compressed image needs to be relocated to avoid being
overwritten by the decompression process, we need to relocate
the hyp vectors as well so that we can find them once the
decompression has taken effect.

For that, we perform the following calculation:
	u32 v = __hyp_get_vectors();
	v += offset;
	__hyp_set_vectors(v);

But we're guaranteed that the initial value of v as returned by
__hyp_get_vectors is always __hyp_stub_vectors, because we have
just set it by calling __hyp_stub_install.

So let's remove the use of __hyp_get_vectors, and directly use
__hyp_stub_vectors instead.

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm/boot/compressed/head.S | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 9150f97..7c711ba 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -422,7 +422,17 @@ dtb_check_done:
 		cmp	r0, #HYP_MODE
 		bne	1f
 
-		bl	__hyp_get_vectors
+		/*
+		 * Compute the address of the hyp vectors after relocation.
+		 * This requires some arithmetic since we cannot directly
+		 * reference __hyp_stub_vectors in a PC-relative way.
+		 * Call __hyp_set_vectors with the new address so that we
+		 * can HVC again after the copy.
+		 */
+0:		adr	r0, 0b
+		movw	r1, #:lower16:__hyp_stub_vectors - 0b
+		movt	r1, #:upper16:__hyp_stub_vectors - 0b
+		add	r0, r0, r1
 		sub	r0, r0, r5
 		add	r0, r0, r10
 		bl	__hyp_set_vectors
-- 
2.9.0
