From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 11 Feb 2014 11:37:07 +0000
Subject: [PATCH 2/7] serial: amba-pl011: attempt to get uartclk by name
In-Reply-To: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1392118632-11312-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The primecell device tree binding (from which the pl011 binding is
derived from) states that the apb_pclk clock input should be listed
first for all primecell devices. The amba-pl011 driver requires the
uartclk clock input to enable the uart and calculate the correct uart
baud rate, but the way it currently grabs the clock means that it always
gets the first clock (which should be apb_pclk).

As the AMBA bus code grabs apb_pclk by name, some existing dts provide
uartclk then apb_pclk by name to work around this, in violation of both
the primecell binding and the pl011 binding. Some dtbs only provide
apb_pclk, which is evidently at a similar enough frequency to uartclk on
those platforms to allow the driver to function.

This patch attempts to fix the mess my having the amba-pl011 driver
first attempt to get uartclk by name. If this fails, it falls back to
the old behaviour of simply acquiring the first clock. This is
compatible with any old dtb, whether it lists uartclk by name or not,
and allows the driver to support dtbs which do not violate either
binding.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
---
 drivers/tty/serial/amba-pl011.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d58783d..067952a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2123,7 +2123,14 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 		goto out;
 	}
 
-	uap->clk = devm_clk_get(&dev->dev, NULL);
+	/*
+	 * For compatibility with old DTBs and platform data, fall back to the
+	 * first clock if there's not an explicitly named "uartclk" entry.
+	 */
+	uap->clk = devm_clk_get(&dev->dev, "uartclk");
+	if (IS_ERR(uap->clk))
+		uap->clk = devm_clk_get(&dev->dev, NULL);
+
 	if (IS_ERR(uap->clk)) {
 		ret = PTR_ERR(uap->clk);
 		goto out;
-- 
1.8.1.1
