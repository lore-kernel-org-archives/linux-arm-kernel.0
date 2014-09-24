From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Sep 2014 18:41:38 +0100
Subject: [PATCH v2] ARM: mm: clear SCTLR.HA instead of setting it for LPAE
Message-ID: <1411580498-17367-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SCTLR.HA (hardware access flag) is deprecated and not actually
implemented by any CPUs. Furthermore, it can confuse cr_alignment checks
where the whole value of SCTLR is compared against the value sitting in
the hardware, since the bit is actually RAZ/WI and will not match the
saved cr_alignment value.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---

v1 -> v2: Reword commit message

 arch/arm/mm/proc-v7-3level.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
index b64e67c7f176..d3daed0ae0ad 100644
--- a/arch/arm/mm/proc-v7-3level.S
+++ b/arch/arm/mm/proc-v7-3level.S
@@ -157,9 +157,9 @@ ENDPROC(cpu_v7_set_pte_ext)
 	 *  TFR   EV X F   IHD LR    S
 	 * .EEE ..EE PUI. .TAT 4RVI ZWRS BLDP WCAM
 	 * rxxx rrxx xxx0 0101 xxxx xxxx x111 xxxx < forced
-	 *   11    0 110    1  0011 1100 .111 1101 < we want
+	 *   11    0 110    0  0011 1100 .111 1101 < we want
 	 */
 	.align	2
 	.type	v7_crval, #object
 v7_crval:
-	crval	clear=0x0120c302, mmuset=0x30c23c7d, ucset=0x00c01c7c
+	crval	clear=0x0122c302, mmuset=0x30c03c7d, ucset=0x00c01c7c
-- 
2.1.0
