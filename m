From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 18 Sep 2014 02:13:06 +0100
Subject: [PATCH 11/13] arm64/kexec: Add core kexec support
In-Reply-To: <3337b516ad1e1227a29b9068519e3ad91d2b305e.1410302383.git.geoff@infradead.org>
References: <cover.1410302383.git.geoff@infradead.org>
 <3337b516ad1e1227a29b9068519e3ad91d2b305e.1410302383.git.geoff@infradead.org>
Message-ID: <20140918011306.GG7983@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Tue, Sep 09, 2014 at 11:49:05PM +0100, Geoff Levand wrote:
> Add three new files, kexec.h, machine_kexec.c and relocate_kernel.S to the
> arm64 architecture that add support for the kexec re-boot mechanism
> (CONFIG_KEXEC) on arm64 platforms.
>
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/Kconfig                  |   8 +
>  arch/arm64/include/asm/kexec.h      |  52 +++
>  arch/arm64/kernel/Makefile          |   2 +
>  arch/arm64/kernel/machine_kexec.c   | 612 ++++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/relocate_kernel.S | 185 +++++++++++
>  include/uapi/linux/kexec.h          |   1 +
>  6 files changed, 860 insertions(+)
>  create mode 100644 arch/arm64/include/asm/kexec.h
>  create mode 100644 arch/arm64/kernel/machine_kexec.c
>  create mode 100644 arch/arm64/kernel/relocate_kernel.S
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index f0d3a2d..6f0e1f1 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -313,6 +313,14 @@ config ARCH_HAS_CACHE_LINE_SIZE
>
>  source "mm/Kconfig"
>
> +config KEXEC
> +       bool "kexec system call"
> +       ---help---
> +         kexec is a system call that implements the ability to shutdown your
> +         current kernel, and to start another kernel.  It is like a reboot
> +         but it is independent of the system firmware.   And like a reboot
> +         you can start any kernel with it, not just Linux.
> +
>  config XEN_DOM0
>         def_bool y
>         depends on XEN
> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> new file mode 100644
> index 0000000..9a3932c
> --- /dev/null
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -0,0 +1,52 @@
> +/*
> + * kexec for arm64
> + *
> + * Copyright (C) Linaro.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#if !defined(_ARM64_KEXEC_H)
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

What are these used for? I see that other architectures seem to do the
same thing, but they look odd.

> +#define KEXEC_CONTROL_PAGE_SIZE        4096

What's this used for?

Does this work with 64k pages, and is there any reason we can't figure
out the actual size of the code (so we don't get bitten if it grows)?

> +
> +#define KEXEC_ARCH KEXEC_ARCH_ARM64
> +
> +#define ARCH_HAS_KIMAGE_ARCH
> +
> +#if !defined(__ASSEMBLY__)
> +
> +struct kimage_arch {
> +       void *ctx;
> +};
> +
> +/**
> + * crash_setup_regs() - save registers for the panic kernel
> + *
> + * @newregs: registers are saved here
> + * @oldregs: registers to be saved (may be %NULL)
> + */
> +
> +static inline void crash_setup_regs(struct pt_regs *newregs,
> +                                   struct pt_regs *oldregs)
> +{
> +}

It would be nice to know what we're going to do for this.

Is this a required function, or can we get away without crash kernel
support for the moment?

