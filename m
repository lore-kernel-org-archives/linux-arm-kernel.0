From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 6 Mar 2017 07:45:38 -0600
Subject: [PATCH v2] arm64: kvm: Use has_vhe() instead of
 hyp_alternate_select()
In-Reply-To: <87bmte3itj.fsf@on-the-bus.cambridge.arm.com>
References: <1488767598-2055-1-git-send-email-shankerd@codeaurora.org>
 <87bmte3itj.fsf@on-the-bus.cambridge.arm.com>
Message-ID: <06920fd1-8efc-5ee3-b57f-6fa495199e43@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,


On 03/06/2017 02:34 AM, Marc Zyngier wrote:
> Hi Shanker,
>
> On Mon, Mar 06 2017 at  2:33:18 am GMT, Shanker Donthineni <shankerd@codeaurora.org> wrote:
>> Now all the cpu_hwcaps features have their own static keys. We don't
>> need a separate function hyp_alternate_select() to patch the vhe/nvhe
>> code. We can achieve the same functionality by using has_vhe(). It
>> improves the code readability, uses the jump label instructions, and
>> also compiler generates the better code with a fewer instructions.
> How do you define "better"? Which compiler? Do you have any benchmarking data?
I'm using gcc version 5.2.0. With has_vhe() it shows the smaller code 
size as shown below. I tried to benchmark
the code changes using Cristiffer's microbench tool, but not seeing a 
noticeable difference on QDF2400 platform.

hyp_alternate_select() uses BR/BLR instructions to patch vhe/mvhe code, 
which is not good for branch prediction purpose.
compiler treats patched code as a function call, so the contents of the 
registers x0-x18 are not reusable after vhe/nvhe call.

Current code:
arch/arm64/kvm/hyp/switch.o:     file format elf64-littleaarch64

Sections:
Idx Name          Size      VMA               LMA               File 
off  Algn
   0 .text         00000000  0000000000000000  0000000000000000 
00000040  2**0
                   CONTENTS, ALLOC, LOAD, READONLY, CODE
   1 .data         00000000  0000000000000000  0000000000000000 
00000040  2**0
                   CONTENTS, ALLOC, LOAD, DATA
   2 .bss          00000000  0000000000000000  0000000000000000 
00000040  2**0
                   ALLOC
   3 .hyp.text     00000550  0000000000000000  0000000000000000 
00000040  2**3
                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE

New code:
arch/arm64/kvm/hyp/switch.o:     file format elf64-littleaarch64

Sections:
Idx Name          Size      VMA               LMA               File 
off  Algn
   0 .text         00000000  0000000000000000  0000000000000000 
00000040  2**0
                   CONTENTS, ALLOC, LOAD, READONLY, CODE
   1 .data         00000000  0000000000000000  0000000000000000 
00000040  2**0
                   CONTENTS, ALLOC, LOAD, DATA
   2 .bss          00000000  0000000000000000  0000000000000000 
00000040  2**0
                   ALLOC
   3 .hyp.text     00000488  0000000000000000  0000000000000000 
00000040  2**3
                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE


>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>> ---
>> v2: removed 'Change-Id: Ia8084189833f2081ff13c392deb5070c46a64038' from commit
>>
>>   arch/arm64/kvm/hyp/debug-sr.c  | 12 ++++++----
>>   arch/arm64/kvm/hyp/switch.c    | 50 +++++++++++++++++++-----------------------
>>   arch/arm64/kvm/hyp/sysreg-sr.c | 23 +++++++++----------
>>   3 files changed, 43 insertions(+), 42 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/hyp/debug-sr.c b/arch/arm64/kvm/hyp/debug-sr.c
>> index f5154ed..e5642c2 100644
>> --- a/arch/arm64/kvm/hyp/debug-sr.c
>> +++ b/arch/arm64/kvm/hyp/debug-sr.c
>> @@ -109,9 +109,13 @@ static void __hyp_text __debug_save_spe_nvhe(u64 *pmscr_el1)
>>   	dsb(nsh);
>>   }
>>   
>> -static hyp_alternate_select(__debug_save_spe,
>> -			    __debug_save_spe_nvhe, __debug_save_spe_vhe,
>> -			    ARM64_HAS_VIRT_HOST_EXTN);
>> +static void __hyp_text __debug_save_spe(u64 *pmscr_el1)
>> +{
>> +	if (has_vhe())
>> +		__debug_save_spe_vhe(pmscr_el1);
>> +	else
>> +		__debug_save_spe_nvhe(pmscr_el1);
>> +}
> I have two worries about this kind of thing:
> - Not all compilers do support jump labels, leading to a memory access
> on each static key (GCC 4.8, for example). This would immediately
> introduce a pretty big regression
> - The hyp_alternate_select() method doesn't introduce a fast/slow path
> duality. Each path has the exact same cost. I'm not keen on choosing
> what is supposed to be the fast path, really.
Yes, it'll require a runtime check if the compiler doesn't support ASM 
GOTO labels.
Agree, hyp_alternate_select() has a constant branch over head but it 
might cause a branch prediction penality.

> Thanks,
>
> 	M.

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
