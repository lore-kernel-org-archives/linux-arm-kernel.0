From: marvin24@gmx.de (Marc Dietrich)
Date: Fri, 08 Jun 2012 21:48:12 +0200
Subject: [PATCH v3 7/9] staging: nvec: add clk_prepare/clk_unprepare
In-Reply-To: <1338870583-8704-8-git-send-email-pgaikwad@nvidia.com>
References: <1338870583-8704-1-git-send-email-pgaikwad@nvidia.com>
 <1338870583-8704-8-git-send-email-pgaikwad@nvidia.com>
Message-ID: <4214308.tKJXbx0ZCv@ax5200p>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 June 2012 09:59:41 Prashant Gaikwad wrote:
> Use clk_prepare/clk_unprepare as required by the generic clk framework.
> 
> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>

I think I gave an ack already on the first (or second version), which was 
identical. Nevertheless, here is one more.

Acked-by: Marc Dietrich <marvin24@gmx.de>

> ---
> Please ignore previous versions. Updated commit message and
> maintainers properly in this version. No other change.
> 
> This patch should go through Tegra tree since other patches to port Tegra
> to generic clock framework are dependent on it. Posting here to get ack from
> the maintainers.
> 
>  drivers/staging/nvec/nvec.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> index 3c60088..9356886 100644
> --- a/drivers/staging/nvec/nvec.c
> +++ b/drivers/staging/nvec/nvec.c
> @@ -675,7 +675,7 @@ static void tegra_init_i2c_slave(struct nvec_chip *nvec)
> {
>  	u32 val;
> 
> -	clk_enable(nvec->i2c_clk);
> +	clk_prepare_enable(nvec->i2c_clk);
> 
>  	tegra_periph_reset_assert(nvec->i2c_clk);
>  	udelay(2);
> @@ -695,14 +695,14 @@ static void tegra_init_i2c_slave(struct nvec_chip
> *nvec)
> 
>  	enable_irq(nvec->irq);
> 
> -	clk_disable(nvec->i2c_clk);
> +	clk_disable_unprepare(nvec->i2c_clk);
>  }
> 
>  static void nvec_disable_i2c_slave(struct nvec_chip *nvec)
>  {
>  	disable_irq(nvec->irq);
>  	writel(I2C_SL_NEWSL | I2C_SL_NACK, nvec->base + I2C_SL_CNFG);
> -	clk_disable(nvec->i2c_clk);
> +	clk_disable_unprepare(nvec->i2c_clk);
>  }
> 
>  static void nvec_power_off(void)
> @@ -812,7 +812,7 @@ static int __devinit tegra_nvec_probe(struct
> platform_device *pdev)
> 
>  	tegra_init_i2c_slave(nvec);
> 
> -	clk_enable(i2c_clk);
> +	clk_prepare_enable(i2c_clk);
> 
> 
>  	/* enable event reporting */
