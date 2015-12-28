From: yalin.wang2010@gmail.com (yalin wang)
Date: Mon, 28 Dec 2015 15:07:35 +0800
Subject: [RFC] arm: change to use generic sign_extend32() function
Message-ID: <1451286455-13121-1-git-send-email-yalin.wang2010@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

change to use generic sign_extend32() to caaculate branch_displacement.

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 arch/arm/probes/decode-arm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/probes/decode-arm.c b/arch/arm/probes/decode-arm.c
index f72c33a..ff794c0 100644
--- a/arch/arm/probes/decode-arm.c
+++ b/arch/arm/probes/decode-arm.c
@@ -20,13 +20,12 @@
 #include <linux/module.h>
 #include <linux/stddef.h>
 #include <linux/ptrace.h>
+#include <linux/bitops.h>
 
 #include "decode.h"
 #include "decode-arm.h"
 
-#define sign_extend(x, signbit) ((x) | (0 - ((x) & (1 << (signbit)))))
-
-#define branch_displacement(insn) sign_extend(((insn) & 0xffffff) << 2, 25)
+#define branch_displacement(insn) sign_extend32(((insn) & 0xffffff) << 2, 25)
 
 /*
  * To avoid the complications of mimicing single-stepping on a
-- 
1.9.1
