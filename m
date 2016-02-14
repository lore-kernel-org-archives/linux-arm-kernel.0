From: milo.kim@ti.com (Kim, Milo)
Date: Mon, 15 Feb 2016 08:31:02 +0900
Subject: [PATCH v2 2/4] regulator: lp872x: Add enable GPIO pin support
In-Reply-To: <1455301532.2760.1.camel@collins>
References: <1454697741-8687-1-git-send-email-contact@paulk.fr>
 <1454697741-8687-3-git-send-email-contact@paulk.fr> <56BD23ED.8010207@ti.com>
 <1455301532.2760.1.camel@collins>
Message-ID: <56C10E36.1030808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/13/2016 3:25 AM, Paul Kocialkowski wrote:
>>> > >+
>>> > >+	/* Always set enable GPIO high. */
>>> > >+	ret = devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "LP872X EN");
>>> > >+	if (ret) {
>>> > >+		dev_err(lp->dev, "gpio request err: %d\n", ret);
>>> > >+		return ret;
>>> > >+	}
>>> > >+
>>> > >+	/* Each chip has a different enable delay. */
>>> > >+	if (lp->chipid == LP8720)
>>> > >+		usleep_range(LP8720_ENABLE_DELAY, 1.5 * LP8720_ENABLE_DELAY);
>>> > >+	else
>>> > >+		usleep_range(LP8725_ENABLE_DELAY, 1.5 * LP8725_ENABLE_DELAY);
>>> > >+
>>> > >+	return 0;
>>> > >+}
>>> > >+
>>> > >   static int lp872x_config(struct lp872x *lp)
>>> > >   {
>>> > >   	struct lp872x_platform_data *pdata = lp->pdata;
>>> > >@@ -875,6 +903,8 @@ static struct lp872x_platform_data
>>> > >   	of_property_read_u8(np, "ti,dvs-state", &dvs_state);
>>> > >   	pdata->dvs->init_state = dvs_state ? DVS_HIGH : DVS_LOW;
>>> > >
>>> > >+	pdata->enable_gpio = of_get_named_gpio(np, "enable-gpios", 0);
>> >
>> >Please move this code to lp872x_populate_pdata_from_dt().
> This already adds it in lp872x_populate_pdata_from_dt (see the context
> around the insertion).

Ah, sorry. Your patch is correct.

> I don't know why the diff makes it seem like it's added in
> lp872x_config. It's really not.

I think it was from a line break of lp872x_populate_pdata_from_dt().
Let me add my ACK to this patch. Thank you.

Best regards,
Milo
