From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 14:54:48 +0200
Subject: [PATCH 1/6] ARM: pxa: remove irq_to_gpio from ezx-pcap driver
In-Reply-To: <1344430493-5304-1-git-send-email-arnd@arndb.de>
References: <1344430493-5304-1-git-send-email-arnd@arndb.de>
Message-ID: <1344430493-5304-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq_to_gpio function was removed from the pxa platform
in linux-3.2, and this driver has been broken since.

There is actually no in-tree user of this driver that adds
this platform device, but the driver can and does get enabled
on some platforms.

Without this patch, building ezx_defconfig results in:

drivers/mfd/ezx-pcap.c: In function 'pcap_isr_work':
drivers/mfd/ezx-pcap.c:205:2: error: implicit declaration of function 'irq_to_gpio' [-Werror=implicit-function-declaration]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: stable at vger.kernel.org (v3.2+)
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Daniel Ribeiro <drwyrm@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/mfd/ezx-pcap.c       |    2 +-
 include/linux/mfd/ezx-pcap.h |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index 43a76c4..db662e2 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -202,7 +202,7 @@ static void pcap_isr_work(struct work_struct *work)
 		}
 		local_irq_enable();
 		ezx_pcap_write(pcap, PCAP_REG_MSR, pcap->msr);
-	} while (gpio_get_value(irq_to_gpio(pcap->spi->irq)));
+	} while (gpio_get_value(pdata->gpio));
 }
 
 static void pcap_irq_handler(unsigned int irq, struct irq_desc *desc)
diff --git a/include/linux/mfd/ezx-pcap.h b/include/linux/mfd/ezx-pcap.h
index 40c37216..32a1b5c 100644
--- a/include/linux/mfd/ezx-pcap.h
+++ b/include/linux/mfd/ezx-pcap.h
@@ -16,6 +16,7 @@ struct pcap_subdev {
 struct pcap_platform_data {
 	unsigned int irq_base;
 	unsigned int config;
+	int gpio;
 	void (*init) (void *);	/* board specific init */
 	int num_subdevs;
 	struct pcap_subdev *subdevs;
-- 
1.7.10
