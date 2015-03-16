From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Mar 2015 12:05:42 +0100
Subject: [PATCH 3/4] arm64: fix hyp mode mismatch detection
In-Reply-To: <5506B888.4050700@arm.com>
References: <1426263277-9827-1-git-send-email-mark.rutland@arm.com>
 <1426263277-9827-4-git-send-email-mark.rutland@arm.com>
 <CAKv+Gu-LiQnvWv6_yh=G5=YO4ohNLCFpmedFYRyHKS39PubcHw@mail.gmail.com>
 <20150316105614.GD15066@leverpostej> <5506B888.4050700@arm.com>
Message-ID: <CAKv+Gu9qC552+Ys-fYcc8UL++kuhRC_YehK1S-vJFN+d+7ZifA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 March 2015 at 12:03, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 16/03/15 10:56, Mark Rutland wrote:
>> On Fri, Mar 13, 2015 at 08:21:19PM +0000, Ard Biesheuvel wrote:
>>> On 13 March 2015 at 17:14, Mark Rutland <mark.rutland@arm.com> wrote:
>>>> Commit 828e9834e9a5b7e6 ("arm64: head: create a new function for setting
>>>> the boot_cpu_mode flag") added BOOT_CPU_MODE_EL1, a nonzero value
>>>> replacing uses of zero. However it failed to update __boot_cpu_mode
>>>> appropriately.
>>>>
>>>> A CPU booted at EL2 writes BOOT_CPU_MODE_EL2 to __boot_cpu_mode[0], and
>>>> a CPU booted at EL1 writes BOOT_CPU_MODE_EL1 to __boot_cpu_mode[1].
>>>> Later is_hyp_mode_mismatched() determines there to be a mismatch if
>>>> __boot_cpu_mode[0] != __boot_cpu_mode[1].
>>>>
>>>> If all CPUs are booted at EL1, __boot_cpu_mode[0] will be set to
>>>> BOOT_CPU_MODE_EL1, but __boot_cpu_mode[1] will retain its initial value
>>>> of zero, and is_hyp_mode_mismatched will erroneously determine that the
>>>> boot modes are mismatched. This hasn't been a problem so far, but later
>>>> patches which will make use of is_hyp_mode_mismatched() expect it to
>>>> work correctly.
>>>>
>>>> This patch initialises __boot_cpu_mode[1] to BOOT_CPU_MODE_EL1, fixing
>>>> the erroneous mismatch detection when all CPUs are booted at EL1.
>>>>
>>>
>>> Maybe it's just me, but isn't it *much* easier to understand to
>>> initialise both values to 0, and use 'both are non-zero' as the error
>>> condition?
>>> 'HYP mode available' would then be '__boot_cpu_mode[0] ==
>>> BOOT_CPU_MODE_EL2 && __boot_cpu_mode[1] == 0'
>>
>> I agree that change would make this easier to follow.
>>
>> Marc, are you happy with Ard's proposed change?
>
> Absolutely. If that makes it more obvious, please go for it.
>
>

OK, thanks

Actually, simply checking for  __boot_cpu_mode[1] == 0 (i.e., no CPUs
booted at EL1) would be sufficient to implement 'is HYP mode
available'.
