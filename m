From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 9 Apr 2014 00:11:05 -0700
Subject: [PATCH 14/15] mtd: st_spi_fsm: Provide mask to obtain correct
 boot device pins
In-Reply-To: <1395851969-13520-15-git-send-email-lee.jones@linaro.org>
References: <1395851969-13520-1-git-send-email-lee.jones@linaro.org>
 <1395851969-13520-15-git-send-email-lee.jones@linaro.org>
Message-ID: <20140409071105.GE3131@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ DT list

On Wed, Mar 26, 2014 at 04:39:28PM +0000, Lee Jones wrote:
> From: Christophe Kerello <christophe.kerello@st.com>
> 
> This patch adds a mask to be able to get the right boot device selection.
> 
> For example:
>     for STiH415, value = SYSTEM_STATUS398[4:0]
>     for STiH416, value = SYSTEM_STATUS2598[4:0]
>     for STiH407, value = SYSTEM_STATUS5561[6:2]
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mtd/devices/st_spi_fsm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
> index 9e00173..3ab27c8 100644
> --- a/drivers/mtd/devices/st_spi_fsm.c
> +++ b/drivers/mtd/devices/st_spi_fsm.c
> @@ -2159,6 +2159,7 @@ static void stfsm_fetch_platform_configs(struct platform_device *pdev)
>  	struct regmap *regmap;
>  	uint32_t boot_device_reg;
>  	uint32_t boot_device_spi;
> +	uint32_t boot_device_msk;
>  	uint32_t boot_device;     /* Value we read from *boot_device_reg */
>  	int ret;
>  
> @@ -2183,10 +2184,17 @@ static void stfsm_fetch_platform_configs(struct platform_device *pdev)
>  	if (ret)
>  		goto boot_device_fail;
>  
> +	/* Mask to apply on boot_device_reg */
> +	ret = of_property_read_u32(np, "st,boot-device-msk", &boot_device_msk);

You need to document this binding in Documentation/devicetree/bindings/,
and CC the devicetree list.

> +	if (ret)
> +		goto boot_device_fail;
> +
>  	ret = regmap_read(regmap, boot_device_reg, &boot_device);
>  	if (ret)
>  		goto boot_device_fail;
>  
> +	boot_device &= boot_device_msk;
> +
>  	if (boot_device != boot_device_spi)
>  		fsm->booted_from_spi = false;
>  

Brian
