From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 17:05:51 +0200
Subject: [PATCH 3/3] soc: xilinx: zynqmp: Add firmware interface
In-Reply-To: <3809b6a0-1cb9-37af-a524-8bc1986268ec@xilinx.com>
References: <cover.1501854302.git.michal.simek@xilinx.com>
 <98038734d73c604dee6ac0d34740d5bc2034e87d.1501854302.git.michal.simek@xilinx.com>
 <CAK8P3a1UhKAhYx2fCoWGm7HMka+8XrzFCxEphYNdyNS7yYR8cA@mail.gmail.com>
 <247a5660-6c53-ccc3-7b9f-bfd2a11f6f54@xilinx.com>
 <CAK8P3a3TsnYRWnurAduChLVc5q41vax_S0mpK5sQPUo5reM5bw@mail.gmail.com>
 <d55c3064-3db8-dad9-ac0a-8adad53465ff@xilinx.com>
 <3809b6a0-1cb9-37af-a524-8bc1986268ec@xilinx.com>
Message-ID: <CAK8P3a2h27MSyUhTdU07m8dyGj92o2E5h0dviQ+mp7AtTYhM_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 16, 2017 at 4:34 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 16.8.2017 16:00, Michal Simek wrote:
>> On 16.8.2017 14:41, Arnd Bergmann wrote:
>>
>
> What do you think?
>                 ret_payload[0] = lower_32_bits(le64_to_cpu(res.a0));
>                 ret_payload[1] = upper_32_bits(le64_to_cpu(res.a0));
>                 ret_payload[2] = lower_32_bits(le64_to_cpu(res.a1));
>                 ret_payload[3] = upper_32_bits(le64_to_cpu(res.a1));
>                 ret_payload[4] = lower_32_bits(le64_to_cpu(res.a2));
>
> There should be probably also change in invoke_pm_fn to do conversion
> from cpu to le64.
>
> int invoke_pm_fn(u32 pm_api_id, u32 arg0, u32 arg1, u32 arg2, u32 arg3,
>                  u32 *ret_payload)
> {
>         /*
>          * Added SIP service call Function Identifier
>          * Make sure to stay in x0 register
>          */
>         u64 smc_arg[4];
>
>         smc_arg[0] = cpu_to_le64(PM_SIP_SVC | pm_api_id);
>         smc_arg[1] = cpu_to_le64(((u64)arg1 << 32) | arg0);
>         smc_arg[2] = cpu_to_le64(((u64)arg3 << 32) | arg2);
>
>         return do_fw_call(smc_arg[0], smc_arg[1], smc_arg[2], ret_payload);
> }
>
> This is not tested on BE just on LE.

Looks good, just make sure you also check with sparse (make C=1)
to ensure you have the right __le64/__le32 types everywhere.

       Arnd
