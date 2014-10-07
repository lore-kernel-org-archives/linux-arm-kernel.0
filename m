From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 7 Oct 2014 11:14:41 +0200
Subject: [PATCH 5/5] regulator: Remove unnecessary ena_gpio initializations
In-Reply-To: <5433A9CD.8090007@samsung.com>
References: <1412626635-7404-1-git-send-email-mpa@pengutronix.de>
 <1412626635-7404-6-git-send-email-mpa@pengutronix.de>
 <5433A9CD.8090007@samsung.com>
Message-ID: <20141007091441.GE5042@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 10:52:29AM +0200, Krzysztof Koz?owski wrote:
> On 06.10.2014 22:17, Markus Pargmann wrote:
> >It is not necessary to setup config.ena_gpio with -EINVAL or similar.
> >This patch removes these unnecessary initializations.
> >
> >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> >---
> >  drivers/regulator/pfuze100-regulator.c | 1 -
> >  drivers/regulator/s5m8767.c            | 2 --
> >  2 files changed, 3 deletions(-)
> >
> >diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
> >index c879dff597ee..d7455ee309bf 100644
> >--- a/drivers/regulator/pfuze100-regulator.c
> >+++ b/drivers/regulator/pfuze100-regulator.c
> >@@ -509,7 +509,6 @@ static int pfuze100_regulator_probe(struct i2c_client *client,
> >  		config.init_data = init_data;
> >  		config.driver_data = pfuze_chip;
> >  		config.of_node = match_of_node(i);
> >-		config.ena_gpio = -EINVAL;
> >
> >  		pfuze_chip->regulators[i] =
> >  			devm_regulator_register(&client->dev, desc, &config);
> >diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
> >index d258e6613831..2c7817f12516 100644
> >--- a/drivers/regulator/s5m8767.c
> >+++ b/drivers/regulator/s5m8767.c
> >@@ -949,8 +949,6 @@ static int s5m8767_pmic_probe(struct platform_device *pdev)
> >  		config.driver_data = s5m8767;
> >  		config.regmap = iodev->regmap_pmic;
> >  		config.of_node = pdata->regulators[i].reg_node;
> >-		config.ena_gpio = -EINVAL;
> >-		config.ena_gpio_flags = 0;
> >  		if (gpio_is_valid(pdata->regulators[i].ext_control_gpio))
> >  			s5m8767_regulator_config_ext_control(s5m8767,
> >  					&pdata->regulators[i], &config);
> 
> This would bring back problem with carried over ena_gpio (commit
> f4fbb3ce342bc1 "regulator: s5m8767: Fix carried over ena_gpio
> assignment").
> 
> The "config" is re-used in loop for next regulators. This means that
> the "config.ena_gpio" has to be set here to prevent using the same
> value for next regulator.
> 
> I think these lines shouldn't be removed.

Yes right, thanks.

Best regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141007/1824284c/attachment-0001.sig>
