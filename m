From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Aug 2017 23:11:45 +0200
Subject: [PATCH 3/3] soc: xilinx: zynqmp: Add firmware interface
In-Reply-To: <5a53e449-b269-89da-9b69-e560132502fc@xilinx.com>
References: <cover.1501854302.git.michal.simek@xilinx.com>
 <98038734d73c604dee6ac0d34740d5bc2034e87d.1501854302.git.michal.simek@xilinx.com>
 <CAK8P3a1UhKAhYx2fCoWGm7HMka+8XrzFCxEphYNdyNS7yYR8cA@mail.gmail.com>
 <247a5660-6c53-ccc3-7b9f-bfd2a11f6f54@xilinx.com>
 <CAK8P3a3TsnYRWnurAduChLVc5q41vax_S0mpK5sQPUo5reM5bw@mail.gmail.com>
 <d55c3064-3db8-dad9-ac0a-8adad53465ff@xilinx.com>
 <3809b6a0-1cb9-37af-a524-8bc1986268ec@xilinx.com>
 <CAK8P3a2h27MSyUhTdU07m8dyGj92o2E5h0dviQ+mp7AtTYhM_A@mail.gmail.com>
 <5a53e449-b269-89da-9b69-e560132502fc@xilinx.com>
Message-ID: <CAK8P3a0+tMHHYtVsq77LdcH+3Sdse38md=Bn3Sjkg0LzKyTn9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 12:48 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 16.8.2017 17:05, Arnd Bergmann wrote:
>> On Wed, Aug 16, 2017 at 4:34 PM, Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> Looks good, just make sure you also check with sparse (make C=1)
>> to ensure you have the right __le64/__le32 types everywhere.
>
> Are you aware about any doc where it is written that data should be
> passed as little endian?

Looking at http://infocenter.arm.com/help/topic/com.arm.doc.den0028b/ARM_DEN0028B_SMC_Calling_Convention.pdf
now, I think that the structure above is endian-neutral as the arguments
get passed in registers rather than memory.

However, if you pass pointers to data structures in memory, those
data structures would have to be defined with __le32/__le64 types.

> I was playing with it a little bit and this means that these 2(3 with
> hvc) needs to be changed.
>
> asmlinkage void __arm_smccc_smc(__le64 a0, __le64 a1, __le64 a2,
>  __le64 a3,__le64 a4, __le64 a5, __le64 a6, __le64 a7,
> struct arm_smccc_res *res, struct arm_smccc_quirk *quirk);
>
>  struct arm_smccc_res {
> -       unsigned long a0;
> -       unsigned long a1;
> -       unsigned long a2;
> -       unsigned long a3;
> +       __le64 a0;
> +       __le64 a1;
> +       __le64 a2;
> +       __le64 a3;
>  };

This is clearly wrong on 32-bit machines, I think this is intentionally
defined as 'unsigned long' to have register sized arguments.

       Arnd
