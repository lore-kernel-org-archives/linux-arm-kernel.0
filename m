From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 17 Apr 2013 10:22:02 -0600
Subject: [PATCH 3/3] ARM: tegra: make sure the pointer on 4 byte align
 when THUMB2_KERNEL enabled
In-Reply-To: <20130417102957.GA2249@linaro.org>
References: <1366066255-18192-1-git-send-email-swarren@wwwdotorg.org>
 <1366066255-18192-3-git-send-email-swarren@wwwdotorg.org>
 <20130416141252.GA2229@linaro.org> <516D7A3B.9030404@wwwdotorg.org>
 <20130417102957.GA2249@linaro.org>
Message-ID: <516ECC2A.1060308@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2013 04:30 AM, Dave Martin wrote:
> On Tue, Apr 16, 2013 at 10:20:11AM -0600, Stephen Warren wrote:
>> On 04/16/2013 08:13 AM, Dave Martin wrote:
>>> On Mon, Apr 15, 2013 at 04:50:55PM -0600, Stephen Warren wrote:
>>>> From: Joseph Lo <josephl@nvidia.com>
>>>>
>>>> When building kernel with CONFIG_THUMB2_KERNEL, the data pointer in the
>>>> assembly may not on the 4 byte alignment. Then causing a data abort when
>>>> accessing the pointer. This patch add a ".align" flag in the head of the
>>>> pointer. And always using 32-bit ADR Thumb instruction to make sure it
>>>> won't build failure.
>>>>
>>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>>>> ---
>>>>  arch/arm/mach-tegra/reset-handler.S |    1 +
>>>>  arch/arm/mach-tegra/sleep.h         |    3 ++-
>>>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
>>>> index e6de88a..519a8c5 100644
>>>> --- a/arch/arm/mach-tegra/reset-handler.S
>>>> +++ b/arch/arm/mach-tegra/reset-handler.S
>>>> @@ -83,6 +83,7 @@ ENDPROC(tegra_resume)
>>>>  
>>>>  #ifdef CONFIG_CACHE_L2X0
>>>>  	.globl	l2x0_saved_regs_addr
>>>> +	.align
>>>>  l2x0_saved_regs_addr:
>>>>  	.long	0
>>>>  #endif
>>>> diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
>>>> index 4ffae54..8e9b6af 100644
>>>> --- a/arch/arm/mach-tegra/sleep.h
>>>> +++ b/arch/arm/mach-tegra/sleep.h
>>>> @@ -92,7 +92,8 @@
>>>>  
>>>>  #ifdef CONFIG_CACHE_L2X0
>>>>  .macro l2_cache_resume, tmp1, tmp2, tmp3, phys_l2x0_saved_regs
>>>> -	adr	\tmp1, \phys_l2x0_saved_regs
>>>> + ARM(	adr	\tmp1, \phys_l2x0_saved_regs )
>>>> + THUMB(	adr.w	\tmp1, \phys_l2x0_saved_regs )
>>>
>>> Can you give an example of the assembler error you get without this?
>>
>> arch/arm/mach-tegra/reset-handler.S: Assembler messages:
>> arch/arm/mach-tegra/reset-handler.S:78: Error: invalid immediate for
>> address calculation (value = 0x00000004)
> 
> The immediate in the 16-bit form of ADR is alignment-sensitive, and
> can't address anything that's not on a word boundary.  What if you just
> have the .align, without adr.w?
> 
>> This is with gcc-4.5.3, as:
>> GNU assembler (crosstool-NG hg_unknown at 20110628.165246) 2.20.1.20100303
>>
>>> The target symbol is local and the assembler can see where it is,
>>> so it should choose the correct variant for the adr instruction
>>> with no need for the ".w" suffix.
>>>
>>> If not, it could mean that there is a bug in the version of the
>>> assembler you're using.
>>
>> True. Switching to the Ubuntu-packaged ARM cross-compiler that ships
>> with Ubuntu 12.10, I do not see this problem.
>>
>> Still, many people probably still use older compilers.
>>
>>> If it's definitely needed, you can append a Thumb-only .w suffix with
>>>
>>> 	W(adr)	\tmp1, \phys_l2x0_saved_regs
>>>
>>> ...which is slightly neater.
>>
>> Yes, that certainly works too, even without the .align change in
>> reset-handler.S.
> 
> Sure, although the unaligned access is not such a good idea anyway.
> 
> Keeping the adr fix is harmless, I just wanted to understand why it's
> needed.

With just the following, and no adr.w:

> diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
> index e6de88a..519a8c5 100644
> --- a/arch/arm/mach-tegra/reset-handler.S
> +++ b/arch/arm/mach-tegra/reset-handler.S
> @@ -83,6 +83,7 @@ ENDPROC(tegra_resume)
>  
>  #ifdef CONFIG_CACHE_L2X0
>         .globl  l2x0_saved_regs_addr
> +       .align
>  l2x0_saved_regs_addr:
>         .long   0
>  #endif

I still get:

> arch/arm/mach-tegra/reset-handler.S: Assembler messages:
> arch/arm/mach-tegra/reset-handler.S:78: Error: invalid immediate for address calculation (value = 0x00000004)

That's with GNU assembler (crosstool-NG hg_unknown at 20110628.165246)
2.20.1.20100303.

BTW, I'm on vacation for the next 2 weeks starting this afternoon.
Hopefully Joseph can keep this thread alive while I'm gone if needed.
