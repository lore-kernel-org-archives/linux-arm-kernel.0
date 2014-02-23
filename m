From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 23 Feb 2014 15:21:00 +0100
Subject: [PATCH v4 02/16] pinctrl: mvebu: remove obsolete per-control name
 buffer allocation
In-Reply-To: <1393165274-32492-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1392220776-30851-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393165274-32492-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1393165274-32492-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of a global name buffer, we can now remove
the allocation and preparation of per-control name buffers.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/pinctrl/mvebu/pinctrl-mvebu.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
index d47650fc5119..c0e27e4f8953 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
@@ -636,7 +636,6 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 	pctl->desc.npins = 0;
 	for (n = 0; n < soc->ncontrols; n++) {
 		struct mvebu_mpp_ctrl *ctrl = &soc->controls[n];
-		char *names;
 
 		pctl->desc.npins += ctrl->npins;
 		/* initial control pins */
@@ -654,14 +653,6 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 		}
 
 		/* generic mvebu register control */
-		names = devm_kzalloc(&pdev->dev, ctrl->npins * 8, GFP_KERNEL);
-		if (!names) {
-			dev_err(&pdev->dev, "failed to alloc mpp names\n");
-			return -ENOMEM;
-		}
-		for (k = 0; k < ctrl->npins; k++)
-			sprintf(names + 8*k, "mpp%d", ctrl->pid+k);
-		ctrl->name = names;
 		pctl->num_groups += ctrl->npins;
 		noname += ctrl->npins;
 	}
-- 
1.8.5.3
