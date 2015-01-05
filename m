From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Mon,  5 Jan 2015 11:04:14 +0100
Subject: [RESEND PATCH 2/2] pinctrl: st: Add irq_disable hook to
 st_gpio_irqchip
In-Reply-To: <1420452254-30625-1-git-send-email-patrice.chotard@st.com>
References: <1420452254-30625-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1420452254-30625-3-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently disable_irq() doesn't work for pinctrl-st driver, due to
missing irq_disable hook in the driver.
disable_irq() is required only for level-triggered interrupts, which
is not the case normally.

Signed-off-by: Pankaj Dev <pankaj.dev@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/pinctrl/pinctrl-st.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 87570e6..9e5ec00 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1445,6 +1445,7 @@ static struct gpio_chip st_gpio_template = {
 
 static struct irq_chip st_gpio_irqchip = {
 	.name		= "GPIO",
+	.irq_disable	= st_gpio_irq_mask,
 	.irq_mask	= st_gpio_irq_mask,
 	.irq_unmask	= st_gpio_irq_unmask,
 	.irq_set_type	= st_gpio_irq_set_type,
-- 
1.9.1
