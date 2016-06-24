From: amitoj1606@gmail.com (Amitoj Kaur Chawla)
Date: Fri, 24 Jun 2016 18:36:30 +0530
Subject: [PATCH] pinctrl: Add missing of_node_put
Message-ID: <20160624130630.GA11858@amitoj-Inspiron-3542>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_find_node_by_name does an of_node_get on its return value, 
so an of_node_put is needed on this value before the corresponding 
variable goes out of scope.

The Coccinelle semantic patch used to make this change is as follows:
@@
struct device_node *n;
struct device_node *n1;
statement S;
identifier f;
expression E;
constant C;
@@

n = of_find_node_by_name(...)
...
if (!n) S
... when != of_node_put(n)
    when != n1 = f(n,...)
    when != E = n
    when any
    when strict
(
+ of_node_put(n);
  return -C;
|
  of_node_put(n);
|
  n1 = f(n,...)
|
  E = n
|
  return ...;
)

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/pinctrl/sirf/pinctrl-atlas7.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-atlas7.c b/drivers/pinctrl/sirf/pinctrl-atlas7.c
index 3d233fc..7d9c1a3 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas7.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas7.c
@@ -5424,8 +5424,10 @@ static int atlas7_pinmux_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 	pmx->sys2pci_base = devm_ioremap_resource(&pdev->dev, &res);
-	if (IS_ERR(pmx->sys2pci_base))
+	if (IS_ERR(pmx->sys2pci_base)) {
+		of_node_put(sys2pci_np);
 		return -ENOMEM;
+	}
 
 	pmx->dev = &pdev->dev;
 
-- 
1.9.1
