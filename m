From: will.deacon@arm.com (Will Deacon)
Date: Thu, 24 May 2018 13:24:14 +0100
Subject: [PATCH 10/14] arm64: ssbd: Add prctl interface for per-thread
 mitigation
In-Reply-To: <20180522150648.28297-11-marc.zyngier@arm.com>
References: <20180522150648.28297-1-marc.zyngier@arm.com>
 <20180522150648.28297-11-marc.zyngier@arm.com>
Message-ID: <20180524122413.GD8689@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 04:06:44PM +0100, Marc Zyngier wrote:
> If running on a system that performs dynamic SSBD mitigation, allow
> userspace to request the mitigation for itself. This is implemented
> as a prctl call, allowing the mitigation to be enabled or disabled at
> will for this particular thread.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kernel/Makefile |   1 +
>  arch/arm64/kernel/ssbd.c   | 107 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+)
>  create mode 100644 arch/arm64/kernel/ssbd.c
> 
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index bf825f38d206..0025f8691046 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -54,6 +54,7 @@ arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
>  arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
>  arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
>  arm64-obj-$(CONFIG_ARM_SDE_INTERFACE)	+= sdei.o
> +arm64-obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
>  
>  obj-y					+= $(arm64-obj-y) vdso/ probes/
>  obj-m					+= $(arm64-obj-m)
> diff --git a/arch/arm64/kernel/ssbd.c b/arch/arm64/kernel/ssbd.c
> new file mode 100644
> index 000000000000..34e3c430176b
> --- /dev/null
> +++ b/arch/arm64/kernel/ssbd.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 ARM Ltd, All Rights Reserved.
> + */
> +
> +#include <linux/sched.h>
> +#include <linux/thread_info.h>
> +
> +#include <asm/cpufeature.h>
> +
> +/*
> + * prctl interface for SSBD
> + * FIXME: Drop the below ifdefery once the common interface has been merged.
> + */
> +#ifdef PR_SPEC_STORE_BYPASS
> +static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
> +{
> +	int state = arm64_get_ssbd_state();
> +
> +	/* Unsupported or already mitigated */
> +	if (state == ARM64_SSBD_UNKNOWN)
> +		return -EINVAL;
> +	if (state == ARM64_SSBD_MITIGATED)
> +		return -EPERM;

I'm not sure this is the best thing to do. If the firmware says that the
CPU is mitigated, we should probably return 0 for PR_SPEC_DISABLE but
-EPERM for PR_SPEC_ENABLE (i.e. the part that doesn't work is disabling
the mitigation).

Will
