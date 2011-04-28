From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 28 Apr 2011 18:50:19 -0400
Subject: [PATCH 4/9] ARM: zImage: the page table memory must be considered
	before relocation
In-Reply-To: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
References: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
Message-ID: <1304031024-5121-5-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

For correctness, the initial page table located right before the
decompressed kernel should be considered when determining if relocation
is required.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/compressed/head.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 6dae179..4c50490 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -216,9 +216,10 @@ restart:	adr	r0, LC0
  *   r9  = size of decompressed image
  *   r10 = end of this image, including  bss/stack/malloc space if non XIP
  * We basically want:
- *   r4 >= r10 -> OK
+ *   r4 - 16k page directory >= r10 -> OK
  *   r4 + image length <= current position (pc) -> OK
  */
+		add	r10, r10, #16384
 		cmp	r4, r10
 		bhs	wont_overwrite
 		add	r10, r4, r9
-- 
1.7.4
