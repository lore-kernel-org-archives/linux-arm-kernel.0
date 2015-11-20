From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 20 Nov 2015 15:48:28 +0000
Subject: [PATCH v9 4/6] target-arm: kvm - add support for HW assisted debug
In-Reply-To: <1447345251-22625-5-git-send-email-alex.bennee@linaro.org>
References: <1447345251-22625-1-git-send-email-alex.bennee@linaro.org>
 <1447345251-22625-5-git-send-email-alex.bennee@linaro.org>
Message-ID: <CAFEAcA-kb5FVvKtq6kSpk2ehoMfJjzS6X+KCqbmV3xwNprfZLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 November 2015 at 16:20, Alex Benn?e <alex.bennee@linaro.org> wrote:
> This adds basic support for HW assisted debug. The ioctl interface to
> KVM allows us to pass an implementation defined number of break and
> watch point registers. When KVM_GUESTDBG_USE_HW is specified these
> debug registers will be installed in place on the world switch into the
> guest.
>
> The hardware is actually capable of more advanced matching but it is
> unclear if this expressiveness is available via the gdbstub protocol.
>
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
>
> ---
> v2
>   - correct setting of PMC/BAS/MASK
>   - improved commentary
>   - added helper function to check watchpoint in range
>   - fix find/deletion of watchpoints
> v3
>   - use internals.h definitions
> v6
>   - KVM_GUESTDBG_USE_HW_BP->KVM_GUESTDBG_USE_HW
>   - renamed some helper functions to avoid confusion
> v9
>   - fix merge conflicts on re-base
>   - rm asm/ptrace.h include
>   - add additional commentry for hw breakpoints
>   - explain gdb's model for HW bkpts
>   - fix up spacing, formatting as per checkpatch
>   - better PAC values
>   - use is_power_of_2
>   - use _arm_ fn naming and add docs
>   - add a CPUWatchpoint structure for reporting
>   - replace manual array manipulation with g_array abstraction
> ---
>  target-arm/kvm.c     |  38 +++---
>  target-arm/kvm64.c   | 352 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  target-arm/kvm_arm.h |  38 ++++++
>  3 files changed, 406 insertions(+), 22 deletions(-)
>
> diff --git a/target-arm/kvm.c b/target-arm/kvm.c
> index d505a7e..1f57e92 100644
> --- a/target-arm/kvm.c
> +++ b/target-arm/kvm.c
> @@ -547,6 +547,20 @@ static int kvm_handle_debug(CPUState *cs, struct kvm_run *run)
>              return true;
>          }
>          break;
> +    case EC_BREAKPOINT:
> +        if (kvm_arm_find_hw_breakpoint(cs, env->pc)) {
> +            return true;
> +        }
> +        break;
> +    case EC_WATCHPOINT:
> +    {
> +        CPUWatchpoint *wp = kvm_arm_find_hw_watchpoint(cs, arch_info->far);

This won't compile for 32-bit ARM.

> +        if (wp) {
> +            cs->watchpoint_hit = wp;
> +            return true;
> +        }
> +        break;
> +    }
>      default:
>          error_report("%s: unhandled debug exit (%"PRIx32", %"PRIx64")\n",
>                       __func__, arch_info->hsr, env->pc);
> @@ -608,6 +622,10 @@ void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
>      if (kvm_sw_breakpoints_active(cs)) {
>          dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
>      }
> +    if (kvm_arm_hw_debug_active(cs)) {
> +        dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_HW;
> +        kvm_arm_copy_hw_debug_data(&dbg->arch);
> +    }
>  }
>
>  /* C6.6.29 BRK instruction */
> @@ -635,26 +653,6 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
>      return 0;
>  }
>
> -int kvm_arch_insert_hw_breakpoint(target_ulong addr,
> -                                  target_ulong len, int type)
> -{
> -    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
> -    return -EINVAL;
> -}

You've moved these functions into kvm64.c but haven't provided
a stub version in kvm32.c...

