From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 12 Dec 2015 22:43:05 +0100
Subject: [PATCH] fixup! pinctrl: pxa: pxa2xx: add pin control skeleton
Message-ID: <1449956585-17118-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wrong free functions were used to release temporary buffers.

This didn't show up in the normal driver's life. Yet in suspend to RAM,
the managed resource list is walked, and as memory was released, the
list is corrupted and make the kernel Oops.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Linus, if it's time, then this can fixup the commit. If not, I'll
provide a better commit message.
---
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
index e01914460219..d90e205cf809 100644
--- a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
@@ -292,7 +292,7 @@ static int pxa2xx_build_functions(struct pxa_pinctrl *pctl)
 	if (!pctl->functions)
 		return -ENOMEM;
 
-	kfree(functions);
+	devm_kfree(pctl->dev, functions);
 	return 0;
 }
 
@@ -328,7 +328,7 @@ static int pxa2xx_build_groups(struct pxa_pinctrl *pctl)
 		memcpy(func->groups, gtmp, ngroups * sizeof(*gtmp));
 	}
 
-	kfree(gtmp);
+	devm_kfree(pctl->dev, gtmp);
 	return 0;
 }
 
-- 
2.1.4
