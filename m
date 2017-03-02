From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 2 Mar 2017 09:05:22 +0000
Subject: [PATCH/RFC] arm64: pmu: add Qualcomm Technologies extensions
In-Reply-To: <a44d89fa-c5ff-9511-c774-59e5a3f26676@codeaurora.org>
References: <1488385085-19238-1-git-send-email-nleeder@codeaurora.org>
 <20170301181032.GL28874@leverpostej>
 <a44d89fa-c5ff-9511-c774-59e5a3f26676@codeaurora.org>
Message-ID: <4b90b76f-f08d-f248-8153-287b2552dceb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/17 21:36, Leeder, Neil wrote:
> Hi Mark,
> Thanks for the quick response.
> 
> On 3/1/2017 1:10 PM, Mark Rutland wrote:
>> Hi Neil,
>>
>> On Wed, Mar 01, 2017 at 11:18:05AM -0500, Neil Leeder wrote:
>>> Adds CPU PMU perf events support for Qualcomm Technologies' Falkor CPU.
>>>
>>> The Qualcomm Technologies CPU PMU is named qcom_pmuv3 and provides
>>> extensions to the architected PMU events.
>>
>> Is this is a strict superset of PMUv3 (that could validly be treated as
>> just PMUv3), or do those IMP DEF parts need to be poked to use this at
>> all?
>>
>> What is reported by ID_AA64DFR0_EL1.PMUVer on these CPUs?
> 
> It's a strict superset. If you don't use any of the extensions than it 
> behaves as a PMUv3 for architected events. ID_AA64DFR0_EL1.PMUVer = 1.
> 
>> Quite frankly, I'm less than thrilled about the prospect of
>> IMPLEMENTATION DEFINED CPU PMUs that fall outside of the architected PMU
>> model, especially for ACPI systems where the raison d'?tre is standards
>> and uniformity, and where we have no sensible mechanism to provide
>> information regarding IMPLEMENTATION DEFINED functionality.
>>
>> This has knock-on effects for other things, like userspace PMU access
>> and/or virtualization, and this multiplies the support effort.
>>
>> KVM already has (architected) PMU support, and without a corresponding
>> KVM patch this is at best insufficient. I don't imagine the KVM folk
>> will be too thrilled about the prospect of emulating an IMPLEMENTATION
>> DEFINED CPU feature like this.
> 
> Does KVM handle ARMv7 PMU implementations? If so, do you know what it 
> does for the scorpion_* and krait_* implementations in 
> arch/arm/kernel/perf_events_v7.c? These extensions in ARMv8 are very 
> similar to the krait extensions, with some 64-bit tweaks, so could be 
> handled by KVM the same way it handles the ARMv7 cases.

No, KVM doesn't handle the ARMv7 PMU at all. I'm not aware of the
virtualization extensions being available on Scorpion or Krait, which
makes it a moot point. What it handles is the PMUv3 architecture.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
