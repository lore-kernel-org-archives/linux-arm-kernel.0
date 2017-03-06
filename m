From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  6 Mar 2017 14:24:55 +0000
Subject: [PATCH v3 22/25] ARM: decompressor: Remove __hyp_get_vectors usage
In-Reply-To: <20170306142458.8875-1-marc.zyngier@arm.com>
References: <20170306142458.8875-1-marc.zyngier@arm.com>
Message-ID: <20170306142458.8875-23-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/boot/compressed/head.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 9150f9732785..d58bb104c6e8 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -422,7 +422,10 @@ dtb_check_done:
 		cmp	r0, #HYP_MODE
 		bne	1f
 
-		bl	__hyp_get_vectors
+0:		adr	r0, 0b
+		movw	r1, #:lower16:__hyp_stub_vectors - 0b
+		movt	r1, #:upper16:__hyp_stub_vectors - 0b
+		add	r0, r0, r1
 		sub	r0, r0, r5
 		add	r0, r0, r10
 		bl	__hyp_set_vectors
-- 
2.11.0
