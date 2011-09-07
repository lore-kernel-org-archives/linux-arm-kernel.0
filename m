From: dave.martin@linaro.org (Dave Martin)
Date: Wed,  7 Sep 2011 16:59:18 +0100
Subject: [RFC PATCH 3/3] ARM: pxa/pj4: Port problematic pj4 support code to
	v7/Thumb-2
In-Reply-To: <1315411158-17479-1-git-send-email-dave.martin@linaro.org>
References: <1315411158-17479-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1315411158-17479-4-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The iwmmxt code contains some code to implement a pseudo-ISB, but
this is not buildable for Thumb-2.

This patch replaces the pseudo-ISB with a real one on v7 and above.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/kernel/pj4-cp0.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/pj4-cp0.c b/arch/arm/kernel/pj4-cp0.c
index a4b1b07..5117d9d 100644
--- a/arch/arm/kernel/pj4-cp0.c
+++ b/arch/arm/kernel/pj4-cp0.c
@@ -66,9 +66,13 @@ static void __init pj4_cp_access_write(u32 value)
 
 	__asm__ __volatile__ (
 		"mcr	p15, 0, %1, c1, c0, 2\n\t"
+#ifdef __LINUX_ARM_ARCH__ >= 7
+		"isb\n\t"
+#else
 		"mrc	p15, 0, %0, c1, c0, 2\n\t"
 		"mov	%0, %0\n\t"
 		"sub	pc, pc, #4\n\t"
+#endif
 		: "=r" (temp) : "r" (value));
 }
 
-- 
1.7.4.1
