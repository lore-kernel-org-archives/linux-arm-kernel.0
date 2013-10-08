From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  8 Oct 2013 13:24:28 +0900
Subject: [PATCH] serial8250-em: convert to clk_prepare/unprepare
In-Reply-To: <1381206268-3914-1-git-send-email-horms+renesas@verge.net.au>
References: <1381206268-3914-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1381206268-3914-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

Add calls to clk_prepare and unprepare so that EMMA Mobile EV2 can
migrate to the common clock framework.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
[takashi.yoshii.ze at renesas.com: edited for conflicts]
Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/8250/8250_em.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_em.c b/drivers/tty/serial/8250/8250_em.c
index 5f3bba1..d1a9078 100644
--- a/drivers/tty/serial/8250/8250_em.c
+++ b/drivers/tty/serial/8250/8250_em.c
@@ -122,7 +122,7 @@ static int serial8250_em_probe(struct platform_device *pdev)
 	up.port.dev = &pdev->dev;
 	up.port.private_data = priv;
 
-	clk_enable(priv->sclk);
+	clk_prepare_enable(priv->sclk);
 	up.port.uartclk = clk_get_rate(priv->sclk);
 
 	up.port.iotype = UPIO_MEM32;
@@ -134,7 +134,7 @@ static int serial8250_em_probe(struct platform_device *pdev)
 	ret = serial8250_register_8250_port(&up);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "unable to register 8250 port\n");
-		clk_disable(priv->sclk);
+		clk_disable_unprepare(priv->sclk);
 		return ret;
 	}
 
@@ -148,7 +148,7 @@ static int serial8250_em_remove(struct platform_device *pdev)
 	struct serial8250_em_priv *priv = platform_get_drvdata(pdev);
 
 	serial8250_unregister_port(priv->line);
-	clk_disable(priv->sclk);
+	clk_disable_unprepare(priv->sclk);
 	return 0;
 }
 
-- 
1.8.4
