From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 5 Aug 2016 13:26:11 +0200 (CEST)
Subject: [PATCH 03/11 v2] pinctrl: nomadik: use of_property_read_bool
In-Reply-To: <1470387411-15879-4-git-send-email-Julia.Lawall@lip6.fr>
References: <1470387411-15879-1-git-send-email-Julia.Lawall@lip6.fr>
 <1470387411-15879-4-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <alpine.DEB.2.10.1608051325350.2999@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use of_property_read_bool to check for the existence of a property.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e1,e2,x;
@@
-	if (of_get_property(e1,e2,NULL))
-		x = true;
-	else
-		x = false;
+	x = of_property_read_bool(e1,e2);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
v2: special case for propagating true and false

 drivers/pinctrl/nomadik/pinctrl-nomadik.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 35f6218..6f2e1da 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1110,10 +1110,8 @@ static int nmk_gpio_probe(struct platform_device *dev)
 		return PTR_ERR(nmk_chip);
 	}

-	if (of_get_property(np, "st,supports-sleepmode", NULL))
-		supports_sleepmode = true;
-	else
-		supports_sleepmode = false;
+	supports_sleepmode =
+		of_property_read_bool(np, "st,supports-sleepmode");

 	/* Correct platform device ID */
 	dev->id = nmk_chip->bank;
