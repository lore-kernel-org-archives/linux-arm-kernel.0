From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 15 Nov 2014 00:06:41 +0100
Subject: [PATCHv1 2/6] rtc: rtc-isl12057: add support for century bit
In-Reply-To: <cover.1416006090.git.arno@natisbad.org>
References: <cover.1416006090.git.arno@natisbad.org>
Message-ID: <83c5f7964faf3b04371f2dd447b78d65f0c11fb8.1416006090.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The month register of ISL12057 RTC chip includes a century bit
which reports overflow of year register from 99 to 0. This bit
can also be written, which allows using it to extend the time
interval the chip can support from 99 to 199 years.

This patch adds support for century overflow bit in tm to regs
and regs to tm helpers in ISL12057 driver.

This was tested by putting a device 100 years in the future (using
a specific kernel due to the inability of userland tools such as
date or hwclock to pass year 2038), rebooting on a kernel w/ this
patch applied and verifying the device was still 100 years in the
future.

Suggested-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 drivers/rtc/rtc-isl12057.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-isl12057.c b/drivers/rtc/rtc-isl12057.c
index 8c3f60737df8..b538fabfcfd3 100644
--- a/drivers/rtc/rtc-isl12057.c
+++ b/drivers/rtc/rtc-isl12057.c
@@ -41,6 +41,7 @@
 #define ISL12057_REG_RTC_DW	0x03	/* Day of the Week */
 #define ISL12057_REG_RTC_DT	0x04	/* Date */
 #define ISL12057_REG_RTC_MO	0x05	/* Month */
+#define ISL12057_REG_RTC_MO_CEN	BIT(7)	/* Century bit */
 #define ISL12057_REG_RTC_YR	0x06	/* Year */
 #define ISL12057_RTC_SEC_LEN	7
 
@@ -99,24 +100,35 @@ static void isl12057_rtc_regs_to_tm(struct rtc_time *tm, u8 *regs)
 	tm->tm_wday = bcd2bin(regs[ISL12057_REG_RTC_DW]) - 1; /* starts at 1 */
 	tm->tm_mon  = bcd2bin(regs[ISL12057_REG_RTC_MO] & 0x1f) - 1; /* ditto */
 	tm->tm_year = bcd2bin(regs[ISL12057_REG_RTC_YR]) + 100;
+
+	/* Check if years register has overflown from 99 to 00 */
+	if (regs[ISL12057_REG_RTC_MO] & ISL12057_REG_RTC_MO_CEN)
+		tm->tm_year += 100;
 }
 
 static int isl12057_rtc_tm_to_regs(u8 *regs, struct rtc_time *tm)
 {
+	u8 century_bit;
+
 	/*
 	 * The clock has an 8 bit wide bcd-coded register for the year.
+	 * It also has a century bit encoded in MO flag which provides
+	 * information about overflow of year register from 99 to 00.
 	 * tm_year is an offset from 1900 and we are interested in the
-	 * 2000-2099 range, so any value less than 100 is invalid.
+	 * 2000-2199 range, so any value less than 100 or larger than
+	 * 299 is invalid.
 	 */
-	if (tm->tm_year < 100)
+	if (tm->tm_year < 100 || tm->tm_year > 299)
 		return -EINVAL;
 
+	century_bit = (tm->tm_year > 199) ? ISL12057_REG_RTC_MO_CEN : 0;
+
 	regs[ISL12057_REG_RTC_SC] = bin2bcd(tm->tm_sec);
 	regs[ISL12057_REG_RTC_MN] = bin2bcd(tm->tm_min);
 	regs[ISL12057_REG_RTC_HR] = bin2bcd(tm->tm_hour); /* 24-hour format */
 	regs[ISL12057_REG_RTC_DT] = bin2bcd(tm->tm_mday);
-	regs[ISL12057_REG_RTC_MO] = bin2bcd(tm->tm_mon + 1);
-	regs[ISL12057_REG_RTC_YR] = bin2bcd(tm->tm_year - 100);
+	regs[ISL12057_REG_RTC_MO] = bin2bcd(tm->tm_mon + 1) | century_bit;
+	regs[ISL12057_REG_RTC_YR] = bin2bcd(tm->tm_year % 100);
 	regs[ISL12057_REG_RTC_DW] = bin2bcd(tm->tm_wday + 1);
 
 	return 0;
-- 
2.1.1
