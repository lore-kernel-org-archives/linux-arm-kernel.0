From: collinsd@codeaurora.org (David Collins)
Date: Fri, 8 Jun 2018 11:05:53 -0700
Subject: [PATCH v6 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <20180608002653.GD88063@google.com>
References: <cover.1528138319.git.collinsd@codeaurora.org>
 <6d7abf248493cf81d62eb17ecb5030783aa85f72.1528138319.git.collinsd@codeaurora.org>
 <20180608002653.GD88063@google.com>
Message-ID: <a062ede9-20de-22e3-24a5-1aba8cf3740d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Matthias,

On 06/07/2018 05:26 PM, Matthias Kaehlcke wrote:
> On Mon, Jun 04, 2018 at 12:15:12PM -0700, David Collins wrote:
>> static int rpmh_regulator_send_request(struct rpmh_vreg *vreg,
>> +                       struct tcs_cmd *cmd, int count, bool wait_for_ack)
>>
> 
> nit: as of now this is only called with a single command. If you
> anticipate that this is unlikely to change consider removing 'count',
> not having it in the calls slightly improves readability.

The count parameter was needed in the original version of the patch.  That
need is no longer present after removing features in subsequent versions.

I'll remove this parameter.


>> +static int _rpmh_regulator_vrm_set_voltage_sel(struct regulator_dev *rdev,
>> +				unsigned int selector, bool wait_for_ack)
>> +{
>> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>> +	struct tcs_cmd cmd = {
>> +		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE,
>> +	};
>> +	int ret;
>> +
>> +	/* VRM voltage control register is set with voltage in millivolts. */
>> +	cmd.data = DIV_ROUND_UP(regulator_list_voltage_linear_range(rdev,
>> +							selector), 1000);
>> +
>> +	ret = rpmh_regulator_send_request(vreg, &cmd, 1, wait_for_ack);
>> +	if (!ret)
>> +		vreg->voltage_selector = selector;
>> +
>> +	return 0;
> 
> Shouldn't this return 'ret'?

Yes; good catch.  I'll fix it.


>> +static int rpmh_regulator_enable(struct regulator_dev *rdev)
>> +{
>> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>> +	struct tcs_cmd cmd = {
>> +		.addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
>> +		.data = 1,
>> +	};
>> +	int ret;
>> +
>> +	if (vreg->enabled == -EINVAL &&
>> +	    vreg->voltage_selector != -ENOTRECOVERABLE) {
>> +		ret = _rpmh_regulator_vrm_set_voltage_sel(rdev,
>> +						vreg->voltage_selector, true);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>> +	ret = rpmh_regulator_send_request(vreg, &cmd, 1, true);
>> +	if (!ret)
>> +		vreg->enabled = true;
>> +
>> +	return ret;
>> +}
>> +
>> +static int rpmh_regulator_disable(struct regulator_dev *rdev)
>> +{
>> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>> +	struct tcs_cmd cmd = {
>> +		.addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
>> +		.data = 0,
>> +	};
>> +	int ret;
>> +
>> +	if (vreg->enabled == -EINVAL &&
>> +	    vreg->voltage_selector != -ENOTRECOVERABLE) {
>> +		ret = _rpmh_regulator_vrm_set_voltage_sel(rdev,
>> +						vreg->voltage_selector, true);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>> +	ret = rpmh_regulator_send_request(vreg, &cmd, 1, false);
>> +	if (!ret)
>> +		vreg->enabled = false;
>> +
>> +	return ret;
>> +}
> 
> nit: rpmh_regulator_enable() and rpmh_regulator_disable() are
> essentially the same code, consider introducing a helper like
> _rpmh_regulator_enable(struct regulator_dev *rdev, bool enable).

Sure, I'll add a helper function.


>> +static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
>> +				struct device_node *node, const char *pmic_id,
>> +				const struct rpmh_vreg_init_data *rpmh_data)
>> +{
>> +	struct regulator_config reg_config = {};
>> +	char rpmh_resource_name[20] = "";
>> +	struct regulator_dev *rdev;
>> +	struct regulator_init_data *init_data;
>> +	int ret;
>> +
>> +	vreg->dev = dev;
>> +
>> +	for (; rpmh_data->name; rpmh_data++)
>> +		if (!strcmp(rpmh_data->name, node->name))
>> +			break;
> 
> nit: it's a bit odd to use the parameter itself for iteration, but I
> guess it's a matter of preferences.

I'll change this to add a specific iterator so that it is less surprising.

Thanks,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
