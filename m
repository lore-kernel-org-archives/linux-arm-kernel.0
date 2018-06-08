From: mka@chromium.org (Matthias Kaehlcke)
Date: Thu, 7 Jun 2018 17:26:53 -0700
Subject: [PATCH v6 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <6d7abf248493cf81d62eb17ecb5030783aa85f72.1528138319.git.collinsd@codeaurora.org>
References: <cover.1528138319.git.collinsd@codeaurora.org>
 <6d7abf248493cf81d62eb17ecb5030783aa85f72.1528138319.git.collinsd@codeaurora.org>
Message-ID: <20180608002653.GD88063@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Mon, Jun 04, 2018 at 12:15:12PM -0700, David Collins wrote:
> Add the QCOM RPMh regulator driver to manage PMIC regulators
> which are controlled via RPMh on some Qualcomm Technologies, Inc.
> SoCs.  RPMh is a hardware block which contains several
> accelerators which are used to manage various hardware resources
> that are shared between the processors of the SoC.  The final
> hardware state of a regulator is determined within RPMh by
> performing max aggregation of the requests made by all of the
> processors.
> 
> Add support for PMIC regulator control via the voltage regulator
> manager (VRM) and oscillator buffer (XOB) RPMh accelerators.
> VRM supports manipulation of enable state, voltage, and mode.
> XOB supports manipulation of enable state.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> ---
>  drivers/regulator/Kconfig               |   9 +
>  drivers/regulator/Makefile              |   1 +
>  drivers/regulator/qcom-rpmh-regulator.c | 767 ++++++++++++++++++++++++++++++++
>  3 files changed, 777 insertions(+)
>  create mode 100644 drivers/regulator/qcom-rpmh-regulator.c
>
> ...
>
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> new file mode 100644
> index 0000000..a7fffb6
> --- /dev/null
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
>
> ...
> static int rpmh_regulator_send_request(struct rpmh_vreg *vreg,
> +                       struct tcs_cmd *cmd, int count, bool wait_for_ack)
>

nit: as of now this is only called with a single command. If you
anticipate that this is unlikely to change consider removing 'count',
not having it in the calls slightly improves readability.

> ...
> +static int _rpmh_regulator_vrm_set_voltage_sel(struct regulator_dev *rdev,
> +				unsigned int selector, bool wait_for_ack)
> +{
> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +	struct tcs_cmd cmd = {
> +		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE,
> +	};
> +	int ret;
> +
> +	/* VRM voltage control register is set with voltage in millivolts. */
> +	cmd.data = DIV_ROUND_UP(regulator_list_voltage_linear_range(rdev,
> +							selector), 1000);
> +
> +	ret = rpmh_regulator_send_request(vreg, &cmd, 1, wait_for_ack);
> +	if (!ret)
> +		vreg->voltage_selector = selector;
> +
> +	return 0;

Shouldn't this return 'ret'?

> +static int rpmh_regulator_enable(struct regulator_dev *rdev)
> +{
> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +	struct tcs_cmd cmd = {
> +		.addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
> +		.data = 1,
> +	};
> +	int ret;
> +
> +	if (vreg->enabled == -EINVAL &&
> +	    vreg->voltage_selector != -ENOTRECOVERABLE) {
> +		ret = _rpmh_regulator_vrm_set_voltage_sel(rdev,
> +						vreg->voltage_selector, true);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = rpmh_regulator_send_request(vreg, &cmd, 1, true);
> +	if (!ret)
> +		vreg->enabled = true;
> +
> +	return ret;
> +}
> +
> +static int rpmh_regulator_disable(struct regulator_dev *rdev)
> +{
> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +	struct tcs_cmd cmd = {
> +		.addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
> +		.data = 0,
> +	};
> +	int ret;
> +
> +	if (vreg->enabled == -EINVAL &&
> +	    vreg->voltage_selector != -ENOTRECOVERABLE) {
> +		ret = _rpmh_regulator_vrm_set_voltage_sel(rdev,
> +						vreg->voltage_selector, true);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = rpmh_regulator_send_request(vreg, &cmd, 1, false);
> +	if (!ret)
> +		vreg->enabled = false;
> +
> +	return ret;
> +}

nit: rpmh_regulator_enable() and rpmh_regulator_disable() are
essentially the same code, consider introducing a helper like
_rpmh_regulator_enable(struct regulator_dev *rdev, bool enable).

> +/**
> + * rpmh_regulator_init_vreg() - initialize all attributes of an rpmh-regulator
> + * vreg:		Pointer to the individual rpmh-regulator resource
> + * dev:			Pointer to the top level rpmh-regulator PMIC device
> + * node:		Pointer to the individual rpmh-regulator resource
> + *			device node
> + * pmic_id:		String used to identify the top level rpmh-regulator
> + *			PMIC device on the board
> + * rpmh_data:		Pointer to a null-terminated array of rpmh-regulator
> + *			resources defined for the top level PMIC device
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
> +				struct device_node *node, const char *pmic_id,
> +				const struct rpmh_vreg_init_data *rpmh_data)
> +{
> +	struct regulator_config reg_config = {};
> +	char rpmh_resource_name[20] = "";
> +	struct regulator_dev *rdev;
> +	struct regulator_init_data *init_data;
> +	int ret;
> +
> +	vreg->dev = dev;
> +
> +	for (; rpmh_data->name; rpmh_data++)
> +		if (!strcmp(rpmh_data->name, node->name))
> +			break;

nit: it's a bit odd to use the parameter itself for iteration, but I
guess it's a matter of preferences.

Thanks

Matthias
