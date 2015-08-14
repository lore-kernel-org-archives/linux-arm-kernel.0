From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 14 Aug 2015 16:11:02 +0200
Subject: [PATCH v3 5/9] gpiolib: Add gpio name information to
 /sys/kernel/debug/gpio
In-Reply-To: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
References: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1439561466-14350-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add some information about gpio names to the debugfs gpio file. name and
label of a GPIO are then displayed next to each other. This way it is
easy to see what the real name of GPIO is and what the driver requested
it for.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 Documentation/ABI/testing/sysfs-gpio |  1 +
 drivers/gpio/gpiolib.c               | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-gpio b/Documentation/ABI/testing/sysfs-gpio
index 55ffa2df1c10..2c1e199fd4e1 100644
--- a/Documentation/ABI/testing/sysfs-gpio
+++ b/Documentation/ABI/testing/sysfs-gpio
@@ -21,6 +21,7 @@ Description:
 	    /value ... always readable, writes fail for input GPIOs
 	    /direction ... r/w as: in, out (default low); write: high, low
 	    /edge ... r/w as: none, falling, rising, both
+	    /name ... r/o, unique name of the GPIO
 	/gpiochipN ... for each gpiochip; #N is its first GPIO
 	    /base ... (r/o) same as N
 	    /label ... (r/o) descriptive, not necessarily unique
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 3908503bebfe..79a0b41ce57b 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2344,14 +2344,19 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	int			is_irq;
 
 	for (i = 0; i < chip->ngpio; i++, gpio++, gdesc++) {
-		if (!test_bit(FLAG_REQUESTED, &gdesc->flags))
+		if (!test_bit(FLAG_REQUESTED, &gdesc->flags)) {
+			if (gdesc->name) {
+				seq_printf(s, " gpio-%-3d (%-20.20s)\n",
+					   gpio, gdesc->name);
+			}
 			continue;
+		}
 
 		gpiod_get_direction(gdesc);
 		is_out = test_bit(FLAG_IS_OUT, &gdesc->flags);
 		is_irq = test_bit(FLAG_USED_AS_IRQ, &gdesc->flags);
-		seq_printf(s, " gpio-%-3d (%-20.20s) %s %s %s",
-			gpio, gdesc->label,
+		seq_printf(s, " gpio-%-3d (%-20.20s|%-20.20s) %s %s %s",
+			gpio, gdesc->name ? gdesc->name : "", gdesc->label,
 			is_out ? "out" : "in ",
 			chip->get
 				? (chip->get(chip, i) ? "hi" : "lo")
-- 
2.4.6
