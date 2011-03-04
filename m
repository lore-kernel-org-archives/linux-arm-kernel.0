From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Fri, 4 Mar 2011 11:04:14 +0530
Subject: staging: iio: ak8975: make gpio platdata mandatory
Message-ID: <AANLkTik1MSkfyb36AHUOG+OK=h=rt1D4sbpyUiYg07dT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Issue:
For some architectures CONFIG_GENERIC_GPIO is defined,
leaving irq_to_gpio undefined.  Causing build break.

Solution:
1. Some architechtures define irq_to_gpio in machine specific code.
2. Make GPIO in platdata mandatory.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
---

 drivers/staging/iio/magnetometer/ak8975.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/ak8975.c
b/drivers/staging/iio/magnetometer/ak8975.c
index 80c0f41..8456d1f 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -98,7 +98,6 @@ struct ak8975_data {
        unsigned long           mode;
        u8                      reg_cache[AK8975_MAX_REGS];
        int                     eoc_gpio;
-       int                     eoc_irq;
 };

 /*
@@ -453,12 +452,13 @@ static int ak8975_probe(struct i2c_client *client,
        mutex_init(&data->lock);

        /* Grab and set up the supplied GPIO. */
-       data->eoc_irq = client->irq;
        pdata = client->dev.platform_data;
        if (pdata)
                data->eoc_gpio = pdata->gpio;
-       else
-               data->eoc_gpio = irq_to_gpio(client->irq);
+       else {
+       else {
+               dev_err(&client->dev, "failed, no platform GPIO specified\n");
+               goto exit;
+       }

        if (!data->eoc_gpio) {
                dev_err(&client->dev, "failed, no valid GPIO\n");
--
1.7.0.4

--
Shine bright,
(: Nav :)
