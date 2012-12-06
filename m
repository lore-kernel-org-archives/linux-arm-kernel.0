From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 06 Dec 2012 11:59:05 -0700
Subject: [PATCH V2 2/6] ARM: tegra20: cpuidle: add powered-down state
 for secondary CPU
In-Reply-To: <1354778576.13857.19.camel@jlo-ubuntu-64.nvidia.com>
References: <1354701715-24150-1-git-send-email-josephl@nvidia.com>
 <1354701715-24150-3-git-send-email-josephl@nvidia.com>
 <50BFC826.1020705@wwwdotorg.org>
 <1354778576.13857.19.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <50C0EAF9.1080807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2012 12:22 AM, Joseph Lo wrote:
> On Thu, 2012-12-06 at 06:18 +0800, Stephen Warren wrote:
>> On 12/05/2012 03:01 AM, Joseph Lo wrote:
>>> The powered-down state of Tegra20 requires power gating both CPU cores.
>>> When the secondary CPU requests to enter powered-down state, it saves
>>> its own contexts and then enters WFI. The Tegra20 had a limition to
>>> power down both CPU cores. The secondary CPU must waits for CPU0 in
>>> powered-down state too. If the secondary CPU be woken up before CPU0
>>> entering powered-down state, then it needs to restore its CPU states
>>> and waits for next chance.
>>>
>>> Be aware of that, you may see the legacy power state "LP2" in the code
>>> which is exactly the same meaning of "CPU power down".

>>> diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
>>
>>> +/*
>>> + * tegra_pen_lock
>>
>>> + * on cpu 0:
>>> + * SCRATCH38 = r2 = flag[0]
>>> + * SCRATCH39 = r3 = flag[1]
>>
>> It would be slightly clearer if that was written:
>>
>> * r2 = flag[0] (in SCRATCH38)
>> * r3 = flag[1] (in SCRATCH39)
>>
>> since the meaning of r2/r3 is what's being selected.
>>
> OK. Will fix.
> 
>>> +	mov	r12, #1
>>> +	str	r12, [r2]		@ flag[cpu] = 1

So here I can see we should hard-code the value that's written

>>> +	dsb
>>> +	str	r12, [r1]		@ !turn = cpu

But here we're also writing "1" always, whereas the comment says it's
writing "cpu", and given the algorithm description, I would expect to
write "cpu" here not "1".

>> Should that be "str r0, [r1]"? Otherwise, you're always writing 1 there,
>> not writing the CPU ID as expected.
> 
> The CPU_ID was not used to lock or un-lock the flag. Wriging 1 to lock
> and 0 to release.
