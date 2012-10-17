From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 16:35:56 +0100
Subject: [RESEND PATCH 2/4] ARM: mm: don't use the access flag permissions
 mechanism for classic MMU
In-Reply-To: <1350488158-3399-1-git-send-email-will.deacon@arm.com>
References: <1350488158-3399-1-git-send-email-will.deacon@arm.com>
Message-ID: <1350488158-3399-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The simplified access permissions model is not used for the classic MMU
translation regime, so ensure that it is turned off in the sctlr prior
to turning on address translation for ARMv7.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/proc-v7-2level.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index fd045e7..e37600b 100644
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -161,11 +161,11 @@ ENDPROC(cpu_v7_set_pte_ext)
 	 *  TFR   EV X F   I D LR    S
 	 * .EEE ..EE PUI. .T.T 4RVI ZWRS BLDP WCAM
 	 * rxxx rrxx xxx0 0101 xxxx xxxx x111 xxxx < forced
-	 *    1    0 110       0011 1100 .111 1101 < we want
+	 *   01    0 110       0011 1100 .111 1101 < we want
 	 */
 	.align	2
 	.type	v7_crval, #object
 v7_crval:
-	crval	clear=0x0120c302, mmuset=0x10c03c7d, ucset=0x00c01c7c
+	crval	clear=0x2120c302, mmuset=0x10c03c7d, ucset=0x00c01c7c
 
 	.previous
-- 
1.7.4.1
