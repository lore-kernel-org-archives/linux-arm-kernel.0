From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 16 May 2013 12:21:19 -0600
Subject: [PATCH 1/6] ARM: tegra: add an assembly marco to check Tegra
 SoC ID
In-Reply-To: <1368698988.7403.25.camel@jlo-ubuntu-64.nvidia.com>
References: <1368613644-11863-1-git-send-email-josephl@nvidia.com>
 <1368613644-11863-2-git-send-email-josephl@nvidia.com>
 <51940FA4.6050609@wwwdotorg.org>
 <1368698988.7403.25.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <5195239F.5030602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2013 04:09 AM, Joseph Lo wrote:
> On Thu, 2013-05-16 at 06:43 +0800, Stephen Warren wrote:
>> On 05/15/2013 04:27 AM, Joseph Lo wrote:
>>> There are some Tegra SoC ID checking code around the low level assembly
>>> code. Adding a marco to replace them. For the single image to support all
>>> the Tegra series, we may also need the marco in other common code. So we
>>> make it become a marco for the usage.
>>
>> I'm not sure this patch doesn't obfuscate the code too much. The big
>> issue I see is:
>>
>>> @@ -115,13 +112,9 @@ ENTRY(__tegra_cpu_reset_handler)
>>>  
>>>  	cpsid	aif, 0x13			@ SVC mode, interrupts disabled
>>>  
>>> -	mov32	r6, TEGRA_APB_MISC_BASE
>>> -	ldr	r6, [r6, #APB_MISC_GP_HIDREV]
>>> -	and	r6, r6, #0xff00
>>> -#ifdef CONFIG_ARCH_TEGRA_2x_SOC
>>> -t20_check:
>>> -	cmp	r6, #(0x20 << 8)
>>> +	tegra_check_soc_id TEGRA20, TEGRA_APB_MISC_BASE, r6, r5
>>
>> Here, we replace all the code with the new macro, ...
>>
>>>  #ifdef CONFIG_ARCH_TEGRA_2x_SOC
>>>  	/* Are we on Tegra20? */
>>> -	cmp	r6, #(0x20 << 8)
>>> +	cmp	r6, #(TEGRA20 << 8)
>>
>> But here we still have to write out the cmp instructions.
>>
> The marco did "cmp" once and move the soc_id into r6. But the flags may
> be changed after running some other codes, we need to "cmp" again to get
> the correct flag.

Yes, I understand that. The issue is that writing the macro didn't
remove all the code, so it seems like it'd be best if the macro only
included the common code, and anything that needs to be repeated at each
test site not be part of the macro.
