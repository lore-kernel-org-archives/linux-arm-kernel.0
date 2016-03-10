From: stefan@agner.ch (Stefan Agner)
Date: Wed,  9 Mar 2016 18:16:59 -0800
Subject: [PATCH 18/18] ARM: vf610: PM: enable SNVS access
In-Reply-To: <1457576219-7971-1-git-send-email-stefan@agner.ch>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
Message-ID: <1457576219-7971-19-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Restore access to SNVS which seems to be done by the boot ROM
on normal boot. This is required for RTC wakeup not ending up
in a interrupt storm, since the SNVS RTC driver can not
acknowledge the wakeup alarm without write access.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mach-imx/suspend-vf610.S | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-imx/suspend-vf610.S b/arch/arm/mach-imx/suspend-vf610.S
index 09ad246..6df0622 100644
--- a/arch/arm/mach-imx/suspend-vf610.S
+++ b/arch/arm/mach-imx/suspend-vf610.S
@@ -429,6 +429,17 @@ ddrmc_initializing:
 	ldr	r5, =0x0
 	str	r5, [r11, #VF610_GPC_LPMR]
 
+	/* Enable SNVS */
+	ldr	r3, [r0, #PM_INFO_VF610_CCM_P_OFFSET]
+	ldr	r4, [r3, #VF610_CCM_CCGR6]
+	orr	r4, r4, #0x0000C000
+	str	r4, [r3, #VF610_CCM_CCGR6]
+
+	/* Enable SNVS access (RTC) */
+	ldr	r11, =0x400a7000
+	ldr	r4, =0x80000100
+	str	r4, [r11, #0x4]
+
 	/* get physical resume address from pm_info. */
 	ldr	lr, [r0, #PM_INFO_RESUME_ADDR_OFFSET]
 
-- 
2.7.2
