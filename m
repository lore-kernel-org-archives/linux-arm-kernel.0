From: ckadabi@codeaurora.org (Channa)
Date: Wed, 17 Jan 2018 21:00:38 -0800
Subject: [PATCH 3/3] arm64: Add work around for Arm Cortex-A55 Erratum
 1024718
In-Reply-To: <4b06ad53-e8a6-abd2-2ecf-177abb71bdfe@arm.com>
References: <20180116102323.3470-1-suzuki.poulose@arm.com>
 <20180116102323.3470-4-suzuki.poulose@arm.com>
 <5bff2bc7fc3d5d04d8fccc099599dd58@codeaurora.org>
 <4b06ad53-e8a6-abd2-2ecf-177abb71bdfe@arm.com>
Message-ID: <e9e3a16e28dc4aee72fb1b85b87ef612@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-01-17 02:28, Suzuki K Poulose wrote:
> On 17/01/18 03:34, ckadabi at codeaurora.org wrote:
>> On 2018-01-16 02:23, Suzuki K Poulose wrote:
>>> Some variants of the Arm Cortex-55 cores (r0p0, r0p1, r1p0) suffer
>>> from an erratum 1024718, which causes incorrect updates when DBM/AP
>>> bits in a page table entry is modified without a break-before-make
>>> sequence. The work around is to disable the hardware DBM feature
>>> on the affected cores. The hardware Access Flag management features
>>> is not affected.
>>> 
>>> The hardware DBM feature is a non-conflicting capability, i.e, the
>>> kernel could handle cores using the feature and those without having
>>> the features running at the same time. So this work around is 
>>> detected
>>> at early boot time, rather than delaying it until the CPUs are 
>>> brought
>>> up into the kernel with MMU turned on. This also avoids other 
>>> complexities
>>> with late CPUs turning online, with or without the hardware DBM 
>>> features.
>>> 
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>> ?Documentation/arm64/silicon-errata.txt |? 1 +
>>> ?arch/arm64/Kconfig???????????????????? | 14 ++++++++++++++
>>> ?arch/arm64/mm/proc.S?????????????????? |? 5 +++++
>>> ?3 files changed, 20 insertions(+)
>>> 
>>> diff --git a/Documentation/arm64/silicon-errata.txt
>>> b/Documentation/arm64/silicon-errata.txt
>>> index b9d93e981a05..5203e71c113d 100644
>>> --- a/Documentation/arm64/silicon-errata.txt
>>> +++ b/Documentation/arm64/silicon-errata.txt
>>> @@ -55,6 +55,7 @@ stable kernels.
>>> ?| ARM??????????? | Cortex-A57????? | #834220???????? |
>>> ARM64_ERRATUM_834220??????? |
>>> ?| ARM??????????? | Cortex-A72????? | #853709???????? | N/A
>>> ???????????? |
>>> ?| ARM??????????? | Cortex-A73????? | #858921???????? |
>>> ARM64_ERRATUM_858921??????? |
>>> +| ARM??????????? | Cortex-A55????? | #1024718??????? |
>>> ARM64_ERRATUM_1024718?????? |
>>> ?| ARM??????????? | MMU-500???????? | #841119,#826419 | N/A
>>> ???????????? |
>>> ?|??????????????? |???????????????? |???????????????? |
>>> ???????????? |
>>> ?| Cavium???????? | ThunderX ITS??? | #22375, #24313? |
>>> CAVIUM_ERRATUM_22375??????? |
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 664fadc2aa2e..19b8407a0325 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -461,6 +461,20 @@ config ARM64_ERRATUM_843419
>>> 
>>> ?????? If unsure, say Y.
>>> 
>>> +config ARM64_ERRATUM_1024718
>>> +??? bool "Cortex-A55: 1024718: Update of DBM/AP bits without break
>>> before make might result in incorrect update"
>>> +??? default y
>>> +??? help
>>> +????? This option adds work around for Arm Cortex-A55 Erratum 
>>> 1024718.
>>> +
>>> +????? Affected Cortex-A55 cores (r0p0, r0p1, r1p0) could cause 
>>> incorrect
>>> +????? update of the hardware dirty bit when the DBM/AP bits are 
>>> updated
>>> +????? without a break-before-make. The work around is to disable the 
>>> usage
>>> +????? of hardware DBM locally on the affected cores. CPUs not 
>>> affected by
>>> +????? erratum will continue to use the feature.
>>> +
>>> +????? If unsure, say Y.
>>> +
>>> ?config CAVIUM_ERRATUM_22375
>>> ???? bool "Cavium erratum 22375, 24313"
>>> ???? default y
>>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>>> index 5a59eea49395..ba2c22180f4e 100644
>>> --- a/arch/arm64/mm/proc.S
>>> +++ b/arch/arm64/mm/proc.S
>>> @@ -252,6 +252,11 @@ ENTRY(__cpu_setup)
>>> ???? cbz??? x9, 2f
>>> ???? cmp??? x9, #2
>>> ???? b.lt??? 1f
>>> +#ifdef CONFIG_ARM64_ERRATUM_1024718
>>> +??? /* Disable hardware DBM on Cortex-A55 r0p0, r0p1 & r1p0 */
>>> +??? cpu_midr_match MIDR_CORTEX_A55, MIDR_CPU_VAR_REV(0, 0),
>> 
>> What is there is a custom core with different MIDRs, can we specify 
>> multiple MIDR values?
> 
> At the moment no. May be we could pass a table of such values to the 
> macro ?
> 
>> Would it be good to clear the bit as part of 
>> arch/arm64/kernel/cpu_errata.c so we can specify multiple MIDR values 
>> if required.
> 
> The problem is, we already have some part of the kernel mappings with
> PTE_DBM set
> (PTE_WRITE = PTE_DBM with CONFIG_HW_AFDBM) and could potentially hit 
> the errata,
> before we disable it on the CPU. Also, if the CPU is brought up late
> by userspace,
> that adds more entities. I had another approach, where we delay 
> enabling the
> TCR_HD until all cores are up. But then it has other complexities with 
> the CPU
> feature framework.
> e.g, we can't use the feature unless we turn the HADBS feature bit to
> HIGHER_SAFE
> so that we can turn it on if at least one CPU has it. But then, we 
> don't know
> what the future values of the feature could imply, leaving that choice 
> unsafe.
> Also, a late CPU will be prevented from booting if it doesn't have DBM 
> unless
> we hack the framework.

I was thinking if we can enable the DBM feature based on a cpu feature 
register.
Not sure if all future CPUs would have a bit for identifying whether DBM 
is supported
or not.

> 
> So an early check seemed the easier solution at the moment. I will take 
> a look
> at changing the framework a little bit and see where it takes us. 
> Otherwise,
> we could switch back to a table of affected MIDRs.

Agree, its better to change the implementation to take a table of MIDRs.

> 
> Suzuki

-- 
--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
