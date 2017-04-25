From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Tue, 25 Apr 2017 11:01:33 +0200
Subject: [PATCH 1/1] ARM: compressed/head.S: fix __nop macro rept number for
 ARMv7M
Message-ID: <1493110893-21857-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

In zImage, _magic_sig is located at offset 0x24.
But for ARMv7M architecture which enable CPU_THUMBONLY
and !EFI_STUB kernel flag, _magic_sig is located at offset 0x14

00000000  00 46 00 46 00 46 00 46  00 46 00 46 00 46 0f f2  |.F.F.F.F.F.F.F.?|
00000010  15 0c 60 47 18 28 6f 01  00 00 00 00 28 5c 0e 00  |..`G.(o.....(\..|
00000020  01 02 03 04 0f 46 90 46  00 00 00 00 00 00 00 00  |.....F.F........|

Reproduced with stm32_defconfig with XIP_KERNEL flag disabled.

To restore correct _magic_sig offset at 0x24, we add 8 additional
"mov r0, r0" instruction.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/compressed/head.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 9150f97..5d9cda3 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -127,7 +127,8 @@
  AR_CLASS(	.arm	)
 start:
 		.type	start,#function
-		.rept	7
+   ARM(		.rept	7)
+ THUMB(		.rept	15)
 		__nop
 		.endr
    ARM(		mov	r0, r0		)
-- 
1.9.1
