From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 29 Jan 2018 16:57:40 +0000
Subject: [PATCH 06/16] arm64: capabilities: Unify the verification
In-Reply-To: <c46997bb-8b56-4e93-d603-4fc0abd2f4b4@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-7-suzuki.poulose@arm.com>
 <20180126110759.GN5862@e103592.cambridge.arm.com>
 <c46997bb-8b56-4e93-d603-4fc0abd2f4b4@arm.com>
Message-ID: <20180129165739.GZ5862@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 12:10:11PM +0000, Suzuki K Poulose wrote:
> On 26/01/18 11:08, Dave Martin wrote:
> >On Tue, Jan 23, 2018 at 12:27:59PM +0000, Suzuki K Poulose wrote:
> >>Now that each capability describes how to treat the conflicts
> >>of CPU cap state vs System wide cap state, we can unify the
> >>verification logic to a single place.
> >>
> >>Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>---
> >>  arch/arm64/kernel/cpufeature.c | 87 ++++++++++++++++++++++++++----------------
> >>  1 file changed, 54 insertions(+), 33 deletions(-)
> >>
> >>diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> >>index 43c7e992d784..79737034a628 100644
> >>--- a/arch/arm64/kernel/cpufeature.c
> >>+++ b/arch/arm64/kernel/cpufeature.c
> >>@@ -1228,6 +1228,54 @@ static void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *
> >>  }
> >
> >>  /*
> >>+ * Run through the list of capabilities to check for conflicts.
> >>+ * Returns "false" on conflicts.
> >>+ */
> >>+static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_list)
> >>+{
> >>+	bool cpu_has_cap, system_has_cap;
> >>+	const struct arm64_cpu_capabilities *caps = caps_list;
> >>+
> >>+	for (; caps->matches; caps++) {
> >>+		cpu_has_cap = __this_cpu_has_cap(caps_list, caps->capability);
> >
> >What's the point of scanning the whole of caps_list?  Don't we already
> >have the pointer to the right cap struct?
> >
> >We already know caps->matches is true.  Can't we just call
> >caps->matches(caps)?  That seemed pretty intuitive to me in the old
> >code.
> >
> 
> This was supposed to be fixed by [1] in the "old code". Given we have multiple
> entries for a "capability", we could be dealing with the one which doesn't
> apply to this CPU and could eventually trigger a wrong conflict below. To
> avoid this, we need to make sure use the right values.

Ah, I see: do we want to do something like this:

	for (each cap corresponding to a bit in cpu_hwcaps) {
		for (each arm64_cpu_capabilities c corresponding to this cap) {
			if (c->matches(c, ...))
				goto ok;
		}

		goto mismatch;

	ok:
		continue;
	}

	return 0;

mismatch:
	/* barf */
	return -1;

An additional comment explaining the purpose of the code might help
(though I could have read the commit message, I guess).

We can't do the above directly, becasue we don't index the capabilities
by the capability field.  The above looks O((number of
arm64_cpu_capability structs) ^ 2), which could become slightly annoying
as the number of structs grows (?)

Could this be solved by making the match criteria a separate struct
and allowing a list of them to be specified per-capability?

Maybe too much effort for this series though.

> 

[...]

> >The role of the ->enable() call is the only real subtlety here.
> >
> >>+			if (cpu_has_cap && !cpucap_late_cpu_have_cap_safe(caps))
> >>+				break;
> >>+		}
> >>+	}
> >>+
> >>+	if (caps->matches) {
> >>+		pr_crit("CPU%d: Detected conflict for capability %d (%s), System: %d, CPU: %d\n",
> >>+			smp_processor_id(), caps->capability,
> >>+			caps->desc ? : "no description",
> >
> >Wouldn't it be a bug for a conflict to occur on a cap with no .desc?
> >
> >Why can't we just let printk print its default "(null)" for %s
> >in this case?
> 
> We could.
> 
> >
> >Alternatively, is there a reason for any cap not to have a description?
> 
> Some of them do. e.g, some of them could be "negative" capabilities. e.g,
> ARM64_NO_FPSIMD.

Is that a reason not to have a description?

> >>+			system_has_cap, cpu_has_cap);
> >>+		return false;
> >>+	}
> >>+
> >>+	return true;
> >>+}
> >
> >Perhaps the capability verification procedure could be made a little
> >clearer by splitting this into two functions:
> >
> 
> As explained above, the code below is not sufficient.

Fair enough: I hadn't understood what the code was trying to achieve.

Given that, it's a bit harder to refactor than I though, and it's
probably not worth it.

[...]

Cheers
---Dave
