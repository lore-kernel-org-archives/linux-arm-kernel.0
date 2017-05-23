From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 23 May 2017 20:41:40 +0200
Subject: [PATCH 2/3] pinctrl: samsung: Handle memory allocation failure during
 wakeup banks init
In-Reply-To: <20170523184141.24284-1-krzk@kernel.org>
References: <20170523184141.24284-1-krzk@kernel.org>
Message-ID: <20170523184141.24284-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check if kmemdup failed during wakeup banks initialization.  Otherwise
NULL pointer would be stored under "irq_chip" member of bank and later
dereferenced in interrupt handler.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index cdea07af308a..66122627b3ed 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -503,6 +503,8 @@ static int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 		if (match) {
 			irq_chip = kmemdup(match->data,
 				sizeof(*irq_chip), GFP_KERNEL);
+			if (!irq_chip)
+				return -ENOMEM;
 			wkup_np = np;
 			break;
 		}
-- 
2.9.3
