From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 26 Nov 2012 20:16:39 +0100
Subject: [PATCH v2 2/2] pinctrl: mvebu: make pdma clock on dove mandatory
In-Reply-To: <1353957399-28799-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1353921525-25163-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1353957399-28799-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1353957399-28799-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the ability to pass clocks through DT, now make the pdma
clock of dove pinctrl mandatory. Otherwise, pinctrl will hang
the system when accessing some registers.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
v1->v2:
- propagate error of devm_clk_get as suggested by Baruch Siach

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Axel Lin <axel.lin@ingics.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/pinctrl/mvebu/pinctrl-dove.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index 40c9c3e..9cc219f 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -595,8 +595,11 @@ static int __devinit dove_pinctrl_probe(struct platform_device *pdev)
 	 * grab clk to make sure it is ticking.
 	 */
 	clk = devm_clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(clk))
-		clk_prepare_enable(clk);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "Unable to get pdma clock");
+		return PTR_RET(clk);
+	}
+	clk_prepare_enable(clk);
 
 	return mvebu_pinctrl_probe(pdev);
 }
-- 
1.7.10.4
