From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Sun, 26 Jun 2016 20:20:43 +0900
Subject: [PATCH] extcon: Add support for qcom SPMI PMIC USB id detection
 hardware
In-Reply-To: <20160626055647.18898-1-stephen.boyd@linaro.org>
References: <20160626055647.18898-1-stephen.boyd@linaro.org>
Message-ID: <CAGTfZH3ireJWo5-Jd5SEiSy-WMTsw43pweruOqwSesAZqagvtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch looks good to me.
But, there is some comment.

2016-06-26 14:56 GMT+09:00 Stephen Boyd <stephen.boyd@linaro.org>:
> Some Qualcomm PMICs have a misc device that performs USB id pin
> detection via an interrupt. When the interrupt triggers, we
> should read the interrupt line to see if it has gone high or low.
> If the interrupt is low then the ID pin is grounded, and if the
> interrupt is high then the ID pin is being held high.
>
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  .../bindings/extcon/qcom,pm8941-misc.txt           |  41 +++++
>  drivers/extcon/Kconfig                             |   6 +
>  drivers/extcon/Makefile                            |   1 +
>  drivers/extcon/extcon-qcom-spmi-misc.c             | 170 +++++++++++++++++++++
>  4 files changed, 218 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.txt
>  create mode 100644 drivers/extcon/extcon-qcom-spmi-misc.c
>
> diff --git a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.txt b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.txt
> new file mode 100644
> index 000000000000..35383adb10f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.txt
> @@ -0,0 +1,41 @@
> +Qualcomm's PM8941 USB ID Extcon device
> +
> +Some Qualcomm PMICs have a "misc" module that can be used to detect when
> +the USB ID pin has been pulled low or high.
> +
> +PROPERTIES
> +
> +- compatible:
> +    Usage: required
> +    Value type: <string>
> +    Definition: Should contain "qcom,pm8941-misc";
> +
> +- reg:
> +    Usage: required
> +    Value type: <u32>
> +    Definition: Should contain the offset to the misc address space

'reg' property is used on extcon-qcom-spmi-misc.c?
I think that you don't need to include this property.

> +
> +- interrupts:
> +    Usage: required
> +    Value type: <prop-encoded-array>
> +    Definition: Should contain the usb id interrupt
> +
> +- interrupt-names:
> +    Usage: required
> +    Value type: <stringlist>
> +    Definition: Should contain the string "usb_id" for the usb id interrupt
> +
> +Example:
> +
> +       pmic {
> +               usb_id: misc at 900 {
> +                       compatible = "qcom,pm8941-misc";
> +                       reg = <0x900>;
> +                       interrupts = <0x0 0x9 0 IRQ_TYPE_EDGE_BOTH>;
> +                       interrupt-names = "usb_id";
> +               };
> +       }
> +
> +       usb-controller {
> +               extcon = <&usb_id>;
> +       };
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index 3d89e60a3e71..b2ee47cb10ca 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -119,6 +119,12 @@ config EXTCON_SM5502
>           Silicon Mitus SM5502. The SM5502 is a USB port accessory
>           detector and switch.
>
> +config EXTCON_QCOM_SPMI_MISC
> +       tristate "Qualcomm USB extcon support"
> +       help
> +         Say Y here to enable SPMI PMIC based USB cable detection
> +         support on Qualcomm PMICs such as PM8941.

You need to reorder the entry alphabetically. You better to move
it below

