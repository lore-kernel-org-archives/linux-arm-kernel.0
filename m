From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Sat, 24 Sep 2016 17:14:24 +0800
Subject: [PATCH 4/5] tty: amba-pl011: Don't complain on -EPROBE_DEFER when no
 irq
In-Reply-To: <1474708465-38958-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1474708465-38958-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1474708465-38958-5-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't complain on -EPROBE_DEFER when attempting to get the irq.
the driver probe will be retried later.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/tty/serial/amba-pl011.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8a9e213..7d9b291 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2555,7 +2555,8 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "cannot obtain irq\n");
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "cannot obtain irq\n");
 		return ret;
 	}
 	uap->port.irq	= ret;
-- 
1.7.12.4
