From: davidb@codeaurora.org (David Brown)
Date: Tue, 12 Mar 2013 11:41:53 -0700
Subject: [PATCH v2 08/11] ssbi: Remove extraneous logging
In-Reply-To: <1363113716-25897-1-git-send-email-davidb@codeaurora.org>
References: <1362616187-21089-1-git-send-email-davidb@codeaurora.org>
 <1363113716-25897-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1363113716-25897-9-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove some unhelpful error logs.  This also removes the necessity of
having a pointer back to the struct device within the ssbi-specific
structure

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 drivers/ssbi/ssbi.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/ssbi/ssbi.c b/drivers/ssbi/ssbi.c
index 6878e55..b056a07 100644
--- a/drivers/ssbi/ssbi.c
+++ b/drivers/ssbi/ssbi.c
@@ -66,7 +66,6 @@
 #define SSBI_TIMEOUT_US			100
 
 struct msm_ssbi {
-	struct device		*dev;
 	struct device		*slave;
 	void __iomem		*base;
 	spinlock_t		lock;
@@ -108,8 +107,6 @@ static int ssbi_wait_mask(struct msm_ssbi *ssbi, u32 set_mask, u32 clr_mask)
 		udelay(1);
 	}
 
-	dev_err(ssbi->dev, "%s: timeout (status %x set_mask %x clr_mask %x)\n",
-		__func__, ssbi_readl(ssbi, SSBI2_STATUS), set_mask, clr_mask);
 	return -ETIMEDOUT;
 }
 
@@ -185,11 +182,8 @@ msm_ssbi_pa_transfer(struct msm_ssbi *ssbi, u32 cmd, u8 *data)
 	while (timeout--) {
 		rd_status = ssbi_readl(ssbi, SSBI_PA_RD_STATUS);
 
-		if (rd_status & SSBI_PA_RD_STATUS_TRANS_DENIED) {
-			dev_err(ssbi->dev, "%s: transaction denied (0x%x)\n",
-					__func__, rd_status);
+		if (rd_status & SSBI_PA_RD_STATUS_TRANS_DENIED)
 			return -EPERM;
-		}
 
 		if (rd_status & SSBI_PA_RD_STATUS_TRANS_DONE) {
 			if (data)
@@ -199,7 +193,6 @@ msm_ssbi_pa_transfer(struct msm_ssbi *ssbi, u32 cmd, u8 *data)
 		udelay(1);
 	}
 
-	dev_err(ssbi->dev, "%s: timeout, status 0x%x\n", __func__, rd_status);
 	return -ETIMEDOUT;
 }
 
@@ -248,9 +241,6 @@ int msm_ssbi_read(struct device *dev, u16 addr, u8 *buf, int len)
 	unsigned long flags;
 	int ret;
 
-	if (ssbi->dev != dev)
-		return -ENXIO;
-
 	spin_lock_irqsave(&ssbi->lock, flags);
 	ret = ssbi->read(ssbi, addr, buf, len);
 	spin_unlock_irqrestore(&ssbi->lock, flags);
@@ -265,9 +255,6 @@ int msm_ssbi_write(struct device *dev, u16 addr, u8 *buf, int len)
 	unsigned long flags;
 	int ret;
 
-	if (ssbi->dev != dev)
-		return -ENXIO;
-
 	spin_lock_irqsave(&ssbi->lock, flags);
 	ret = ssbi->write(ssbi, addr, buf, len);
 	spin_unlock_irqrestore(&ssbi->lock, flags);
@@ -303,7 +290,6 @@ static int msm_ssbi_probe(struct platform_device *pdev)
 		ret = -EINVAL;
 		goto err_ioremap;
 	}
-	ssbi->dev = &pdev->dev;
 	platform_set_drvdata(pdev, ssbi);
 
 	type = of_get_property(np, "qcom,controller-type", NULL);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
