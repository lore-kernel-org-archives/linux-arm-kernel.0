From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 18 Jun 2018 10:52:29 +0100
Subject: [PATCH 2/4] ARM: NOMMU: Postpone MPU activation till
 __after_proc_init
In-Reply-To: <a266d2d9-44dc-16aa-6b35-7bbda080c4ef@kernel.org>
References: <a266d2d9-44dc-16aa-6b35-7bbda080c4ef@kernel.org>
Message-ID: <7db4e6a5-4644-8afd-cf60-a00338386ca9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/06/18 02:20, Greg Ungerer wrote:
> Hi Vladimir,

Hi Greg,

> 
> On 12/02/2018 11:19:31, Vladimir Murzin wrote:
>> This patch postpone MPU activation till __after_proc_init (which is
>> placed in .text section) rather than doing it in __setup_mpu. It
>> allows us ignore used-only-once .head.text section while programming
>> PMSAv8 MPU (for PMSAv7 it stays covered anyway).
>>
>> Tested-by: Szemz? Andr?s <sza@xxxxxx>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@xxxxxxx>
>> ---
>> ?arch/arm/kernel/head-nommu.S | 45 ++++++++++++++++++++++----------------------
>> ?1 file changed, 22 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
>> index aaa25a6..482936a 100644
>> --- a/arch/arm/kernel/head-nommu.S
>> +++ b/arch/arm/kernel/head-nommu.S
>> @@ -125,11 +125,24 @@ __secondary_data:
>> ? */
>> ???? .text
>> ?__after_proc_init:
>> +#ifdef CONFIG_ARM_MPU
>> +M_CLASS(movw??? r12, #:lower16:BASEADDR_V7M_SCB)
>> +M_CLASS(movt??? r12, #:upper16:BASEADDR_V7M_SCB)
>> +M_CLASS(ldr??? r3, [r12, 0x50])
>> +AR_CLASS(mrc??? p15, 0, r3, c0, c1, 4)????????? @ Read ID_MMFR0
>> +??? and??? r3, r3, #(MMFR0_PMSA)?????????? @ PMSA field
>> +??? teq??? r3, #(MMFR0_PMSAv7)???????????? @ PMSA v7
>> +#endif
>> ?#ifdef CONFIG_CPU_CP15
>> ???? /*
>> ????? * CP15 system control register value returned in r0 from
>> ????? * the CPU init function.
>> ????? */
>> +
>> +#ifdef CONFIG_ARM_MPU
>> +??? biceq??? r0, r0, #CR_BR??????????? @ Disable the 'default mem-map'
>> +??? orreq??? r0, r0, #CR_M??????????? @ Set SCTRL.M (MPU on)
>> +#endif
>> ?#if defined(CONFIG_ALIGNMENT_TRAP) && __LINUX_ARM_ARCH__ < 6
>> ???? orr??? r0, r0, #CR_A
>> ?#else
>> @@ -145,7 +158,15 @@ __after_proc_init:
>> ???? bic??? r0, r0, #CR_I
>> ?#endif
>> ???? mcr??? p15, 0, r0, c1, c0, 0??????? @ write control reg
>> +??? isb
> 
> This is causing breakage for me when building with my patches to
> support the old Versatile platform in no-MMU mode:
> 
> ? AS????? arch/arm/kernel/head-nommu.o
> arch/arm/kernel/head-nommu.S: Assembler messages:
> arch/arm/kernel/head-nommu.S:180: Error: selected processor does not support `isb' in ARM mode
> scripts/Makefile.build:417: recipe for target 'arch/arm/kernel/head-nommu.o' failed
> make[2]: *** [arch/arm/kernel/head-nommu.o] Error 1
> Makefile:1034: recipe for target 'arch/arm/kernel' failed
> make[1]: *** [arch/arm/kernel] Error 2
> 
> You may recall that patch series from some time back:
> https://www.spinics.net/lists/arm-kernel/msg547602.html
> 
> That patch series is pretty much unchanged, and I am running it
> on top of linux-4.18-rc1, using a gcc-5.4.0 based toolchain.
> (I really need to make an effort again to push this further...)
> 
> Is the "isb" instruction valid on ARM926T?

Thanks for report and sorry for causing you problems. I've just sent
a patch to address that which I've quickly tested with

qemu-system-arm -M versatilepb ...

sure your patches were applied.

Cheers
Vladimir

> 
> Regards
> Greg
> 
> 
> 