> -
> -int kvm_arch_remove_hw_breakpoint(target_ulong addr,
> -                                  target_ulong len, int type)
> -{
> -    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
> -    return -EINVAL;
> -}
> -
> -
> -void kvm_arch_remove_all_hw_breakpoints(void)
> -{
> -    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
> -}
> -
>  void kvm_arch_init_irq_routing(KVMState *s)
>  {
>  }
> diff --git a/target-arm/kvm64.c b/target-arm/kvm64.c
> index d087794..c468324 100644
> --- a/target-arm/kvm64.c
> +++ b/target-arm/kvm64.c
> @@ -2,6 +2,7 @@
>   * ARM implementation of KVM hooks, 64 bit specific code
>   *
>   * Copyright Mian-M. Hamayun 2013, Virtual Open Systems
> + * Copyright Alex Benn?e 2014, Linaro
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or later.
>   * See the COPYING file in the top-level directory.
> @@ -12,12 +13,17 @@
>  #include <sys/types.h>
>  #include <sys/ioctl.h>
>  #include <sys/mman.h>
> +#include <sys/ptrace.h>
>
> +#include <linux/elf.h>
>  #include <linux/kvm.h>
>
>  #include "config-host.h"
>  #include "qemu-common.h"
>  #include "qemu/timer.h"
> +#include "qemu/host-utils.h"
> +#include "qemu/error-report.h"
> +#include "exec/gdbstub.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/kvm.h"
>  #include "kvm_arm.h"
> @@ -27,20 +33,362 @@
>
>  static bool have_guest_debug;
>
> +/*
> + * Although the ARM implementation of hardware assisted debugging
> + * allows for different breakpoints per-core the current GDB interface

Comma after "per-core".

> + * treats them as a global pool of registers (which seems to be the
> + * case for x86, ppc and s390). As a result we store one copy of
> + * registers which is used for all active cores.
> + *
> + * Write access is serialised by virtue of the GDB protocol which
> + * updates things. Read access (i.e. when the values are copied to the
> + * vCPU) is also gated by GDBs run control.

"GDB's".

> + *
> + * This is not unreasonable as most of the time debugging kernels you
> + * never know which core will eventually execute your function.
> + */
> +
> +typedef struct {
> +    uint64_t bcr;
> +    uint64_t bvr;
> +} HWBreakpoint;
> +
> +/* The watchpoint registers can cover more area than the requested
> + * watchpoint so we need to store the additional information
> + * somewhere. We also need to supply a CPUWatchpoint to the GDB stub
> + * when the watchpoint is hit.
> + */
> +typedef struct {
> +    uint64_t wcr;
> +    uint64_t wvr;
> +    CPUWatchpoint details;
> +} HWWatchpoint;
> +
> +/* Maximum and current break/watch point counts */
> +int max_hw_bps, max_hw_wps;
> +GArray *hw_breakpoints, *hw_watchpoints;
> +
> +#define cur_hw_wps      (hw_watchpoints->len)
> +#define cur_hw_bps      (hw_breakpoints->len)
> +#define get_hw_bp(i)    (&g_array_index(hw_breakpoints, HWBreakpoint, i))
> +#define get_hw_wp(i)    (&g_array_index(hw_watchpoints, HWWatchpoint, i))
> +
>  /**
> - * kvm_arm_init_debug()
> + * kvm_arm_init_debug() - check for guest debug capabilities
>   * @cs: CPUState
>   *
> - * Check for guest debug capabilities.
> + * kvm_check_extension returns 0 if we have no debug registers or the
> + * number we have.

this would be easier to read phrased as "kvm_check_extension returns
the number of debug registers we have (which might be none)".

>   *
>   */
>  static void kvm_arm_init_debug(CPUState *cs)
>  {
>      have_guest_debug = kvm_check_extension(cs->kvm_state,
>                                             KVM_CAP_SET_GUEST_DEBUG);
> +
> +    max_hw_wps = kvm_check_extension(cs->kvm_state, KVM_CAP_GUEST_DEBUG_HW_WPS);
> +    hw_watchpoints = g_array_sized_new(true, true,
> +                                       sizeof(HWWatchpoint), max_hw_wps);
> +
> +    max_hw_bps = kvm_check_extension(cs->kvm_state, KVM_CAP_GUEST_DEBUG_HW_BPS);
> +    hw_breakpoints = g_array_sized_new(true, true,
> +                                       sizeof(HWBreakpoint), max_hw_bps);
>      return;
>  }
>
> +/**
> + * insert_hw_breakpoint()
> + * @addr: address of breakpoint
> + *
> + * See ARM ARM D2.9.1 for details but here we are only going to create
> + * simple un-linked breakpoints (i.e. we don't chain breakpoints
> + * together to match address and context or vmid). The hardware is
> + * capable of fancier matching but that will require exposing that
> + * fanciness to GDB's interface
> + *
> + * D7.3.2 DBGBCR<n>_EL1, Debug Breakpoint Control Registers
> + *
> + *  31  24 23  20 19   16 15 14  13  12   9 8   5 4    3 2   1  0
> + * +------+------+-------+-----+----+------+-----+------+-----+---+
> + * | RES0 |  BT  |  LBN  | SSC | HMC| RES0 | BAS | RES0 | PMC | E |
> + * +------+------+-------+-----+----+------+-----+------+-----+---+
> + *
> + * BT: Breakpoint type (0 = unlinked address match)
> + * LBN: Linked BP number (0 = unused)
> + * SSC/HMC/PMC: Security, Higher and Priv access control (Table D-12)
> + * BAS: Byte Address Select (RES1 for AArch64)
> + * E: Enable bit
> + */
> +static int insert_hw_breakpoint(target_ulong addr)
> +{
> +    HWBreakpoint brk = {
> +        .bcr = 0x1,                             /* BCR E=1, enable */
> +        .bvr = addr
> +    };
> +
> +    if (cur_hw_bps >= max_hw_bps) {
> +        return -ENOBUFS;
> +    }
> +
> +    brk.bcr = deposit32(brk.bcr, 1, 2, 0x3);   /* PMC = 11 */
> +    brk.bcr = deposit32(brk.bcr, 5, 4, 0xf);   /* BAS = RES1 */
> +
> +    g_array_append_val(hw_breakpoints, brk);
> +
> +    return 0;
> +}
> +
> +/**
> + * delete_hw_breakpoint()
> + * @pc: address of breakpoint
> + *
> + * Delete a breakpoint and shuffle any above down
> + */
> +
> +static int delete_hw_breakpoint(target_ulong pc)
> +{
> +    int i;
> +    for (i = 0; i < hw_breakpoints->len; i++) {
> +        HWBreakpoint *brk = get_hw_bp(i);
> +        if (brk->bvr == pc) {
> +            g_array_remove_index(hw_breakpoints, i);
> +            return 0;
> +        }
> +    }
> +    return -ENOENT;
> +}
> +
> +/**
> + * insert_hw_watchpoint()
> + * @addr: address of watch point
> + * @len: size of area
> + * @type: type of watch point
> + *
> + * See ARM ARM D2.10. As with the breakpoints we can do some advanced
> + * stuff if we want to. The watch points can be linked with the break
> + * points above to make them context aware. However for simplicity
> + * currently we only deal with simple read/write watch points.
> + *
> + * D7.3.11 DBGWCR<n>_EL1, Debug Watchpoint Control Registers
> + *
> + *  31  29 28   24 23  21  20  19 16 15 14  13   12  5 4   3 2   1  0
> + * +------+-------+------+----+-----+-----+-----+-----+-----+-----+---+
> + * | RES0 |  MASK | RES0 | WT | LBN | SSC | HMC | BAS | LSC | PAC | E |
> + * +------+-------+------+----+-----+-----+-----+-----+-----+-----+---+
> + *
> + * MASK: num bits addr mask (0=none,01/10=res,11=3 bits (8 bytes))
> + * WT: 0 - unlinked, 1 - linked (not currently used)
> + * LBN: Linked BP number (not currently used)
> + * SSC/HMC/PAC: Security, Higher and Priv access control (Table D2-11)
> + * BAS: Byte Address Select
> + * LSC: Load/Store control (01: load, 10: store, 11: both)
> + * E: Enable
> + *
> + * The bottom 2 bits of the value register are masked. Therefore to
> + * break on any sizes smaller than an unaligned word you need to set
> + * MASK=0, BAS=bit per byte in question. For larger regions (^2) you
> + * need to ensure you mask the address as required and set BAS=0xff
> + */
> +
> +static int insert_hw_watchpoint(target_ulong addr,
> +                                target_ulong len, int type)
> +{
> +    HWWatchpoint wp = {
> +        .wcr = 1, /* E=1, enable */
> +        .wvr = addr & (~0x7ULL),
> +        .details = { .vaddr = addr, .len = len}

Should at least have a space after "len".

> +    };
> +
> +    if (cur_hw_wps >= max_hw_wps) {
> +        return -ENOBUFS;
> +    }
> +
> +    /*
> +     * HMC=0 SSC=0 PAC=3 will hit EL0 or EL1, any security state,
> +     * valid whether EL3 is implemented or not
> +     */
> +    wp.wcr = deposit32(wp.wcr, 1, 2, 3);
> +
> +    switch (type) {
> +    case GDB_WATCHPOINT_READ:
> +        wp.wcr = deposit32(wp.wcr, 3, 2, 1);
> +        wp.details.flags = BP_MEM_READ;
> +        break;
> +    case GDB_WATCHPOINT_WRITE:
> +        wp.wcr = deposit32(wp.wcr, 3, 2, 2);
> +        wp.details.flags = BP_MEM_WRITE;
> +        break;
> +    case GDB_WATCHPOINT_ACCESS:
> +        wp.wcr = deposit32(wp.wcr, 3, 2, 3);
> +        wp.details.flags = BP_MEM_ACCESS;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +        break;
> +    }
> +    if (len <= 8) {
> +        /* we align the address and set the bits in BAS */
> +        int off = addr & 0x7;
> +        int bas = (1 << len)-1;

Missing spaces around operator "-" (here and below).

> +
> +        wp.wcr = deposit32(wp.wcr, 5 + off, 8 - off, bas);
> +    } else {
> +        /* For ranges above 8 bytes we need to be a power of 2 */
> +        if (is_power_of_2(len)) {
> +            int bits = ctz64(len);
> +
> +            wp.wvr &= ~((1 << bits)-1);
> +            wp.wcr = deposit32(wp.wcr, 24, 4, bits);
> +            wp.wcr = deposit32(wp.wcr, 5, 8, 0xff);
> +        } else {
> +            return -ENOBUFS;
> +        }
> +    }
> +
> +    g_array_append_val(hw_watchpoints, wp);
> +    return 0;
> +}
> +
> +
> +static bool check_watchpoint_in_range(int i, target_ulong addr)
> +{
> +    HWWatchpoint *wp = get_hw_wp(i);
> +    uint64_t addr_top, addr_bottom = wp->wvr;
> +    int bas = extract32(wp->wcr, 5, 8);
> +    int mask = extract32(wp->wcr, 24, 4);
> +
> +    if (mask) {
> +        addr_top = addr_bottom + (1 << mask);
> +    } else {
> +        /* BAS must be contiguous but can offset against the base
> +         * address in DBGWVR */
> +        addr_bottom = addr_bottom + ctz32(bas);
> +        addr_top = addr_bottom + clo32(bas);
> +    }
> +
> +    if (addr >= addr_bottom && addr <= addr_top) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +/**
> + * delete_hw_watchpoint()
> + * @addr: address of breakpoint
> + *
> + * Delete a breakpoint and shuffle any above down
> + */
> +
> +static int delete_hw_watchpoint(target_ulong addr,
> +                                target_ulong len, int type)
> +{
> +    int i;
> +    for (i = 0; i < cur_hw_wps; i++) {
> +        if (check_watchpoint_in_range(i, addr)) {
> +            g_array_remove_index(hw_watchpoints, i);
> +            return 0;
> +        }
> +    }
> +    return -ENOENT;
> +}
> +
> +
> +int kvm_arch_insert_hw_breakpoint(target_ulong addr,
> +                                  target_ulong len, int type)
> +{
> +    switch (type) {
> +    case GDB_BREAKPOINT_HW:
> +        return insert_hw_breakpoint(addr);
> +        break;
> +    case GDB_WATCHPOINT_READ:
> +    case GDB_WATCHPOINT_WRITE:
> +    case GDB_WATCHPOINT_ACCESS:
> +        return insert_hw_watchpoint(addr, len, type);
> +    default:
> +        return -ENOSYS;
> +    }
> +}
> +
> +int kvm_arch_remove_hw_breakpoint(target_ulong addr,
> +                                  target_ulong len, int type)
> +{
> +    switch (type) {
> +    case GDB_BREAKPOINT_HW:
> +        return delete_hw_breakpoint(addr);
> +        break;
> +    case GDB_WATCHPOINT_READ:
> +    case GDB_WATCHPOINT_WRITE:
> +    case GDB_WATCHPOINT_ACCESS:
> +        return delete_hw_watchpoint(addr, len, type);
> +    default:
> +        return -ENOSYS;
> +    }
> +}
> +
> +
> +void kvm_arch_remove_all_hw_breakpoints(void)
> +{
> +    if (cur_hw_wps > 0) {
> +        g_array_remove_range(hw_watchpoints, 0, cur_hw_wps);
> +    }
> +    if (cur_hw_bps > 0) {
> +        g_array_remove_range(hw_breakpoints, 0, cur_hw_bps);
> +    }
> +}
> +
> +void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr)
> +{
> +    int i;
> +    memset(ptr, 0, sizeof(struct kvm_guest_debug_arch));
> +
> +    for (i = 0; i < max_hw_wps; i++) {
> +        HWWatchpoint *wp = get_hw_wp(i);
> +        ptr->dbg_wcr[i] = wp->wcr;
> +        ptr->dbg_wvr[i] = wp->wvr;
> +    }
> +    for (i = 0; i < max_hw_bps; i++) {
> +        HWBreakpoint *bp = get_hw_bp(i);
> +        ptr->dbg_bcr[i] = bp->bcr;
> +        ptr->dbg_bvr[i] = bp->bvr;
> +    }
> +}
> +
> +bool kvm_arm_hw_debug_active(CPUState *cs)
> +{
> +    return ((cur_hw_wps > 0) || (cur_hw_bps > 0)) ? true : false;

You don't nede the ?: here.

> +}
> +
> +bool kvm_arm_find_hw_breakpoint(CPUState *cpu, target_ulong pc)
> +{
> +    if (kvm_arm_hw_debug_active(cpu)) {

Do we need to do this check? I think the loop condition
will DTRT if there aren't any current breakpoints.

> +        int i;
> +
> +        for (i = 0; i < cur_hw_bps; i++) {
> +            HWBreakpoint *bp = get_hw_bp(i);
> +            if (bp->bvr == pc) {
> +                return true;
> +            }
> +        }
> +    }
> +    return false;
> +}
> +
> +CPUWatchpoint *kvm_arm_find_hw_watchpoint(CPUState *cpu, target_ulong addr)
> +{
> +    if (kvm_arm_hw_debug_active(cpu)) {

Similarly here.

> +        int i;
> +
> +        for (i = 0; i < cur_hw_wps; i++) {
> +            if (check_watchpoint_in_range(i, addr)) {
> +                return &get_hw_wp(i)->details;
> +            }
> +        }
> +    }
> +    return NULL;
> +}
> +
> +
>  static inline void set_feature(uint64_t *features, int feature)
>  {
>      *features |= 1ULL << feature;
> diff --git a/target-arm/kvm_arm.h b/target-arm/kvm_arm.h
> index b516041..da88658 100644
> --- a/target-arm/kvm_arm.h
> +++ b/target-arm/kvm_arm.h
> @@ -215,4 +215,42 @@ static inline const char *gic_class_name(void)
>   */
>  const char *gicv3_class_name(void);
>
> +/**
> + * kvm_arm_hw_debug_active:
> + *
> + * Return TRUE is any hardware breakpoints in use.

"if".

> + */
> +
> +bool kvm_arm_hw_debug_active(CPUState *cs);
> +
> +/**
> + * kvm_arm_copy_hw_debug_data:
> + *
> + * @ptr: kvm_guest_debug_arch structure
> + *
> + * Copy the architecture specific debug registers into the
> + * kvm_guest_debug ioctl structure.
> + */
> +struct kvm_guest_debug_arch;
> +
> +void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr);
> +
> +/**
> + * kvm_arm_find_hw_breakpoint:
> + * @cpu: CPUState
> + * @pc: pc of breakpoint
> + *
> + * Return TRUE if the pc matches one of our breakpoints.
> + */
> +bool kvm_arm_find_hw_breakpoint(CPUState *cpu, target_ulong pc);
> +
> +/**
> + * kvm_arm_find_hw_watchpoint:
> + * @cpu: CPUState
> + * @addr: address of watchpoint
> + *
> + * Return the CPUWatchpoint structure the addr matches one of our watchpoints.

Missing "if" ? (or needs rephrasing)

> + */
> +CPUWatchpoint *kvm_arm_find_hw_watchpoint(CPUState *cpu, target_ulong addr);
> +
>  #endif
> --
> 2.6.3
>

thanks
-- PMM
