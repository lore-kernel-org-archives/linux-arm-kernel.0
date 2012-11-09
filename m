From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 9 Nov 2012 08:52:19 +0100
Subject: [PATCH v2 04/10] pwm: pwm-tiecap: Add device-tree binding
 support for APWM driver
In-Reply-To: <1352361197-27442-5-git-send-email-avinashphilip@ti.com>
References: <1352361197-27442-1-git-send-email-avinashphilip@ti.com>
 <1352361197-27442-5-git-send-email-avinashphilip@ti.com>
Message-ID: <20121109075219.GA22224@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 08, 2012 at 01:23:11PM +0530, Philip, Avinash wrote:
> This patch
> 1. Add support for device-tree binding for ECAP APWM driver.
> 2. Set size of pwm-cells set to 3 to support PWM channel number, PWM
>    period & polarity configuration from device tree.
> 3. Add enable/disable clock gating in PWM subsystem common config space.
> 4. When here set .owner member in platform_driver structure to
>    THIS_MODULE.
> 
> Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> Cc:	Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Rob Landley <rob@landley.net>
> ---
> Changes since v1:
> 	- Add separate patch for pinctrl support
> 	- Add conditional check for PWM subsystem clock enable.
> 	- Combined with HWMOD changes & DT bindings.
> 	- Remove the custom of xlate support.
> 
> :000000 100644 0000000... fe24cac... A	Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
> :100644 100644 d6d4cf0... 0d43266... M	drivers/pwm/pwm-tiecap.c
>  .../devicetree/bindings/pwm/pwm-tiecap.txt         |   22 +++++++++
>  drivers/pwm/pwm-tiecap.c                           |   48 +++++++++++++++++++-
>  2 files changed, 69 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
> new file mode 100644
> index 0000000..fe24cac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
> @@ -0,0 +1,22 @@
> +TI SOC ECAP based APWM controller
> +
> +Required properties:
> +- compatible: Must be "ti,am33xx-ecap"
> +- #pwm-cells: Should be 3. Number of cells being used to specify PWM property.
> +  First cell specifies the per-chip index of the PWM to use, the second
> +  cell is the period cycle in nanoseconds and bit 0 in the third cell is

I think this should be "period in nanoseconds". I haven't heard "period
cycle" before.

> +  used to encode the polarity of PWM output.

Maybe you should explicitly say how this is encoded.

> +- reg: physical base address and size of the registers map.
> +
> +Optional properties:
> +- ti,hwmods: Name of the hwmod associated to the ECAP:
> +  "ecap<x>", <x> being the 0-based instance number from the HW spec
> +
> +Example:
> +
> +ecap0: ecap at 0 {
> +	compatible = "ti,am33xx-ecap";
> +	#pwm-cells = <3>;
> +	reg = <0x48300100 0x80>;
> +	ti,hwmods = "ecap0";
> +};
> diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
> index d6d4cf0..0d43266 100644
> --- a/drivers/pwm/pwm-tiecap.c
> +++ b/drivers/pwm/pwm-tiecap.c
> @@ -25,6 +25,9 @@
>  #include <linux/clk.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pwm.h>
> +#include <linux/of_device.h>
> +
> +#include "tipwmss.h"
>  
>  /* ECAP registers and bits definitions */
>  #define CAP1			0x08
> @@ -37,6 +40,13 @@
>  #define ECCTL2_SYNC_SEL_DISA	(BIT(7) | BIT(6))
>  #define ECCTL2_TSCTR_FREERUN	BIT(4)
>  
> +#define ECAPCLK_EN			BIT(0)
> +#define ECAPCLK_STOP_REQ	BIT(1)

This one doesn't seem to align with the rest. Also, why is bit 0 called
_EN and bit 1 _STOP_REQ? Couldn't they be made more consistent, i.e.
_START and _STOP? Or _ENABLE and _DISABLE?

> +
> +#define ECAPCLK_EN_ACK		BIT(0)
> +
> +#define PWM_CELL_SIZE		3

You don't need a define for this.

> +
>  struct ecap_pwm_chip {
>  	struct pwm_chip	chip;
>  	unsigned int	clk_rate;
> @@ -184,6 +194,16 @@ static const struct pwm_ops ecap_pwm_ops = {
>  	.owner		= THIS_MODULE,
>  };
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id ecap_of_match[] = {
> +	{
> +		.compatible	= "ti,am33xx-ecap",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ecap_of_match);
> +#endif
> +

I'm not sure if I remember correctly, but wasn't AM33xx support supposed
to be DT only? In that case you don't need the CONFIG_OF guards.

>  static int __devinit ecap_pwm_probe(struct platform_device *pdev)

__devinit can go away.

>  {
>  	int ret;
> @@ -211,6 +231,7 @@ static int __devinit ecap_pwm_probe(struct platform_device *pdev)
>  
>  	pc->chip.dev = &pdev->dev;
>  	pc->chip.ops = &ecap_pwm_ops;
> +	pc->chip.of_pwm_n_cells = PWM_CELL_SIZE;
>  	pc->chip.base = -1;
>  	pc->chip.npwm = 1;
>  
> @@ -231,14 +252,37 @@ static int __devinit ecap_pwm_probe(struct platform_device *pdev)
>  	}
>  
>  	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_get_sync(&pdev->dev);

Maybe put a blank line after this for readability.

> +	if (!(pwmss_submodule_state_change(pdev->dev.parent, ECAPCLK_EN) &
> +				ECAPCLK_EN_ACK)) {

This is very hard to read, can you split this up into something like the
following please?

	status = pwmss_submodule_state_change(pdev->dev.parent, ECAPCLK_EN);
	if (!(status & ECAPCLK_EN_ACK)) {
		...
	}

> +		dev_err(&pdev->dev, "PWMSS config space clock enable failure\n");
> +		ret = -EINVAL;
> +		goto pwmss_clk_failure;
> +	}
> +	pm_runtime_put_sync(&pdev->dev);

Another blank line between the two above would be good.

> +
>  	platform_set_drvdata(pdev, pc);
>  	return 0;
> +
> +pwmss_clk_failure:
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	pwmchip_remove(&pc->chip);
> +	return ret;
>  }
>  
>  static int __devexit ecap_pwm_remove(struct platform_device *pdev)

No __devexit please.

>  {
>  	struct ecap_pwm_chip *pc = platform_get_drvdata(pdev);
>  
> +	pm_runtime_get_sync(&pdev->dev);
> +	/*
> +	 * Due to hardware misbehaviour, acknowledge of the stop_req
> +	 * is missing. Hence checking of the status bit skipped.
> +	 */
> +	pwmss_submodule_state_change(pdev->dev.parent, ECAPCLK_STOP_REQ);
> +	pm_runtime_put_sync(&pdev->dev);
> +
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	return pwmchip_remove(&pc->chip);
> @@ -246,7 +290,9 @@ static int __devexit ecap_pwm_remove(struct platform_device *pdev)
>  
>  static struct platform_driver ecap_pwm_driver = {
>  	.driver = {
> -		.name = "ecap",
> +		.name	= "ecap",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = of_match_ptr(ecap_of_match),

Here as well, if AM33xx is DT-only, then the of_match_ptr() can be
dropped.

>  	},
>  	.probe = ecap_pwm_probe,
>  	.remove = __devexit_p(ecap_pwm_remove),

No __devexit_p() please.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121109/ed27409b/attachment-0001.sig>
