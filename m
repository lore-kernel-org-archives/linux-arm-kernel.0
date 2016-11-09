From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Wed, 9 Nov 2016 11:14:11 +0800
Subject: [v16, 6/7] base: soc: Check for NULL SoC device attributes
In-Reply-To: <1478661252-42439-1-git-send-email-yangbo.lu@nxp.com>
References: <1478661252-42439-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1478661252-42439-7-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

If soc_device_match() is used to check the value of a specific
attribute that is not present for the current SoC, the kernel crashes
with a NULL pointer dereference.

Fix this by explicitly checking for the absence of a needed property,
and considering this a non-match.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Changes for v16:
	- Added this patch
---
 drivers/base/soc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 0c5cf87..0e701e2 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -167,19 +167,23 @@ static int soc_device_match_one(struct device *dev, void *arg)
 	const struct soc_device_attribute *match = arg;
 
 	if (match->machine &&
-	    !glob_match(match->machine, soc_dev->attr->machine))
+	    (!soc_dev->attr->machine ||
+	     !glob_match(match->machine, soc_dev->attr->machine)))
 		return 0;
 
 	if (match->family &&
-	    !glob_match(match->family, soc_dev->attr->family))
+	    (!soc_dev->attr->family ||
+	     !glob_match(match->family, soc_dev->attr->family)))
 		return 0;
 
 	if (match->revision &&
-	    !glob_match(match->revision, soc_dev->attr->revision))
+	    (!soc_dev->attr->revision ||
+	     !glob_match(match->revision, soc_dev->attr->revision)))
 		return 0;
 
 	if (match->soc_id &&
-	    !glob_match(match->soc_id, soc_dev->attr->soc_id))
+	    (!soc_dev->attr->soc_id ||
+	     !glob_match(match->soc_id, soc_dev->attr->soc_id)))
 		return 0;
 
 	return 1;
-- 
2.1.0.27.g96db324
