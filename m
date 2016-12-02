From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri,  2 Dec 2016 15:05:28 +0000
Subject: [RFC v3 PATCH 10/25] ARM: NOMMU: implement secondary_startup_arm
In-Reply-To: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480691143-19845-11-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mediatek's and Qualcomm's platform code has reference to
secondary_startup_arm and that breaks NOMMU build.

Since head-nommu.S is common, we need to take extra care of M-class
platforms since there are no ARM instructions avaliable there. Even
though secondary_startup_arm is build it in SMP configuration only
(which is not supported by M-class) it'd be better to be on the safe
side and handle Thumb-only case there - keep in Thumb mode and fall
through to secondary_startup.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/kernel/head-nommu.S |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index ae80c71..f5bb554 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -88,7 +88,17 @@ ENTRY(stext)
 ENDPROC(stext)
 
 #ifdef CONFIG_SMP
-	.text
+#ifdef CONFIG_CPU_THUMBONLY
+	.thumb
+ENTRY(secondary_startup_arm)
+#else
+	.arm
+ENTRY(secondary_startup_arm)
+	THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
+	THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
+	THUMB(	.thumb			)	@ switch to Thumb now.
+	THUMB(1:			)
+#endif
 ENTRY(secondary_startup)
 	/*
 	 * Common entry point for secondary CPUs.
@@ -126,6 +136,7 @@ ENTRY(secondary_startup)
 	mov	fp, #0
 	b	secondary_start_kernel
 ENDPROC(secondary_startup)
+ENDPROC(secondary_startup_arm)
 
 	.type	__secondary_data, %object
 __secondary_data:
-- 
1.7.9.5
