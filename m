From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 28 Jul 2014 18:31:17 +0200
Subject: [PATCH v3 4/4] can: flexcan: add vf610 support for FlexCAN
In-Reply-To: <e88108c655e2c16dc9cf6c4194547e73@agner.ch>
References: <cover.1405428166.git.stefan@agner.ch>
 <ff2ea1726b13dc2ffa3519ce9244f3633cf1420d.1405428166.git.stefan@agner.ch>
 <53C5398F.2000005@pengutronix.de> <1b8a8ca03b4a160027a79b722f697e25@agner.ch>
 <601adb6fe47279c115c1cc607365a00e@agner.ch> <53D25C9D.5080803@pengutronix.de>
 <e88108c655e2c16dc9cf6c4194547e73@agner.ch>
Message-ID: <53D67AD5.2000500@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2014 06:20 PM, Stefan Agner wrote:
[...]

> However, I got once this Kernel panic after I reconfigured to normal
> mode. But I could not reproduce this.
> 
> [  461.954394] flexcan_irq, esr=00059d82
> [  461.958093] flexcan_irq, ctrl=17092051
> [  461.961873] ------------[ cut here ]------------
> [  461.966536] WARNING: CPU: 0 PID: 0 at kernel/locking/mutex.c:826
> mutex_trylock+0x1b0/0x208()
> [  461.974982] DEBUG_LOCKS_WARN_ON(in_interrupt())

Please use this updated version of your patch:

Marc

---

>From b6b8ae7cdb04f1a3b9d3a6dd83f8146bfaf48553 Mon Sep 17 00:00:00 2001
From: Stefan Agner <stefan@agner.ch>
Date: Tue, 15 Jul 2014 14:56:20 +0200
Subject: [PATCH] can: flexcan: flexcan_get_berr_counter(): switch on clocks
 before accessing ecr register

The funcion flexcan_get_berr_counter() may be called from userspace even if the
interface is down, this the clocks are disabled. This patch switches on the
clocks before accessing the ecr register.

Reported-by: Ashutosh Singh <ashuleapyear@gmail.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index f425ec2..6bfe24a 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -378,8 +378,9 @@ static int flexcan_chip_softreset(struct flexcan_priv *priv)
 	return 0;
 }
 
-static int flexcan_get_berr_counter(const struct net_device *dev,
-				    struct can_berr_counter *bec)
+
+static int __flexcan_get_berr_counter(const struct net_device *dev,
+				      struct can_berr_counter *bec)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->base;
@@ -391,6 +392,29 @@ static int flexcan_get_berr_counter(const struct net_device *dev,
 	return 0;
 }
 
+static int flexcan_get_berr_counter(const struct net_device *dev,
+				    struct can_berr_counter *bec)
+{
+	const struct flexcan_priv *priv = netdev_priv(dev);
+	int err;
+
+	err = clk_prepare_enable(priv->clk_ipg);
+	if (err)
+		return err;
+
+	err = clk_prepare_enable(priv->clk_per);
+	if (err)
+		goto out_disable_ipg;
+
+	err = __flexcan_get_berr_counter(dev, bec);
+
+	clk_disable_unprepare(priv->clk_per);
+ out_disable_ipg:
+	clk_disable_unprepare(priv->clk_ipg);
+
+	return err;
+}
+
 static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
@@ -503,7 +527,7 @@ static void do_state(struct net_device *dev,
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct can_berr_counter bec;
 
-	flexcan_get_berr_counter(dev, &bec);
+	__flexcan_get_berr_counter(dev, &bec);
 
 	switch (priv->can.state) {
 	case CAN_STATE_ERROR_ACTIVE:
-- 
2.0.1

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140728/a980ea01/attachment.sig>
