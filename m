From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 3 Dec 2010 17:21:54 +0530
Subject: [PATCH v9 6/6] davinci: USB1.1 support for Omapl138-Hawkboard
In-Reply-To: <AANLkTinMGvRS4N2rSRp43Osnn_Df=JRAJB0iBdZLzrZ-@mail.gmail.com>
References: <1291231949-23835-1-git-send-email-vm.rod25@gmail.com>
	<1291231949-23835-7-git-send-email-vm.rod25@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247AFDD7E@dbde02.ent.ti.com>
	<AANLkTinMGvRS4N2rSRp43Osnn_Df=JRAJB0iBdZLzrZ-@mail.gmail.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930247B9A907@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 03, 2010 at 06:14:39, Victor Rodriguez wrote:
> On Thu, Dec 2, 2010 at 12:49 AM, Nori, Sekhar <nsekhar@ti.com> wrote:
> > On Thu, Dec 02, 2010 at 01:02:29, vm.rod25 at gmail.com wrote:
> >> +static int hawk_usb_ocic_notify(da8xx_ocic_handler_t handler)
> >> +{
> >> +     int irq         = gpio_to_irq(DA850_USB1_OC_PIN);
> >> +     int error       = 0;
> >> +
> >> +     if (handler != NULL) {
> >> +             hawk_usb_ocic_handler = handler;
> >> +
> >> +             error = request_irq(irq, omapl138_hawk_usb_ocic_irq,
> >> +                                     IRQF_DISABLED | IRQF_TRIGGER_RISING |
> >> +                                     IRQF_TRIGGER_FALLING,
> >> +                                     "OHCI over-current indicator", NULL);
> >> +             if (error)
> >> +                     pr_err(KERN_ERR "%s: could not request IRQ to watch "
> >> +                             "over-current indicator changes\n", __func__);
> >
> > pr_err adds a KERN_ERR already.
>
> Changed to this
>
> static int hawk_usb_ocic_notify(da8xx_ocic_handler_t handler)
> {
>       int irq         = gpio_to_irq(DA850_USB1_OC_PIN);
>       int error       = 0;
>
>       if (handler != NULL) {
>               hawk_usb_ocic_handler = handler;
>
>               error = request_irq(irq, omapl138_hawk_usb_ocic_irq,
>                                       IRQF_DISABLED | IRQF_TRIGGER_RISING |
>                                       IRQF_TRIGGER_FALLING,
>                                       "OHCI over-current indicator", NULL);
>               if (error)
>                       pr_err("%s: could not request IRQ to watch "
>                               "over-current indicator changes\n", __func__);

Looks good. Thanks. The same error is present elsewhere in the
patch and other patches too. Please fix those too.

>
> USB part
>
> Changed to this
>
>       if (ret < 0) {
>               pr_err("%s: failed to request GPIO for USB 1.1 port "
>                       "power control: %d\n", __func__, ret);
>               gpio_free(DA850_USB1_VBUS_PIN);
>               return;
>       }
>
>       ret = gpio_request_one(DA850_USB1_OC_PIN,
>                       GPIOF_DIR_IN, "USB1 OC");
>       if (ret < 0) {
>               pr_err("%s: failed to request GPIO for USB 1.1 port "
>                       "over-current indicator: %d\n", __func__, ret);
>               gpio_free(DA850_USB1_OC_PIN);
>               return;
>       }
>
> Patch 4/6
>
>       ret = gpio_request_one(DA850_HAWK_MMCSD_CD_PIN,
>                       GPIOF_DIR_IN, "MMC CD");
>       if (ret < 0) {
>               pr_warning("%s: can not open GPIO %d\n",
>                       __func__, DA850_HAWK_MMCSD_CD_PIN);
>               gpio_free(DA850_HAWK_MMCSD_CD_PIN);
>               return;
>       }
>
>       ret = gpio_request_one(DA850_HAWK_MMCSD_WP_PIN,
>                       GPIOF_DIR_IN, "MMC WP");
>       if (ret < 0) {
>               pr_warning("%s: can not open GPIO %d\n",
>                       __func__, DA850_HAWK_MMCSD_WP_PIN);
>               gpio_free(DA850_HAWK_MMCSD_WP_PIN);
>               return;
>       }
>
>
> Is this ok ? or should I free the GPIO on the next section ? Same with USB

Not sure what you mean by "next section"? goto based error recovery is
more commonly used and probably more preferred as it is easier to extend.

You can look at function da850_evm_ui_expander_setup() of
arch/arm/mach-davinci/board-da850-evm.c for an example.

Thanks,
Sekhar
