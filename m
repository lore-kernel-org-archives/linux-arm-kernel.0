From: ada@thorsis.com (Alexander Dahl)
Date: Tue, 25 Jul 2017 14:00:23 +0200
Subject: [PATCH 2/3] memory: atmel-ebi: Allow t_DF timings of zero ns
In-Reply-To: <1500984024-26403-1-git-send-email-ada@thorsis.com>
References: <1500984024-26403-1-git-send-email-ada@thorsis.com>
Message-ID: <1500984024-26403-3-git-send-email-ada@thorsis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As reported in [1] and in [2] it's not possible to set the device tree
property 'atmel,smc-tdf-ns' to zero, although the SoC allows a setting
of 0ns for the t_DF time.

Allow this setting by doing the same thing as in the atmel nand
controller driver by setting ncycles to ATMEL_SMC_MODE_TDF_MIN if zero
is set in the dts.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/490966.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-July/520652.html

Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/memory/atmel-ebi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 1cf34d2..f8a01ae 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -120,12 +120,14 @@ static int atmel_ebi_xslate_smc_timings(struct atmel_ebi_dev *ebid,
 	if (!ret) {
 		required = true;
 		ncycles = DIV_ROUND_UP(val, clk_period_ns);
-		if (ncycles > ATMEL_SMC_MODE_TDF_MAX ||
-		    ncycles < ATMEL_SMC_MODE_TDF_MIN) {
+		if (ncycles > ATMEL_SMC_MODE_TDF_MAX) {
 			ret = -EINVAL;
 			goto out;
 		}
 
+		if (ncycles < ATMEL_SMC_MODE_TDF_MIN)
+			ncycles = ATMEL_SMC_MODE_TDF_MIN;
+
 		smcconf->mode |= ATMEL_SMC_MODE_TDF(ncycles);
 	}
 
-- 
2.1.4
