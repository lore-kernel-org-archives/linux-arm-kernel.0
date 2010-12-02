From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 2 Dec 2010 12:19:13 +0530
Subject: [PATCH v9 6/6] davinci: USB1.1 support for Omapl138-Hawkboard
In-Reply-To: <1291231949-23835-7-git-send-email-vm.rod25@gmail.com>
References: <1291231949-23835-1-git-send-email-vm.rod25@gmail.com>
	<1291231949-23835-7-git-send-email-vm.rod25@gmail.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930247AFDD7E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 02, 2010 at 01:02:29, vm.rod25 at gmail.com wrote:
> +static int hawk_usb_ocic_notify(da8xx_ocic_handler_t handler)
> +{
> +     int irq         = gpio_to_irq(DA850_USB1_OC_PIN);
> +     int error       = 0;
> +
> +     if (handler != NULL) {
> +             hawk_usb_ocic_handler = handler;
> +
> +             error = request_irq(irq, omapl138_hawk_usb_ocic_irq,
> +                                     IRQF_DISABLED | IRQF_TRIGGER_RISING |
> +                                     IRQF_TRIGGER_FALLING,
> +                                     "OHCI over-current indicator", NULL);
> +             if (error)
> +                     pr_err(KERN_ERR "%s: could not request IRQ to watch "
> +                             "over-current indicator changes\n", __func__);

pr_err adds a KERN_ERR already.

> +static __init void omapl138_hawk_usb_init(void)
> +{
> +     int ret;
> +     u32 cfgchip2;
> +
> +     ret = davinci_cfg_reg_list(da850_hawk_usb11_pins);
> +     if (ret) {
> +             pr_warning("%s: USB 1.1 PinMux setup failed: %d\n",
> +                     __func__, ret);
> +             return;
> +     }
> +
> +     /* Setup the Ref. clock frequency for the HAWK at 24 MHz. */
> +
> +     cfgchip2 = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
> +     cfgchip2 &= ~CFGCHIP2_REFFREQ;
> +     cfgchip2 |=  CFGCHIP2_REFFREQ_24MHZ;
> +     __raw_writel(cfgchip2, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
> +
> +     ret = gpio_request_one(DA850_USB1_VBUS_PIN,
> +                     GPIOF_DIR_OUT, "USB1 VBUS");
> +     if (ret < 0) {
> +             pr_err(KERN_ERR "%s: failed to request GPIO for USB 1.1 port "
> +                     "power control: %d\n", __func__, ret);
> +             return;
> +     }
> +
> +     ret = gpio_request_one(DA850_USB1_OC_PIN,
> +                     GPIOF_DIR_IN, "USB1 OC");
> +     if (ret < 0) {
> +             pr_err(KERN_ERR "%s: failed to request GPIO for USB 1.1 port "
> +                     "over-current indicator: %d\n", __func__, ret);
> +             return;
> +     }

Should free the gpio DA850_USB1_VBUS_PIN in this error
path. This is also valid for MMC/SD gpio acquisition in
patch 4/6.

Thanks,
Sekhar
