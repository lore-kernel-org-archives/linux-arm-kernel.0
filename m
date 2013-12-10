From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Dec 2013 10:06:10 +0100
Subject: [PATCH] pinctrl: make the MSM SoC driver depend on OF
Message-ID: <1386666370-6394-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We had a compilation failure on x86_64 due to missing OF support
as this was an implicit dependency. Add an explicit dependency
on OF and OF_IRQ on the SoC driver.

Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Total failure with older approaches: what we need to do is
  have the *SoC subdriver* depend on OF and OF_IRQ. This is
  because the placeholder bool PINCTRL_MSM cannot cascade its
  dependencies when a subdriver selects it, Kconfig is smart
  but not that smart.
ChangeLog v1->v2:
- OK so "depends on OF" did not work here let's try to simply
  select OF and OF_IRQ for this then? It's one of those
  "warning: (PINCTRL_MSM8X74) selects PINCTRL_MSM which has
  unmet direct dependencies (PINCTRL && OF)" that I simply
  cannot find my way out of :-/
---
 drivers/pinctrl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 06e057bb3376..30fcb897eb99 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -211,6 +211,7 @@ config PINCTRL_MSM
 
 config PINCTRL_MSM8X74
 	bool "Qualcomm 8x74 pin controller driver"
+	depends on OF && OF_IRQ
 	select PINCTRL_MSM
 
 config PINCTRL_NOMADIK
-- 
1.8.3.1
