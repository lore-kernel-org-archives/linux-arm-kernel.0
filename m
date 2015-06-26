From: yizhang@marvell.com (Yi Zhang)
Date: Fri, 26 Jun 2015 13:53:17 +0800
Subject: [PATCH-v4 1/3] mfd: 88pm800: Add device tree support
In-Reply-To: <558C1DF5.2060103@linaro.org>
References: <1435217189-19578-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1435217189-19578-2-git-send-email-vaibhav.hiremath@linaro.org>
 <20150625101916.GB15013@x1> <558BE1B7.2060308@linaro.org>
 <20150625144800.GC23990@x1> <558C1DF5.2060103@linaro.org>
Message-ID: <20150626055317.GA32687@yizhang>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 25, 2015 at 08:57:49PM +0530, Vaibhav Hiremath wrote:
> 
> 
> On Thursday 25 June 2015 08:18 PM, Lee Jones wrote:
> >On Thu, 25 Jun 2015, Vaibhav Hiremath wrote:
> >>On Thursday 25 June 2015 03:49 PM, Lee Jones wrote:
> >>>On Thu, 25 Jun 2015, Vaibhav Hiremath wrote:
> >>>
> >>>>Add DT support to the 88pm800 driver, along with compatible
> >>>>field for it's sub-devices (rtc, onkey and regulator)
> >>>>
> >>>>Signed-off-by: Chao Xie <chao.xie@marvell.com>
> >>>>Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> >>>>---
> >>>>  drivers/mfd/88pm800.c | 23 +++++++++++++++++++++++
> >>>>  1 file changed, 23 insertions(+)
> >>>>
> >>>>diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
> >>>>index 841717a..40fd014 100644
> >>>>--- a/drivers/mfd/88pm800.c
> >>>>+++ b/drivers/mfd/88pm800.c
> >>>>@@ -27,6 +27,7 @@
> >>>>  #include <linux/mfd/core.h>
> >>>>  #include <linux/mfd/88pm80x.h>
> >>>>  #include <linux/slab.h>
> >>>>+#include <linux/of_device.h>
> >>>>
> >>>>  /* Interrupt Registers */
> >>>>  #define PM800_INT_STATUS1		(0x05)
> >>>>@@ -121,6 +122,11 @@ static const struct i2c_device_id pm80x_id_table[] = {
> >>>>  };
> >>>>  MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
> >>>>
> >>>>+static const struct of_device_id pm80x_of_match_table[] = {
> >>>>+	{ .compatible = "marvell,88pm800", },
> >>>>+	{},
> >>>>+};
> >>>>+
> >>>>  static struct resource rtc_resources[] = {
> >>>>  	{
> >>>>  	 .name = "88pm80x-rtc",
> >>>>@@ -133,6 +139,7 @@ static struct resource rtc_resources[] = {
> >>>>  static struct mfd_cell rtc_devs[] = {
> >>>>  	{
> >>>>  	 .name = "88pm80x-rtc",
> >>>>+	 .of_compatible = "marvell,88pm80x-rtc",
> >>>>  	 .num_resources = ARRAY_SIZE(rtc_resources),
> >>>>  	 .resources = &rtc_resources[0],
> >>>>  	 .id = -1,
> >>>>@@ -151,6 +158,7 @@ static struct resource onkey_resources[] = {
> >>>>  static const struct mfd_cell onkey_devs[] = {
> >>>>  	{
> >>>>  	 .name = "88pm80x-onkey",
> >>>>+	 .of_compatible = "marvell,88pm80x-onkey",
> >>>>  	 .num_resources = 1,
> >>>>  	 .resources = &onkey_resources[0],
> >>>>  	 .id = -1,
> >>>>@@ -160,6 +168,7 @@ static const struct mfd_cell onkey_devs[] = {
> >>>>  static const struct mfd_cell regulator_devs[] = {
> >>>>  	{
> >>>>  	 .name = "88pm80x-regulator",
> >>>>+	 .of_compatible = "marvell,88pm80x-regulator",
> >>>>  	 .id = -1,
> >>>>  	},
> >>>>  };
> >>>>@@ -544,8 +553,21 @@ static int pm800_probe(struct i2c_client *client,
> >>>>  	int ret = 0;
> >>>>  	struct pm80x_chip *chip;
> >>>>  	struct pm80x_platform_data *pdata = dev_get_platdata(&client->dev);
> >>>>+	struct device_node *np = client->dev.of_node;
> >>>>  	struct pm80x_subchip *subchip;
> >>>>
> >>>>+	if (!pdata && !np) {
> >>>>+		dev_err(&client->dev,
> >>>>+			"pm80x requires platform data or of_node\n");
> >>>>+		return -EINVAL;
> >>>>+	}
> >>>>+
> >>>>+	if (!pdata) {
> >>>>+		pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
> >>>>+		if (!pdata)
> >>>>+			return -ENOMEM;
> >>>>+	}
> >>>
> >>>Why have you allocated data for pdata, then done nothing with it?
> >>>
> >>
> >>Not in this patch, but subsequent patches would use it.
> >
> >Only provide it when you start using it please.
> >
> 
> I will take back my earlier comment of "not using in this patch, but
> subsequent patches".
> 
> pdata is being used, couple of places in the driver,
> 
> 
> @line-751
> 
>         ret = device_800_init(chip, pdata);
>         if (ret) {
>                 dev_err(chip->dev, "Failed to initialize 88pm800
> devices\n");
>                 goto err_device_init;
>         }
> 
>         if (pdata && pdata->plat_config)
>                 pdata->plat_config(chip, pdata);

  this plat_config() is used in legacy non-device-tree code, it's used
  to implement fixup for chip or board level, it exists in
  the board configuration file

  just curious, do you think we still need to keep it?
  considering device-tree has been used. thanks;

> 
> Thanks,
> Vaibhav
