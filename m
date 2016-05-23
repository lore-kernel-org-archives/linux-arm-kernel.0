From: damien.thebault@vitec.com (=?utf-8?B?RGFtaWVuIFRow6liYXVsdA==?=)
Date: Mon, 23 May 2016 14:07:49 +0000
Subject: armada thermal issues with negative temperatures
Message-ID: <1464012466.1329.361.camel@vitec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I've been using an armada 370 SoC, and the thermal driver is reporting
erroneous values at negative temperatures.

After looking at what happened, in the armada_get_temp() function,
after applying shift and mask, we get the following values around 0?C:
- 315 (just above 0)
- 316 (just below 0)

If the code after /* Get formula coeficients */ is executed with those
two values, the first one gives the proper value of 216, but the second
one gives 310160 instead of the proper value of -506.

To have the proper final value, a signed division must be performed,
which will only be done if both operands are signed according to the C
standard, otherwise an unsigned division is done, which will provide
wrong results.

As the current coefficients are just fitting in unsigned long values,
the best fix I could find was to just cast each operand to (signed)
long.

With this fix, the temperature is the proper one, even for negative
values.

Best Regards
---
?drivers/thermal/armada_thermal.c | 4 ++--
?1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c
b/drivers/thermal/armada_thermal.c
index ae75328..ad8b88c 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -177,9 +177,9 @@ static int armada_get_temp(struct
thermal_zone_device *thermal,
?	div = priv->data->coef_div;
?
?	if (priv->data->inverted)
-		*temp = ((m * reg) - b) / div;
+		*temp = (long)((m * reg) - b) / (long)div;
?	else
-		*temp = (b - (m * reg)) / div;
+		*temp = (long)(b - (m * reg)) / (long)div;
?	return 0;
?}
?
--?
2.8.2

-- 
Damien Th?bault
