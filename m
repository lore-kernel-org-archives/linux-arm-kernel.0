From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Fri, 22 Feb 2013 10:52:35 +0800
Subject: [PATCH -next] spi: fix return value check in ce4100_spi_probe()
Message-ID: <CAPgLHd-PhE2igUQOeg90H98Ni55DwfYdp0D52uaBK0=J3M1V+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function platform_device_register_full()
returns ERR_PTR() and never returns NULL. The NULL test in the
return value check should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/spi/spi-pxa2xx-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 364964d..0a11dcfc 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -47,8 +47,8 @@ static int ce4100_spi_probe(struct pci_dev *dev,
 	pi.size_data = sizeof(spi_pdata);
 
 	pdev = platform_device_register_full(&pi);
-	if (!pdev)
-		return -ENOMEM;
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
 
 	pci_set_drvdata(dev, pdev);
 
