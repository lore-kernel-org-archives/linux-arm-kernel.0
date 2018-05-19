From: digetx@gmail.com (Dmitry Osipenko)
Date: Sun, 20 May 2018 01:02:46 +0300
Subject: [PATCH v2 3/6] ARM: trusted_foundations: do not use naked function
In-Reply-To: <507a66ab9ab530a6d71db7a74f11ddfb@agner.ch>
References: <20180325180959.28008-1-stefan@agner.ch>
 <20180325180959.28008-4-stefan@agner.ch>
 <704c863a-0b5a-6396-d7da-f0ed17b7cca2@gmail.com>
 <263337af-7541-be9e-3db6-6cb987fd08fb@arm.com>
 <f627177c-f813-9e10-ade5-c7654375639b@gmail.com>
 <cf9b916103c0dba1e67682efc69f5bae@agner.ch>
 <498de826-6e6c-63d8-00d6-f394b2725a34@wwwdotorg.org>
 <507a66ab9ab530a6d71db7a74f11ddfb@agner.ch>
Message-ID: <3bc2c0c2-1b8b-5296-4d33-ee8c97c54430@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.04.2018 21:21, Stefan Agner wrote:
> On 16.04.2018 18:08, Stephen Warren wrote:
>> On 04/16/2018 09:56 AM, Stefan Agner wrote:
>>> On 27.03.2018 14:16, Dmitry Osipenko wrote:
>>>> On 27.03.2018 14:54, Robin Murphy wrote:
>>>>> On 26/03/18 22:20, Dmitry Osipenko wrote:
>>>>>> On 25.03.2018 21:09, Stefan Agner wrote:
>>>>>>> As documented in GCC naked functions should only use Basic asm
>>>>>>> syntax. The Extended asm or mixture of Basic asm and "C" code is
>>>>>>> not guaranteed. Currently this works because it was hard coded
>>>>>>> to follow and check GCC behavior for arguments and register
>>>>>>> placement.
>>>>>>>
>>>>>>> Furthermore with clang using parameters in Extended asm in a
>>>>>>> naked function is not supported:
>>>>>>>  ?? arch/arm/firmware/trusted_foundations.c:47:10: error: parameter
>>>>>>>  ?????????? references not allowed in naked functions
>>>>>>>  ???????????????? : "r" (type), "r" (arg1), "r" (arg2)
>>>>>>>  ??????????????????????? ^
>>>>>>>
>>>>>>> Use a regular function to be more portable. This aligns also with
>>>>>>> the other smc call implementations e.g. in qcom_scm-32.c and
>>>>>>> bcm_kona_smc.c.
>>>>>>>
>>>>>>> Cc: Dmitry Osipenko <digetx@gmail.com>
>>>>>>> Cc: Stephen Warren <swarren@nvidia.com>
>>>>>>> Cc: Thierry Reding <treding@nvidia.com>
>>>>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>>>>>> ---
>>>>>>> Changes in v2:
>>>>>>> - Keep stmfd/ldmfd to avoid potential ABI issues
>>>>>>>
>>>>>>>  ? arch/arm/firmware/trusted_foundations.c | 14 +++++++++-----
>>>>>>>  ? 1 file changed, 9 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm/firmware/trusted_foundations.c
>>>>>>> b/arch/arm/firmware/trusted_foundations.c
>>>>>>> index 3fb1b5a1dce9..689e6565abfc 100644
>>>>>>> --- a/arch/arm/firmware/trusted_foundations.c
>>>>>>> +++ b/arch/arm/firmware/trusted_foundations.c
>>>>>>> @@ -31,21 +31,25 @@
>>>>>>>  ? ? static unsigned long cpu_boot_addr;
>>>>>>>  ? -static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>>>>>>> +static void tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>>>>>>>  ? {
>>>>>>> +??? register u32 r0 asm("r0") = type;
>>>>>>> +??? register u32 r1 asm("r1") = arg1;
>>>>>>> +??? register u32 r2 asm("r2") = arg2;
>>>>>>> +
>>>>>>>  ????? asm volatile(
>>>>>>>  ????????? ".arch_extension??? sec\n\t"
>>>>>>> -??????? "stmfd??? sp!, {r4 - r11, lr}\n\t"
>>>>>>> +??????? "stmfd??? sp!, {r4 - r11}\n\t"
>>>>>>>  ????????? __asmeq("%0", "r0")
>>>>>>>  ????????? __asmeq("%1", "r1")
>>>>>>>  ????????? __asmeq("%2", "r2")
>>>>>>>  ????????? "mov??? r3, #0\n\t"
>>>>>>>  ????????? "mov??? r4, #0\n\t"
>>>>>>>  ????????? "smc??? #0\n\t"
>>>>>>> -??????? "ldmfd??? sp!, {r4 - r11, pc}"
>>>>>>> +??????? "ldmfd??? sp!, {r4 - r11}\n\t"
>>>>>>>  ????????? :
>>>>>>> -??????? : "r" (type), "r" (arg1), "r" (arg2)
>>>>>>> -??????? : "memory");
>>>>>>> +??????? : "r" (r0), "r" (r1), "r" (r2)
>>>>>>> +??????? : "memory", "r3", "r12", "lr");
>>>>>>
>>>>>> Although seems "lr" won't be affected by SMC invocation because it should be
>>>>>> banked and hence could be omitted entirely from the code. Maybe somebody could
>>>>>> confirm this.
>>>>> Strictly per the letter of the architecture, the SMC could be trapped to Hyp
>>>>> mode, and a hypervisor might clobber LR_usr in the process of forwarding the
>>>>> call to the firmware secure monitor (since Hyp doesn't have a banked LR of its
>>>>> own). Admittedly there are probably no real systems with the appropriate
>>>>> hardware/software combination to hit that, but on the other hand if this gets
>>>>> inlined where the compiler has already created a stack frame then an LR clobber
>>>>> is essentially free, so I reckon we're better off keeping it for reassurance.
>>>>> This isn't exactly a critical fast path anyway.
>>>>
>>>> Okay, thank you for the clarification.
>>>
>>> So it seems this change is fine?
>>>
>>> Stephen, you picked up changes for this driver before, is this patch
>>> going through your tree?
>>
>> You had best ask Thierry; he's taken over Tegra maintenance upstream.
>> But that said, don't files in arch/arm go through Russell?
> 
> I think the last patches applied to that file went through your tree.
> 
> Thierry, Russel, any preferences?

I've been preparing patches for upstream to add initial support of L2 cache
maintance to TF / Tegra30 and noticed that without this patch I'm getting a hang
early in boot. That is because before this patch registers store / restore was
incorrect, probably the premature return (lr -> pc) causes stack corruption. Not
sure whether it's worth to backport this patch, but I want to see it at least in
-next.

Thierry, please take care of this patch. Thanks.
