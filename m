From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 18 Dec 2017 17:08:42 +0100
Subject: [PATCH v4 09/12] thermal: armada: Change sensors trim default
 value
In-Reply-To: <20171218143643.7714-10-miquel.raynal@free-electrons.com> (Miquel
 Raynal's message of "Mon, 18 Dec 2017 15:36:40 +0100")
References: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
 <20171218143643.7714-10-miquel.raynal@free-electrons.com>
Message-ID: <87lgi0hvcl.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On lun., d?c. 18 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> Errata #132698 highlights an error in the default value of Tc trim.
> Set this parameter to b'011.
>
> Suggested-by: David Sniatkiwicz <davidsn@marvell.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Gregory

> ---
>  drivers/thermal/armada_thermal.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index cef5c65c8f32..2eadd662591d 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -46,6 +46,10 @@
>  #define CONTROL0_OFFSET			0x0
>  #define CONTROL1_OFFSET			0x4
>  
> +/* Errata fields */
> +#define CONTROL0_TSEN_TC_TRIM_MASK	0x7
> +#define CONTROL0_TSEN_TC_TRIM_VAL	0x3
> +
>  /* TSEN refers to the temperature sensors within the AP */
>  #define CONTROL0_TSEN_START		BIT(0)
>  #define CONTROL0_TSEN_RESET		BIT(1)
> @@ -161,6 +165,15 @@ static void armada380_init_sensor(struct platform_device *pdev,
>  	reg &= ~CONTROL1_EXT_TSEN_SW_RESET;
>  	writel(reg, priv->control1);
>  	msleep(10);
> +
> +	/* Set Tsen Tc Trim to correct default value (errata #132698) */
> +	if (priv->control0) {
> +		reg = readl_relaxed(priv->control0);
> +		reg &= ~CONTROL0_TSEN_TC_TRIM_MASK;
> +		reg |= CONTROL0_TSEN_TC_TRIM_VAL;
> +		writel(reg, priv->control0);
> +		msleep(10);
> +	}
>  }
>  
>  static void armada_ap806_init_sensor(struct platform_device *pdev,
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
