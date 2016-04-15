From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 15 Apr 2016 14:17:58 +0200
Subject: [PATCH v5 2/2] i2c: rk3x: add i2c support for rk3399 soc
In-Reply-To: <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
References: <1458147438-62387-1-git-send-email-david.wu@rock-chips.com>
 <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
Message-ID: <4971788.LeT208jGID@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Am Donnerstag, 17. M?rz 2016, 00:57:18 schrieb David Wu:
> From: David Wu <wdc@rock-chips.com>
> 
> - new method to caculate i2c timings for rk3399:
>   There was an timing issue about "repeated start" time at the I2C
>   controller of version0, controller appears to drop SDA at .875x (7/8)
>   programmed clk high. On version 1 of the controller, the rule(.875x)
>   isn't enough to meet tSU;STA
>   requirements on 100k's Standard-mode. To resolve this issue,
>   sda_update_config, start_setup_config and stop_setup_config for I2C
>   timing information are added, new rules are designed to calculate
>   the timing information at new v1.
> - pclk and function clk are separated at rk3399.
> - support i2c highspeed mode: 1.7MHz for rk3399
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>

[...]

> @@ -83,11 +88,34 @@ enum rk3x_i2c_state {
>  	STATE_STOP
>  };
> 
> +struct rk3x_i2c;
> +
> +/**
> + * struct rk3x_i2c_calced_timings:
> + * @div_low: Divider output for low
> + * @div_high: Divider output for high
> + * @sda_update_cfg: Used to config sda change state when scl is low,
> + * used to adjust setup/hold time
> + * @stp_sta_cfg: Start setup config for setup start time and hold start
> time + * @stp_sto_cfg: Stop setup config for setup stop time
> + */
> +struct rk3x_i2c_calced_timings {
> +	unsigned long div_low;
> +	unsigned long div_high;
> +	unsigned int sda_update_cfg;
> +	unsigned int stp_sta_cfg;
> +	unsigned int stp_sto_cfg;
> +};
> +
>  /**
>   * @grf_offset: offset inside the grf regmap for setting the i2c type
>   */
>  struct rk3x_i2c_soc_data {
>  	int grf_offset;
> +
> +	int (*clk_init)(struct rk3x_i2c *, unsigned long *);
> +	int (*calc_timings)(unsigned long, struct i2c_timings *,
> +			    struct rk3x_i2c_calced_timings *);
>  };
> 
>  struct rk3x_i2c {
> @@ -97,11 +125,13 @@ struct rk3x_i2c {
> 
>  	/* Hardware resources */
>  	void __iomem *regs;
> -	struct clk *clk;
> +	struct clk *pclk; /* APB clock */
> +	struct clk *clk; /* Func clk for rk3399 or Func & APB clks for others */
>  	struct notifier_block clk_rate_nb;

please use regular kernel-doc for the struct elements (aka @pclk: something) 
like some of the other fields already have.

I can't spot anything else, but also don't know enough about i2c itself :-)


Heiko
