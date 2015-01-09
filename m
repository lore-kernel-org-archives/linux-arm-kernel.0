From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 9 Jan 2015 14:51:37 +0800
Subject: [PATCH v19 08/11] ARM: kprobes: enable OPTPROBES for ARM 32
In-Reply-To: <1420457376-77366-1-git-send-email-wangnan0@huawei.com>
References: <1420457284-76923-1-git-send-email-wangnan0@huawei.com>
 <1420457376-77366-1-git-send-email-wangnan0@huawei.com>
Message-ID: <54AF7A79.20500@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tixy and other,

Similar to patch 01/11, build robot found a building error in this patch when ARM version
is lower than 4. In such processors 'blx' instruction is unusable.

I have posted a new version of this patch, which has following code change:

diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
index 6a60df3..cb47eff 100644
--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -58,7 +58,12 @@ asm (
 			 */
 			"	and	r4, sp, #4\n"
 			"	sub	sp, sp, r4\n"
+#if __LINUX_ARM_ARCH__ >= 5
 			"	blx	r2\n"
+#else
+			"	mov     lr, pc\n"
+			"	bx	r2\n"
+#endif
 			"	add	sp, sp, r4\n"
 			"	ldr	r1, [sp, #64]\n"
 			"	tst	r1, #"__stringify(PSR_T_BIT)"\n"

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/314542.html

Tixy, could you please collect it into your repository and test again?

Thank you!
