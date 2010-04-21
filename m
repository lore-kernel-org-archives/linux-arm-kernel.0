From: viresh.kumar@st.com (Viresh KUMAR)
Date: Wed, 21 Apr 2010 13:54:56 +0530
Subject: [PATCH resend] PL061 GPIO: Changing *_irq_chip_data with *_irq_data
	for real irqs.
Message-ID: <1271838297-20528-1-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PL061 driver is using set_irq_chip_data and get_irq_chip_data for real
irq lines. It must be using *_irq_data functions instead. As chip_data
is used by interrupt controllers also, which makes vic write at incorrect
addresses.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/gpio/pl061.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/pl061.c b/drivers/gpio/pl061.c
index 3ad1eeb..4b6c22d 100644
--- a/drivers/gpio/pl061.c
+++ b/drivers/gpio/pl061.c
@@ -203,7 +203,7 @@ static struct irq_chip pl061_irqchip = {
 
 static void pl061_irq_handler(unsigned irq, struct irq_desc *desc)
 {
-	struct list_head *chip_list = get_irq_chip_data(irq);
+	struct list_head *chip_list = get_irq_data(irq);
 	struct list_head *ptr;
 	struct pl061_gpio *chip;
 
@@ -296,9 +296,9 @@ static int __init pl061_probe(struct amba_device *dev, struct amba_id *id)
 			goto iounmap;
 		}
 		INIT_LIST_HEAD(chip_list);
-		set_irq_chip_data(irq, chip_list);
+		set_irq_data(irq, chip_list);
 	} else
-		chip_list = get_irq_chip_data(irq);
+		chip_list = get_irq_data(irq);
 	list_add(&chip->list, chip_list);
 
 	for (i = 0; i < PL061_GPIO_NR; i++) {
-- 
1.6.0.2
