From: dave.long@linaro.org (David Long)
Date: Mon, 29 Feb 2016 21:57:21 -0500
Subject: [PATCH v10 3/9] arm64: add copy_to/from_user to kprobes blacklist
In-Reply-To: <1456801047-29014-1-git-send-email-dave.long@linaro.org>
References: <1456801047-29014-1-git-send-email-dave.long@linaro.org>
Message-ID: <1456801047-29014-4-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "David A. Long" <dave.long@linaro.org>

Currrently taking exceptions when accessing user data from a kprobe'd
instruction doesn't work. Avoid this situation by blacklisting the relevant
functions.

Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm64/lib/copy_from_user.S | 1 +
 arch/arm64/lib/copy_to_user.S   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 4699cd7..0ac2131 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -66,6 +66,7 @@
 	.endm
 
 end	.req	x5
+	.section .kprobes.text,"ax",%progbits
 ENTRY(__copy_from_user)
 ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
 	    CONFIG_ARM64_PAN)
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index 7512bbb..e4eb84c 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -65,6 +65,7 @@
 	.endm
 
 end	.req	x5
+	.section .kprobes.text,"ax",%progbits
 ENTRY(__copy_to_user)
 ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
 	    CONFIG_ARM64_PAN)
-- 
2.5.0
