From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 13 Mar 2018 10:24:12 +0000
Subject: [PATCH v5 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
 driver
In-Reply-To: <DM2PR0201MB07673298E409D07F0F748316B8D30@DM2PR0201MB0767.namprd02.prod.outlook.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-3-git-send-email-jollys@xilinx.com>
 <dab419e8-3afe-5bfe-240e-e9ee4f2300f2@arm.com>
 <DM2PR0201MB076735E33069DC6F0C84EFDCB8D80@DM2PR0201MB0767.namprd02.prod.outlook.com>
 <2fb8ee8c-35ac-b7e6-e691-84464b0c8745@arm.com>
 <DM2PR0201MB07673298E409D07F0F748316B8D30@DM2PR0201MB0767.namprd02.prod.outlook.com>
Message-ID: <4cff1193-5345-0531-d81e-0dd6e0633b19@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/03/18 23:05, Jolly Shah wrote:
> 

[...]

>>
>> OK, what are the types you are referring here ? or why PSCI is not sufficient ?
>> How do you plan to use these APIs in Linux ?
> 
> It supports system/subsystem restart as types. For example, only APU
> restart, system restart, PS restart for ZynqMP
> PSCI doesn?t support any argument to identify these types. Linux, one
> can set the reset scope through debug interface and execute
> "reboot" then. Inside ATF, PSCI_SYSTEM_RESET mapped function will call
> EEMI API with that scope.

OK, I am not sure how you use them in Linux. Please add drivers using
them or just drop them for now and add when you add the users of these
functions.

>>
>>>>
>>>>> +static const struct zynqmp_eemi_ops eemi_ops = {
>>>>> +	.get_api_version = zynqmp_pm_get_api_version,
>>>>> +	.get_chipid = zynqmp_pm_get_chipid,
>>>>> +	.reset_assert = zynqmp_pm_reset_assert,
>>>>> +	.reset_get_status = zynqmp_pm_reset_get_status,
>>>>> +	.fpga_load = zynqmp_pm_fpga_load,
>>>>> +	.fpga_get_status = zynqmp_pm_fpga_get_status,
>>>>> +	.sha_hash = zynqmp_pm_sha_hash,
>>>>> +	.rsa = zynqmp_pm_rsa,
>>>>> +	.request_suspend = zynqmp_pm_request_suspend,
>>>>> +	.force_powerdown = zynqmp_pm_force_powerdown,
>>>>> +	.request_wakeup = zynqmp_pm_request_wakeup,
>>>>> +	.set_wakeup_source = zynqmp_pm_set_wakeup_source,
>>>>> +	.system_shutdown = zynqmp_pm_system_shutdown,
>>>>> +	.request_node = zynqmp_pm_request_node,
>>>>> +	.release_node = zynqmp_pm_release_node,
>>>>> +	.set_requirement = zynqmp_pm_set_requirement,
>>>>> +	.set_max_latency = zynqmp_pm_set_max_latency,
>>>>> +	.set_configuration = zynqmp_pm_set_configuration,
>>>>> +	.get_node_status = zynqmp_pm_get_node_status,
>>>>> +	.get_operating_characteristic =
>>>> zynqmp_pm_get_operating_characteristic,
>>>>> +	.init_finalize = zynqmp_pm_init_finalize,
>>>>> +	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
>>>>> +	.ioctl = zynqmp_pm_ioctl,
>>>>> +	.query_data = zynqmp_pm_query_data,
>>>>> +	.pinctrl_request = zynqmp_pm_pinctrl_request,
>>>>> +	.pinctrl_release = zynqmp_pm_pinctrl_release,
>>>>> +	.pinctrl_get_function = zynqmp_pm_pinctrl_get_function,
>>>>> +	.pinctrl_set_function = zynqmp_pm_pinctrl_set_function,
>>>>> +	.pinctrl_get_config = zynqmp_pm_pinctrl_get_config,
>>>>> +	.pinctrl_set_config = zynqmp_pm_pinctrl_set_config,
>>>>> +	.clock_enable = zynqmp_pm_clock_enable,
>>>>> +	.clock_disable = zynqmp_pm_clock_disable,
>>>>> +	.clock_getstate = zynqmp_pm_clock_getstate,
>>>>> +	.clock_setdivider = zynqmp_pm_clock_setdivider,
>>>>> +	.clock_getdivider = zynqmp_pm_clock_getdivider,
>>>>> +	.clock_setrate = zynqmp_pm_clock_setrate,
>>>>> +	.clock_getrate = zynqmp_pm_clock_getrate,
>>>>> +	.clock_setparent = zynqmp_pm_clock_setparent,
>>>>> +	.clock_getparent = zynqmp_pm_clock_getparent, };
>>>>> +
>>>> Instead of introducing all these in oneshot, add them as you have users of it.
>>>> IOW, show the users of these functions in the series. Also I asked to
>>>> split this into functional changes like clock, pinctrl, power, etc.
>>>
>>> It can be split into functional changes in same series but it will be
>>> difficult to split between users as there are more than 10 driver
>>> users for different EEMI APIs and also multiple driver users using
>>> specifc EEMI APIs. They all can't be submitted as single series.
>>>
>>
>> Why ? Start with basic EEMI and one functionality with it's user/client driver in
>> one series. Then you can top up with EEMI changes for other functionality with
>> it's user. If you introduce API's without the users in a series it's hard to review
>> and if there are more such unused APIs I will object it in future versions.
>>
>> To start with add only clock or power APIs and functionality in this series, add
>> drivers using then. Drop other functionalities like pinctrl, fpga control and other
>> functionalities. IOW start something basic and simple.
>> 

> 
> I am ok to break it for clock/pinctrl with users but there are
> multiple users for some APIs. In that case, it will create dependency
> issues when different owners are involved.
> Also, it will hard to visualize a whole EEMI interface if its broken
> into such pieces.
> 

It's opposite, you are just adding whole lot of functions/APIs here with
out the users of those APIs. I am unable to visualise how they are
getting used. So for me even if you just add handful of above APIs with
drivers making call to each one of them along with it, I can better
understand it. Without any usage of these APIs in this series, I fail
to understand the need of it.
So NACK to this patch without the users of the APIs introduced here.

-- 
Regards,
Sudeep
