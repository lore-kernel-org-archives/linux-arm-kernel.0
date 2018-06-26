From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 26 Jun 2018 15:23:20 +0200
Subject: [PATCH v2 4/4] mailbox: Add support for i.MX7D messaging unit
In-Reply-To: <AM0PR04MB4211BBB72255BDA36C5AFF9880490@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180615095107.24610-1-o.rempel@pengutronix.de>
 <20180615095107.24610-5-o.rempel@pengutronix.de>
 <AM0PR04MB4211BBB72255BDA36C5AFF9880490@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <20180626132320.uvgfxff32p32ke6f@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2018 at 10:09:14AM +0000, A.s. Dong wrote:
> Since Sascha is requesting to write a generic MU mailbox driver for both
> SCU MU and M4 case, the current way using virtual channels in this patch
> only send one word a time obviously can't fit for SCU MU clients well.
> Do you think if we can refer to TI case to design a generic data transfer
> protocol to allow send multi words which is more close to SCU?
> include/linux/soc/ti/ti-msgmgr.h
> struct ti_msgmgr_message {
>         size_t len;
>         u8 *buf;
> };  
> 
> Or we try to support both type transfer protocols in this driver?
> That may introduce much complexities, personally I'm not quite
> like that.

To give you an idea what I am suggesting see the following patch.
It implements SCU mode ontop of Oleksijs patch. Untested of course
and as said, the mailbox framework lacks some way of synchronous
receive, that would still have to be implemented and Jassi might
have his own ideas how this could be done, but it doesn't add much
complexity.

Sascha


------------------------------8<--------------------------------

>From fad77078a1f1b5719fcc3c1ab789ce9cca4c9212 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 26 Jun 2018 15:07:04 +0200
Subject: [PATCH] mailbox: imx-mu: Implement SCU mode

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mailbox/imx-mailbox.c        | 89 +++++++++++++++++++++++++++-
 include/dt-bindings/mailbox/imx-mu.h | 10 ++++
 2 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/mailbox/imx-mu.h

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index e3f621cb1d30..a4803d1eae1d 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -10,6 +10,8 @@
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/iopoll.h>
+#include <dt-bindings/mailbox/imx-mu.h>
 
 /* Transmit Register */
 #define IMX_MU_xTRn(x)		(0x00 + 4 * (x))
@@ -28,7 +30,7 @@
 /* Receive Interrupt Enable */
 #define IMX_MU_xCR_RIEn(x)	BIT(24 + (x))
 
-#define IMX_MU_MAX_CHANS	4u
+#define IMX_MU_MAX_CHANS	5u
 
 struct imx_mu_priv;
 
@@ -119,12 +121,80 @@ static bool imx_mu_last_tx_done(struct mbox_chan *chan)
 	return (!!(val & IMX_MU_xSR_TEn(cp->bidx)));
 }
 
+// Take from some include file
+struct sc_rpc_msg {
+	uint8_t version;
+	uint8_t size;
+	uint8_t svc;
+	uint8_t func;
+};
+
+#define MU_DATA_TIME_OUT_US    (100 * USEC_PER_MSEC)
+
+static int imx_mu_scu_send_data(struct imx_mu_priv *priv, void *data)
+{
+	struct sc_rpc_msg *msg = data;
+	uint32_t *msg_raw = data;
+	int i, ret;
+
+	for (i = 0; i < msg->size + 1; i++) {
+		int index = i % 4;
+		uint32_t asr;
+
+		/* Wait TX register to be empty. */
+		ret = readl_poll_timeout_atomic(priv->base + IMX_MU_xSR, asr,
+						asr & IMX_MU_xSR_TEn(4 - index),
+						0, MU_DATA_TIME_OUT_US);
+		if (ret)
+			goto out;
+
+		writel(msg_raw[i], priv->base + IMX_MU_xTRn(4 - index));
+	}
+
+	ret = 0;
+out:
+	mbox_chan_txdone(chan, ret);
+	return ret;
+}
+
+static int imx_mu_scu_receive_data(struct imx_mu_priv *priv, void *data)
+{
+	struct sc_rpc_msg *msg = data;
+	uint32_t *msg_raw = data;
+	int i, ret, size = 8;
+
+	for (i = 0; i < size; i++) {
+		int index = i % 4;
+		uint32_t asr;
+
+		/* Wait TX register to be empty. */
+		ret = readl_poll_timeout_atomic(priv->base + IMX_MU_xSR, asr,
+						asr & IMX_MU_xSR_RFn(4 - index),
+						0, MU_DATA_TIME_OUT_US);
+		if (ret)
+			return ret;
+
+		msg_raw[i] = readl(priv->base + IMX_MU_xRRn(4 - index));
+
+		if (i == 0) {
+			size = msg->size;
+			if (size > 7)
+				return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int imx_mu_send_data(struct mbox_chan *chan, void *data)
 {
 	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
 	struct imx_mu_con_priv *cp = chan->con_priv;
 	u32 *arg = data;
 
+	if (cp->idx == IMX_MU_CHANNEL_IMX8_SCU)
+		return imx_mu_scu_send_data(priv, data);
+
 	if (!imx_mu_last_tx_done(chan))
 		return -EBUSY;
 
@@ -134,6 +204,17 @@ static int imx_mu_send_data(struct mbox_chan *chan, void *data)
 	return 0;
 }
 
+static int imx_mu_receive_data(struct mbox_chan *chan, void *data)
+{
+	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	if (cp->idx == IMX_MU_CHANNEL_IMX8_SCU)
+		return imx_mu_scu_receive_data(priv, data);
+
+	return -EINVAL;
+}
+
 static int imx_mu_startup(struct mbox_chan *chan)
 {
 	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
@@ -166,6 +247,12 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
 
 static const struct mbox_chan_ops imx_mu_ops = {
 	.send_data = imx_mu_send_data,
+	/*
+	 * FIXME: This has to be implemented in the mailbox framework.
+	 * Currently there is only support for asynchronous read using
+	 * callbacks which is not suitable for the SCU usecase.
+	 */
+//	.synchronous_read = imx_mu_receive_data,
 	.startup = imx_mu_startup,
 	.shutdown = imx_mu_shutdown,
 };
diff --git a/include/dt-bindings/mailbox/imx-mu.h b/include/dt-bindings/mailbox/imx-mu.h
new file mode 100644
index 000000000000..4836266a7e57
--- /dev/null
+++ b/include/dt-bindings/mailbox/imx-mu.h
@@ -0,0 +1,10 @@
+#ifndef __DT_BINDINGS_MAILBOX_IMX_MU_H
+#define __DT_BINDINGS_MAILBOX_IMX_MU_H
+
+#define IMX_MU_CHANNEL0		0
+#define IMX_MU_CHANNEL1		1
+#define IMX_MU_CHANNEL2		2
+#define IMX_MU_CHANNEL3		3
+#define IMX_MU_CHANNEL_IMX8_SCU 4
+
+#endif /* __DT_BINDINGS_MAILBOX_IMX_MU_H */
-- 
2.17.1

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
