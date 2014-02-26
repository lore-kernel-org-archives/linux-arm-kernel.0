From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 26 Feb 2014 09:26:39 +0200
Subject: TWL6040 fails to initialize
In-Reply-To: <530CB9C6.60806@epfl.ch>
References: <530C70B3.4010103@epfl.ch> <530CA8DA.8050806@ti.com>
 <530CB9C6.60806@epfl.ch>
Message-ID: <530D972F.805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2014 05:41 PM, Florian Vaussard wrote:
> If the power was not enabled at all, I would be unable to read the
> revision register, no? And delaying the probe by one millisecond would
> be of no help in this case IMHO.

One thing which might cause this is that if the audpwron GPIO is set high
before the twl6040 module is probing. When I request the GPIO I ask it to be
set to low. If the line was high before this means we initiate the power off
sequence.
Can you try something like this:

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index 75316fb33448..d2a0bd1539ae 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -674,6 +674,9 @@ static int twl6040_probe(struct i2c_client *client,
                                            GPIOF_OUT_INIT_LOW, "audpwron");
                if (ret)
                        goto gpio_err;
+
+               /* power-down sequence latency */
+               usleep_range(500, 700);
        }

        ret = regmap_add_irq_chip(twl6040->regmap, twl6040->irq, IRQF_ONESHOT,


-- 
P?ter