> +
> +#endif /* !defined(__ASSEMBLY__) */
> +
> +#endif
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index df7ef87..8b7c029 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -29,6 +29,8 @@ arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND) += sleep.o suspend.o
>  arm64-obj-$(CONFIG_JUMP_LABEL)         += jump_label.o
>  arm64-obj-$(CONFIG_KGDB)               += kgdb.o
>  arm64-obj-$(CONFIG_EFI)                        += efi.o efi-stub.o efi-entry.o
> +arm64-obj-$(CONFIG_KEXEC)              += machine_kexec.o relocate_kernel.o    \
> +                                          cpu-properties.o
>
>  obj-y                                  += $(arm64-obj-y) vdso/
>  obj-m                                  += $(arm64-obj-m)
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> new file mode 100644
> index 0000000..043a3bc
> --- /dev/null
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -0,0 +1,612 @@
> +/*
> + * kexec for arm64
> + *
> + * Copyright (C) Linaro.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/kexec.h>
> +#include <linux/of_fdt.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/cpu_ops.h>
> +#include <asm/system_misc.h>
> +
> +#include "cpu-properties.h"
> +
> +#if defined(DEBUG)
> +static const int debug = 1;
> +#else
> +static const int debug;
> +#endif

I don't think we need this.

> +
> +typedef struct dtb_buffer {char b[0]; } dtb_t;

It would be nice for this to be consistent with other dtb uses; if we
need a dtb type then it shouldn't be specific to kexec.

[...]

> +static struct kexec_ctx *current_ctx;
> +
> +static int kexec_ctx_alloc(struct kimage *image)
> +{
> +       BUG_ON(image->arch.ctx);
> +
> +       image->arch.ctx = kmalloc(sizeof(struct kexec_ctx), GFP_KERNEL);
> +
> +       if (!image->arch.ctx)
> +               return -ENOMEM;
> +
> +       current_ctx = (struct kexec_ctx *)image->arch.ctx;

This seems to be the only use of current_ctx. I take it this is a
leftover from debugging?

[...]

> +/**
> + * kexec_list_walk - Helper to walk the kimage page list.
> + */

Please keep this associated with the function it refers to (nothing
should be between this comment and the function prototype).

> +
> +#define IND_FLAGS (IND_DESTINATION | IND_INDIRECTION | IND_DONE | IND_SOURCE)

Can't this live in include/linux/kexec.h, where these flags are defined.

The meaning of these doesn't seem to be documented anywhere. Would you
be able to explain what each of these means?

> +static void kexec_list_walk(void *ctx, unsigned long kimage_head,
> +       void (*cb)(void *ctx, unsigned int flag, void *addr, void *dest))
> +{
> +       void *dest;
> +       unsigned long *entry;
> +
> +       for (entry = &kimage_head, dest = NULL; ; entry++) {
> +               unsigned int flag = *entry & IND_FLAGS;
> +               void *addr = phys_to_virt(*entry & PAGE_MASK);
> +
> +               switch (flag) {
> +               case IND_INDIRECTION:
> +                       entry = (unsigned long *)addr - 1;
> +                       cb(ctx, flag, addr, NULL);
> +                       break;
> +               case IND_DESTINATION:
> +                       dest = addr;
> +                       cb(ctx, flag, addr, NULL);
> +                       break;
> +               case IND_SOURCE:
> +                       cb(ctx, flag, addr, dest);
> +                       dest += PAGE_SIZE;

I really don't understand what's going on with dest here, but that's
probably because I don't understand the meaning of the flags.

> +                       break;
> +               case IND_DONE:
> +                       cb(ctx, flag , NULL, NULL);
> +                       return;
> +               default:
> +                       pr_devel("%s:%d unknown flag %xh\n", __func__, __LINE__,
> +                               flag);

Wouldn't pr_warn would be more appropriate here?

> +                       cb(ctx, flag, addr, NULL);
> +                       break;
> +               }
> +       }
> +}
> +
> +/**
> + * kexec_image_info - For debugging output.
> + */
> +
> +#define kexec_image_info(_i) _kexec_image_info(__func__, __LINE__, _i)
> +static void _kexec_image_info(const char *func, int line,
> +       const struct kimage *image)
> +{
> +       if (debug) {
> +               unsigned long i;
> +
> +               pr_devel("%s:%d:\n", func, line);
> +               pr_devel("  kexec image info:\n");
> +               pr_devel("    type:        %d\n", image->type);
> +               pr_devel("    start:       %lx\n", image->start);
> +               pr_devel("    head:        %lx\n", image->head);
> +               pr_devel("    nr_segments: %lu\n", image->nr_segments);
> +
> +               for (i = 0; i < image->nr_segments; i++) {
> +                       pr_devel("      segment[%lu]: %016lx - %016lx, "
> +                               "%lxh bytes, %lu pages\n",
> +                               i,
> +                               image->segment[i].mem,
> +                               image->segment[i].mem + image->segment[i].memsz,
> +                               image->segment[i].memsz,
> +                               image->segment[i].memsz /  PAGE_SIZE);
> +
> +                       if (kexec_is_dtb_user(image->segment[i].buf))
> +                               pr_devel("        dtb segment\n");
> +               }
> +       }
> +}

