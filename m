From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 18 Nov 2015 11:29:29 +0000
Subject: A problem about interrupt when booting a captured kernel
In-Reply-To: <564C30D9.7030108@linaro.org>
References: <5645B6D3.60305@huawei.com> <564A2DE4.4030702@arm.com>
 <564A7D53.6010906@linaro.org> <20151117090736.7db5e646@arm.com>
 <564C30D9.7030108@linaro.org>
Message-ID: <564C6119.2050704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/11/15 08:03, AKASHI Takahiro wrote:
> On 11/17/2015 06:07 PM, Marc Zyngier wrote:
>> On Tue, 17 Nov 2015 10:05:23 +0900
>> AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
>>
>>> Marc,
>>> (Cc: Mark)
>>>
>>> On 11/17/2015 04:26 AM, Marc Zyngier wrote:
>>>> On 13/11/15 10:09, Yang Yingliang wrote:
>>>>> Hi, Marc
>>>>>
>>>>>
>>>>>        The kexec will boot a captured kernel while the kernel panic. But
>>>>> it boots failed if the kernel panic in handler function of PPI. The
>>>>> reason is that the PPI has not been 'eoi', other interrupts can not be
>>>>> handled when booting  the captured kernel.
>>>>>
>>>>>        The kexec will call irq_eoi to end the irqs that have
>>>>> IRQD_IRQ_INPROGRESS flag. But PPIs don't have this flag, so it won't be
>>>>> ended.
>>>>>
>>>>>       Three ways to solve this problem we can think :
>>>>>       1. Is there a way to reset gic like its_reset ?
>>>>>       2. Can we add some flag for calling irq_eoi ?
>>>>>       3. Just 'eoi' all PPIs without checking flags in kexec.
>>>>>
>>>>>        Please give some advice.
>>>>
>>>> Good timing. Please see:
>>>>
>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/385383.html
>>>
>>> I removed machine_kexec_mask_interrupts() from my arm64 kdump patch series[1]
>>> due to the past discussions[2].
>>>
>>> Is it the time that I should resurrect the code?
>>
>> Probably.
> 
> Let me make sure.
> Have your patches here, especially #1, also addressed the issue that you pointed out
> in [1]?
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/338969.html

Patch #1 still has the current behaviour (deactivate any in flight
interrupt), but does it in a more complete way. The additional 3 patches
make sure that the GIC (any version) is not affected by having active
interrupts when getting initialized.

These are the two sides of the same coin, basically. I'm still not fond
of what we do in machine_kexec_mask_interrupts(), but we can't rely on
the secondary kernel doing the right thing either.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
