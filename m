From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 30 Jan 2018 15:27:14 +0000
Subject: [PATCH 16/16] arm64: Add work around for Arm Cortex-A55 Erratum
 1024718
In-Reply-To: <58d36133-4f83-99f3-0423-7a80f3dd82f8@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-17-suzuki.poulose@arm.com>
 <20180126153314.GW5862@e103592.cambridge.arm.com>
 <58d36133-4f83-99f3-0423-7a80f3dd82f8@arm.com>
Message-ID: <20180130152714.GI5862@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 04:29:53PM +0000, Suzuki K Poulose wrote:
> On 26/01/18 15:33, Dave Martin wrote:
> >On Tue, Jan 23, 2018 at 12:28:09PM +0000, Suzuki K Poulose wrote:
> >>Some variants of the Arm Cortex-55 cores (r0p0, r0p1, r1p0) suffer
> >>from an erratum 1024718, which causes incorrect updates when DBM/AP
> >>bits in a page table entry is modified without a break-before-make
> >>sequence. The work around is to skip enabling the hardware DBM feature
> >>on the affected cores. The hardware Access Flag management features
> >>is not affected.
> >>
> >>Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>---
> >>  Documentation/arm64/silicon-errata.txt |  1 +
> >>  arch/arm64/Kconfig                     | 14 ++++++++++++++
> >>  arch/arm64/kernel/cpufeature.c         | 14 +++++++++++++-
> >>  3 files changed, 28 insertions(+), 1 deletion(-)
> >
> >[...]
> >
> >>diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> >>index 8af755b8219d..64f1e911c6af 100644
> >>--- a/arch/arm64/kernel/cpufeature.c
> >>+++ b/arch/arm64/kernel/cpufeature.c
> >>@@ -914,9 +914,21 @@ static inline void __cpu_enable_hw_dbm(void)
> >>  	isb();
> >>  }
> >>+static bool cpu_has_erratum_1024718(void)
> >>+{
> >>+	static const struct midr_range __maybe_unused cpus[] = {
> >
> >Do you need __maybe_unused?  If #ifdef were used here then
> >__maybe_unused would be needed, but I thought that if code is optimised
> >out instead of conditionally copiled, this didn't apply.
> 
> Yep. I don't know if the compiler could optimise the array itself with
> the tag as a hint. I will double check.

I think the compiler should optimise cpus[] out as appropriate here,
even without the annotation.  It's scoped to this function and nothing
is done with it in the !IS_ENABLED() case.

I've relied heavily on this in the SVE code -- it massively reduces the
amount of #ifdefs and annotations required, which would otherwise clutter
the code a lot.

Since the kernel in general does rely on dead code elimination (and
presumably dead object elimination too) in order to avoid link failures,
I considered this reasonable.  The compiler did seem to do the right
thing for my code.

> 
> >
> >>+		MIDR_RANGE(MIDR_CORTEX_A55, 0, 0, 1, 0),	// A55 r0p0 -r1p0
> >>+		{},
> >>+	};
> >>+
> >>+	return IS_ENABLED(CONFIG_ARM64_ERRATUM_1024718) &&
> >>+	       is_midr_in_range_list(read_cpuid_id(), cpus);
> >
> >Why have a list with just one entry?  Do you expect more entries over
> >time?
> 
> Yes. I should have mentioned it here. See [1]
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-January/554516.html

Right, that seemed the likely explanation!

Cheers
---Dave
