From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Tue, 29 Jul 2014 06:55:30 +0000
Subject: [PATCH] ARM: imx: fix TLB missing of IOMUXC base address during
 suspend
In-Reply-To: <1406344035-7836-1-git-send-email-shawn.guo@freescale.com>
References: <1406344035-7836-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <c7eb55963a674527bd5d95791f1f4e56@BN1PR0301MB0628.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked.

-----Original Message-----
From: Shawn Guo [mailto:shawn.guo at freescale.com] 
Sent: 2014-07-26 11:07 AM
To: linux-arm-kernel at lists.infradead.org
Cc: Russell King; Huang Yongcai-B20788; kernel at pengutronix.de; Guo Shawn-R65073; stable at vger.kernel.org
Subject: [PATCH] ARM: imx: fix TLB missing of IOMUXC base address during suspend

After the suspend routine running in OCRAM puts DDR into self-refresh, it will access IOMUXC block to float DDR IO for power saving.  A TLB missing of IOMUXC base address may happen in this case, and triggers an access to DDR, and thus hangs the system.

The failure is discovered by running suspend/resume on a Cubox-i board.
Though the issue is not Cubox-i specific, it can be hit the on the board quite easily with the 3.15 or 3.16 kernel.

Fix the issue with a dummy access to IOMUXC block at the beginning of suspend routine, so that the address translation can be filled into TLB before DDR is put into self-refresh.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
Cc: <stable@vger.kernel.org>
---
 arch/arm/mach-imx/suspend-imx6.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
index fe123b079c05..87bdf7a629a5 100644
--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -172,6 +172,8 @@ ENTRY(imx6_suspend)
 	ldr	r6, [r11, #0x0]
 	ldr	r11, [r0, #PM_INFO_MX6Q_GPC_V_OFFSET]
 	ldr	r6, [r11, #0x0]
+	ldr	r11, [r0, #PM_INFO_MX6Q_IOMUXC_V_OFFSET]
+	ldr	r6, [r11, #0x0]
 
 	/* use r11 to store the IO address */
 	ldr	r11, [r0, #PM_INFO_MX6Q_SRC_V_OFFSET]
--
1.9.1
