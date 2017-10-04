From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 4 Oct 2017 14:00:35 +0100
Subject: [PATCH] arm64: Enable MRS emulation early
In-Reply-To: <20171004113212.GC23092@leverpostej>
References: <20171004094805.24009-1-suzuki.poulose@arm.com>
 <20171004101425.GB23092@leverpostej>
 <20171004111040.vumbc3bk7sj2enc6@armageddon.cambridge.arm.com>
 <20171004113212.GC23092@leverpostej>
Message-ID: <15df3286-0784-a01e-d860-8ae13f2e6696@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/17 12:32, Mark Rutland wrote:
> On Wed, Oct 04, 2017 at 12:10:40PM +0100, Catalin Marinas wrote:
>> On Wed, Oct 04, 2017 at 11:14:26AM +0100, Mark Rutland wrote:
>>> On Wed, Oct 04, 2017 at 10:48:05AM +0100, Suzuki K Poulose wrote:
>>>> Make sure the MRS emulation is enabled early enough, such that the
>>>> early userspace applications (e.g, those run from initrd) could
>>>> use the facility without crashing them.
>>>>
>>>> Fixes: commit 77c97b4ee2129 ("arm64: cpufeature: Expose CPUID registers by emulation")
>>>> Reported-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>
>>>> Cc: James Morse <james.morse@arm.com>
>>>> Cc: Dave Martin <Dave.martin@arm.com>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>> Cc: stable at vger.kernel.org
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>
>>> This looks sensible, but shouldn't we do the same for other
>>> late_inicalls can affect initrd userspace?
>>>
>>> e.g. armv8_deprecated_init, fpsimd_init, sys_reg_genericv8_init?
>>
>> I think we should, though not all of them are concerned with the user
>> code. For example, fpsimd_init() takes care of the pm/hotplug aspect and
>> nothing to do with user space.
> 
> My worry was that without the pm/hotplug notifiers, things could go
> wrong during the initrd. e.g. we could lose userspace fp state without
> the pm notifier, or userspace could trigger hotplpug that we wouldn't
> manage correctly
> 
> So even if it's not directly userspace related, it can affect (or can be
> affected by) initrd userspace.

You're right. In fact, I had a version of the patch which enables the emulation
as soon as we have initialised the ELF_HWCAPs from setup_cpu_features(), rather
than depending on an initcall. But that requires moving the setup_cpu_features()
to the bottom, which makes the hunk look a bit more complex than it is.

And similarly, we should be able to do the fpsimd_init from setup_cpu_features(),
as we have finalised the HWCAPs and pm_register_notifier any adds the entry to
a static list of notifiers ( even though the cpu_pm callbacks are registered as
a core_initcall() ).

Similarly for sys_reg_genericv8_init & armv8_deprecated_init could be made a core
initcall.

I think it would be good to separate them out.

i.e, enable_mrs_emulation & fpsimd_init from setup_cpu_features()
and the other two promoted as core_initcalls.

Thoughts ?

Suzuki
