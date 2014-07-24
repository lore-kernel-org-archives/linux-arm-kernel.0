From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 24 Jul 2014 11:17:37 +0200
Subject: [PATCHv3 13/16] cpuidle: mvebu: add Armada 38x support
In-Reply-To: <1406120453-29291-14-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1406120453-29291-14-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <53D0CF31.8000607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2014 03:00 PM, Thomas Petazzoni wrote:
> This commit adds the list of cpuidle states supported by the Armada
> 38x SoC in the cpuidle-mvebu-v7 driver, as well as the necessary logic
> around it to support this SoC.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/cpuidle/cpuidle-mvebu-v7.c | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
> index d23597f..45371bb 100644
> --- a/drivers/cpuidle/cpuidle-mvebu-v7.c
> +++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
> @@ -1,5 +1,5 @@
>   /*
> - * Marvell Armada 370 and Armada XP SoC cpuidle driver
> + * Marvell Armada 370, 38x and XP SoC cpuidle driver
>    *
>    * Copyright (C) 2014 Marvell
>    *
> @@ -86,6 +86,21 @@ static struct cpuidle_driver armada370_idle_driver = {
>   	.state_count = 2,
>   };
>
> +static struct cpuidle_driver armada38x_idle_driver = {
> +	.name			= "armada_38x_idle",
> +	.states[0]		= ARM_CPUIDLE_WFI_STATE,
> +	.states[1]		= {
> +		.enter			= mvebu_v7_enter_idle,
> +		.exit_latency		= 10,
> +		.power_usage		= 5,
> +		.target_residency	= 100,
> +		.flags			= CPUIDLE_FLAG_TIME_VALID,
> +		.name			= "Idle",
> +		.desc			= "CPU and SCU power down",
> +	},
> +	.state_count = 2,
> +};
> +
>   static int mvebu_v7_cpuidle_probe(struct platform_device *pdev)
>   {
>   	mvebu_v7_cpu_suspend = pdev->dev.platform_data;
> @@ -94,6 +109,8 @@ static int mvebu_v7_cpuidle_probe(struct platform_device *pdev)
>   		return cpuidle_register(&armadaxp_idle_driver, NULL);
>   	else if (!strcmp(pdev->dev.driver->name, "cpuidle-armada-370"))
>   		return cpuidle_register(&armada370_idle_driver, NULL);
> +	else if (!strcmp(pdev->dev.driver->name, "cpuidle-armada-38x"))
> +		return cpuidle_register(&armada38x_idle_driver, NULL);
>   	else
>   		return -EINVAL;
>   }
> @@ -118,6 +135,16 @@ static struct platform_driver armada370_cpuidle_plat_driver = {
>
>   module_platform_driver(armada370_cpuidle_plat_driver);
>
> +static struct platform_driver armada38x_cpuidle_plat_driver = {
> +	.driver = {
> +		.name = "cpuidle-armada-38x",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = mvebu_v7_cpuidle_probe,
> +};
> +
> +module_platform_driver(armada38x_cpuidle_plat_driver);
> +
>   MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
>   MODULE_DESCRIPTION("Marvell EBU v7 cpuidle driver");
>   MODULE_LICENSE("GPL");
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
