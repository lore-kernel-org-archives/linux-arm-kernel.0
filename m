From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 16 Aug 2017 14:05:58 +0200
Subject: [PATCH 3/3] soc: xilinx: zynqmp: Add firmware interface
In-Reply-To: <247a5660-6c53-ccc3-7b9f-bfd2a11f6f54@xilinx.com>
References: <cover.1501854302.git.michal.simek@xilinx.com>
 <98038734d73c604dee6ac0d34740d5bc2034e87d.1501854302.git.michal.simek@xilinx.com>
 <CAK8P3a1UhKAhYx2fCoWGm7HMka+8XrzFCxEphYNdyNS7yYR8cA@mail.gmail.com>
 <247a5660-6c53-ccc3-7b9f-bfd2a11f6f54@xilinx.com>
Message-ID: <1074f025-404e-f6a1-cc69-4f9ea7b366a7@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.8.2017 13:51, Michal Simek wrote:
> On 14.8.2017 17:06, Arnd Bergmann wrote:
>> On Fri, Aug 4, 2017 at 3:45 PM, Michal Simek <michal.simek@xilinx.com> wrote:
>>> +static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
>>> +                                  u32 *ret_payload)
>>> +{
>>> +       struct arm_smccc_res res;
>>> +
>>> +       arm_smccc_smc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
>>> +
>>> +       if (ret_payload) {
>>> +               ret_payload[0] = (u32)res.a0;
>>> +               ret_payload[1] = (u32)(res.a0 >> 32);
>>> +               ret_payload[2] = (u32)res.a1;
>>> +               ret_payload[3] = (u32)(res.a1 >> 32);
>>> +               ret_payload[4] = (u32)res.a2;
>>> +       }
>>> +
>>> +       return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
>>> +}
>>
>> It looks like you forgot to add the cpu_to_le32/le32_to_cpu conversions
>> here to make this work on big-endian kernels.
> 
> We have discussed support for big endian kernels in past and discussion
> end up with that there is no customer for this. It means I can change
> this but none will use this.
> 
> 
>>
>>> +
>>> +static u32 pm_api_version;
>>> +
>>> +/**
>>> + * zynqmp_pm_get_api_version - Get version number of PMU PM firmware
>>> + * @version:   Returned version value
>>> + *
>>> + * Return:     Returns status, either success or error+reason
>>> + */
>>> +int zynqmp_pm_get_api_version(u32 *version)
>>> +{
>>> +       u32 ret_payload[PAYLOAD_ARG_CNT];
>>> +
>>> +       if (!version)
>>> +               return zynqmp_pm_ret_code(XST_PM_CONFLICT);
>>> +
>>> +       /* Check is PM API version already verified */
>>> +       if (pm_api_version > 0) {
>>> +               *version = pm_api_version;
>>> +               return XST_PM_SUCCESS;
>>> +       }
>>> +       invoke_pm_fn(GET_API_VERSION, 0, 0, 0, 0, ret_payload);
>>> +       *version = ret_payload[1];
>>> +
>>> +       return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
>>> +}
>>> +EXPORT_SYMBOL_GPL(zynqmp_pm_get_api_version);
>>
>> How is this supposed to be used? API version number interfaces
>> are generally problematic, as you don't have that interface any
>> more if you change the version.
> 
> This function is called from power management driver to find out a
> version of PMUFW. It is not a problem to save version in the driver and
> provide another function to access it instead of asking firmware again.
> Or also remove this completely because it is more for power management
> then for communication. And this patch is just about communication.
> 
> 
>>
>> Normally this should be based on the "compatible" string
>> in DT to find our what you are talking to, in combination with
>> a list of features that you can query to find out if something
>> is available that you can't just try out by calling.
> 
> How can you find out what you are talking to without asking for version?
> 
> It should be probably be based on some sort of list of services and
> based on that enabled features.
> 
> Anyway I don't need this function to be in this interface driver that's
> why I will remove this part in v2.
> 
>>> diff --git a/include/linux/soc/xilinx/zynqmp/firmware.h b/include/linux/soc/xilinx/zynqmp/firmware.h
>>> new file mode 100644
>>> index 000000000000..5beb5988e3de
>>> --- /dev/null
>>> +++ b/include/linux/soc/xilinx/zynqmp/firmware.h
>>> @@ -0,0 +1,246 @@
>>> +
>>> +#ifndef __SOC_ZYNQMP_FIRMWARE_H__
>>> +#define __SOC_ZYNQMP_FIRMWARE_H__
>>> +
>>> +#define ZYNQMP_PM_VERSION_MAJOR        0
>>> +#define ZYNQMP_PM_VERSION_MINOR        3
>>
>> Again, having the version number hardcoded in a global constant
>> seems pointless. If you expect to have to support different incompatible
>> versions in the future, name the header file firmware-0-3.h and
>> prefix the constants with the current version.
> 
> Will remove.
> 
>>
>>> +/*
>>> + * Internal functions
>>> + */
>>> +int invoke_pm_fn(u32 pm_api_id, u32 arg0, u32 arg1, u32 arg2, u32 arg3,
>>> +                u32 *ret_payload);
>>> +int zynqmp_pm_ret_code(u32 ret_status);
>>> +
>>> +/* Miscellaneous API functions */
>>> +int zynqmp_pm_get_api_version(u32 *version);
> 
> This will go out too.
> 
>>> +int zynqmp_pm_get_chipid(u32 *idcode, u32 *version);
>>
>> The "internal" functions probably shouldn't be declared in a global
>> header file.

Sorry got your comment now - will mark that internal functions as static
to get them out of this header.

Thanks,
Michal
