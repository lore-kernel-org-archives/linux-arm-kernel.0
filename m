From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 08 Jun 2015 11:10:02 +0900
Subject: [RESEND 1/2] usb: ehci-exynos: Make provision for vdd regulators
In-Reply-To: <1433683242-3945-1-git-send-email-linux.amoon@gmail.com>
References: <1433683242-3945-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <5574F97A.5030104@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.06.2015 22:20, Anand Moon wrote:
> Facilitate getting required 3.3V and 1.0V VDD supply for
> EHCI controller on Exynos.
> 
> With the patches for regulators' nodes merged in 3.15:
> c8c253f ARM: dts: Add regulator entries to smdk5420
> 275dcd2 ARM: dts: add max77686 pmic node for smdk5250,
> the exynos systems turn on only minimal number of regulators.
> 
> Until now, the VDD regulator supplies were either turned on
> by the bootloader, or the regulators were enabled by default
> in the kernel, so that the controller drivers did not need to
> care about turning on these regulators on their own.
> This was rather bad about these controller drivers.
> So ensuring now that the controller driver requests the necessary
> VDD regulators (if available, unless there are direct VDD rails),
> and enable them so as to make them working.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> ---
> Initial version of this patch was part of following series, though
> they are not dependent on each other, resubmitting after rebasing.
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/266418.html

So you just took Vivek's patch along with all the credits... That is not
how we usually do this.

I would expect that rebasing a patch won't change the author unless this
is fine with Vivek.

> ---
>  .../devicetree/bindings/usb/exynos-usb.txt         |  2 +
>  drivers/usb/host/ehci-exynos.c                     | 55 +++++++++++++++++++++-
>  2 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
> index 9b4dbe3..776fa03 100644
> --- a/Documentation/devicetree/bindings/usb/exynos-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
> @@ -23,6 +23,8 @@ Required properties:
>  Optional properties:
>   - samsung,vbus-gpio:  if present, specifies the GPIO that
>     needs to be pulled up for the bus to be powered.
> + - vdd33-supply: handle to 3.3V Vdd supply regulator for the controller.
> + - vdd10-supply: handle to 1.0V Vdd supply regulator for the controller.
>  
>  Example:
>  
> diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
> index df538fd..4f8f9d2 100644
> --- a/drivers/usb/host/ehci-exynos.c
> +++ b/drivers/usb/host/ehci-exynos.c
> @@ -21,6 +21,7 @@
>  #include <linux/of_gpio.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
>  
> @@ -45,6 +46,8 @@ static struct hc_driver __read_mostly exynos_ehci_hc_driver;
>  struct exynos_ehci_hcd {
>  	struct clk *clk;
>  	struct phy *phy[PHY_NUMBER];
> +	struct regulator *vdd33;
> +	struct regulator *vdd10;
>  };
>  
>  #define to_exynos_ehci(hcd) (struct exynos_ehci_hcd *)(hcd_to_ehci(hcd)->priv)
> @@ -170,7 +173,27 @@ static int exynos_ehci_probe(struct platform_device *pdev)
>  
>  	err = exynos_ehci_get_phy(&pdev->dev, exynos_ehci);
>  	if (err)
> -		goto fail_clk;
> +		goto fail_regulator1;
> +
> +	exynos_ehci->vdd33 = devm_regulator_get_optional(&pdev->dev, "vdd33");
> +	if (!IS_ERR(exynos_ehci->vdd33)) {
> +		err = regulator_enable(exynos_ehci->vdd33);
> +		if (err) {
> +			dev_err(&pdev->dev,
> +				"Failed to enable 3.3V Vdd supply\n");
> +			goto fail_regulator1;
> +		}
> +	}
> +
> +	exynos_ehci->vdd10 = devm_regulator_get_optional(&pdev->dev, "vdd10");
> +	if (!IS_ERR(exynos_ehci->vdd10)) {
> +		err = regulator_enable(exynos_ehci->vdd10);
> +		if (err) {
> +			dev_err(&pdev->dev,
> +				"Failed to enable 1.0V Vdd supply\n");
> +			goto fail_regulator2;
> +		}
> +	}
>  
>  skip_phy:
>  
> @@ -231,6 +254,10 @@ fail_add_hcd:
>  fail_io:
>  	clk_disable_unprepare(exynos_ehci->clk);
>  fail_clk:
> +	regulator_disable(exynos_ehci->vdd10);
> +fail_regulator2:
> +	regulator_disable(exynos_ehci->vdd33);

if (!IS_ERR()).

> +fail_regulator1:
>  	usb_put_hcd(hcd);
>  	return err;
>  }
> @@ -246,6 +273,11 @@ static int exynos_ehci_remove(struct platform_device *pdev)
>  
>  	clk_disable_unprepare(exynos_ehci->clk);
>  
> +	if (!IS_ERR(exynos_ehci->vdd33))
> +		regulator_disable(exynos_ehci->vdd33);
> +	if (!IS_ERR(exynos_ehci->vdd10))
> +		regulator_disable(exynos_ehci->vdd10);
> +
>  	usb_put_hcd(hcd);
>  
>  	return 0;
> @@ -268,6 +300,11 @@ static int exynos_ehci_suspend(struct device *dev)
>  
>  	clk_disable_unprepare(exynos_ehci->clk);
>  
> +	if (!IS_ERR(exynos_ehci->vdd33))
> +		regulator_disable(exynos_ehci->vdd33);
> +	if (!IS_ERR(exynos_ehci->vdd10))
> +		regulator_disable(exynos_ehci->vdd10);
> +


Is EHCI a wakeup source? If yes then how disabling regulators during
suspend affects waking up process?

Best regards,
Krzysztof
