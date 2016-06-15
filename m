From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 15 Jun 2016 17:14:02 +0900
Subject: [PATCH v18 03/13] arm64/kexec: Add core kexec support
In-Reply-To: <84e50e4043a2061e0f5d9273f55e158c59754af0.1465502767.git.geoff@infradead.org>
References: <cover.1465502767.git.geoff@infradead.org>
 <84e50e4043a2061e0f5d9273f55e158c59754af0.1465502767.git.geoff@infradead.org>
Message-ID: <20160615081401.GO20774@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Geoff,

On Thu, Jun 09, 2016 at 08:08:44PM +0000, Geoff Levand wrote:
> Add three new files, kexec.h, machine_kexec.c and relocate_kernel.S to the
> arm64 architecture that add support for the kexec re-boot mechanism
> (CONFIG_KEXEC) on arm64 platforms.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/Kconfig                  |  10 ++
>  arch/arm64/include/asm/kexec.h      |  48 ++++++++++
>  arch/arm64/kernel/Makefile          |   2 +
>  arch/arm64/kernel/machine_kexec.c   | 185 ++++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/relocate_kernel.S | 131 +++++++++++++++++++++++++
>  include/uapi/linux/kexec.h          |   1 +
>  6 files changed, 377 insertions(+)
>  create mode 100644 arch/arm64/include/asm/kexec.h
>  create mode 100644 arch/arm64/kernel/machine_kexec.c
>  create mode 100644 arch/arm64/kernel/relocate_kernel.S
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5a0a691..330786d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -664,6 +664,16 @@ config PARAVIRT_TIME_ACCOUNTING
>  
>  	  If in doubt, say N here.
>  
> +config KEXEC
> +	depends on PM_SLEEP_SMP
> +	select KEXEC_CORE
> +	bool "kexec system call"
> +	---help---
> +	  kexec is a system call that implements the ability to shutdown your
> +	  current kernel, and to start another kernel.  It is like a reboot
> +	  but it is independent of the system firmware.   And like a reboot
> +	  you can start any kernel with it, not just Linux.
> +
>  config XEN_DOM0
>  	def_bool y
>  	depends on XEN
> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> new file mode 100644
> index 0000000..04744dc
> --- /dev/null
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -0,0 +1,48 @@
> +/*
> + * kexec for arm64
> + *
> + * Copyright (C) Linaro.
> + * Copyright (C) Huawei Futurewei Technologies.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _ARM64_KEXEC_H
> +#define _ARM64_KEXEC_H
> +
> +/* Maximum physical address we can use pages from */
> +
> +#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
> +
> +/* Maximum address we can reach in physical address mode */
> +
> +#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
> +
> +/* Maximum address we can use for the control code buffer */
> +
> +#define KEXEC_CONTROL_MEMORY_LIMIT (-1UL)
> +
> +#define KEXEC_CONTROL_PAGE_SIZE 4096
> +
> +#define KEXEC_ARCH KEXEC_ARCH_AARCH64
> +
> +#ifndef __ASSEMBLY__
> +
> +/**
> + * crash_setup_regs() - save registers for the panic kernel
> + *
> + * @newregs: registers are saved here
> + * @oldregs: registers to be saved (may be %NULL)
> + */
> +
> +static inline void crash_setup_regs(struct pt_regs *newregs,
> +				    struct pt_regs *oldregs)
> +{
> +	/* Empty routine needed to avoid build errors. */
> +}
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#endif
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 2173149..7700c0c 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -46,6 +46,8 @@ arm64-obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
>  arm64-obj-$(CONFIG_PARAVIRT)		+= paravirt.o
>  arm64-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
>  arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
> +arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o	\
> +					   cpu-reset.o
>  
>  obj-y					+= $(arm64-obj-y) vdso/
>  obj-m					+= $(arm64-obj-m)
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> new file mode 100644
> index 0000000..05f7c21
> --- /dev/null
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -0,0 +1,185 @@
> +/*
> + * kexec for arm64
> + *
> + * Copyright (C) Linaro.
> + * Copyright (C) Huawei Futurewei Technologies.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/highmem.h>
> +#include <linux/kexec.h>
> +#include <linux/of_fdt.h>
> +#include <linux/slab.h>
> +#include <linux/smp.h>
> +#include <linux/uaccess.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/cpu_ops.h>
> +#include <asm/mmu_context.h>
> +#include <asm/system_misc.h>
> +
> +#include "cpu-reset.h"
> +
> +/* Global variables for the arm64_relocate_new_kernel routine. */
> +extern const unsigned char arm64_relocate_new_kernel[];
> +extern const unsigned long arm64_relocate_new_kernel_size;
> +
> +static unsigned long kimage_start;
> +
> +void machine_kexec_cleanup(struct kimage *kimage)
> +{
> +	/* Empty routine needed to avoid build errors. */
> +}
> +
> +/**
> + * machine_kexec_prepare - Prepare for a kexec reboot.
> + *
> + * Called from the core kexec code when a kernel image is loaded.
> + * Forbid loading a kexec kernel if we have no way of hotplugging cpus or cpus
> + * are stuck in the kernel. This avoids a panic once we hit machine_kexec().
> + */
> +int machine_kexec_prepare(struct kimage *kimage)
> +{
> +	kimage_start = kimage->start;
> +
> +	if (kimage->type != KEXEC_TYPE_CRASH) {
> +		if (cpus_are_stuck_in_kernel()) {
> +			pr_err("Can't kexec: failed CPUs are stuck in the kernel.\n");
> +			return -EBUSY;
> +		}
> +
> +		if (num_online_cpus() > 1) {
> +#ifdef CONFIG_HOTPLUG_CPU
> +			/* any_cpu as we don't mind being preempted */
> +			int any_cpu = raw_smp_processor_id();
> +
> +			if (cpu_ops[any_cpu]->cpu_die)
> +				return 0;
> +#endif /* CONFIG_HOTPLUG_CPU */
> +
> +			pr_err("Can't kexec: no mechanism to offline secondary CPUs.\n");
> +			return -EBUSY;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * kexec_list_flush - Helper to flush the kimage list to PoC.
> + */
> +static void kexec_list_flush(struct kimage *kimage)
> +{
> +	kimage_entry_t *entry;
> +	unsigned int flag;
> +
> +	for (entry = &kimage->head, flag = 0; flag != IND_DONE; entry++) {
> +		void *addr = kmap(phys_to_page(*entry & PAGE_MASK));
> +
> +		flag = *entry & IND_FLAGS;

I found a bug here when I tested the kernel *without* CONFIG_SPARSEMEM_VMEMMAP.
We need to check 'flag == IND_DONE' first before calculating
phys_to_page(*entry & PAGE_MASK), otherwise we will see a kernel page fault
(around the address 0x0) in case of IND_DONE.
This bug was harmless with CONFIG_SPARSEMEM_VMEMMAP because phys_to_page()
macro doesn't contain any memory access and 'addr' can be bogus but never used
in IND_DONE.

See my fix.
(As James mentioned before, we may use phys_to_virt() instead of kmap() here.)

Thanks,
-Takahiro AKASHI

===8<===
>From b814922d74bcd1746265fa0fcdb7fc6f4cb1515e Mon Sep 17 00:00:00 2001
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Date: Wed, 15 Jun 2016 16:32:21 +0900
Subject: [PATCH] arm64: kexec: bugfix

---
 arch/arm64/kernel/machine_kexec.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 0d99fde..ea8e5fe 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -124,23 +124,22 @@ static void kexec_list_flush(struct kimage *kimage)
 {
 	kimage_entry_t *entry;
 	unsigned int flag;
+	void *addr;
 
-	for (entry = &kimage->head, flag = 0; flag != IND_DONE; entry++) {
-		void *addr = kmap(phys_to_page(*entry & PAGE_MASK));
-
+	for (entry = &kimage->head; ; entry++) {
 		flag = *entry & IND_FLAGS;
+		if (flag == IND_DONE)
+			break;
+
+		addr = kmap(phys_to_page(*entry & PAGE_MASK));
 
 		switch (flag) {
 		case IND_INDIRECTION:
 			entry = (kimage_entry_t *)addr - 1;
-			__flush_dcache_area(addr, PAGE_SIZE);
-			break;
-		case IND_DESTINATION:
-			break;
 		case IND_SOURCE:
 			__flush_dcache_area(addr, PAGE_SIZE);
 			break;
-		case IND_DONE:
+		case IND_DESTINATION:
 			break;
 		default:
 			BUG();
-- 
2.8.1
