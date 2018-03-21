From: digetx@gmail.com (Dmitry Osipenko)
Date: Wed, 21 Mar 2018 18:26:58 +0300
Subject: [PATCH 3/5] ARM: trusted_foundations: do not use naked function
In-Reply-To: <302cfd1a4324e064cd4f189e4e0ffc21@agner.ch>
References: <20180320230206.25289-1-stefan@agner.ch>
 <20180320230206.25289-4-stefan@agner.ch>
 <124e16c9-b8ca-9c7e-ade5-b033eed76e14@arm.com>
 <302cfd1a4324e064cd4f189e4e0ffc21@agner.ch>
Message-ID: <03de5241-fb69-9097-5020-f9843482318d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.03.2018 17:09, Stefan Agner wrote:
> On 21.03.2018 13:13, Robin Murphy wrote:
>> On 20/03/18 23:02, Stefan Agner wrote:
>>> As documented in GCC naked functions should only use Basic asm
>>> syntax. The Extended asm or mixture of Basic asm and "C" code is
>>> not guaranteed. Currently this works because it was hard coded
>>> to follow and check GCC behavior for arguments and register
>>> placement.
>>>
>>> Furthermore with clang using parameters in Extended asm in a
>>> naked function is not supported:
>>>    arch/arm/firmware/trusted_foundations.c:47:10: error: parameter
>>>            references not allowed in naked functions
>>>                  : "r" (type), "r" (arg1), "r" (arg2)
>>>                         ^
>>>
>>> Use a regular function to be more portable. This aligns also with
>>> the other smc call implementations e.g. in qcom_scm-32.c and
>>> bcm_kona_smc.c.
>>>
>>> Additionally also make sure all callee-saved registers get saved
>>> as it has been done before.
>>>
>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>> ---
>>>   arch/arm/firmware/trusted_foundations.c | 12 +++++++-----
>>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
>>> index 3fb1b5a1dce9..426d732e6591 100644
>>> --- a/arch/arm/firmware/trusted_foundations.c
>>> +++ b/arch/arm/firmware/trusted_foundations.c
>>> @@ -31,21 +31,23 @@
>>>     static unsigned long cpu_boot_addr;
>>>   -static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>>> +static void tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>>>   {
>>> +	register u32 r0 asm("r0") = type;
>>> +	register u32 r1 asm("r1") = arg1;
>>> +	register u32 r2 asm("r2") = arg2;
>>> +
>>>   	asm volatile(
>>>   		".arch_extension	sec\n\t"
>>> -		"stmfd	sp!, {r4 - r11, lr}\n\t"
>>>   		__asmeq("%0", "r0")
>>>   		__asmeq("%1", "r1")
>>>   		__asmeq("%2", "r2")
>>>   		"mov	r3, #0\n\t"
>>>   		"mov	r4, #0\n\t"
>>>   		"smc	#0\n\t"
>>> -		"ldmfd	sp!, {r4 - r11, pc}"
>>>   		:
>>> -		: "r" (type), "r" (arg1), "r" (arg2)
>>> -		: "memory");
>>> +		: "r" (r0), "r" (r1), "r" (r2)
>>> +		: "memory", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10");
>>
>> I may be missing a subtlety, but it looks like we no longer have a
>> guarantee that r11 will be caller-saved as it was previously. I don't
>> know the Trusted Foundations ABI to say whether that matters or not,
>> but if it is the case that it never needed preserving anyway, that
>> might be worth calling out in the commit message.
> 
> Adding r11 (fp) to the clobber list causes an error when using gcc and
> CONFIG_FRAME_POINTER=y:
> arch/arm/firmware/trusted_foundations.c: In function ?tf_generic_smc?:
> arch/arm/firmware/trusted_foundations.c:51:1: error: fp cannot be used
> in asm here
> 
> Not sure what ABI Trusted Foundations follow.
> 
> [adding Stephen, Thierry and Dmitry]
> Maybe someone more familiar with NVIDIA Tegra SoCs can help?
> 
> When CONFIG_FRAME_POINTER=y fp gets saved anyway. So we could add r11 to
> clobber list ifndef CONFIG_FRAME_POINTER...

I have no idea about TF ABI either. Looking at the downstream kernel code, r4 -
r12 should be saved. I've CC'd Alexandre as he is the author of the original
patch and may still remember the details.

I'm also wondering why original code doesn't have r3 in the clobber list and why
r3 is set to '0', downstream sets it to the address of SP and on return from SMC
r3 contains the address of SP which should be restored. I'm now wondering how
SMC calling worked for me at all on T30, maybe it didn't..
