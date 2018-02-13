From: mmayer@broadcom.com (Markus Mayer)
Date: Tue, 13 Feb 2018 12:40:38 -0800
Subject: [PATCH 1/3] memory: brcmstb: dpfe: properly mask vendor error bits
In-Reply-To: <1518554440-21805-1-git-send-email-mmayer@broadcom.com>
References: <1518554440-21805-1-git-send-email-mmayer@broadcom.com>
Message-ID: <1518554440-21805-2-git-send-email-mmayer@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We were printing the entire 32 bit register rather than just the lower
8 bits. Anything above bit 7 is reserved and may be any random value.

Fixes: 2f330caff577 ("memory: brcmstb: Add driver for DPFE")
Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 0a7bdbed3a6f..088153760e52 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -603,7 +603,8 @@ static ssize_t show_vendor(struct device *dev, struct device_attribute *devattr,
 		       readl_relaxed(info + DRAM_VENDOR_MR6) & DRAM_VENDOR_MASK,
 		       readl_relaxed(info + DRAM_VENDOR_MR7) & DRAM_VENDOR_MASK,
 		       readl_relaxed(info + DRAM_VENDOR_MR8) & DRAM_VENDOR_MASK,
-		       readl_relaxed(info + DRAM_VENDOR_ERROR));
+		       readl_relaxed(info + DRAM_VENDOR_ERROR) &
+				     DRAM_VENDOR_MASK);
 }
 
 static int brcmstb_dpfe_resume(struct platform_device *pdev)
-- 
2.7.4
