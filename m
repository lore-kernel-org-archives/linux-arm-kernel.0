From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 17 Dec 2017 00:22:34 +0200
Subject: [PATCH v3 05/11] thermal: armada: Add support for Armada AP806
In-Reply-To: <20171214103011.24713-6-miquel.raynal@free-electrons.com>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
 <20171214103011.24713-6-miquel.raynal@free-electrons.com>
Message-ID: <20171216222234.xp5gybcbfymouvvd@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miqu?l,

On Thu, Dec 14, 2017 at 11:30:05AM +0100, Miquel Raynal wrote:
> From: Baruch Siach <baruch@tkos.co.il>
> 
> The AP806 component is integrated in the Armada 8k and 7k lines of
> processors.
> 
> The thermal sensor sample field on the status register is a signed
> value. Extend armada_get_temp() to handle signed values.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> ---

[...]

> +static void armada_ap806_init_sensor(struct platform_device *pdev,
> +				     struct armada_thermal_priv *priv)
> +{
> +	u32 reg;
> +
> +	if (!priv->control0) {
> +		dev_err(&pdev->dev,
> +			"Cannot access to control0 (control LSB) register\n");
> +		return;
> +	}

With the probe time control area size validation this check would not be 
needed.

baruch

> +
> +	reg = readl_relaxed(priv->control0);
> +	reg &= ~CONTROL0_TSEN_RESET;
> +	reg |= CONTROL0_TSEN_START | CONTROL0_TSEN_ENABLE;
> +	writel(reg, priv->control0);
> +	msleep(10);
> +}

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
