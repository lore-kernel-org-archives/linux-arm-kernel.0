From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 9 Nov 2016 08:51:58 -0800
Subject: [PATCH] mfd: qcom-pm8xxx: Clean up PM8XXX namespace
In-Reply-To: <1477487453-15801-1-git-send-email-linus.walleij@linaro.org>
References: <1477487453-15801-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20161109165158.GR25787@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 26 Oct 06:10 PDT 2016, Linus Walleij wrote:

> The Kconfig and file naming for the PM8xxx driver is totally
> confusing:
> 
> - Kconfig options MFD_PM8XXX and MFD_PM8921_CORE, some in-kernel
>   users depending on or selecting either at random.
> - A driver file named pm8921-core.c even if it is indeed
>   used by the whole PM8xxx family of chips.
> - An irqchip named pm8xxx since it was (I guess) realized that
>   the driver was generic for all pm8xxx PMICs.
> 
> As I may want to add support for PM8901 this is starting to get
> really messy. Fix this situation by:
> 
> - Remove the MFD_PM8921_CORE symbol and rely solely on MFD_PM8XXX
>   and convert all users, including LEDs Kconfig and ARM defconfigs
>   for qcom and multi_v7 to use that single symbol.
> - Renaming the driver to qcom-pm8xxx.c to fit along the two
>   other qcom* prefixed drivers.
> - Rename functions withing the driver from 8921 to 8xxx to
>   indicate it is generic.
> - Just drop the =m config from the pxa_defconfig, I have no clue
>   why it is even there, it is not a Qualcomm platform. (Possibly
>   older Kconfig noise from saveconfig.)
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I do NOT think it is a good idea to try to split this commit up,
> I rather prefer that Lee simply merge it into MFD.
> 
> The reason is that files like qcom_defconfig already contain both
> the right symbols, but the MFD_PM8921_CORE symbol cannot be removed
> until this rename has happened, whereas multi_v7_defconfig needs
> it added etc, and this is just a clean nice cut.
> 
> Jacek, ARM SoC person: please ACK this patch to get merged into
> MFD.
> ---
>  arch/arm/configs/multi_v7_defconfig          |  2 +-
>  arch/arm/configs/pxa_defconfig               |  1 -
>  arch/arm/configs/qcom_defconfig              |  1 -
>  drivers/leds/Kconfig                         |  2 +-
>  drivers/mfd/Kconfig                          | 14 ++++------
>  drivers/mfd/Makefile                         |  2 +-
>  drivers/mfd/{pm8921-core.c => qcom-pm8xxx.c} | 42 ++++++++++++++--------------
>  7 files changed, 29 insertions(+), 35 deletions(-)
>  rename drivers/mfd/{pm8921-core.c => qcom-pm8xxx.c} (92%)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 437d0740dec6..4280de7b9b4e 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -489,7 +489,7 @@ CONFIG_MFD_MAX8907=y
>  CONFIG_MFD_MAX8997=y
>  CONFIG_MFD_MAX8998=y
>  CONFIG_MFD_RK808=y
> -CONFIG_MFD_PM8921_CORE=y
> +CONFIG_MFD_PM8XXX=y
>  CONFIG_MFD_QCOM_RPM=y
>  CONFIG_MFD_SPMI_PMIC=y
>  CONFIG_MFD_SEC_CORE=y
> diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
> index a016ecc0084b..e4314b1227a3 100644
> --- a/arch/arm/configs/pxa_defconfig
> +++ b/arch/arm/configs/pxa_defconfig
> @@ -411,7 +411,6 @@ CONFIG_MFD_MAX77693=y
>  CONFIG_MFD_MAX8907=m
>  CONFIG_EZX_PCAP=y
>  CONFIG_UCB1400_CORE=m
> -CONFIG_MFD_PM8921_CORE=m
>  CONFIG_MFD_SEC_CORE=y
>  CONFIG_MFD_PALMAS=y
>  CONFIG_MFD_TPS65090=y
> diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
> index c2dff4fd5fc4..74e9cd759b99 100644
> --- a/arch/arm/configs/qcom_defconfig
> +++ b/arch/arm/configs/qcom_defconfig
> @@ -119,7 +119,6 @@ CONFIG_POWER_RESET=y
>  CONFIG_POWER_RESET_MSM=y
>  CONFIG_THERMAL=y
>  CONFIG_MFD_PM8XXX=y
> -CONFIG_MFD_PM8921_CORE=y
>  CONFIG_MFD_QCOM_RPM=y
>  CONFIG_MFD_SPMI_PMIC=y
>  CONFIG_REGULATOR=y
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 7a628c6516f6..86bb1515a00e 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -645,7 +645,7 @@ config LEDS_VERSATILE
>  
>  config LEDS_PM8058
>  	tristate "LED Support for the Qualcomm PM8058 PMIC"
> -	depends on MFD_PM8921_CORE
> +	depends on MFD_PM8XXX
>  	depends on LEDS_CLASS
>  	help
>  	  Choose this option if you want to use the LED drivers in
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index c6df6442ba2b..1ed0584f494e 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -756,24 +756,20 @@ config UCB1400_CORE
>  	  module will be called ucb1400_core.
>  
>  config MFD_PM8XXX
> -	tristate
> -
> -config MFD_PM8921_CORE
> -	tristate "Qualcomm PM8921 PMIC chip"
> +	tristate "Qualcomm PM8xxx PMIC chips driver"
>  	depends on (ARM || HEXAGON)
>  	select IRQ_DOMAIN
>  	select MFD_CORE
> -	select MFD_PM8XXX
>  	select REGMAP
>  	help
>  	  If you say yes to this option, support will be included for the
> -	  built-in PM8921 PMIC chip.
> +	  built-in PM8xxx PMIC chips.
>  
> -	  This is required if your board has a PM8921 and uses its features,
> +	  This is required if your board has a PM8xxx and uses its features,
>  	  such as: MPPs, GPIOs, regulators, interrupts, and PWM.
>  
> -	  Say M here if you want to include support for PM8921 chip as a module.
> -	  This will build a module called "pm8921-core".
> +	  Say M here if you want to include support for PM8xxx chips as a
> +	  module. This will build a module called "pm8xxx-core".
>  
>  config MFD_QCOM_RPM
>  	tristate "Qualcomm Resource Power Manager (RPM)"
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 9834e669d985..7bb5a50127cb 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -172,7 +172,7 @@ obj-$(CONFIG_MFD_SI476X_CORE)	+= si476x-core.o
>  
>  obj-$(CONFIG_MFD_CS5535)	+= cs5535-mfd.o
>  obj-$(CONFIG_MFD_OMAP_USB_HOST)	+= omap-usb-host.o omap-usb-tll.o
> -obj-$(CONFIG_MFD_PM8921_CORE) 	+= pm8921-core.o ssbi.o
> +obj-$(CONFIG_MFD_PM8XXX) 	+= qcom-pm8xxx.o ssbi.o
>  obj-$(CONFIG_MFD_QCOM_RPM)	+= qcom_rpm.o
>  obj-$(CONFIG_MFD_SPMI_PMIC)	+= qcom-spmi-pmic.o
>  obj-$(CONFIG_TPS65911_COMPARATOR)	+= tps65911-comparator.o
> diff --git a/drivers/mfd/pm8921-core.c b/drivers/mfd/qcom-pm8xxx.c
> similarity index 92%
> rename from drivers/mfd/pm8921-core.c
> rename to drivers/mfd/qcom-pm8xxx.c
> index 0e3a2ea25942..7f9620ec61e8 100644
> --- a/drivers/mfd/pm8921-core.c
> +++ b/drivers/mfd/qcom-pm8xxx.c
> @@ -53,7 +53,7 @@
>  #define REG_HWREV		0x002  /* PMIC4 revision */
>  #define REG_HWREV_2		0x0E8  /* PMIC4 revision 2 */
>  
> -#define PM8921_NR_IRQS		256
> +#define PM8XXX_NR_IRQS		256
>  
>  struct pm_irq_chip {
>  	struct regmap		*regmap;
> @@ -308,22 +308,22 @@ static const struct regmap_config ssbi_regmap_config = {
>  	.reg_write = ssbi_reg_write
>  };
>  
> -static const struct of_device_id pm8921_id_table[] = {
> +static const struct of_device_id pm8xxx_id_table[] = {
>  	{ .compatible = "qcom,pm8018", },
>  	{ .compatible = "qcom,pm8058", },
>  	{ .compatible = "qcom,pm8921", },
>  	{ }
>  };
> -MODULE_DEVICE_TABLE(of, pm8921_id_table);
> +MODULE_DEVICE_TABLE(of, pm8xxx_id_table);
>  
> -static int pm8921_probe(struct platform_device *pdev)
> +static int pm8xxx_probe(struct platform_device *pdev)
>  {
>  	struct regmap *regmap;
>  	int irq, rc;
>  	unsigned int val;
>  	u32 rev;
>  	struct pm_irq_chip *chip;
> -	unsigned int nirqs = PM8921_NR_IRQS;
> +	unsigned int nirqs = PM8XXX_NR_IRQS;
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
> @@ -384,46 +384,46 @@ static int pm8921_probe(struct platform_device *pdev)
>  	return rc;
>  }
>  
> -static int pm8921_remove_child(struct device *dev, void *unused)
> +static int pm8xxx_remove_child(struct device *dev, void *unused)
>  {
>  	platform_device_unregister(to_platform_device(dev));
>  	return 0;
>  }
>  
> -static int pm8921_remove(struct platform_device *pdev)
> +static int pm8xxx_remove(struct platform_device *pdev)
>  {
>  	int irq = platform_get_irq(pdev, 0);
>  	struct pm_irq_chip *chip = platform_get_drvdata(pdev);
>  
> -	device_for_each_child(&pdev->dev, NULL, pm8921_remove_child);
> +	device_for_each_child(&pdev->dev, NULL, pm8xxx_remove_child);
>  	irq_set_chained_handler_and_data(irq, NULL, NULL);
>  	irq_domain_remove(chip->irqdomain);
>  
>  	return 0;
>  }
>  
> -static struct platform_driver pm8921_driver = {
> -	.probe		= pm8921_probe,
> -	.remove		= pm8921_remove,
> +static struct platform_driver pm8xxx_driver = {
> +	.probe		= pm8xxx_probe,
> +	.remove		= pm8xxx_remove,
>  	.driver		= {
> -		.name	= "pm8921-core",
> -		.of_match_table = pm8921_id_table,
> +		.name	= "pm8xxx-core",
> +		.of_match_table = pm8xxx_id_table,
>  	},
>  };
>  
> -static int __init pm8921_init(void)
> +static int __init pm8xxx_init(void)
>  {
> -	return platform_driver_register(&pm8921_driver);
> +	return platform_driver_register(&pm8xxx_driver);
>  }
> -subsys_initcall(pm8921_init);
> +subsys_initcall(pm8xxx_init);
>  
> -static void __exit pm8921_exit(void)
> +static void __exit pm8xxx_exit(void)
>  {
> -	platform_driver_unregister(&pm8921_driver);
> +	platform_driver_unregister(&pm8xxx_driver);
>  }
> -module_exit(pm8921_exit);
> +module_exit(pm8xxx_exit);
>  
>  MODULE_LICENSE("GPL v2");
> -MODULE_DESCRIPTION("PMIC 8921 core driver");
> +MODULE_DESCRIPTION("PMIC 8xxx core driver");
>  MODULE_VERSION("1.0");
> -MODULE_ALIAS("platform:pm8921-core");
> +MODULE_ALIAS("platform:pm8xxx-core");
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
