From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 17 May 2013 18:24:30 +0200
Subject: [PATCH 4/6] pinctrl: samsung: Add support for SoC-specific
 suspend/resume callbacks
In-Reply-To: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
Message-ID: <1368807872-2601-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SoC-specific driver might require additional save and restore of
registers. This patch adds pair of SoC-specific callbacks per pinctrl
device to account for this.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/pinctrl/pinctrl-samsung.c | 6 ++++++
 drivers/pinctrl/pinctrl-samsung.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index 15db258..63ac22e 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -1010,6 +1010,9 @@ static void samsung_pinctrl_suspend_dev(
 				 reg, bank->pm_save[PINCFG_TYPE_FUNC]);
 		}
 	}
+
+	if (ctrl->suspend)
+		ctrl->suspend(drvdata);
 }
 
 /**
@@ -1026,6 +1029,9 @@ static void samsung_pinctrl_resume_dev(struct samsung_pinctrl_drv_data *drvdata)
 	void __iomem *virt_base = drvdata->virt_base;
 	int i;
 
+	if (ctrl->resume)
+		ctrl->resume(drvdata);
+
 	for (i = 0; i < ctrl->nr_banks; i++) {
 		struct samsung_pin_bank *bank = &ctrl->pin_banks[i];
 		void __iomem *reg = virt_base + bank->pctl_offset;
diff --git a/drivers/pinctrl/pinctrl-samsung.h b/drivers/pinctrl/pinctrl-samsung.h
index 9f5cc81..b316d9f 100644
--- a/drivers/pinctrl/pinctrl-samsung.h
+++ b/drivers/pinctrl/pinctrl-samsung.h
@@ -187,6 +187,9 @@ struct samsung_pin_ctrl {
 
 	int		(*eint_gpio_init)(struct samsung_pinctrl_drv_data *);
 	int		(*eint_wkup_init)(struct samsung_pinctrl_drv_data *);
+	void		(*suspend)(struct samsung_pinctrl_drv_data *);
+	void		(*resume)(struct samsung_pinctrl_drv_data *);
+
 	char		*label;
 };
 
-- 
1.8.2.1
