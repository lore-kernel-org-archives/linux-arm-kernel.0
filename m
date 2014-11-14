From: j.uzycki@elproma.com.pl (Janusz Uzycki)
Date: Fri, 14 Nov 2014 23:24:33 +0100
Subject: [PATCH] serial: mxs-auart: fix gpio change detection on interrupt
Message-ID: <1416003873-9576-1-git-send-email-j.uzycki@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mxs_auart_modem_status() did't detect gpio's state change
because s->mctrl_prev was modified before by mctrl_gpio_get().
The patch introduces mctrl_temp variable to fix the bug.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---

Two patches were missed during movements between our internal repos.
The 1/2 patch is required against commits:
  f9e42397d79b ("serial: mxs-auart: add interrupts for modem control lines")
  36a262782b04 ("serial: mxs-auart: enable PPS support")
I've done build-test for the next only before.
I should have done hardware test also for the next, sorry.
Now it is tested for the next on real hardware too.

---
 drivers/tty/serial/mxs-auart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 840c1f7..c556116 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -798,6 +798,7 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 {
 	u32 istat;
 	struct mxs_auart_port *s = context;
+	u32 mctrl_temp = s->mctrl_prev;
 	u32 stat = readl(s->port.membase + AUART_STAT);
 
 	istat = readl(s->port.membase + AUART_INTR);
@@ -817,7 +818,7 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 	    irq == s->gpio_irq[UART_GPIO_DSR] ||
 	    irq == s->gpio_irq[UART_GPIO_RI])
 		mxs_auart_modem_status(s,
-				mctrl_gpio_get(s->gpios, &s->mctrl_prev));
+				mctrl_gpio_get(s->gpios, &mctrl_temp));
 
 	if (istat & AUART_INTR_CTSMIS) {
 		if (CTS_AT_AUART() && s->ms_irq_enabled)
-- 
1.7.11.3
