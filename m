From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  2 May 2013 16:48:10 +0100
Subject: [PATCH 4/4] =?UTF-8?q?staging:=20ste=5Frmi4:=20Suppress=20'ignoring?=
 =?UTF-8?q?=20return=20value=20of=20=E2=80=98regulator=5Fenable()'=20warning?=
In-Reply-To: <1367509690-24022-1-git-send-email-lee.jones@linaro.org>
References: <1367509690-24022-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367509690-24022-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c:
        In function ?synaptics_rmi4_resume?:
drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c:1090:18:
        warning: ignoring return value of ?regulator_enable?, declared
        with attribute warn_unused_result [-Wunused-result

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel at driverdev.osuosl.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c b/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
index fe667dd..c4d013d 100644
--- a/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
+++ b/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
@@ -1087,7 +1087,9 @@ static int synaptics_rmi4_resume(struct device *dev)
 	unsigned char intr_status;
 	struct synaptics_rmi4_data *rmi4_data = dev_get_drvdata(dev);
 
-	regulator_enable(rmi4_data->regulator);
+	retval = regulator_enable(rmi4_data->regulator);
+	if (retval < 0)
+		return retval;
 
 	enable_irq(rmi4_data->i2c_client->irq);
 	rmi4_data->touch_stopped = false;
-- 
1.7.10.4
