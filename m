From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  9 Jan 2013 19:28:09 +0100
Subject: [PATCH] pinctrl: mvebu: Fix compiler warnings
Message-ID: <1357756089-6028-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

match->data is const void * where as dev.platform_data is just void *.
Add a cast to remove the const, which is causing the compiler warning:

drivers/pinctrl/mvebu/pinctrl-kirkwood.c:461:26: warning: assignment
discards 'const' qualifier from pointer target type

Dove has the exact same warning, so gets the same cast.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/pinctrl/mvebu/pinctrl-dove.c     |    2 +-
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index 40c9c3e..f2757df 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -588,7 +588,7 @@ static int __devinit dove_pinctrl_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match =
 		of_match_device(dove_pinctrl_of_match, &pdev->dev);
-	pdev->dev.platform_data = match->data;
+	pdev->dev.platform_data = (void *)match->data;
 
 	/*
 	 * General MPP Configuration Register is part of pdma registers.
diff --git a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
index fa6ce31..33b1c49 100644
--- a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
+++ b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
@@ -458,7 +458,7 @@ static int __devinit kirkwood_pinctrl_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match =
 		of_match_device(kirkwood_pinctrl_of_match, &pdev->dev);
-	pdev->dev.platform_data = match->data;
+	pdev->dev.platform_data = (void *)match->data;
 	return mvebu_pinctrl_probe(pdev);
 }
 
-- 
1.7.10.4
