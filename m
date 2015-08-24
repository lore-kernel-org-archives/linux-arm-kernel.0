From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Mon, 24 Aug 2015 23:12:27 +0200
Subject: [PATCH 2/2] pinctrl: digicolor: convert null test to IS_ERR test
In-Reply-To: <1440450747-10080-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1440450747-10080-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1440450747-10080-3-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 323de9efdf3e ("pinctrl: make pinctrl_register() return proper
error code"), pinctrl_register returns an error code rather than NULL on
failure.  Update a driver that was introduced more recently.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e,e1,e2;
@@

e = pinctrl_register(...)
... when != e = e1
if (
-   e == NULL
+   IS_ERR(e)
   ) {
     ...
     return
-      e2
+      PTR_ERR(e)
     ;
     }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/pinctrl/pinctrl-digicolor.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-digicolor.c b/drivers/pinctrl/pinctrl-digicolor.c
index 461fffc..11f8b83 100644
--- a/drivers/pinctrl/pinctrl-digicolor.c
+++ b/drivers/pinctrl/pinctrl-digicolor.c
@@ -337,9 +337,9 @@ static int dc_pinctrl_probe(struct platform_device *pdev)
 	pmap->dev = &pdev->dev;
 
 	pmap->pctl = pinctrl_register(pctl_desc, &pdev->dev, pmap);
-	if (!pmap->pctl) {
+	if (IS_ERR(pmap->pctl)) {
 		dev_err(&pdev->dev, "pinctrl driver registration failed\n");
-		return -EINVAL;
+		return PTR_ERR(pmap->pctl);
 	}
 
 	ret = dc_gpiochip_add(pmap, pdev->dev.of_node);
