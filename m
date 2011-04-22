From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 21 Apr 2011 23:26:48 -0400
Subject: [PATCH 3/3] ARM: zImage: the page table memory must be considered
	before relocation
In-Reply-To: <1303442808-14275-2-git-send-email-nicolas.pitre@linaro.org>
References: <1303442808-14275-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1303442808-14275-3-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For correctness, the initial page table located right before the
decompressed kernel should be considered when determining if relocation
is required.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/boot/compressed/head.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 9169e79..83348f6 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -232,9 +232,10 @@ restart:	adr	r0, LC0
  *   r9  = size of decompressed image
  *   r10 = end of this image, including  bss/stack/malloc space if non XIP
  * We basically want:
- *   r4 >= r10 -> OK
+ *   r4 - 16k page directory >= r10 -> OK
  *   r4 + image length <= r5 -> OK
  */
+		add	r10, r10, #16384
 		cmp	r4, r10
 		bhs	wont_overwrite
 		add	r10, r4, r9
-- 
1.7.4
