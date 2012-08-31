From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Fri, 31 Aug 2012 11:21:18 +0200
Subject: [PATCH 2/8] i2c: at91: add warning about transmission issues for some
 devices
In-Reply-To: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1346404884-18451-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Some devices don't have clock streching in transmission mode. It can
lead to premature stop sendings if the latency to write data in the
transmission register is too long. In this case, prefer the i2c-gpio
driver.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/i2c/busses/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d9c4918..da77c37 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -300,6 +300,12 @@ config I2C_AT91
 	  to support combined I2C messages.  Use the i2c-gpio driver
 	  unless your system can cope with this limitation.
 
+	  Caution! at91rm9200, at91sam9261, at91sam9260, at91sam9263 devices
+	  don't have clock stretching in transmission mode. For that reason,
+	  you can encounter underrun issues causing premature stop sendings if
+	  the latency to fill the transmission register is too long. If you
+	  are facing this situation, use the i2c-gpio driver.
+
 config I2C_AU1550
 	tristate "Au1550/Au1200/Au1300 SMBus interface"
 	depends on MIPS_ALCHEMY
-- 
1.7.11.3
