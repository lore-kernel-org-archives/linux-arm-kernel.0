From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 14 Jul 2015 22:21:32 -0700
Subject: [PATCH] pinctrl: add support for Qualcomm Technologies QDF2xxx
 ARM64 SoCs
In-Reply-To: <1436916544-811-1-git-send-email-timur@codeaurora.org>
References: <1436916544-811-1-git-send-email-timur@codeaurora.org>
Message-ID: <20150715052132.GF32767@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 14 Jul 16:29 PDT 2015, Timur Tabi wrote:

[..]

> diff --git a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c

[..]

> + *
> + * GPIO and pin control functions on this SOC are handled by the "TLMM"
> + * device.  The driver which controls this device is pinctrl-msm.c.  Each
> + * SOC with a TLMM is expected to create a client driver that registers
> + * with pinctrl-msm.c.  This means that all TLMM drivers are pin control
> + * drivers.
> + *
> + * This pin control driver is intended to be used only an ACPI-enabled
> + * system.  As such, UEFI will handle all pin control configuration, so
> + * this driver does not provide pin control functions.  It is effectively
> + * a GPIO-only driver.  The alternative is to duplicate the GPIO code of
> + * pinctrl-msm.c into another driver.
> + */

That should be fine, better reuse the existing code than duplicating it.

> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>

Do you really need pinmux.h?

> +#include <linux/acpi.h>
> +
> +#include "pinctrl-msm.h"
> +

[..]

> +
> +static struct platform_driver qdf2xxx_pinctrl_driver = {
> +	.driver = {
> +		.name = "qdf2xxx-pinctrl",
> +		.owner = THIS_MODULE,

No need to specify 'owner' of a platform_driver, so please drop this.

> +		.acpi_match_table = ACPI_PTR(qdf2xxx_acpi_ids),
> +	},
> +	.probe = qdf2xxx_pinctrl_probe,
> +	.remove = msm_pinctrl_remove,
> +};
> +
> +static int __init qdf2xxx_pinctrl_init(void)
> +{
> +	return platform_driver_register(&qdf2xxx_pinctrl_driver);
> +}
> +arch_initcall(qdf2xxx_pinctrl_init);
> +
> +static void __exit qdf2xxx_pinctrl_exit(void)
> +{
> +	platform_driver_unregister(&qdf2xxx_pinctrl_driver);
> +}
> +module_exit(qdf2xxx_pinctrl_exit);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies QDF2xxx pin control driver");
> +MODULE_LICENSE("GPL v2");

Looks good with above nits fixed.

Regards,
Bjorn
