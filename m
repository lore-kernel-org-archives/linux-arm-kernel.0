From: bp@alien8.de (Borislav Petkov)
Date: Thu, 16 Aug 2018 09:35:59 +0200
Subject: [RFC PATCH] edac: armv8_edac: Add ARMv8 EDAC driver
In-Reply-To: <1533242990-12828-1-git-send-email-tbaicar@codeaurora.org>
References: <1533242990-12828-1-git-send-email-tbaicar@codeaurora.org>
Message-ID: <20180816073559.GA2111@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ James.

On Thu, Aug 02, 2018 at 04:49:50PM -0400, Tyler Baicar wrote:
> Add ARMv8 EDAC driver to detect and report errors that are reported
> through the ARMv8.2 RAS extensions.
> 
> This is by no means complete hence the RFC. At minimum, this should
> also have support to check the SRs of each CPU during boot time to
> check for anything pending. Also, the SEI code flow could be improved
> to separate the check for uncontained errors and panic ASAP before
> doing any of this reporting.
> 
> This is also limited to SR based RAS extension nodes. There is not
> currently a way to detect memory mapped RAS extension nodes. The
> initialization which prints the FR registers only does so for a
> single CPU, so the assumption is that all CPUs are identical from
> a RAS extension node perspective.
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  arch/arm64/include/asm/ras.h | 26 +++++++++++++++++++
>  arch/arm64/kernel/Makefile   |  1 +
>  arch/arm64/kernel/ras.c      | 54 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/traps.c    |  4 +++
>  arch/arm64/mm/fault.c        |  4 +++
>  drivers/edac/Kconfig         |  9 +++++++
>  drivers/edac/Makefile        |  2 ++
>  drivers/edac/armv8_edac.c    | 59 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/armv8_edac.h   | 20 +++++++++++++++
>  9 files changed, 179 insertions(+)
>  create mode 100644 arch/arm64/include/asm/ras.h
>  create mode 100644 arch/arm64/kernel/ras.c
>  create mode 100644 drivers/edac/armv8_edac.c
>  create mode 100644 include/linux/armv8_edac.h

Remember to always run your stuff through checkpatch to catch legit issues:

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#48: 
new file mode 100644

Yes it does - I need a MAINTAINERS entry for the edac driver so that you
get all the bug reports. :)

And then more:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#53: FILE: arch/arm64/include/asm/ras.h:1:
+// SPDX-License-Identifier: GPL-2.0

WARNING: please write a paragraph that describes the config symbol fully
#203: FILE: drivers/edac/Kconfig:77:
+config EDAC_ARMV8

WARNING: braces {} are not necessary for single statement blocks
#284: FILE: drivers/edac/armv8_edac.c:51:
+	for (i = 0; i < num_nodes; i++) {
+		arch_ras_node_setup(i);
+	}

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#299: FILE: include/linux/armv8_edac.h:1:
+// SPDX-License-Identifier: GPL-2.0

> diff --git a/arch/arm64/kernel/ras.c b/arch/arm64/kernel/ras.c
> new file mode 100644
> index 0000000..2cb0265
> --- /dev/null
> +++ b/arch/arm64/kernel/ras.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/cpu.h>
> +#include <linux/smp.h>
> +
> +#include <asm/ras.h>
> +
> +bool arch_cpu_has_ras_extensions(void)
> +{
> +	return this_cpu_has_cap(ARM64_HAS_RAS_EXTN);
> +}
> +
> +u64 arch_cpu_num_ras_nodes(void)
> +{
> +	return read_sysreg_s(SYS_ERRIDR_EL1);
> +}
> +
> +void arch_report_ras_error_on_node(unsigned int cpu_num, unsigned int i)
> +{
> +	u64 status;
> +
> +	write_sysreg_s(i, SYS_ERRSELR_EL1);
> +	status = read_sysreg_s(SYS_ERXSTATUS_EL1);
> +	if (status) {
> +		pr_err("cpu #%u: ERR%uSTATUS = 0x%llx\n", cpu_num, i, status);
> +		pr_err("cpu #%u: ERR%uCTLR   = 0x%llx\n",
> +			cpu_num, i, read_sysreg_s(SYS_ERXCTLR_EL1));
> +		pr_err("cpu #%u: ERR%uADDR   = 0x%llx\n",
> +			cpu_num, i, read_sysreg_s(SYS_ERXADDR_EL1));
> +		pr_err("cpu #%u: ERR%uMISC0  = 0x%llx\n",
> +			cpu_num, i, read_sysreg_s(SYS_ERXMISC0_EL1));
> +		pr_err("cpu #%u: ERR%uMISC1  = 0x%llx\n",
> +			cpu_num, i, read_sysreg_s(SYS_ERXMISC1_EL1));
> +	}
> +}
> +
> +void arch_ras_node_setup(unsigned int i)
> +{
> +	write_sysreg_s(i, SYS_ERRSELR_EL1);
> +	pr_info("ERR%uFR = 0x%llx\n", i, read_sysreg_s(SYS_ERXFR_EL1));
> +}
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index d399d45..53ed974 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -35,6 +35,7 @@
>  #include <linux/sizes.h>
>  #include <linux/syscalls.h>
>  #include <linux/mm_types.h>
> +#include <linux/armv8_edac.h>
>  
>  #include <asm/atomic.h>
>  #include <asm/bug.h>
> @@ -731,6 +732,9 @@ asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
>  {
>  	nmi_enter();
>  
> +	if (IS_ENABLED(CONFIG_EDAC_ARMV8))
> +		armv8_edac_report_error();

I would strongly advise against that - calling driver code from arch
core code. You've made armv8_edac bool as it cannot be a module because
of it, which is silly. I was lucky that we were able to remove that ugly
dependency from x86 traps code. Hint: use a notifier and this way the
edac driver can be a module too.

And looking at armv8_edac.c - this is making the whole error reporting
unnecessarily complicated. Why? Why aren't you doing everything in
ras.c?!

I don't see the need for adding anything to drivers/edac/ *at* *all*!

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
