From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Mar 2015 18:01 +0100
Subject: [PATCH 06/10] iio: exynos-adc: add experimental touchscreen
 support
In-Reply-To: <20150304231000.GD38298@dtor-ws>
References: <1425299763-4066822-1-git-send-email-arnd@arndb.de>
 <1425299763-4066822-7-git-send-email-arnd@arndb.de>
 <20150304231000.GD38298@dtor-ws>
Message-ID: <2880161.O2Qj0NkBq3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 March 2015 15:10:00 Dmitry Torokhov wrote:
> > +static int exynos_adc_ts_init(struct exynos_adc *info)
> > +{
> > +     int ret;
> > +
> > +     if (info->tsirq <= 0)
> > +             return -ENODEV;
> > +
> > +     info->input = input_allocate_device();
> > +     if (!info->input)
> > +             return -ENOMEM;
> > +
> > +     info->input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> > +     info->input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> > +
> > +     input_set_abs_params(info->input, ABS_X, 0, 0x3FF, 0, 0);
> > +     input_set_abs_params(info->input, ABS_Y, 0, 0x3FF, 0, 0);
> > +
> > +     info->input->name = "S3C24xx TouchScreen";
> > +     info->input->id.bustype = BUS_HOST;
> > +     info->input->open = exynos_adc_ts_open;
> > +     info->input->close = exynos_adc_ts_close;
> > +
> > +     input_set_drvdata(info->input, info);
> > +
> > +     ret = input_register_device(info->input);
> > +     if (ret)
> > +             input_free_device(info->input);
> 
> 
> If you fail to register input device are you sure you want to continue
> and register interrupt?
> 
> > +
> > +     disable_irq(info->tsirq);
> > +     ret = request_threaded_irq(info->tsirq, NULL, exynos_ts_isr,
> > +                                0, "touchscreen", info);
> > +     if (ret)
> > +             input_unregister_device(info->input);
> > +
> > +     return ret;
> > +}

Sorry for the delayed reply, I've now folded in this patch:


diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 75cd381a8181..d11cd604562c 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -732,8 +732,10 @@ static int exynos_adc_ts_init(struct exynos_adc *info)
 	input_set_drvdata(info->input, info);
 
 	ret = input_register_device(info->input);
-	if (ret)
+	if (ret) {
 		input_free_device(info->input);
+		return ret;
+	}
 
 	disable_irq(info->tsirq);
 	ret = request_threaded_irq(info->tsirq, NULL, exynos_ts_isr,


	Arnd
