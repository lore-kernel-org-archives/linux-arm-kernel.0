From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Thu, 23 Aug 2018 20:07:06 -0500
Subject: [PATCH] memory: atmel-ebi: Use struct_size() in devm_kzalloc()
Message-ID: <20180824010706.GA25522@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
	int stuff;
        void *entry[];
};

instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/memory/atmel-ebi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index b907865..c3748b4 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -327,8 +327,7 @@ static int atmel_ebi_dev_setup(struct atmel_ebi *ebi, struct device_node *np,
 		return -EINVAL;
 	}
 
-	ebid = devm_kzalloc(ebi->dev,
-			    sizeof(*ebid) + (numcs * sizeof(*ebid->configs)),
+	ebid = devm_kzalloc(ebi->dev, struct_size(ebid, configs, numcs),
 			    GFP_KERNEL);
 	if (!ebid)
 		return -ENOMEM;
-- 
2.7.4
