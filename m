From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 9 Mar 2018 17:02:34 +0100
Subject: [PATCH v2 02/17 2/3] mfd: abx500-core: Improve two size
 determinations in abx500_register_ops()
In-Reply-To: <6c8ff539-9e9d-635b-22a8-df8100ac8156@users.sourceforge.net>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
 <6c8ff539-9e9d-635b-22a8-df8100ac8156@users.sourceforge.net>
Message-ID: <f91a55b5-c915-2fa2-6aba-b24c3950092e@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Mar 2018 12:46:47 +0100

Replace the specification of two data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

 drivers/mfd/abx500-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/abx500-core.c b/drivers/mfd/abx500-core.c
index c8c9d41abcaa..17176e91cbd0 100644
--- a/drivers/mfd/abx500-core.c
+++ b/drivers/mfd/abx500-core.c
@@ -37,14 +37,12 @@ int abx500_register_ops(struct device *dev, struct abx500_ops *ops)
 {
 	struct abx500_device_entry *dev_entry;
 
-	dev_entry = devm_kzalloc(dev,
-				 sizeof(struct abx500_device_entry),
-				 GFP_KERNEL);
+	dev_entry = devm_kzalloc(dev, sizeof(*dev_entry), GFP_KERNEL);
 	if (!dev_entry)
 		return -ENOMEM;
 
 	dev_entry->dev = dev;
-	memcpy(&dev_entry->ops, ops, sizeof(struct abx500_ops));
+	memcpy(&dev_entry->ops, ops, sizeof(*ops));
 
 	list_add_tail(&dev_entry->list, &abx500_list);
 	return 0;
-- 
2.16.2
