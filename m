From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 26 Nov 2014 22:25:00 +0100
Subject: [PATCH v9 2/9] qcom: spm: Add Subsystem Power Manager driver
In-Reply-To: <7hy4qxet3c.fsf@deeprootsystems.com>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org>	<1414194024-55547-3-git-send-email-lina.iyer@linaro.org>
 <7hy4qxet3c.fsf@deeprootsystems.com>
Message-ID: <5476452C.9040107@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2014 07:04 PM, Kevin Hilman wrote:
> Oops, I thought I had sent this, but it was sitting in the drafts
> folder.  Sending anyways because it looks like most of these issues
> still exist in v10.

[ ... ]

>> +	 * On some SoC's if the control registers are written first and if the
>> +	 * CPU was held in reset, the reset signal could trigger the SPM state
>> +	 * machine, before the sequences are completely written.
>> +	 */
>> +	spm_register_write(drv, SPM_REG_CFG, drv->reg_data->spm_cfg);
>> +	spm_register_write(drv, SPM_REG_DLY, drv->reg_data->spm_dly);
>> +	spm_register_write(drv, SPM_REG_PMIC_DLY, drv->reg_data->pmic_dly);
>> +
>> +	spm_register_write(drv, SPM_REG_PMIC_DATA_0,
>> +				drv->reg_data->pmic_data[0]);
>> +	spm_register_write(drv, SPM_REG_PMIC_DATA_1,
>> +				drv->reg_data->pmic_data[1]);
>> +
>> +	/**
>> +	 * Ensure all observers see the above register writes before the
>> +	 * cpuidle driver is allowed to use the SPM.
>> +	 */
>> +	wmb();
>> +	drv->available = true;
>
> Others have already commented on this, but I'll add my $0.02 that this
> suggest something is not right in the init sequence.

Yep, I did the same comment. There is very likely something wrong in the 
init sequence somewhere.

Lina, you really have to lean over that.

>> +	if ((cpu > -1) && !cpuidle_drv_init) {
>> +		platform_device_register(&qcom_cpuidle_device);
>> +		cpuidle_drv_init = true;
>> +	}
>> +
>> +	return 0;
>> +}
>> +

[ ... ]

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
