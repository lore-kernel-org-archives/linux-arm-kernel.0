From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Sat, 12 Dec 2009 17:48:43 +0100
Subject: [PATCH 1/4] mfd: mc13783: Take care of semantic inversion between
	read and write value of two bits in POWER_MISCELLANEUS register.
In-Reply-To: <1260635829.2054.16.camel@climbing-alby>
References: <1260635829.2054.16.camel@climbing-alby>
Message-ID: <1260636523.2054.28.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MC13783_REGCTRL_PWGTnSPIEN controls the states of the corresponding
PWGTn_DRV output.
Reading 1 on the corresponding bit mean that the output is enabled
Writing 1 on the corresponding bit disable that output!

So, if not asked directly to modify those bits, write the inverted
value.

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
 drivers/mfd/mc13783-core.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/mc13783-core.c b/drivers/mfd/mc13783-core.c
index a1ade23..aa1f79a 100644
--- a/drivers/mfd/mc13783-core.c
+++ b/drivers/mfd/mc13783-core.c
@@ -207,6 +207,9 @@ int mc13783_reg_write(struct mc13783 *mc13783, unsigned int offset, u32 val)
 }
 EXPORT_SYMBOL(mc13783_reg_write);
 
+#define MC13783_REG_POWER_MISCELLANEOUS	34
+#define MC13783_REGCTRL_PWGT1SPIEN	(1 << 15)
+#define MC13783_REGCTRL_PWGT2SPIEN	(1 << 16)
 int mc13783_reg_rmw(struct mc13783 *mc13783, unsigned int offset,
 		u32 mask, u32 val)
 {
@@ -221,6 +225,14 @@ int mc13783_reg_rmw(struct mc13783 *mc13783, unsigned int offset,
 
 	valread = (valread & ~mask) | val;
 
+	if ((offset == MC13783_REG_POWER_MISCELLANEOUS) &&
+	   !(mask & MC13783_REGCTRL_PWGT1SPIEN))
+		valread ^= MC13783_REGCTRL_PWGT1SPIEN;
+
+	if ((offset == MC13783_REG_POWER_MISCELLANEOUS) &&
+	   !(mask & MC13783_REGCTRL_PWGT2SPIEN))
+		valread ^= MC13783_REGCTRL_PWGT2SPIEN;
+
 	return mc13783_reg_write(mc13783, offset, valread);
 }
 EXPORT_SYMBOL(mc13783_reg_rmw);
-- 
1.6.3.3
