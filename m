From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 26 Jul 2014 11:07:15 +0800
Subject: [PATCH] ARM: imx: fix TLB missing of IOMUXC base address during
 suspend
Message-ID: <1406344035-7836-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the suspend routine running in OCRAM puts DDR into self-refresh,
it will access IOMUXC block to float DDR IO for power saving.  A TLB
missing of IOMUXC base address may happen in this case, and triggers an
access to DDR, and thus hangs the system.

The failure is discovered by running suspend/resume on a Cubox-i board.
Though the issue is not Cubox-i specific, it can be hit the on the board
quite easily with the 3.15 or 3.16 kernel.

Fix the issue with a dummy access to IOMUXC block at the beginning of
suspend routine, so that the address translation can be filled into TLB
before DDR is put into self-refresh.

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
