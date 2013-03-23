From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 23 Mar 2013 13:56:58 +0100
Subject: [PATCH] ARM: Kirkwood: fix unused mvsdio gpio pins
Message-ID: <1364043420-17641-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mvsdio_platform_data allows to pass card detect and write protect gpio
numbers to the driver. Some kirkwood boards don't use both pins as they
are not connected, and don't set the corresponding value in platform_data.

This will leave the unset values in platform_data initialized as 0, which
is in fact a valid gpio pin. mvsdio will grab that pin and configure it as
gpio, which in turn breaks nand controller as mpp0 also carries nand_io2.

This patch fixes the above by initializing unused gpio functions in the
platform_data with an invalid (-1) value.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Reported-by: Soeren Moch <smoch@web.de>
---
Cc: Soeren Moch <smoch@web.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-kirkwood/guruplug-setup.c  |    2 ++
 arch/arm/mach-kirkwood/openrd-setup.c    |    1 +
 arch/arm/mach-kirkwood/rd88f6281-setup.c |    1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-kirkwood/guruplug-setup.c b/arch/arm/mach-kirkwood/guruplug-setup.c
index 1c6e736..08dd739 100644
--- a/arch/arm/mach-kirkwood/guruplug-setup.c
+++ b/arch/arm/mach-kirkwood/guruplug-setup.c
@@ -53,6 +53,8 @@ static struct mv_sata_platform_data guruplug_sata_data = {
 
 static struct mvsdio_platform_data guruplug_mvsdio_data = {
 	/* unfortunately the CD signal has not been connected */
+	.gpio_card_detect = -1,
+	.gpio_write_protect = -1,
 };
 
 static struct gpio_led guruplug_led_pins[] = {
diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-kirkwood/openrd-setup.c
index 8ddd69f..6a6eb54 100644
--- a/arch/arm/mach-kirkwood/openrd-setup.c
+++ b/arch/arm/mach-kirkwood/openrd-setup.c
@@ -55,6 +55,7 @@ static struct mv_sata_platform_data openrd_sata_data = {
 
 static struct mvsdio_platform_data openrd_mvsdio_data = {
 	.gpio_card_detect = 29,	/* MPP29 used as SD card detect */
+	.gpio_write_protect = -1,
 };
 
 static unsigned int openrd_mpp_config[] __initdata = {
diff --git a/arch/arm/mach-kirkwood/rd88f6281-setup.c b/arch/arm/mach-kirkwood/rd88f6281-setup.c
index c7d93b4..d242231 100644
--- a/arch/arm/mach-kirkwood/rd88f6281-setup.c
+++ b/arch/arm/mach-kirkwood/rd88f6281-setup.c
@@ -69,6 +69,7 @@ static struct mv_sata_platform_data rd88f6281_sata_data = {
 
 static struct mvsdio_platform_data rd88f6281_mvsdio_data = {
 	.gpio_card_detect = 28,
+	.gpio_write_protect = -1,
 };
 
 static unsigned int rd88f6281_mpp_config[] __initdata = {
-- 
1.7.10.4
