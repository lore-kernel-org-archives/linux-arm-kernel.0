From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon,  5 Dec 2011 10:27:42 -0800
Subject: [PATCHv3 3/2] ARM: msm: Drop useless teq from DEBUG_LL support
In-Reply-To: <4EB9FD65.3030900@codeaurora.org>
Message-ID: <1323109662-30614-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This teq was first introduced in bcc0f6a ([ARM] msm: clean up
iomap and devices, 2008-09-10). It seems that DEBUG_LL support on
MSM at the time had to remove the virtual mapping for the uart
base. Thus when the MMU was enabled the addruart macro returned 0
and the senduart macro would test for 0 and do nothing. It was a
simple way to turn off DEBUG_LL when the MMU was enabled.

The virtual mapping was added back in 6339f66 (msm: make
debugging UART (for DEBUG_LL) configurable, 2009-11-02) but the
patch forgot to remove the teq here. So as it stands the teq has
been useless for two years and DEBUG_LL works fine without it.

Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/debug-macro.S |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/debug-macro.S b/arch/arm/mach-msm/include/mach/debug-macro.S
index 3ffd866..0e05f88 100644
--- a/arch/arm/mach-msm/include/mach/debug-macro.S
+++ b/arch/arm/mach-msm/include/mach/debug-macro.S
@@ -30,8 +30,7 @@
 	@ Write the 1 character to UARTDM_TF
 	str	\rd, [\rx, #0x70]
 #else
-	teq	\rx, #0
-	strne	\rd, [\rx, #0x0C]
+	str	\rd, [\rx, #0x0C]
 #endif
 	.endm
 
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
