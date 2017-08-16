From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 16 Aug 2017 16:34:44 +0200
Subject: [PATCH 3/3] soc: xilinx: zynqmp: Add firmware interface
In-Reply-To: <d55c3064-3db8-dad9-ac0a-8adad53465ff@xilinx.com>
References: <cover.1501854302.git.michal.simek@xilinx.com>
 <98038734d73c604dee6ac0d34740d5bc2034e87d.1501854302.git.michal.simek@xilinx.com>
 <CAK8P3a1UhKAhYx2fCoWGm7HMka+8XrzFCxEphYNdyNS7yYR8cA@mail.gmail.com>
 <247a5660-6c53-ccc3-7b9f-bfd2a11f6f54@xilinx.com>
 <CAK8P3a3TsnYRWnurAduChLVc5q41vax_S0mpK5sQPUo5reM5bw@mail.gmail.com>
 <d55c3064-3db8-dad9-ac0a-8adad53465ff@xilinx.com>
Message-ID: <3809b6a0-1cb9-37af-a524-8bc1986268ec@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.8.2017 16:00, Michal Simek wrote:
> On 16.8.2017 14:41, Arnd Bergmann wrote:
>> On Wed, Aug 16, 2017 at 1:51 PM, Michal Simek <michal.simek@xilinx.com> wrote:
>>> On 14.8.2017 17:06, Arnd Bergmann wrote:
>>>> On Fri, Aug 4, 2017 at 3:45 PM, Michal Simek <michal.simek@xilinx.com> wrote:
>>>>> +static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
>>>>> +                                  u32 *ret_payload)
>>>>> +{
>>>>> +       struct arm_smccc_res res;
>>>>> +
>>>>> +       arm_smccc_smc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
>>>>> +
>>>>> +       if (ret_payload) {
>>>>> +               ret_payload[0] = (u32)res.a0;
>>>>> +               ret_payload[1] = (u32)(res.a0 >> 32);
>>>>> +               ret_payload[2] = (u32)res.a1;
>>>>> +               ret_payload[3] = (u32)(res.a1 >> 32);
>>>>> +               ret_payload[4] = (u32)res.a2;
>>>>> +       }
>>>>> +
>>>>> +       return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
>>>>> +}
>>>>
>>>> It looks like you forgot to add the cpu_to_le32/le32_to_cpu conversions
>>>> here to make this work on big-endian kernels.
>>>
>>> We have discussed support for big endian kernels in past and discussion
>>> end up with that there is no customer for this. It means I can change
>>> this but none will use this.
>>
>> Ok, thanks. As a general rule, I prefer kernel code to be written
>> in a portable way even when you assume that is not necessary.
>>
>> Besides the obvious problem of users that end up wanting to do
>> something you don't expect, there is the more general issue of
>> copying code into another driver that may need to be more portable.
> 
> 
> I fully understand this. Let me play with it but I expect there will be
> different issues then just this.
> 

What do you think?
		ret_payload[0] = lower_32_bits(le64_to_cpu(res.a0));
		ret_payload[1] = upper_32_bits(le64_to_cpu(res.a0));
		ret_payload[2] = lower_32_bits(le64_to_cpu(res.a1));
		ret_payload[3] = upper_32_bits(le64_to_cpu(res.a1));
		ret_payload[4] = lower_32_bits(le64_to_cpu(res.a2));

There should be probably also change in invoke_pm_fn to do conversion
from cpu to le64.

int invoke_pm_fn(u32 pm_api_id, u32 arg0, u32 arg1, u32 arg2, u32 arg3,
		 u32 *ret_payload)
{
	/*
	 * Added SIP service call Function Identifier
	 * Make sure to stay in x0 register
	 */
	u64 smc_arg[4];

	smc_arg[0] = cpu_to_le64(PM_SIP_SVC | pm_api_id);
	smc_arg[1] = cpu_to_le64(((u64)arg1 << 32) | arg0);
	smc_arg[2] = cpu_to_le64(((u64)arg3 << 32) | arg2);

	return do_fw_call(smc_arg[0], smc_arg[1], smc_arg[2], ret_payload);
}

This is not tested on BE just on LE.

Thanks,
Michal
