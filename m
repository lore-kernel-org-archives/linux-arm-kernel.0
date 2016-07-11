From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 11 Jul 2016 17:48:45 -0500
Subject: [PATCH 1/3] regulator: qcom_smd: Fix voltage ranges for pm8x41
In-Reply-To: <20160711215009.4519-2-sboyd@codeaurora.org>
References: <20160711215009.4519-1-sboyd@codeaurora.org>
 <20160711215009.4519-2-sboyd@codeaurora.org>
Message-ID: <20160711224845.GC6053@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 02:50:07PM -0700, Stephen Boyd wrote:
> The voltage ranges listed here are wrong. The correct ranges can
> be seen in the "native" spmi regulator driver
> qcom_spmi-regulator.c at pldo_ranges[], ftsmps_ranges[] and
> boost_ranges[] for the pldo, ftsmps, and boost type regulators.
> Port these ranges over to the RPM SMD regulator driver so that we
> list the appropriate set of supported voltages on pldos.
> 
> Doing this allows us to specify a voltage like 3075000 for l24,
> whereas before that wasn't a supported voltage.
> 
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Fixes: da65e367b67e ("regulator: Regulator driver for the Qualcomm RPM")
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

<snip>

>  static const struct regulator_desc pm8941_pldo = {
>  	.linear_ranges = (struct regulator_linear_range[]) {
> -		REGULATOR_LINEAR_RANGE( 750000,  0,  30, 25000),
> -		REGULATOR_LINEAR_RANGE(1500000, 31, 99, 50000),
> +		REGULATOR_LINEAR_RANGE( 750000,  0,  63, 12500),
> +		REGULATOR_LINEAR_RANGE(1550000, 64, 126, 25000),
> +		REGULATOR_LINEAR_RANGE(3100000, 127, 163, 50000),
>  	},
> -	.n_linear_ranges = 2,
> -	.n_voltages = 100,
> +	.n_linear_ranges = 3,
> +	.n_voltages = 164,
>  	.ops = &rpm_smps_ldo_ops,
>  };

Still a little confused on if the 12.5mV is allowed on pmos ldo.  It seems like the
nmos has 1 range of 5mV steps.  The PMOS has 2 ranges, using 25mV and 50mV


Regards,

Andy
