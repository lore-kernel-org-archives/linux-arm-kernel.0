From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 25 Jul 2018 10:28:17 +0100
Subject: [PATCH] arm64: Check for errata before evaluating cpu features
In-Reply-To: <20180725085604.GB4240@e103592.cambridge.arm.com>
References: <20180725083504.25836-1-dmueller@suse.com>
 <aea2daa9-40ef-2066-0da9-0770c3c50dfb@arm.com>
 <20180725085604.GB4240@e103592.cambridge.arm.com>
Message-ID: <3d26391a-afbe-621e-90d0-80c4dbc4e2f6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave,

On 07/25/2018 09:56 AM, Dave Martin wrote:
> On Wed, Jul 25, 2018 at 09:51:53AM +0100, Suzuki K Poulose wrote:
>> On 07/25/2018 09:35 AM, Dirk Mueller wrote:
>>> Since commit d3aec8a28be3b8 ("arm64: capabilities: Restrict KPTI
>>> detection to boot-time CPUs") we rely on errata flags being already
>>> populated during feature enumeration. The order of errata and
>>> features was flipped as part of commit ed478b3f9e4a ("arm64:
>>> capabilities: Group handling of features and errata workarounds").
>>>
>>> Return to the orginal order of errata and feature evaluation to
>>> ensure errata flags are present during feature evaluation.
>>>
>>> Fixes: d3aec8a28be3b8 ("arm64: capabilities: Restrict KPTI
>>> detection to boot-time CPUs")
>>> CC: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> CC: Marc Zyngier <marc.zyngier@arm.com>
>>> Signed-off-by: Dirk Mueller <dmueller@suse.com>
>>
>> It would be good to add "Fixes: ed478b3f9e4a" (instead), just to make
>> sure this gets fixed everywhere the original problem appears.
>>

> 
> I forget why these were originally reordered in ed478b3f9e4a.
> Was there any real reason for it?

No, there was no real reason for it. We have always detected the cpu
local errata first and all features were system wide. So that ensured
that the errata are detected before features. With the introduction
of cpu local features, it was a random order until we realised this
issue.

That said, this exposes a problem with the current infrastructure
where, if there are local capabilities that depend on other local
capabilities. On a heterogeneous system, there is no guarantee on the
order in which the CPUs turn up and thus detect the capabilities. In
this case, this patch wouldn't work if we were dealing with a
heterogeneous system.

The solution would be to use cpu local and system wide versions
of the same capability and use the cpu-local capabilities to
decide the system capability.

i.e, here KPTI needs two caps :

a) CPU_NEEDS_KPTI - Local CPU capability to detect the local CPU
which needs KPTRI

b) SYSTEM_NEEDS_KPTI - System wide capability, which can be turned
on iff we have CPU_NEEDS_KPTI && !CAVIUM_ERRATA.

> 
> I also notice in that commit that after the detection pass, we set
> things up (in update_cpu_capabilities(), enable_cpu_capabilities()) in
> the order errata, features.  Does this matter for anything?

None that I am aware of. But logically that sounds like a better option.


Suzuki
