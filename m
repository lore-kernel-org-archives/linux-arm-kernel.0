From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 18 Jun 2013 17:40:24 +0200
Subject: [PATCH v2 2/2] i2c-mv64xxx: Abort the mv64xxx_of_config if
 clock-frequency is not provided
In-Reply-To: <1371570024-11613-1-git-send-email-gregory.clement@free-electrons.com>
References: <1371570024-11613-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1371570024-11613-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zbigniew Bodek <zbb@semihalf.com>

This commit adds checking whether clock-frequency property acquisition
has succeeded. Do not waste time to find baud factors if there is no
information about the desired bus frequency in dts.

[gregory.clement at free-electrons.com: Reword the commit log]

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Zbigniew Bodek <zbb@semihalf.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 74f8fcb..de384a1 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -591,7 +591,11 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 		goto out;
 	}
 	tclk = clk_get_rate(drv_data->clk);
-	of_property_read_u32(np, "clock-frequency", &bus_freq);
+
+	rc = of_property_read_u32(np, "clock-frequency", &bus_freq);
+	if (rc)
+		goto out;
+
 	if (!mv64xxx_find_baud_factors(bus_freq, tclk,
 				       &drv_data->freq_n, &drv_data->freq_m)) {
 		rc = -EINVAL;
-- 
1.8.1.2
