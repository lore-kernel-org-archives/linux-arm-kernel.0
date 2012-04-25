From: mark.asselstine@windriver.com (Mark Asselstine)
Date: Wed, 25 Apr 2012 11:02:43 -0400
Subject: [PATCH] ARM:mfd: fix ezx-pcap build failure
Message-ID: <1335366163-12920-1-git-send-email-mark.asselstine@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Attempting to build the ezx_defconfig we get a build failure:

drivers/mfd/ezx-pcap.c: In function 'pcap_isr_work':
drivers/mfd/ezx-pcap.c:205: error: implicit declaration of function 'irq_to_gpio'

Looking at this failure we can find that commit 4929f5a8a99f
[ARM:pxa: rename gpio_to_irq and irq_to_gpio] renamed irq_to_gpio()
to pxa_irq_to_gpio() but this change was not made in the ezx-pcap
driver.

Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
---
 drivers/mfd/ezx-pcap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index 43a76c4..c49c52a 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -19,6 +19,7 @@
 #include <linux/spi/spi.h>
 #include <linux/gpio.h>
 #include <linux/slab.h>
+#include <linux/gpio-pxa.h>
 
 #define PCAP_ADC_MAXQ		8
 struct pcap_adc_request {
@@ -202,7 +203,7 @@ static void pcap_isr_work(struct work_struct *work)
 		}
 		local_irq_enable();
 		ezx_pcap_write(pcap, PCAP_REG_MSR, pcap->msr);
-	} while (gpio_get_value(irq_to_gpio(pcap->spi->irq)));
+	} while (gpio_get_value(pxa_irq_to_gpio(pcap->spi->irq)));
 }
 
 static void pcap_irq_handler(unsigned int irq, struct irq_desc *desc)
-- 
1.7.5.4
