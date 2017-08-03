From: Dave.Martin@arm.com (Dave Martin)
Date: Thu,  3 Aug 2017 17:23:18 +0100
Subject: [PATCH 0/5] Simplify kernel-mode NEON
Message-ID: <1501777403-9782-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series aims to simplify kernel-mode NEON.

This series is motivated by SVE, which adds cost and complexity to
management of kernel-mode NEON.  Since the most problematic features of
KMN don't bring a substantial benefit even without SVE, it makes sense
to simplify.

This series depends on [2] to provide the needed crypto algo C
fallbacks, which Herbert Xu already accepted into the crypto tree.

Boot- and boot-bisect tested on Juno r0.


Changes since RFC v4:

 * Flip confusing sense-inverted use of the "efi_fpsimd_state_used"
   percpu variable.

 * Restore bisectability by swapping patches 4 and 5.


Previous blurb:

The key changes are:

 * Kernel-mode NEON is no longer nestable.

 * Kernel-mode NEON is no longer permitted in hardirq or nmi context.

 * Users of kernel-mode NEON must now call may_use_simd(), to determine
   whether NEON may be used.  Since this function is no longer trivial
   and can return false, the caller must typically provide a fallback
   implementation of the optimised algoritm for this situation, or must
   otherwise defer the algorithm execution to another context where it
   can execute.

 * EFI runtime servies save/restore NEON to/from a dedicated percpu
   buffer if called in hardirq or nmi context.


This series depends on Ard's v4.14 crypto rework [2].

AFAIK, that series makes all the required changes to the arm64 crypto
library code.


Changes since RFC v3:

 * Rebased onto Ard's new series [2].

 * Added EFI helpers so that EFI runtime service use still works from
   interrupt context.

Changes since RFC v2:

 * Re-enable softirqs between kernel_neon_begin() and kernel_mode_end()

   (This was the original intention, but I was overtaken by irrational
   paranoia when drafting the previous version of the patch.)

 * softirq disable/enable is removed from fpsimd_thread_switch() (which
   runs with hardirqs disabled in any case, thus local_bh_enable() is
   treated as an error by the core code).  The comment block is updated
   to clarify this situation.

   This also means that no cost is added to the context switch critical
   path after all.

 * Move the this_cpu_write(fpsimd_last_state, NULL) back outside the
   conditional in kernel_neon_begin() (i.e., where it was originally
   before this series).  RFC v2 accidentally moved this invalidation
   inside the conditional, which leads to state corruption if switching
   back to a user task previously running on the same CPU, after
   kernel_mode_neon() is used by a kernel thread.

 * Minor formatting and spurious #include tidyups.

Testing:

 * For now, I've hacked linux/kernel/time/timer.c:run_timer_softirq() to
   call kernel_mode_neon_begin() and erase the FPSIMD registers, and
   jacked CONFIG_HZ to 1000.  I also added a test syscall that userspace
   can hammer to trigger the nested kernel_neon_begin() scenario.

   This is not hugely realistic, but was sufficient to diagnose the
   corruption problem described above, when running on a model.


Original blurb:

The main motivation for these changes is that supporting kernel-mode
NEON alongside SVE is tricky with the current framework: the current
partial save/restore mechanisms would need additional porting to
save/restore the extended SVE vector bits, and this renders the cost
saving of partial save/restore rather doubtful -- even if not all vector
registers are saved, the save/restore cost will still grow with
increasing vector length.  We could get the mechanics of this to work in
principle, but it doesn't feel like the right thing to do.

If we withdraw kernel-mode NEON support for hardirq context, accept some
extra softirq latency and disable nesting, then we can simplify the code
by always saving the task context directly into task_struct and
deferring all restore to ret_to_user.  Previous discussions with Ard
Biesheuvel suggest that this is a feasible approach and reasonably
aligned with other architectures.

The main impact on client code is that callers must check that
kernel-mode NEON is usable in the current context and fall back to a
non-NEON when necessary.  Ard has already done some work on this. [1]

The interesting changes are all in patch 2: the first patch just adds a
header inclusion guard that I noted was missing.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git kernel-mode-neon

[2] [PATCH resend 00/18] crypto: ARM/arm64 roundup for v4.14
lists.infradead.org/pipermail/linux-arm-kernel/2017-July/520664.html


Ard Biesheuvel (1):
  arm64: neon: replace generic definition of may_use_simd()

Dave Martin (4):
  arm64: neon: Add missing header guard in <asm/neon.h>
  arm64: fpsimd: Consistently use __this_cpu_ ops where appropriate
  arm64: neon: Allow EFI runtime services to use FPSIMD in irq context
  arm64: neon: Remove support for nested or hardirq kernel-mode NEON

 arch/arm64/include/asm/Kbuild         |   1 -
 arch/arm64/include/asm/efi.h          |   5 +-
 arch/arm64/include/asm/fpsimd.h       |  16 +---
 arch/arm64/include/asm/fpsimdmacros.h |  56 -----------
 arch/arm64/include/asm/neon.h         |   9 +-
 arch/arm64/include/asm/simd.h         |  54 +++++++++++
 arch/arm64/kernel/entry-fpsimd.S      |  24 -----
 arch/arm64/kernel/fpsimd.c            | 169 ++++++++++++++++++++++++++--------
 8 files changed, 197 insertions(+), 137 deletions(-)
 create mode 100644 arch/arm64/include/asm/simd.h

-- 
2.1.4
