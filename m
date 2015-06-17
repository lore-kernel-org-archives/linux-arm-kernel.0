From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 17 Jun 2015 09:45:41 +0200
Subject: [PATCH v6 13/14] crypto: marvell/CESA: add support for Kirkwood and
 Dove SoCs
In-Reply-To: <1434527142-3609-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1434527142-3609-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1434527142-3609-14-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnaud Ebalard <arno@natisbad.org>

Add the Kirkwood and Dove SoC descriptions, and control the allhwsupport
module parameter to avoid probing the CESA IP when the old CESA driver is
enabled (unless it is explicitly requested to do so).

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/crypto/marvell/cesa.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/cesa.c b/drivers/crypto/marvell/cesa.c
index 8e5ea72..a432633 100644
--- a/drivers/crypto/marvell/cesa.c
+++ b/drivers/crypto/marvell/cesa.c
@@ -215,6 +215,15 @@ static const struct mv_cesa_caps orion_caps = {
 	.has_tdma = false,
 };
 
+static const struct mv_cesa_caps kirkwood_caps = {
+	.nengines = 1,
+	.cipher_algs = orion_cipher_algs,
+	.ncipher_algs = ARRAY_SIZE(orion_cipher_algs),
+	.ahash_algs = orion_ahash_algs,
+	.nahash_algs = ARRAY_SIZE(orion_ahash_algs),
+	.has_tdma = true,
+};
+
 static const struct mv_cesa_caps armada_370_caps = {
 	.nengines = 1,
 	.cipher_algs = armada_370_cipher_algs,
@@ -235,6 +244,8 @@ static const struct mv_cesa_caps armada_xp_caps = {
 
 static const struct of_device_id mv_cesa_of_match_table[] = {
 	{ .compatible = "marvell,orion-crypto", .data = &orion_caps },
+	{ .compatible = "marvell,kirkwood-crypto", .data = &kirkwood_caps },
+	{ .compatible = "marvell,dove-crypto", .data = &kirkwood_caps },
 	{ .compatible = "marvell,armada-370-crypto", .data = &armada_370_caps },
 	{ .compatible = "marvell,armada-xp-crypto", .data = &armada_xp_caps },
 	{ .compatible = "marvell,armada-375-crypto", .data = &armada_xp_caps },
@@ -383,7 +394,7 @@ static int mv_cesa_probe(struct platform_device *pdev)
 		caps = match->data;
 	}
 
-	if (caps == &orion_caps && !allhwsupport)
+	if ((caps == &orion_caps || caps == &kirkwood_caps) && !allhwsupport)
 		return -ENOTSUPP;
 
 	cesa = devm_kzalloc(dev, sizeof(*cesa), GFP_KERNEL);
-- 
1.9.1
