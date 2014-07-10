From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 10 Jul 2014 09:03:45 +0100
Subject: [PATCH v8 2/4] arm: fiq: Allow ACK and EOI to be passed to the intc
In-Reply-To: <1404979427-12943-1-git-send-email-daniel.thompson@linaro.org>
References: <1404118391-3850-1-git-send-email-daniel.thompson@linaro.org>
 <1404979427-12943-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1404979427-12943-3-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modern ARM interrupt controllers require an ACK as interrupts are taken
and an EOI on completion. The FIQ code currently does not provide any
API to perform this.

This patch provides this API, implemented by adding two callbacks to the
fiq_chip structure.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/include/asm/fiq.h |  9 +++++++++
 arch/arm/kernel/fiq.c      | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/include/asm/fiq.h b/arch/arm/include/asm/fiq.h
index ed44528..a25c952 100644
--- a/arch/arm/include/asm/fiq.h
+++ b/arch/arm/include/asm/fiq.h
@@ -22,6 +22,13 @@
 struct fiq_chip {
 	void (*fiq_enable)(struct irq_data *data);
 	void (*fiq_disable)(struct irq_data *data);
+
+	/* .fiq_ack() and .fiq_eoi() will be called from the FIQ
+	 * handler. For this reason they must not use spin locks (or any
+	 * other locks).
+	 */
+	int (*fiq_ack)(struct irq_data *data);
+	void (*fiq_eoi)(struct irq_data *data);
 };
 
 struct fiq_handler {
@@ -44,6 +51,8 @@ extern void release_fiq(struct fiq_handler *f);
 extern void set_fiq_handler(void *start, unsigned int length);
 extern void enable_fiq(int fiq);
 extern void disable_fiq(int fiq);
+extern int ack_fiq(int fiq);
+extern void eoi_fiq(int fiq);
 extern bool has_fiq(int fiq);
 extern void fiq_register_mapping(int irq, struct fiq_chip *chip);
 
diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index 5d831cf..3ccaa8c 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -183,6 +183,25 @@ void disable_fiq(int fiq)
 	disable_irq(fiq + fiq_start);
 }
 
+int ack_fiq(int fiq)
+{
+	struct fiq_data *data = lookup_fiq_data(fiq);
+
+	if (data && data->fiq_chip->fiq_ack)
+		return data->fiq_chip->fiq_ack(data->irq_data);
+
+	return fiq;
+}
+
+void eoi_fiq(int fiq)
+{
+	struct fiq_data *data = lookup_fiq_data(fiq);
+
+	if (data && data->fiq_chip->fiq_eoi)
+		data->fiq_chip->fiq_eoi(data->irq_data);
+}
+EXPORT_SYMBOL(eoi_fiq);
+
 bool has_fiq(int fiq)
 {
 	struct fiq_data *data = lookup_fiq_data(fiq);
-- 
1.9.3
