From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 22 Jun 2018 17:14:16 +0200
Subject: [PATCH v3 01/17] platform-msi: allow creation of MSI domain without
 interrupt number
In-Reply-To: <20180622151432.1566-1-miquel.raynal@bootlin.com>
References: <20180622151432.1566-1-miquel.raynal@bootlin.com>
Message-ID: <20180622151432.1566-2-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_msi_alloc_priv_data() checks that a number of interrupts is
always given. This extra-check has no real impact and just prevents
uselessly the user to create an MSI tree domain: remove it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/base/platform-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 60d6cc618f1c..9f001f4ccc0f 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -203,7 +203,7 @@ platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
 	 * accordingly (which would impact the max number of MSI
 	 * capable devices).
 	 */
-	if (!dev->msi_domain || !write_msi_msg || !nvec || nvec > MAX_DEV_MSIS)
+	if (!dev->msi_domain || !write_msi_msg || nvec > MAX_DEV_MSIS)
 		return ERR_PTR(-EINVAL);
 
 	if (dev->msi_domain->bus_token != DOMAIN_BUS_PLATFORM_MSI) {
-- 
2.14.1
