From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:05:52 +0100
Subject: [PATCH 03/24] ARM: kprobes: Add BLX macro
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-4-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

This is for use by inline assembler which will be added to kprobes-arm.c
It saves memory when used on newer ARM architectures and also provides
correct interworking should ARM probes be required on Thumb kernels in
the future.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index ea96214..80a9411 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -67,6 +67,13 @@
 
 #define branch_displacement(insn) sign_extend(((insn) & 0xffffff) << 2, 25)
 
+#if  __LINUX_ARM_ARCH__ >= 6
+#define BLX(reg)	"blx	"reg"		\n\t"
+#else
+#define BLX(reg)	"mov	lr, pc		\n\t"	\
+			"mov	pc, "reg"	\n\t"
+#endif
+
 #define is_r15(insn, bitpos) (((insn) & (0xf << bitpos)) == (0xf << bitpos))
 
 #define PSR_fs	(PSR_f|PSR_s)
-- 
1.7.2.5
