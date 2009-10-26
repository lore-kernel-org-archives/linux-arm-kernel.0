From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 26 Oct 2009 15:12:44 +0000
Subject: [PATCH 2.6.32] drivers/serial/atmel_serial.c: Fix BUILD_BUG_ON build
Message-ID: <1256569964-14416-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 'BUILD_BUG_ON(): fix it and a couple of bogus uses of it'
(commit 8c87df45) the BUILD_BUG_ON() for the ring buffer size has
failed to build due to use of is_power_of_2(). Fix this in the
same way as the SPARC vio.h was fixed in that commit by converting
to MAYBE_BUILD_BUG_ON().

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/serial/atmel_serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/atmel_serial.c b/drivers/serial/atmel_serial.c
index 3551c5c..b37d75f 100644
--- a/drivers/serial/atmel_serial.c
+++ b/drivers/serial/atmel_serial.c
@@ -1531,7 +1531,7 @@ static int __devinit atmel_serial_probe(struct platform_device *pdev)
 	void *data;
 	int ret;
 
-	BUILD_BUG_ON(!is_power_of_2(ATMEL_SERIAL_RINGSIZE));
+	MAYBE_BUILD_BUG_ON(!is_power_of_2(ATMEL_SERIAL_RINGSIZE));
 
 	port = &atmel_ports[pdev->id];
 	port->backup_imr = 0;
-- 
1.6.5
