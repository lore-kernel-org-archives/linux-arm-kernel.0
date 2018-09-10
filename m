From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Mon, 10 Sep 2018 23:58:34 +0530
Subject: [PATCH] arm64: kernel: arch_crash_save_vmcoreinfo() should depend
 on CONFIG_CRASH_CORE
In-Reply-To: <20180910142054.22013-1-james.morse@arm.com>
References: <20180910142054.22013-1-james.morse@arm.com>
Message-ID: <CACi5LpPYMtkWN3DZ5zPX6_sjfVo3grMKvVcyZVFh6zLfOXhqJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks James,


On Mon, Sep 10, 2018 at 7:50 PM, James Morse <james.morse@arm.com> wrote:
> Since commit 23c85094fe18 ("proc/kcore: add vmcoreinfo note to /proc/kcore")
> the kernel has exported the vmcoreinfo PT_NOTE on /proc/kcore as well
> as /proc/vmcore.
>
> arm64 only exposes it's additional arch information via
> arch_crash_save_vmcoreinfo() if built with CONFIG_KEXEC, as kdump was
> previously the only user of vmcoreinfo.
>
> Move this weak function to a separate file that is built at the same
> time as its caller in kernel/crash_core.c. This ensures values like
> 'kimage_voffset' are always present in the vmcoreinfo PT_NOTE.
>
> CC: AKASHI Takahiro <takahiro.akashi@linaro.org>
> CC: Bhupesh Sharma <bhsharma@redhat.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Intended as a fix for v4.19.
>
>  arch/arm64/kernel/Makefile        |  1 +
>  arch/arm64/kernel/crash_core.c    | 19 +++++++++++++++++++
>  arch/arm64/kernel/machine_kexec.c | 11 -----------
>  3 files changed, 20 insertions(+), 11 deletions(-)
>  create mode 100644 arch/arm64/kernel/crash_core.c
>
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 95ac7374d723..4c8b13bede80 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -54,6 +54,7 @@ arm64-obj-$(CONFIG_KEXEC)             += machine_kexec.o relocate_kernel.o    \
>  arm64-obj-$(CONFIG_ARM64_RELOC_TEST)   += arm64-reloc-test.o
>  arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
>  arm64-obj-$(CONFIG_CRASH_DUMP)         += crash_dump.o
> +arm64-obj-$(CONFIG_CRASH_CORE)         += crash_core.o
>  arm64-obj-$(CONFIG_ARM_SDE_INTERFACE)  += sdei.o
>  arm64-obj-$(CONFIG_ARM64_SSBD)         += ssbd.o
>
> diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
> new file mode 100644
> index 000000000000..ca4c3e12d8c5
> --- /dev/null
> +++ b/arch/arm64/kernel/crash_core.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) Linaro.
> + * Copyright (C) Huawei Futurewei Technologies.
> + */
> +
> +#include <linux/crash_core.h>
> +#include <asm/memory.h>
> +
> +void arch_crash_save_vmcoreinfo(void)
> +{
> +       VMCOREINFO_NUMBER(VA_BITS);
> +       /* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
> +       vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
> +                                               kimage_voffset);
> +       vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
> +                                               PHYS_OFFSET);
> +       vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
> +}
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index f6a5c6bc1434..922add8adb74 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -358,14 +358,3 @@ void crash_free_reserved_phys_range(unsigned long begin, unsigned long end)
>         }
>  }
>  #endif /* CONFIG_HIBERNATION */
> -
> -void arch_crash_save_vmcoreinfo(void)
> -{
> -       VMCOREINFO_NUMBER(VA_BITS);
> -       /* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
> -       vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
> -                                               kimage_voffset);
> -       vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
> -                                               PHYS_OFFSET);
> -       vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
> -}
> --
> 2.18.0
>

Looks fine to me, so:

Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>
