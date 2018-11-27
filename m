From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Tue, 27 Nov 2018 18:00:18 +0100
Subject: [PATCH V2] gpio: mt7621: pass mediatek_gpio_bank_probe() failure up
 the stack
Message-ID: <1543338018-708-1-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The error cases of mediatek_gpio_bank_probe() would go unnoticed (except
for the dev_err() messages). The probe function should return an error
if one of the banks failed to initialize properly indicated by
not returning non-0.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
---

V2: A logic error spoted by Sean Wang <sean.wang@kernel.org> the
    success case is 0 and thus returning early should be on on 
    ret!=0 and not on !ret - thanks for catching this stupid mistake !

Patch was compile tested with: omega2p_defconfig, SOC_MT7621=y,
GPIOLIB=y, GPIO_MT7621=y

Patch is against 4.20-rc3 (localversion-next is next-20181121)

 drivers/gpio/gpio-mt7621.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index 1ec95bc..68fca8b 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -297,6 +297,7 @@ mediatek_gpio_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct mtk *mtk;
 	int i;
+	int ret;
 
 	mtk = devm_kzalloc(dev, sizeof(*mtk), GFP_KERNEL);
 	if (!mtk)
@@ -311,8 +312,11 @@ mediatek_gpio_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mtk);
 	mediatek_gpio_irq_chip.name = dev_name(dev);
 
-	for (i = 0; i < MTK_BANK_CNT; i++)
-		mediatek_gpio_bank_probe(dev, np, i);
+	for (i = 0; i < MTK_BANK_CNT; i++) {
+		ret = mediatek_gpio_bank_probe(dev, np, i);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.1.4
