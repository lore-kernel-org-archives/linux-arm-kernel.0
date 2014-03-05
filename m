From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed,  5 Mar 2014 01:03:10 +0100
Subject: [PATCH 3/3] pinctrl: mvebu: silence WARN to dev_warn
In-Reply-To: <1393977790-29110-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1393977790-29110-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1393977790-29110-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pinctrl will WARN on missing DT resources, which is a little bit too
noisy. Use dev_warn with FW_BUG instead.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Jason Cooper <jason@lakedaemon.net> 
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree at vger.kernel.org 
Cc: linux-arm-kernel at lists.infradead.org 
Cc: linux-kernel at vger.kernel.org
---
 drivers/pinctrl/mvebu/pinctrl-dove.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index 9e7ff651c018..3b022178a566 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -832,7 +832,8 @@ static int dove_pinctrl_probe(struct platform_device *pdev)
 	}
 
 	/* Warn on any missing DT resource */
-	WARN(fb_res.start, FW_BUG "Missing pinctrl regs in DTB. Please update your firmware.\n");
+	if (fb_res.start)
+		dev_warn(&pdev->dev, FW_BUG "Missing pinctrl regs in DTB. Please update your firmware.\n");
 
 	return mvebu_pinctrl_probe(pdev);
 }
-- 
1.8.5.3