pr_devel is already dependent on DEBUG, so surely we don't need to check
the debug variable?

> +
> +/**
> + * kexec_find_dtb_seg - Helper routine to find the dtb segment.
> + */
> +
> +static const struct kexec_segment *kexec_find_dtb_seg(
> +       const struct kimage *image)
> +{
> +       int i;
> +
> +       for (i = 0; i < image->nr_segments; i++) {
> +               if (kexec_is_dtb_user(image->segment[i].buf))
> +                       return &image->segment[i];
> +       }
> +
> +       return NULL;
> +}

I'm really not keen on having the kernel guess which blobs need special
treatment, though we seem to do that for arm.

It would be far nicer if we could pass flags for each segment to
describe what it is (e.g. kernel image, dtb, other binary blob), so we
can do things like pass multiple DTBs (so we load two kernels at once
and pass each a unique DTB if we want to boot a new kernel + crashkernel
pair). Unfortunately that would require some fairly invasive rework of
the kexec core.

For secureboot we can't trust a dtb from userspace, and will have to use
kexec_file_load. To work with that we can either:

* Reuse the original DTB, patched with the new command line. This may
  have statefulness issues (for things like simplefb).

* Build a new DTB by flattening the current live tree. This would rely
  on drivers that modify state to patch the tree appropriately.

Both of those are somewhat ugly. :(

[...]

> +/**
> + * kexec_cpu_info_init - Initialize an array of kexec_cpu_info structures.
> + *
> + * Allocates a cpu info array and fills it with info for all cpus found in
> + * the device tree passed.
> + */
> +
> +static int kexec_cpu_info_init(const struct device_node *dn,
> +       struct kexec_boot_info *info)
> +{
> +       int result;
> +       unsigned int cpu;
> +
> +       info->cp = kmalloc(
> +               info->cpu_count * sizeof(*info->cp), GFP_KERNEL);
> +
> +       if (!info->cp) {
> +               pr_err("%s: Error: Out of memory.", __func__);
> +               return -ENOMEM;
> +       }
> +
> +       for (cpu = 0; cpu < info->cpu_count; cpu++) {
> +               struct cpu_properties *cp = &info->cp[cpu];
> +
> +               dn = of_find_node_by_type((struct device_node *)dn, "cpu");
> +
> +               if (!dn) {
> +                       pr_devel("%s:%d: bad node\n", __func__, __LINE__);
> +                       goto on_error;
> +               }
> +
> +               result = read_cpu_properties(cp, dn);
> +
> +               if (result) {
> +                       pr_devel("%s:%d: bad node\n", __func__, __LINE__);
> +                       goto on_error;
> +               }
> +
> +               if (cp->type == cpu_enable_method_psci)
> +                       pr_devel("%s:%d: cpu-%u: hwid-%llx, '%s'\n",
> +                               __func__, __LINE__, cpu, cp->hwid,
> +                               cp->enable_method);
> +               else
> +                       pr_devel("%s:%d: cpu-%u: hwid-%llx, '%s', "
> +                               "cpu-release-addr %llx\n",
> +                               __func__, __LINE__, cpu, cp->hwid,
> +                               cp->enable_method,
> +                               cp->cpu_release_addr);
> +       }
> +
> +       return 0;
> +
> +on_error:
> +       kfree(info->cp);
> +       info->cp = NULL;
> +       return -EINVAL;
> +}

I don't see why we should need this at all. If we use the hotplug
infrastructure, we don't need access to the enable-method and related
properties, and the kexec code need only deal with a single CPU.

The only case where kexec needs to deal with other CPUs is when some are
sat in the holding pen, but this code doesn't seem to handle that.

as I believe I mentioned before, we should be able to extend the holding
pen code to get those CPUs to increment a sat-in-pen counter and if
that's non-zero after SMP bringup we print a warning (and disallow
kexec).

