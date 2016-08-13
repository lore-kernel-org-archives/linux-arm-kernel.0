From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 12 Aug 2016 21:00:38 -0700
Subject: Applied "regulator: qcom_smd: Fix voltage ranges for pm8x41" to
 the regulator tree
In-Reply-To: <E1bVdwK-0002kb-B3@debutante>
References: <20160711215009.4519-2-sboyd@codeaurora.org>
 <E1bVdwK-0002kb-B3@debutante>
Message-ID: <20160813040038.GK26240@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 05 Aug 05:09 PDT 2016, Mark Brown wrote:

> The patch
> 
>    regulator: qcom_smd: Fix voltage ranges for pm8x41
> 

Hi Mark,

I have a boot regression with v4.8-rc1 on the Honami (msm8974):

[    1.796020] l24: Bringing 0uV into 3075000-3075000uV
[    1.796236] l24: unsupportable voltage constraints 3100000-3050000uV
[    1.796252] qcom_rpm_smd_regulator
smd:rpm:rpm_requests:pm8941-regulators: failed to register l24
[    1.929486] Freeing unused kernel memory: 1024K (c0b00000 -
c0c00000)941-regulators failed with error -22

Forgive the corrupt output.


As Stephen states in the commit message below the configured range of
3075000 is not a valid voltage and the min-voltage gets rounded up which
makes the range invalid. Stephen's patch fixes this problem.


I'm therefor asking you to include this patch in a -rc pull for v4.8.
I assume the pma8084 patch (#2 in this series) will give the same issue,
but don't have the setup to verify this.

Regards,
Bjorn

> has been applied to the regulator tree at
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.  
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 
> From 290284776bb281759b11faa287b8abccaf74bfcb Mon Sep 17 00:00:00 2001
> From: Stephen Boyd <sboyd@codeaurora.org>
> Date: Mon, 11 Jul 2016 14:50:07 -0700
> Subject: [PATCH] regulator: qcom_smd: Fix voltage ranges for pm8x41
> 
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
> Fixes: da65e367b67e ("regulator: Regulator driver for the Qualcomm RPM")
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Reviewed-by: Andy Gross <andy.gross@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/regulator/qcom_smd-regulator.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
> index 5022fa8d10c6..47cd28e960db 100644
> --- a/drivers/regulator/qcom_smd-regulator.c
> +++ b/drivers/regulator/qcom_smd-regulator.c
> @@ -221,29 +221,30 @@ static const struct regulator_desc pm8x41_hfsmps = {
>  static const struct regulator_desc pm8841_ftsmps = {
>  	.linear_ranges = (struct regulator_linear_range[]) {
>  		REGULATOR_LINEAR_RANGE(350000,  0, 184, 5000),
> -		REGULATOR_LINEAR_RANGE(700000, 185, 339, 10000),
> +		REGULATOR_LINEAR_RANGE(1280000, 185, 261, 10000),
>  	},
>  	.n_linear_ranges = 2,
> -	.n_voltages = 340,
> +	.n_voltages = 262,
>  	.ops = &rpm_smps_ldo_ops,
>  };
>  
>  static const struct regulator_desc pm8941_boost = {
>  	.linear_ranges = (struct regulator_linear_range[]) {
> -		REGULATOR_LINEAR_RANGE(4000000, 0, 15, 100000),
> +		REGULATOR_LINEAR_RANGE(4000000, 0, 30, 50000),
>  	},
>  	.n_linear_ranges = 1,
> -	.n_voltages = 16,
> +	.n_voltages = 31,
>  	.ops = &rpm_smps_ldo_ops,
>  };
>  
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
>  
> -- 
> 2.8.1
> 
