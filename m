From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 16 Aug 2017 16:00:27 +0200
Subject: [PATCH 3/3] soc: xilinx: zynqmp: Add firmware interface
In-Reply-To: <CAK8P3a3TsnYRWnurAduChLVc5q41vax_S0mpK5sQPUo5reM5bw@mail.gmail.com>
References: <cover.1501854302.git.michal.simek@xilinx.com>
 <98038734d73c604dee6ac0d34740d5bc2034e87d.1501854302.git.michal.simek@xilinx.com>
 <CAK8P3a1UhKAhYx2fCoWGm7HMka+8XrzFCxEphYNdyNS7yYR8cA@mail.gmail.com>
 <247a5660-6c53-ccc3-7b9f-bfd2a11f6f54@xilinx.com>
 <CAK8P3a3TsnYRWnurAduChLVc5q41vax_S0mpK5sQPUo5reM5bw@mail.gmail.com>
Message-ID: <d55c3064-3db8-dad9-ac0a-8adad53465ff@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.8.2017 14:41, Arnd Bergmann wrote:
> On Wed, Aug 16, 2017 at 1:51 PM, Michal Simek <michal.simek@xilinx.com> wrote:
>> On 14.8.2017 17:06, Arnd Bergmann wrote:
>>> On Fri, Aug 4, 2017 at 3:45 PM, Michal Simek <michal.simek@xilinx.com> wrote:
>>>> +static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
>>>> +                                  u32 *ret_payload)
>>>> +{
>>>> +       struct arm_smccc_res res;
>>>> +
>>>> +       arm_smccc_smc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
>>>> +
>>>> +       if (ret_payload) {
>>>> +               ret_payload[0] = (u32)res.a0;
>>>> +               ret_payload[1] = (u32)(res.a0 >> 32);
>>>> +               ret_payload[2] = (u32)res.a1;
>>>> +               ret_payload[3] = (u32)(res.a1 >> 32);
>>>> +               ret_payload[4] = (u32)res.a2;
>>>> +       }
>>>> +
>>>> +       return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
>>>> +}
>>>
>>> It looks like you forgot to add the cpu_to_le32/le32_to_cpu conversions
>>> here to make this work on big-endian kernels.
>>
>> We have discussed support for big endian kernels in past and discussion
>> end up with that there is no customer for this. It means I can change
>> this but none will use this.
> 
> Ok, thanks. As a general rule, I prefer kernel code to be written
> in a portable way even when you assume that is not necessary.
> 
> Besides the obvious problem of users that end up wanting to do
> something you don't expect, there is the more general issue of
> copying code into another driver that may need to be more portable.


I fully understand this. Let me play with it but I expect there will be
different issues then just this.

> 
>>>> +static u32 pm_api_version;
>>>> +
>>>> +/**
>>>> + * zynqmp_pm_get_api_version - Get version number of PMU PM firmware
>>>> + * @version:   Returned version value
>>>> + *
>>>> + * Return:     Returns status, either success or error+reason
>>>> + */
>>>> +int zynqmp_pm_get_api_version(u32 *version)
>>>> +{
>>>> +       u32 ret_payload[PAYLOAD_ARG_CNT];
>>>> +
>>>> +       if (!version)
>>>> +               return zynqmp_pm_ret_code(XST_PM_CONFLICT);
>>>> +
>>>> +       /* Check is PM API version already verified */
>>>> +       if (pm_api_version > 0) {
>>>> +               *version = pm_api_version;
>>>> +               return XST_PM_SUCCESS;
>>>> +       }
>>>> +       invoke_pm_fn(GET_API_VERSION, 0, 0, 0, 0, ret_payload);
>>>> +       *version = ret_payload[1];
>>>> +
>>>> +       return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(zynqmp_pm_get_api_version);
>>>
>>> How is this supposed to be used? API version number interfaces
>>> are generally problematic, as you don't have that interface any
>>> more if you change the version.
>>
>> This function is called from power management driver to find out a
>> version of PMUFW. It is not a problem to save version in the driver and
>> provide another function to access it instead of asking firmware again.
>> Or also remove this completely because it is more for power management
>> then for communication. And this patch is just about communication.
> 
> Ok. For the purpose of the power management driver, you
> probably also want a different name, as what you are interested
> in is not the API version but the firmware version.

I am really looking forward to see xilinx PM guys to start to upstream
their code. And they most likely need this API version.
But for that stuff which are the part of this patch all functions should
be there. If function is not implemented then you get error back which
is sign that firmware doesn't support it.

Definitely we can consider to add compatible string with version suffix
in future when the same SMCs will be used for different purpose.


>>> Normally this should be based on the "compatible" string
>>> in DT to find our what you are talking to, in combination with
>>> a list of features that you can query to find out if something
>>> is available that you can't just try out by calling.
>>
>> How can you find out what you are talking to without asking for version?
>>
>> It should be probably be based on some sort of list of services and
>> based on that enabled features.
> 
> My point was that you can't even ask for a version number without
> first knowing what you are talking to, and that information comes from
> the DT node describing the interface.

Ok. Got you and yes there must be at least any node.

Thanks,
Michal
