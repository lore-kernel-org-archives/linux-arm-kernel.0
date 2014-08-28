From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 28 Aug 2014 14:14:12 +0100
Subject: [PATCH 06/11] mfd: htc-i2cpld: Rectify pointer offset error
In-Reply-To: <1409231657-18294-1-git-send-email-lee.jones@linaro.org>
References: <1409231657-18294-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1409231657-18294-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Checking the result of container_of() against NULL will always result to
false.  Using the offset of member 'chip_out' to find the start of 'struct
htcpld_chip' will result in an offset error when .get_chip() is attempting
to obtain 'htcpld-in'.  Instead, we'll use the correct member based on a
previously the set chip label.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/htc-i2cpld.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/htc-i2cpld.c b/drivers/mfd/htc-i2cpld.c
index 073e180..99b362e 100644
--- a/drivers/mfd/htc-i2cpld.c
+++ b/drivers/mfd/htc-i2cpld.c
@@ -258,31 +258,18 @@ static void htcpld_chip_set_ni(struct work_struct *work)
 static int htcpld_chip_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct htcpld_chip *chip_data;
-	int val = 0;
-	int is_input = 0;
-
-	/* Try out first */
-	chip_data = container_of(chip, struct htcpld_chip, chip_out);
-	if (!chip_data) {
-		/* Try in */
-		is_input = 1;
-		chip_data = container_of(chip, struct htcpld_chip, chip_in);
-		if (!chip_data)
-			return -EINVAL;
-	}
+	u8 cache;
 
-	/* Determine if this is an input or output GPIO */
-	if (!is_input)
-		/* Use the output cache */
-		val = (chip_data->cache_out >> offset) & 1;
-	else
-		/* Use the input cache */
-		val = (chip_data->cache_in >> offset) & 1;
+	if (!strncmp(chip->label, "htcpld-out", 10)) {
+		chip_data = container_of(chip, struct htcpld_chip, chip_out);
+		cache = chip_data->cache_out;
+	} else if (!strncmp(chip->label, "htcpld-in", 9)) {
+		chip_data = container_of(chip, struct htcpld_chip, chip_in);
+		cache = chip_data->cache_in;
+	} else
+		return -EINVAL;
 
-	if (val)
-		return 1;
-	else
-		return 0;
+	return (cache >> offset) & 1;
 }
 
 static int htcpld_direction_output(struct gpio_chip *chip,
-- 
1.9.1
