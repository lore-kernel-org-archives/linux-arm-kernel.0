From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Fri, 27 Jul 2018 13:13:20 -0300
Subject: [PATCH v3 02/23] thermal: armada: remove useless register accesses
In-Reply-To: <20180716144206.30985-3-miquel.raynal@bootlin.com>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180716144206.30985-3-miquel.raynal@bootlin.com>
Message-ID: <CAAEAJfDZZbsg6UrknYV+6jH-2QeGaTQaazHuZyWo3Zv06J9C+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,

You know, it is usually useful to Cc the author of the lines a patch touches :-)

On 16 July 2018 at 11:41, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> Prepare the migration to use regmaps by first simplifying the
> initialization functions: avoid unnecessary write/read cycles on
> configuration registers.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/thermal/armada_thermal.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 077e8e562306..6fdb90b3c001 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -103,16 +103,13 @@ static void armadaxp_init_sensor(struct platform_device *pdev,
>
>         reg = readl_relaxed(priv->control1);
>         reg |= PMU_TDC0_OTF_CAL_MASK;
> -       writel(reg, priv->control1);
>
>         /* Reference calibration value */
>         reg &= ~PMU_TDC0_REF_CAL_CNT_MASK;
>         reg |= (0xf1 << PMU_TDC0_REF_CAL_CNT_OFFS);
> -       writel(reg, priv->control1);
>
>         /* Reset the sensor */
> -       reg = readl_relaxed(priv->control1);
> -       writel((reg | PMU_TDC0_SW_RST_MASK), priv->control1);
> +       reg |= PMU_TDC0_SW_RST_MASK;
>
>         writel(reg, priv->control1);
>
> @@ -129,14 +126,13 @@ static void armada370_init_sensor(struct platform_device *pdev,
>
>         reg = readl_relaxed(priv->control1);
>         reg |= PMU_TDC0_OTF_CAL_MASK;
> -       writel(reg, priv->control1);
>
>         /* Reference calibration value */
>         reg &= ~PMU_TDC0_REF_CAL_CNT_MASK;
>         reg |= (0xf1 << PMU_TDC0_REF_CAL_CNT_OFFS);
> -       writel(reg, priv->control1);
>
>         reg &= ~PMU_TDC0_START_CAL_MASK;
> +
>         writel(reg, priv->control1);
>

IIRC, the documentation for this hardware block was a meager.

Are you sure there isn't any requirement for the calibration
start to be issued separately or something like that?
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
