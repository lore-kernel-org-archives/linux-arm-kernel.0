From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 23 Feb 2014 15:21:06 +0100
Subject: [PATCH v4 08/16] pinctrl: mvebu: armada-370: provide generic mpp
 callbacks
In-Reply-To: <1393165274-32492-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1392220776-30851-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393165274-32492-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1393165274-32492-9-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to get rid of passing register addresses to common pinctrl
driver, so provide set/get callbacks that use generic mpp pins helper
and will be used later.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Changelog:
v3->v4:
- use generic mpp helpers (Suggested by Thomas Petazzoni)

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/pinctrl/mvebu/pinctrl-armada-370.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index ae1f760cbdd2..fc3162ca48c0 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -23,6 +23,18 @@
 
 #include "pinctrl-mvebu.h"
 
+static void __iomem *mpp_base;
+
+static int armada_370_mpp_ctrl_get(unsigned pid, unsigned long *config)
+{
+	return default_mpp_ctrl_get(mpp_base, pid, config);
+}
+
+static int armada_370_mpp_ctrl_set(unsigned pid, unsigned long config)
+{
+	return default_mpp_ctrl_set(mpp_base, pid, config);
+}
+
 static struct mvebu_mpp_mode mv88f6710_mpp_modes[] = {
 	MPP_MODE(0,
 	   MPP_FUNCTION(0x0, "gpio", NULL),
-- 
1.8.5.3
