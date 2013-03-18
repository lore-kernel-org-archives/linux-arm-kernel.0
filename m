From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 18 Mar 2013 22:31:54 +0100
Subject: [PATCH 5/6] pinctrl: samsung: Handle banks with two configuration
 registers
In-Reply-To: <1363642315-10331-1-git-send-email-tomasz.figa@gmail.com>
References: <1363642315-10331-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1363642315-10331-6-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for banks that have more than one function
configuration registers, e.g. some of the banks of S3C64xx SoCs.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/pinctrl/pinctrl-samsung.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index 45a9939..b738b7b 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -303,6 +303,11 @@ static void samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
 		type = bank->type;
 		mask = (1 << type->fld_width[PINCFG_TYPE_FUNC]) - 1;
 		shift = pin_offset * type->fld_width[PINCFG_TYPE_FUNC];
+		if (shift >= 32) {
+			/* Some banks have two config registers */
+			shift -= 32;
+			reg += 4;
+		}
 
 		spin_lock_irqsave(&bank->slock, flags);
 
@@ -356,6 +361,11 @@ static int samsung_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
 
 	mask = (1 << type->fld_width[PINCFG_TYPE_FUNC]) - 1;
 	shift = pin_offset * type->fld_width[PINCFG_TYPE_FUNC];
+	if (shift >= 32) {
+		/* Some banks have two config registers */
+		shift -= 32;
+		reg += 4;
+	}
 
 	spin_lock_irqsave(&bank->slock, flags);
 
-- 
1.8.1.5
