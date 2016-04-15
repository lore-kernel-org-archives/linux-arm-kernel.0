From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 15 Apr 2016 14:26:33 +0100
Subject: [PATCH 1/5] arm64: cpufeature: Add scope for capability check
In-Reply-To: <20160415125511.GF22906@arm.com>
References: <1459941854-5190-1-git-send-email-suzuki.poulose@arm.com>
 <1459941854-5190-2-git-send-email-suzuki.poulose@arm.com>
 <20160414173809.GN4584@arm.com> <570FD7C2.9030305@arm.com>
 <20160415125511.GF22906@arm.com>
Message-ID: <5710EC09.7050005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/04/16 13:55, Will Deacon wrote:
> On Thu, Apr 14, 2016 at 06:47:46PM +0100, Suzuki K Poulose wrote:
>> On 14/04/16 18:38, Will Deacon wrote:
>>> Hi Suzuki,
>>>
>>> On Wed, Apr 06, 2016 at 12:24:10PM +0100, Suzuki K Poulose wrote:
>>>> Add scope parameter to the arm64_cpu_capabilities::matches(),
>>>> so that this can be reused for checking the capability on a
>>>> given CPU vs the system wide. By default, the system uses
>>>> 'system' wide values for setting the CPU_HWCAPs and ELF_HWCAPs.
>>
>>>>   static bool __maybe_unused
>>>> -is_affected_midr_range(const struct arm64_cpu_capabilities *entry)
>>>> +is_affected_midr_range(const struct arm64_cpu_capabilities *entry, int __unused)
>>>
>>> Maybe it would be better to WARN if somebody passes SCOPE_SYSTEM, rather
>>> than silently treat it as per-cpu?
>>
>> Should we worry about errata's which may not necessarily depend on per CPU or
>> a local capability (GIC) ?

So all of these are arm64_cpu_capabilities, i.e, cpu_errata, ELF_HWCAPS and cpu_hwcaps.
Each of them have a matches() routine, which without this series, checks if the system
as a whole has the capability. Now the matches() could use its own checks using system
wide values (read_system_reg(), used by everything except cpu_errata) or CPU register
values(right now, all of them use MIDR).

The tables are processed by a common routine, update_cpu_capabilities(). The cpu_errata
table is processed for each booting CPU, while the cpu_hwcaps is processed only once,
after all the CPUs have booted.

SCOPE is really a hint to the matches() to tell us the capability of the entire system (SCOPE_SYSTEM)
vs that of a single CPU(SCOPE_LOCAL). This is needed, because matches() may do more than checking
the feature register values (e.g, has_useable_gicv3_cpuif() ), which makes it difficult
to the check if a given CPU has a capability. So we initialise the system capabilities
by passing SCOPE_SYSTEM to the matches() from update_cpu_capabilities(). And we use
SCOPE_LOCAL when we do the early verification check for CPUs that turn online after the
system initialised the bits or this_cpu_has_cap() introduced in this series.
At the moment scope doesn't really matter to cpu_errata, as all of them are using
MIDR checks (btw, it is done for all CPUs unlike, cpu_hwcaps or ELF Hwcaps

>
> Why would they be calling is_affected_midr_range?

They won't be. My point is, since we use a shared structures and shared routines to
process the table, the scope parameter comes from the top, while we go through the
table. The entire table of capabilities::matches() will be called with a specific scope
in either case as explained above.


>> If not, we could add a WARN after passing down LOCAL
>> scope for errata.
>
> But if we don't care about errata that aren't local, then why would we warn
> on LOCAL?

We don't have to.
  

>> Right now we always do SCOPE_SYSTEM from update_cpu_capabilities(), even for
>> cpu_errata table. There is no specific reason for that.
>
> I'm totally confused. Can you define SCOPE_SYSTEM and SCOPE_LOCAL for me,
> please?

Hope it is clear now.

Suzuki