> +
>  config EXTCON_USB_GPIO
>         tristate "USB GPIO extcon support"
>         depends on GPIOLIB || COMPILE_TEST
> diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
> index 2a0e4f45d5b2..8cf6eb068d34 100644
> --- a/drivers/extcon/Makefile
> +++ b/drivers/extcon/Makefile
> @@ -15,4 +15,5 @@ obj-$(CONFIG_EXTCON_MAX8997)  += extcon-max8997.o
>  obj-$(CONFIG_EXTCON_PALMAS)    += extcon-palmas.o
>  obj-$(CONFIG_EXTCON_RT8973A)   += extcon-rt8973a.o
>  obj-$(CONFIG_EXTCON_SM5502)    += extcon-sm5502.o
> +obj-$(CONFIG_EXTCON_QCOM_SPMI_MISC) += extcon-qcom-spmi-misc.o
>  obj-$(CONFIG_EXTCON_USB_GPIO)  += extcon-usb-gpio.o
> diff --git a/drivers/extcon/extcon-qcom-spmi-misc.c b/drivers/extcon/extcon-qcom-spmi-misc.c
> new file mode 100644
> index 000000000000..f0ec6f1541e1
> --- /dev/null
> +++ b/drivers/extcon/extcon-qcom-spmi-misc.c
> @@ -0,0 +1,170 @@
> +/**
> + * Based on extcon-usb-gpio.c
> + *
> + * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
> + * Author: Roger Quadros <rogerq@ti.com>
> + *
> + * Copyright (C) 2016 Linaro Ltd
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/extcon.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +
> +#define USB_ID_DEBOUNCE_MS     5       /* ms */
> +
> +struct qcom_usb_extcon_info {
> +       struct extcon_dev *edev;
> +       int irq;
> +       struct delayed_work wq_detcable;
> +       unsigned long debounce_jiffies;
> +};
> +
> +static const unsigned int qcom_usb_extcon_cable[] = {
> +       EXTCON_USB_HOST,
> +       EXTCON_NONE,
> +};
> +
> +static void qcom_usb_extcon_detect_cable(struct work_struct *work)
> +{
> +       bool id;
> +       int ret;
> +       struct qcom_usb_extcon_info *info = container_of(to_delayed_work(work),
> +                                                   struct qcom_usb_extcon_info,
> +                                                   wq_detcable);
> +
> +       /* check ID and update cable state */
> +       ret = irq_get_irqchip_state(info->irq, IRQCHIP_STATE_LINE_LEVEL, &id);
> +       if (ret)
> +               return;
> +
> +       extcon_set_cable_state_(info->edev, EXTCON_USB_HOST, !id);
> +}
> +
> +static irqreturn_t qcom_usb_irq_handler(int irq, void *dev_id)
> +{
> +       struct qcom_usb_extcon_info *info = dev_id;
> +
> +       queue_delayed_work(system_power_efficient_wq, &info->wq_detcable,
> +                          info->debounce_jiffies);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int qcom_usb_extcon_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct qcom_usb_extcon_info *info;
> +       int ret;
> +
> +       info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +       if (!info)
> +               return -ENOMEM;
> +
> +       info->edev = devm_extcon_dev_allocate(dev, qcom_usb_extcon_cable);
> +       if (IS_ERR(info->edev)) {
> +               dev_err(dev, "failed to allocate extcon device\n");
> +               return -ENOMEM;
> +       }
> +
> +       ret = devm_extcon_dev_register(dev, info->edev);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to register extcon device\n");
> +               return ret;
> +       }
> +
> +       info->debounce_jiffies = msecs_to_jiffies(USB_ID_DEBOUNCE_MS);
> +       INIT_DELAYED_WORK(&info->wq_detcable, qcom_usb_extcon_detect_cable);
> +
> +       info->irq = platform_get_irq_byname(pdev, "usb_id");
> +       if (info->irq < 0)
> +               return info->irq;
> +
> +       ret = devm_request_threaded_irq(dev, info->irq, NULL,
> +                                       qcom_usb_irq_handler,
> +                                       IRQF_TRIGGER_RISING |
> +                                       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +                                       pdev->name, info);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to request handler for ID IRQ\n");
> +               return ret;
> +       }
> +
> +       platform_set_drvdata(pdev, info);
> +       device_init_wakeup(dev, 1);
> +
> +       /* Perform initial detection */
> +       qcom_usb_extcon_detect_cable(&info->wq_detcable.work);
> +
> +       return 0;
> +}
> +
> +static int qcom_usb_extcon_remove(struct platform_device *pdev)
> +{
> +       struct qcom_usb_extcon_info *info = platform_get_drvdata(pdev);
> +
> +       cancel_delayed_work_sync(&info->wq_detcable);
> +
> +       return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int qcom_usb_extcon_suspend(struct device *dev)
> +{
> +       struct qcom_usb_extcon_info *info = dev_get_drvdata(dev);
> +       int ret = 0;
> +
> +       if (device_may_wakeup(dev))
> +               ret = enable_irq_wake(info->irq);
> +
> +       return ret;
> +}
> +
> +static int qcom_usb_extcon_resume(struct device *dev)
> +{
> +       struct qcom_usb_extcon_info *info = dev_get_drvdata(dev);
> +       int ret = 0;
> +
> +       if (device_may_wakeup(dev))
> +               ret = disable_irq_wake(info->irq);
> +
> +       return ret;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(qcom_usb_extcon_pm_ops,
> +                        qcom_usb_extcon_suspend, qcom_usb_extcon_resume);
> +
> +static const struct of_device_id qcom_usb_extcon_dt_match[] = {
> +       { .compatible = "qcom,pm8941-misc", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, qcom_usb_extcon_dt_match);
> +
> +static struct platform_driver qcom_usb_extcon_driver = {
> +       .probe          = qcom_usb_extcon_probe,
> +       .remove         = qcom_usb_extcon_remove,
> +       .driver         = {
> +               .name   = "extcon-pm8941-misc",
> +               .pm     = &qcom_usb_extcon_pm_ops,
> +               .of_match_table = qcom_usb_extcon_dt_match,
> +       },
> +};
> +module_platform_driver(qcom_usb_extcon_driver);
> +
> +MODULE_DESCRIPTION("QCOM USB ID extcon driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.9.0.rc2.8.ga28705d
>
