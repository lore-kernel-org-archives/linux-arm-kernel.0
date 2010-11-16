From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Tue, 16 Nov 2010 10:11:17 +0100
Subject: [PATCH 5/5] ARM: perf: separate PMU backends into multiple files
In-Reply-To: <1289842263-21241-6-git-send-email-will.deacon@arm.com>
References: <1289842263-21241-1-git-send-email-will.deacon@arm.com>
	<1289842263-21241-6-git-send-email-will.deacon@arm.com>
Message-ID: <AANLkTik6gEvTXh75_FouQegm_WxdSm8FmW2HB85jdW+T@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

The checkpatch script returns some warnings and errors, cf. dump here below.

Other than that I have a few remarks inlined.

$ ./scripts/checkpatch.pl ../../patches/pmu_5_5.patch
ERROR: return is not a function, parentheses are not required
#2783: FILE: arch/arm/kernel/perf_event_v6.c:351:
+       return (pmcr & ARMV6_PMCR_OVERFLOWED_MASK);

WARNING: braces {} are not necessary for single statement blocks
#2969: FILE: arch/arm/kernel/perf_event_v6.c:537:
+               if (!test_and_set_bit(ARMV6_COUNTER1, cpuc->used_mask)) {
+                       return ARMV6_COUNTER1;
+               }

WARNING: braces {} are not necessary for single statement blocks
#2973: FILE: arch/arm/kernel/perf_event_v6.c:541:
+               if (!test_and_set_bit(ARMV6_COUNTER0, cpuc->used_mask)) {
+                       return ARMV6_COUNTER0;
+               }

WARNING: please, no space before tabs
#4033: FILE: arch/arm/kernel/perf_event_xscale.c:9:
+ * ^I- xscale1pmu: 2 event counters and a cycle counter$

WARNING: please, no space before tabs
#4034: FILE: arch/arm/kernel/perf_event_xscale.c:10:
+ * ^I- xscale2pmu: 4 event counters and a cycle counter$

WARNING: braces {} are not necessary for single statement blocks
#4367: FILE: arch/arm/kernel/perf_event_xscale.c:343:
+               if (!test_and_set_bit(XSCALE_COUNTER1, cpuc->used_mask)) {
+                       return XSCALE_COUNTER1;
+               }

WARNING: braces {} are not necessary for single statement blocks
#4371: FILE: arch/arm/kernel/perf_event_xscale.c:347:
+               if (!test_and_set_bit(XSCALE_COUNTER0, cpuc->used_mask)) {
+                       return XSCALE_COUNTER0;
+               }

total: 1 errors, 6 warnings, 4758 lines checked

../../patches/pmu_5_5.patch has style problems, please review.  If any
of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.


On Mon, Nov 15, 2010 at 6:31 PM, Will Deacon <will.deacon@arm.com> wrote:
> The ARM perf_event.c file contains all PMU backends and, as new PMUs
> are introduced, will continue to grow.
>
> This patch follows the example of x86 and splits the PMU implementations
> into separate files which are then #included back into the main
> file. Compile-time guards are added to each PMU file to avoid compiling
> in code that is not relevant for the version of the architecture which
> we are targetting.
>
> Cc: Jamie Iles <jamie.iles@picochip.com>
> Cc: Jean Pihet <jean.pihet@newoldbits.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> ?arch/arm/kernel/perf_event.c ? ? ? ?| 2357 +----------------------------------
> ?arch/arm/kernel/perf_event_v6.c ? ? | ?674 ++++++++++
> ?arch/arm/kernel/perf_event_v7.c ? ? | ?906 ++++++++++++++
> ?arch/arm/kernel/perf_event_xscale.c | ?809 ++++++++++++
> ?4 files changed, 2394 insertions(+), 2352 deletions(-)
> ?create mode 100644 arch/arm/kernel/perf_event_v6.c
> ?create mode 100644 arch/arm/kernel/perf_event_v7.c
> ?create mode 100644 arch/arm/kernel/perf_event_xscale.c
>
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index ac4e9a1..421a4bb 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -4,9 +4,7 @@
> ?* ARM performance counter support.
> ?*
> ?* Copyright (C) 2009 picoChip Designs, Ltd., Jamie Iles
> - *
> - * ARMv7 support: Jean Pihet <jpihet@mvista.com>
> - * 2010 (c) MontaVista Software, LLC.
> + * Copyright (C) 2010 ARM Ltd., Will Deacon <will.deacon@arm.com>
> ?*
> ?* This code is based on the sparc64 perf event code, which is in turn based
> ?* on the x86 code. Callchain code is based on the ARM OProfile backtrace
> @@ -606,2355 +604,10 @@ static struct pmu pmu = {
...

> -const struct arm_pmu *__init xscale2pmu_init(void)
> -{
> - ? ? ? return &xscale2pmu;
> -}
> +/* Include the PMU-specific implementations. */
> +#include "perf_event_xscale.c"
> +#include "perf_event_v6.c"
> +#include "perf_event_v7.c"
>
> ?static int __init
> ?init_hw_perf_events(void)

It is better to use Kconfig/Makefile to conditionally compile files
instead of using #include for C files.

Thanks,
Jean
