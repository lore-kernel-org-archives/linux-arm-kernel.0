From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 Jan 2015 13:36:17 +0000
Subject: [RFC PATCHv2 07/19] mfd: ab8500: Use power_supply_*() API for
 accessing function attrs
In-Reply-To: <1420472882-10463-8-git-send-email-k.kozlowski@samsung.com>
References: <1420472882-10463-1-git-send-email-k.kozlowski@samsung.com>
 <1420472882-10463-8-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20150120133617.GG13701@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 05 Jan 2015, Krzysztof Kozlowski wrote:

> Replace direct calls to power supply function attributes with wrappers.
> Wrappers provide safe access in case of unregistering the power
> supply (e.g. by removing the driver). Replace:
>  - get_property -> power_supply_get_property
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Acked-by: Jonghwa Lee <jonghwa3.lee@samusng.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Lee Jones <lee.jones@linaro.org>

You've sent this to me already Acked.  I don't see 00/00, so I have no
idea what's going on.  Do you want me to take this patch?  Can it be
taking on its own?

> ---
>  drivers/mfd/ab8500-sysctrl.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
> index cfff0b643f1b..d4a4b24be7c6 100644
> --- a/drivers/mfd/ab8500-sysctrl.c
> +++ b/drivers/mfd/ab8500-sysctrl.c
> @@ -49,7 +49,8 @@ static void ab8500_power_off(void)
>  		if (!psy)
>  			continue;
>  
> -		ret = psy->get_property(psy, POWER_SUPPLY_PROP_ONLINE, &val);
> +		ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
> +				&val);
>  
>  		if (!ret && val.intval) {
>  			charger_present = true;
> @@ -63,8 +64,8 @@ static void ab8500_power_off(void)
>  	/* Check if battery is known */
>  	psy = power_supply_get_by_name("ab8500_btemp");
>  	if (psy) {
> -		ret = psy->get_property(psy, POWER_SUPPLY_PROP_TECHNOLOGY,
> -					&val);
> +		ret = power_supply_get_property(psy,
> +				POWER_SUPPLY_PROP_TECHNOLOGY, &val);
>  		if (!ret && val.intval != POWER_SUPPLY_TECHNOLOGY_UNKNOWN) {
>  			printk(KERN_INFO
>  			       "Charger \"%s\" is connected with known battery."

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