[...]

> +/**
> +* kexec_compat_check - Iterator for kexec_cpu_check.
> +*/
> +
> +static int kexec_compat_check(const struct kexec_ctx *ctx)
> +{
> +       unsigned int cpu_1;
> +       unsigned int to_process;
> +
> +       to_process = min(ctx->first.cpu_count, ctx->second.cpu_count);
> +
> +       if (ctx->first.cpu_count != ctx->second.cpu_count)
> +               pr_warn("%s: Warning: CPU count mismatch %u != %u.\n",
> +                       __func__, ctx->first.cpu_count, ctx->second.cpu_count);
> +
> +       for (cpu_1 = 0; cpu_1 < ctx->first.cpu_count; cpu_1++) {
> +               unsigned int cpu_2;
> +               struct cpu_properties *cp_1 = &ctx->first.cp[cpu_1];
> +
> +               for (cpu_2 = 0; cpu_2 < ctx->second.cpu_count; cpu_2++) {
> +                       struct cpu_properties *cp_2 = &ctx->second.cp[cpu_2];
> +
> +                       if (cp_1->hwid != cp_2->hwid)
> +                               continue;
> +
> +                       if (!kexec_cpu_check(cp_1, cp_2))
> +                               return -EINVAL;
> +
> +                       to_process--;
> +               }
> +       }
> +
> +       if (to_process) {
> +               pr_warn("%s: Warning: Failed to process %u CPUs.\n", __func__,
> +                       to_process);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}

I don't see the point in checking this in the kernel. If I pass the
second stage kernel a new dtb where my enable methods are different,
that was my choice as a user. If that doesn't work, that's my fault.

There are plenty of other things that might be completely different that
we don't sanity check, so I don't see why enable methods should be any
different.

[...]

> +/**
> + * kexec_check_cpu_die -  Check if cpu_die() will work on secondary processors.
> + */
> +
> +static int kexec_check_cpu_die(void)
> +{
> +       unsigned int cpu;
> +       unsigned int sum = 0;
> +
> +       /* For simplicity this also checks the primary CPU. */
> +
> +       for_each_cpu(cpu, cpu_all_mask) {
> +               if (cpu && (!cpu_ops[cpu] || !cpu_ops[cpu]->cpu_disable ||
> +                       cpu_ops[cpu]->cpu_disable(cpu))) {
> +                       sum++;
> +                       pr_err("%s: Error: "
> +                               "CPU %u does not support hot un-plug.\n",
> +                               __func__, cpu);
> +               }
> +       }
> +
> +       return sum ? -EOPNOTSUPP : 0;
> +}

We should really use disable_nonboot_cpus() for this. That way we don't
end up with a slightly different hotplug implementation for kexec. The
above is missing cpu_kill calls, for example, and I'm worried by the
possibility of further drift over time.

I understand from our face-to-face discussion that you didn't want to
require the PM infrastructure that disable_nonboot_cpus currently pulls
in due to the being dependent on CONFIG_PM_SLEEP_SMP which selects
CONFIG_PM_SLEEP and so on. The solution to that is to refactor the
Kconfig so we can have disable_nonboot_cpus without all the other PM
infrastructure.

> +
> +/**
> + * machine_kexec_prepare - Prepare for a kexec reboot.
> + *
> + * Called from the core kexec code when a kernel image is loaded.
> + */
> +
> +int machine_kexec_prepare(struct kimage *image)
> +{
> +       int result;

This seems to always be an error code. Call it 'err'.

> +       dtb_t *dtb = NULL;
> +       struct kexec_ctx *ctx;
> +       const struct kexec_segment *dtb_seg;
> +
> +       kexec_image_info(image);
> +
> +       result = kexec_check_cpu_die();
> +
> +       if (result)
> +               goto on_error;
> +
> +       result = kexec_ctx_alloc(image);
> +
> +       if (result)
> +               goto on_error;
> +
> +       ctx = kexec_image_to_ctx(image);
> +
> +       result = kexec_boot_info_init(&ctx->first, NULL);
> +
> +       if (result)
> +               goto on_error;
> +
> +       dtb_seg = kexec_find_dtb_seg(image);
> +
> +       if (!dtb_seg) {
> +               result = -EINVAL;
> +               goto on_error;
> +       }
> +
> +       result = kexec_copy_dtb(dtb_seg, &dtb);
> +
> +       if (result)
> +               goto on_error;
> +
> +       result = kexec_boot_info_init(&ctx->second, dtb);
> +
> +       if (result)
> +               goto on_error;
> +
> +       result = kexec_compat_check(ctx);
> +
> +       if (result)
> +               goto on_error;
> +
> +       kexec_dtb_addr = dtb_seg->mem;
> +       kexec_kimage_start = image->start;
> +
> +       goto on_exit;
> +
> +on_error:
> +       kexec_ctx_clean(image);
> +on_exit:

on_* looks weird, and doesn't match the style of other labels in
arch/arm64. Could we call these 'out_clean' and 'out' instead?

> +       kfree(dtb);
> +       return result;
> +}
> +
> +/**
> + * kexec_list_flush_cb - Callback to flush the kimage list to PoC.
> + */
> +
> +static void kexec_list_flush_cb(void *ctx , unsigned int flag,
> +       void *addr, void *dest)
> +{
> +       switch (flag) {
> +       case IND_INDIRECTION:
> +       case IND_SOURCE:
> +               __flush_dcache_area(addr, PAGE_SIZE);

Is PAGE_SIZE always big enough? Do we not have a more accurate size?

Perhaps I've misunderstood what's going on here.

> +               break;
> +       default:
> +               break;
> +       }
> +}
> +
> +/**
> + * machine_kexec - Do the kexec reboot.
> + *
> + * Called from the core kexec code for a sys_reboot with LINUX_REBOOT_CMD_KEXEC.
> + */
> +
> +void machine_kexec(struct kimage *image)
> +{
> +       phys_addr_t reboot_code_buffer_phys;
> +       void *reboot_code_buffer;
> +       struct kexec_ctx *ctx = kexec_image_to_ctx(image);
> +
> +       BUG_ON(relocate_new_kernel_size > KEXEC_CONTROL_PAGE_SIZE);

It looks like relocate_new_kernel_size is a build-time constant. If we
need that to be less than KEXEC_CONTROL_PAGE_SIZE, then we should make
that a build-time check.

> +       BUG_ON(num_online_cpus() > 1);
> +       BUG_ON(!ctx);
> +
> +       kexec_image_info(image);
> +
> +       kexec_kimage_head = image->head;
> +
> +       reboot_code_buffer_phys = page_to_phys(image->control_code_page);
> +       reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
> +
> +       pr_devel("%s:%d: control_code_page:        %p\n", __func__, __LINE__,
> +               (void *)image->control_code_page);

This is already a pointer. Is the cast to void necessary?

> +       pr_devel("%s:%d: reboot_code_buffer_phys:  %p\n", __func__, __LINE__,
> +               (void *)reboot_code_buffer_phys);

Use %pa and pass &reboot_code_buffer_phys, no cast necessary.

> +       pr_devel("%s:%d: reboot_code_buffer:       %p\n", __func__, __LINE__,
> +               reboot_code_buffer);
> +       pr_devel("%s:%d: relocate_new_kernel:      %p\n", __func__, __LINE__,
> +               relocate_new_kernel);
> +       pr_devel("%s:%d: relocate_new_kernel_size: %lxh(%lu) bytes\n", __func__,
> +               __LINE__, relocate_new_kernel_size, relocate_new_kernel_size);

Please use an '0x' prefix rather than a 'h' suffix. Do we need in print
in both hex and decimal?

> +
> +       pr_devel("%s:%d: kexec_dtb_addr:           %p\n", __func__, __LINE__,
> +               (void *)kexec_dtb_addr);
> +       pr_devel("%s:%d: kexec_kimage_head:        %p\n", __func__, __LINE__,
> +               (void *)kexec_kimage_head);
> +       pr_devel("%s:%d: kexec_kimage_start:       %p\n", __func__, __LINE__,
> +               (void *)kexec_kimage_start);

These are all unsigned long, so why not use the existing mechanism for
printing unsigned long?

> +
> +       /*
> +        * Copy relocate_new_kernel to the reboot_code_buffer for use
> +        * after the kernel is shut down.
> +        */
> +
> +       memcpy(reboot_code_buffer, relocate_new_kernel,
> +               relocate_new_kernel_size);
> +
> +       /* Assure reboot_code_buffer is copied. */
> +
> +       mb();

I don't think we need the mb if this is only to guarantee completion
before the cache flush -- cacheable memory accesses should hazard
against cache flushes by VA.

> +
> +       pr_info("Bye!\n");
> +
> +       local_disable(DAIF_ALL);

We can move these two right before the soft_restart, after the cache
maintenance. That way the print is closer to the exit of the current
kernel.

> +
> +       /* Flush the reboot_code_buffer in preparation for its execution. */
> +
> +       __flush_dcache_area(reboot_code_buffer, relocate_new_kernel_size);
> +
> +       /* Flush the kimage list. */
> +
> +       kexec_list_walk(NULL, image->head, kexec_list_flush_cb);
> +
> +       soft_restart(reboot_code_buffer_phys);
> +}
> +
> +void machine_crash_shutdown(struct pt_regs *regs)
> +{
> +       /* Empty routine needed to avoid build errors. */
> +}
> diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
> new file mode 100644
> index 0000000..92aba9d
> --- /dev/null
> +++ b/arch/arm64/kernel/relocate_kernel.S
> @@ -0,0 +1,185 @@
> +/*
> + * kexec for arm64
> + *
> + * Copyright (C) Linaro.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <asm/assembler.h>
> +#include <asm/memory.h>
> +#include <asm/page.h>
> +
> +/* The list entry flags. */
> +
> +#define IND_DESTINATION_BIT 0
> +#define IND_INDIRECTION_BIT 1
> +#define IND_DONE_BIT        2
> +#define IND_SOURCE_BIT      3

Given these ned to match the existing IND_* flags in
include/linux/kexec.h, and they aren't in any way specific to arm64,
please put these ina an asm-generic header and redefine the existing
IND_* flags in terms of them.

> +
> +/*
> + * relocate_new_kernel - Put the 2nd stage kernel image in place and boot it.
> + *
> + * The memory that the old kernel occupies may be overwritten when coping the
> + * new kernel to its final location.  To assure that the relocate_new_kernel
> + * routine which does that copy is not overwritten all code and data needed
> + * by relocate_new_kernel must be between the symbols relocate_new_kernel and
> + * relocate_new_kernel_end.  The machine_kexec() routine will copy
> + * relocate_new_kernel to the kexec control_code_page, a special page which
> + * has been set up to be preserved during the kernel copy operation.
> + */
> +
> +.align 3

Surely this isn't necessary?

> +
> +.globl relocate_new_kernel
> +relocate_new_kernel:
> +
> +       /* Setup the list loop variables. */
> +
> +       ldr     x10, kexec_kimage_head          /* x10 = list entry */

Any reason for using x10 rather than starting with x0? Or x18, if you
need to preserve the low registers?

> +
> +       mrs     x0, ctr_el0
> +       ubfm    x0, x0, #16, #19
> +       mov     x11, #4
> +       lsl     x11, x11, x0                    /* x11 = dcache line size */

Any reason we can't use dcache_line_size, given it's a macro?

> +
> +       mov     x12, xzr                        /* x12 = segment start */
> +       mov     x13, xzr                        /* x13 = entry ptr */
> +       mov     x14, xzr                        /* x14 = copy dest */
> +
> +       /* Check if the new kernel needs relocation. */
> +
> +       cbz     x10, .Ldone
> +       tbnz    x10, IND_DONE_BIT, .Ldone
> +
> +.Lloop:

Is there any reason for the '.L' on all of these? We only seem to do
that in the lib code that was imported from elsewhere, and it doesn't
match the rest of the arm64 asm.

> +       and     x15, x10, PAGE_MASK             /* x15 = addr */
> +
> +       /* Test the entry flags. */
> +
> +.Ltest_source:
> +       tbz     x10, IND_SOURCE_BIT, .Ltest_indirection
> +
> +       /* copy_page(x20 = dest, x21 = src) */
> +
> +       mov x20, x14
> +       mov x21, x15
> +
> +1:     ldp     x22, x23, [x21]
> +       ldp     x24, x25, [x21, #16]
> +       ldp     x26, x27, [x21, #32]
> +       ldp     x28, x29, [x21, #48]
> +       add     x21, x21, #64
> +       stnp    x22, x23, [x20]
> +       stnp    x24, x25, [x20, #16]
> +       stnp    x26, x27, [x20, #32]
> +       stnp    x28, x29, [x20, #48]
> +       add     x20, x20, #64
> +       tst     x21, #(PAGE_SIZE - 1)
> +       b.ne    1b

It's a shame we can't reuse copy_page directly. Could we not move the
body to a macro we can reuse here?

> +
> +       /* dest += PAGE_SIZE */
> +
> +       add     x14, x14, PAGE_SIZE
> +       b       .Lnext
> +
> +.Ltest_indirection:
> +       tbz     x10, IND_INDIRECTION_BIT, .Ltest_destination
> +
> +       /* ptr = addr */
> +
> +       mov     x13, x15
> +       b       .Lnext
> +
> +.Ltest_destination:
> +       tbz     x10, IND_DESTINATION_BIT, .Lnext
> +
> +       /* flush segment */
> +
> +       bl      .Lflush
> +       mov     x12, x15
> +
> +       /* dest = addr */
> +
> +       mov     x14, x15
> +
> +.Lnext:
> +       /* entry = *ptr++ */
> +
> +       ldr     x10, [x13]
> +       add     x13, x13, 8

This can be:

	ldr	x10, [x13], #8

> +
> +       /* while (!(entry & DONE)) */
> +
> +       tbz     x10, IND_DONE_BIT, .Lloop
> +
> +.Ldone:
> +       /* flush last segment */
> +
> +       bl      .Lflush
> +
> +       dsb     sy
> +       isb
> +       ic      ialluis

This doesn't look right; we need a dsb and an isb after the instruction
cache maintenance (or the icache could still be flushing when we branch
to the new kernel).

> +
> +       /* start_new_kernel */
> +
> +       ldr     x4, kexec_kimage_start
> +       ldr     x0, kexec_dtb_addr
> +       mov     x1, xzr
> +       mov     x2, xzr
> +       mov     x3, xzr
> +       br      x4
> +
> +/* flush - x11 = line size, x12 = start addr, x14 = end addr. */
> +
> +.Lflush:
> +       cbz     x12, 2f
> +       mov     x0, x12
> +       sub     x1, x11, #1
> +       bic     x0, x0, x1
> +1:     dc      civac, x0
> +       add     x0, x0, x11
> +       cmp     x0, x14
> +       b.lo    1b
> +2:     ret

It would be nice if this were earlier in the file, before its callers.

> +
> +.align 3

We should have a comment as to why this is needed (to keep the 64-bit
values below naturally aligned).

Thanks,
Mark.
