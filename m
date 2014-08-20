From: vinceh@nvidia.com (Vince Hsu)
Date: Wed, 20 Aug 2014 11:01:47 +0800
Subject: [PATCH v3 03/15] clk: tegra: Add closed loop support for the DFLL
In-Reply-To: <1408419205-10048-4-git-send-email-tuomas.tynkkynen@iki.fi>
References: <1408419205-10048-1-git-send-email-tuomas.tynkkynen@iki.fi>
 <1408419205-10048-4-git-send-email-tuomas.tynkkynen@iki.fi>
Message-ID: <53F40F9B.6070808@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/19/2014 11:33 AM, Tuomas Tynkkynen wrote:
> From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
>
> With closed loop support, the clock rate of the DFLL can be adjusted.
>
> The oscillator itself in the DFLL is a free-running oscillator whose
> rate is directly determined the supply voltage. However, the DFLL
> module contains logic to compare the DFLL output rate to a fixed
> reference clock (51 MHz) and make a decision to either lower or raise
> the DFLL supply voltage. The DFLL module can then autonomously change
> the supply voltage by communicating with an off-chip PMIC via either I2C
> or PWM signals. This driver currently supports only I2C.
>
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
>
> ---
> v3: Fix incorrect order of arguments to dfll_scale_dvco_rate
> ---
>   drivers/clk/tegra/clk-dfll.c | 656 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 653 insertions(+), 3 deletions(-)
>
...
>   
>   /**
> + * dfll_fetch_i2c_params - query PMIC I2C params from DT & regulator subsystem
> + * @td: DFLL instance
> + *
> + * Read all the parameters required for operation in I2C mode. The parameters
> + * can originate from the device tree or the regulator subsystem.
> + * Returns 0 on success or -err on failure.
> + */
> +static int dfll_fetch_i2c_params(struct tegra_dfll *td)
> +{
> +	struct regmap *regmap;
> +	struct device *i2c_dev;
> +	struct i2c_client *i2c_client;
> +	int vsel_reg, vsel_mask;
> +	int ret;
> +
> +	if (!read_dt_param(td, "nvidia,i2c-fs-rate", &td->i2c_fs_rate))
> +		return -EINVAL;
> +
> +	regmap = regulator_get_regmap(td->vdd_reg);
> +	i2c_dev = regmap_get_device(regmap);
> +	i2c_client = to_i2c_client(i2c_dev);
> +
> +	td->i2c_slave_addr = i2c_client->addr;
> +
> +	ret = regulator_get_hardware_vsel_register(td->vdd_reg,
> +						   &vsel_reg,
> +						   &vsel_mask);
> +	if (ret < 0) {
> +		dev_err(td->dev,
> +			"regulator unsuitable for DFLL I2C operation\n");
> +		return -EINVAL;
> +	}
> +
It seems that the td->i2c_reg never gets initialized, and we're lucky on 
JetsonTK1 or Norrin. We should initialize the regulator offset here. Like:

td->i2c_reg = vsel_reg;

Thanks,
Vince
> +	ret = dfll_build_i2c_lut(td);
> +	if (ret) {
> +		dev_err(td->dev, "couldn't build I2C LUT\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
