From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:56:57 +0000
Subject: [PATCH 26/35] mfd: ab8500-sysctrl: AB8505 doesn't have SYSCLKREQ5..8
In-Reply-To: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
References: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1360933026-30325-27-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

So we're removing support for it.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Tested-by: Marcus COOPER <marcus.xm.cooper@stericsson.com>
---
 drivers/mfd/ab8500-sysctrl.c |   37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index f43c42b..272479c 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -182,9 +182,9 @@ EXPORT_SYMBOL(ab8500_sysctrl_write);
 
 static int ab8500_sysctrl_probe(struct platform_device *pdev)
 {
+	struct ab8500 *ab8500 = dev_get_drvdata(pdev->dev.parent);
 	struct ab8500_platform_data *plat;
 	struct ab8500_sysctrl_platform_data *pdata;
-	int ret, i, j;
 
 	plat = dev_get_platdata(pdev->dev.parent);
 
@@ -196,20 +196,27 @@ static int ab8500_sysctrl_probe(struct platform_device *pdev)
 
 	pdata = plat->sysctrl;
 
-
-	for (i = AB8500_SYSCLKREQ1RFCLKBUF;
-	     i <= AB8500_SYSCLKREQ8RFCLKBUF; i++) {
-		j = i - AB8500_SYSCLKREQ1RFCLKBUF;
-		ret = ab8500_sysctrl_write(i, 0xff,
-				pdata->initial_req_buf_config[j]);
-		dev_dbg(&pdev->dev,
-				"Setting SysClkReq%dRfClkBuf 0x%X\n",
-				j + 1,
-				pdata->initial_req_buf_config[j]);
-		if (ret < 0) {
-			dev_err(&pdev->dev,
-				"unable to set sysClkReq%dRfClkBuf: "
-				"%d\n", j + 1, ret);
+	if (pdata) {
+		int last, ret, i, j;
+
+		if (is_ab8505(ab8500))
+			last = AB8500_SYSCLKREQ4RFCLKBUF;
+		else
+			last = AB8500_SYSCLKREQ8RFCLKBUF;
+
+		for (i = AB8500_SYSCLKREQ1RFCLKBUF; i <= last; i++) {
+			j = i - AB8500_SYSCLKREQ1RFCLKBUF;
+			ret = ab8500_sysctrl_write(i, 0xff,
+					pdata->initial_req_buf_config[j]);
+			dev_dbg(&pdev->dev,
+					"Setting SysClkReq%dRfClkBuf 0x%X\n",
+					j + 1,
+					pdata->initial_req_buf_config[j]);
+			if (ret < 0) {
+				dev_err(&pdev->dev,
+					"unable to set sysClkReq%dRfClkBuf: "
+					"%d\n", j + 1, ret);
+			}
 		}
 	}
 
-- 
1.7.10.4
