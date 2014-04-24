From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 24 Apr 2014 17:40:18 +0100
Subject: [PATCH 4/4] ARM: vexpress/TC2: Convert OPP voltage to uV before
 storing
In-Reply-To: <1398357618-11050-1-git-send-email-pawel.moll@arm.com>
References: <1398357618-11050-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1398357618-11050-5-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Punit Agrawal <punit.agrawal@arm.com>

The SPC stores voltage in mV while the code assumes it was returning
uV. Convert the returned voltage to uV before storing. Also fix the
comment depicting voltage to uV.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mach-vexpress/spc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index c26ef5b..2c2754e 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -392,7 +392,7 @@ static irqreturn_t ve_spc_irq_handler(int irq, void *data)
  *  +--------------------------+
  *  | 31      20 | 19        0 |
  *  +--------------------------+
- *  |   u_volt   |  freq(kHz)  |
+ *  |   m_volt   |  freq(kHz)  |
  *  +--------------------------+
  */
 #define MULT_FACTOR	20
@@ -414,7 +414,7 @@ static int ve_spc_populate_opps(uint32_t cluster)
 		ret = ve_spc_read_sys_cfg(SYSCFG_SCC, off, &data);
 		if (!ret) {
 			opps->freq = (data & FREQ_MASK) * MULT_FACTOR;
-			opps->u_volt = data >> VOLT_SHIFT;
+			opps->u_volt = (data >> VOLT_SHIFT) * 1000;
 		} else {
 			break;
 		}
-- 
1.8.3.2
