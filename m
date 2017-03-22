From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:50:30 +0000
Subject: [RFC PATCH v2 00/41] Scalable Vector Extension (SVE) core support
Message-ID: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Scalable Vector Extension (SVE) [1] is an extension to AArch64 which
adds extra SIMD functionality and supports much larger vectors.

This series implements core Linux support for SVE.

Recipents not copied on the whole series can find the rest of the
patches in the linux-arm-kernel archives [2].

Major changes since v1: [3]

 * SVE vector length now configurable via prctl() and ptrace()
   (based on previously posted work [4]);

 * improved CPU feature detection to allow for mismatched CPUs;

 * dynamic allocation of per-task storage for the SVE registers.


There are a lot of outstanding issues that reviewers should be aware of,
including some design and implementation issues that I'd appreciate
input on.

Due to the length of the cover note, I've split it up as follows:

 * Missing Features and Limitations

 * ABI Design Issues
   (implementated interfaces that may need improvement)

 * Security
   (outstanding security-related design considerations)

 * Bugs and Implementation Issues
   (known and suspected problems with the implementation)


For reviewers, I recommend quickly skimming the remainder of this cover
note and the final (documentation) patch, before deciding what to focus
on in more detail.

Because of the length of the series, be aware that some code added by
earlier patches is substantially rewritten by later patches -- so also
look at the final result of applying the series before commenting
heavily on earlier additions.

Review and comments appreciated.

Cheers
---Dave

[1]
https://community.arm.com/groups/processors/blog/2016/08/22/technology-update-the-scalable-vector-extension-sve-for-the-armv8-a-architecture

[2]
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/thread.html
linux-arm-kernel archive

[3]
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/470507.html
[RFC PATCH 00/29] arm64: Scalable Vector Extension core support

[4]
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/478941.html
[RFC PATCH 00/10] arm64/sve: Add userspace vector length control API


Missing Features and Limitations
================================

Sparse vector length support
----------------------------

Currently, the code assumes that all possible vector lengths are
supported up to the maximum supported by the CPU.  The SVE architecture
doesn't require this, so it will be necessary to probe each possible VL
on every CPU and derive the set of common VLs after the secondaries come
up.

The patches don't currently implement this, which will cause incorrect
context save/restore and userspace malfunctions if a VL is configured
that the CPU implementation does not support.


KVM
---

Use of SVE by KVM guests is not supported yet.

SVE is still detected as present by guests due to the fact that
ID_AA64PFR0_EL1 is still read directly from the hardware, even by the
guest, so right now, a guest kernel configured with CONFIG_ARM64_SVE=y
will go into an illegal-instruction spin during early boot.

Sanitising the the ID registers for guests is a broader problem.  It may
be appropriate to implement a stopgap solution for SVE in the meantime,
either:

 * Require guests to be configured with CONFIG_ARM64_SVE=n, and kill
   affected guests instead of injecting an undef

   (not great)

 * Add a point hack for trapping the CPU ID regs and hiding (just) SVE
   from the guest.

   For one or two features this may be acceptable and this may serve as
   a stepping stone towards proper ID register sanitisation, but this
   approach won't scale well as the number of affected features
   increases over time.

 * Implement minimal KVM support a guest can at least boot and run,
   possibly suboptimally, if it uses SVE.  Full userspace ioctl()
   extensions for management of the guest VM's SVE support might be
   omitted to begin with.

   This is the cleanest approach, but involves would involve more work
   and might delay merge.


KERNEL_MODE_NEON (non-)support
------------------------------

"arm64/sve: [BROKEN] Basic support for KERNEL_MODE_NEON" is broken.
There are significant design issues here that need discussion -- see the
commit message for details.

Options:

 * Make KERNEL_MODE_NEON a runtime choice, and disable it if SVE is
   present.

 * Fully SVE-ise the KERNEL_MODE_NEON code: this will involve complexity
   and effort, and may involve unfavourable (and VL-dependent) tradeoffs
   compared with the no-SVE case.

   We will nonetheless need something like this if there is a desire to
   support "kernel mode SVE" in the future.  The fact that with SVE,
   KERNEL_MODE_NEON brings the cost of kernel-mode SVE but only the
   benefits of kernel-mode NEON argues in favour of this.

 * Make KERNEL_MODE_NEON a dynamic choice, and have clients run fallback
   C code instead if at runtime on a case-by-case basis, if SVE regs
   would otherwise need saving.

   This is an interface break, but all NEON-optimised kernel code
   necessarily requires a fallback C implementation to exist anyway, and
   the number of clients is not huge.

We could go for a stopgap solution that at least works but is suboptimal
for SVE systems (such as the first choice above), and then improve it
later.


ABI Design Issues
=================

Vector length handling in sigcontext
------------------------------------

Currently, the vector length is not saved/restored around signals: it
is not saved in the signal frame, and sigreturn is not allowed to
change it.

It would not be difficult to add this ability now, and retrofitting it
in the future instead would require a kernel upgrade and a mechanism for
new software to know whether it's available.

However, it's unclear whether this feature will	 ever truly be needed, or
should be encouraged.

During a normal sigreturn, restoration of the VL would only be needed if
the signal handler returned with a different VL configured than the one
it was called with -- something that PCS-compliant functions are
generally not supposed to do.

A non-local return, such as invoking some userspace bottom-half or
scheduler function, or dispatching a userspace exception, could
conceivably legitimately want to change VL.


Choices:

 * Implement and support this ability: fairly straightforward, but it
   may be abused by userspace (particularly if we can't decide until
   later what counts as "abuse").

 * Implement it but don't document it and maybe add a pr_info_once() to
   warn about future incompatibility if userspace uses it.

 * Don't implement it: a caller must use PR_SVE_SET_VL prior to return
   if it wants a VL change or to restore VL having previously changed it.
   (The caller must sweat the resulting safety issues itself.)


PR_GET_MINSIGSTKSZ (signal frame size discovery)
------------------------------------------------

(Not currently implemented, not 100% trivial to implement, but should be
fairly straightforward.)

It's not obvious whether the maximum possible frame size for the
_current_ thread configuration (e.g., current VL) should be reported, or
the maximum possible frame size irrespective of configuration.

I'd like to be able to hide this call behind sysconf(), which seems a
more natural and cleaner interface for userspace software than issuing
random prctls(), since there is nothing SVE-specific about the problem
of sizing stacks.  POSIX doesn't permit sysconf() values to vary over
the lifetime of a process, so this would require the configuration-
independent maximum frame size to be returned, but this may result in
the caller allocating more memory than is really needed.

Taking the system's maximum supported VL into account would mitigate
against this, since it's highly likely to be much smaller than
SVE_VL_MAX.


Reporting of supported vector lengths to userspace
--------------------------------------------------

Currently, the set of supported vector lengths and maximum vector length
are not directly reported to userspace.

Instead, userspace will need to probe by trying to set different vector
lengths and seeing what comes back.

This is unlikely to be a significant burden for now, and it could be
addressed later without backwards-incompatibility.


Maximum vector length
---------------------

For VL-setting interfaces (PR_SVE_SET_VL, ptrace, and possibly
sigreturn):

Is it reasonable to have a way to request "the maximum supported VL" via
these interfaces.  Up to now, I've assumed that this is reasonable and
useful, however...

Currently, SVE_VL_MAX is overloaded for this purpose, but this is
intended as an absolute limit encompassing future extensions to SVE --
i.e., this is the limit a remote debug protocol ought to scale up to,
for example.  Code compiled for the current SVE architecture is allowed
by the architecture to assume that VL <= 256, so requesting SVE_VL_MAX
may result in an impossibly large VL if executing on some future
hardware that supports vectors > 256 bytes.

This define should probably be forked in two, but confusion and misuse
seem highly likely.  Alternatively, the kernel could clamp VL to 256
bytes, and a future flag could be required in order to enable larger VLs
could be set.


PR_SVE_SET_VL interface
-----------------------

Should the arguments to this prctl be merged?

In other interfaces, the vl and flags are separate, but an obvious use
of PR_SVE_SET_VL would be to restore the configuration previously
discovered via PR_SVE_GET_VL, which rather ugly to do today.

Options include:

 * merging the PR_SVE_SET_VL arguments

 * provide macros to extract the arguments from the PR_SVE_GET_VL return
   value

 * migrate both prctls to using a struct containing vl and flags.


Vector length setting versus restoration
----------------------------------------

Currently, PTRACE_SETREGSET(NT_ARM_SVE) will fail by default on a
multithreaded target process, even if the vector length is not being
changed.  This can be avoided by OR-ing SVE_PT_VL_THREAD into
user_sve_header.flags before calling PTRACE_SETREGSET, to indicate "I
know what I'm doing".  But it's weird to have to do this when restoring
the VL to a value it had previously, or when leaving the VL unchanged.

A similar issue applies when calling PR_SVE_SET_VL based on the return
from a previous PR_SVE_GET_VL.  If sigreturn is extended to allow VL
changes, it would be affected too.

It's not obvious what the preferred semantics are here, or even if
they're the same in every case.

Options:

 * OR the _THREAD flag into the flags or result when reading the VL, as
   currently done for PR_SVE_SET_VL, but not for PTRACE_GETREGSET.

 * Require the caller to set this flag explicitly, even to restore the
   VL to something it was previously successfully set to.

and/or

 * Relax the behaviour not to treat VL setting without _THREAD as an
   error if the current VL for the thread already matches requested
   value.

Different interfaces might take different decisions about these (as at
present).


Coredump padding
----------------

Currently, the regset API and core ELF coredump implementation don't
allow for regsets to have a dynamic size.

NT_ARM_SVE is therefore declared with the theoretical maximum size based
on SVE_MAX_VL, which is ridiculously large.

This is relatively harmless, but it causes about a quarter of a megabyte
of useless padding to be written into the coredump for each thread.
Readers can skip this data, and software consuming coredumps usually
mmaps them rather then streaming them in, so this won't end the world.

I plan to add a regset method to discover the size at runtime, but for
now this is not implemented.


Security
========

Even though it's preferred to work with any vector length, it's
legitimate for code in userspace to prefer certain VLs, or only work
with or be optimised for certain VLs -- or only be tested against
certain VLs.

Thus, controlling the VL that code may execute with, while generally
useful, may have security implications when there is a change of
privilege.

At the moment, it's still unclear how much of this responsibility the
libc startup code should take on.  There may be merit in taking a
belt-and-braces approach in the kernel/user ABI, to at least apply some
sanity.

Thus:

 * A privilege-escalating execve() (i.e., execing a setuid/setgid binary
   or a binary that has filesystem capabilities set on it) could reset
   the VL to something "sane" instead of allowing the execve() caller to
   control it.

 * Currently, the system default VL (configured via
   /proc/cpu/sve_default_vl) is my best effort at defining a "sane" VL.
   This is writable only by root, but a decision needs to be made about
   the interaction of this control with containers.

Either each container needs its own version (cleanest option), or only
the root container should be able to configure it (simplest option).

(It would also be necessary to define how "container" should be defined
for this purpose).

Decisions will be needed on these issues -- neither is currently
addressed.


Bugs and Implementation Issues
==============================

Regarding the patches themselves, comment and review would be
particularly helpful on the following:

procfs
------

It feels wrong to implement /proc/cpu/sve_default_vl by hand (see patch
37), along with all the potential bugs, buffer overflows, and
behavioural inconsistencies this implies, for a rather trivial bit of
functionality.

This may not even belong in procfs at all, though sysfs doesn't seem
right either and there's no natural kobject to tie this control to.

If there's a better framework for this, I'm open to suggestions...


Race conditions
---------------

Because parts of the FPSIMD/SVE-code can preempt other parts on the back
of context switch or IRQ, various races can occur.

The following in particular need close scrutiny:

 * Access with preemption enabled, to anything touched by
   fpsimd_thread_switch()

 * Access with IRQs enabled, to anything touched by
   kernel_neon_begin{,_partial}()


SVE register flushing
---------------------

Synchronisation of the Z- (TIF_SVE, thread->sve_state) and V- (!TIF_SVE,
thread->fpsimd_state) views of the registers, and zeroing of the high
bits of the SVE Z-registers is not consistently applied in all cases.
This may lead to noncompliance with the SVE programmer's model whereby,
say,

	// syscall
	// ...
	ldr	v0, [x0]
	// ...
	// context switch
	// ...
	str	z0, [x1]

might not result in the high bits stored from z0 all being zero (which
the SVE programmer's model demands), or there may be other similarly
weird effects -- such behaviour would be a bug, but there may be
outstanding cases I've missed.


Context management
------------------

There are up to 4 views of a task's FPSIMD/SVE state
(thread->fpsimd_state, thread->sve_state, CPU smp_processor_id(), CPU
thread->fpsimd.cpu) and various synchronisations that need to occur at
various times.  The desire to minimise preemption/IRQ blackouts when
synchronising complicates matters further by enabling races to occur.

With the addition of SVE on top of KERNEL_MODE_NEON, the code to manage
coherence between these views has grown organically into something
haphazard and hard to reason about and maintain.

I'd like to redesign the way these interactions are abstracted -- any
suggestions are welcome.


Coredump synchronisation
------------------------

In a related, non-SVE-specific issue, the FPSIMD (and SVE) registers are
not necessarily synchronised when generating a coredump, which may
result in stale FPSIMD/SVE register values in the dump compared with the
actual register state at the time the process died.

The series currently makes no attempt to fix this.  A fix may be added,
or this may be handled separately.


Bugs
----

An older version of this series exhibited buggy context switch behaviour
under stress.  This has not been reproduced on any recent version of the
code, but the test environment is currently not reproducible (involving
experimental KVM support that is not portable to the current branch).

To date, the bug (or bugs) remain undiagnosed.  I have reason to belive
that there were multiple contributory bugs in the original code, and it
seems likely that they haven't all been fixed.

The possibility of a bug in the CPU simlation used to run the test has
also never been conclusively ruled out.

The failures:

 * were only ever observed in the host;

 * were only ever observed when running multiple guests, with all guest
   VCPUs busy and all;

 * were never observed to affect FPSIMD state, only the extra SVE state;

 * were never observed to leak data between tasks, between the kernel
   and userspace, or between host and guest;

 * did not seem to involve buffer overruns or memory corruption: high
   bits of SVE Z-registers, or (more rarely) P-registers or FFR would be
   unexpectedly replaced with zeros or stale data belonging to the same
   task.

Thus I have seen no evidence that suggests non-SVE systems can be
affected, but it's difficult to say for certain.

I have a strong suspicion that the complexity of the SVE/FPSIMD context
synchronisation code is the source of these issues, but this remains
unproven.


Alan Hayward (1):
  arm64/sve: ptrace support

Dave Martin (40):
  arm64: signal: Refactor sigcontext parsing in rt_sigreturn
  arm64: signal: factor frame layout and population into separate passes
  arm64: signal: factor out signal frame record allocation
  arm64: signal: Allocate extra sigcontext space as needed
  arm64: signal: Parse extra_context during sigreturn
  arm64: efi: Add missing Kconfig dependency on KERNEL_MODE_NEON
  arm64/sve: Allow kernel-mode NEON to be disabled in Kconfig
  arm64/sve: Low-level save/restore code
  arm64/sve: Boot-time feature detection and reporting
  arm64/sve: Boot-time feature enablement
  arm64/sve: Expand task_struct for Scalable Vector Extension state
  arm64/sve: Save/restore SVE state on context switch paths
  arm64/sve: [BROKEN] Basic support for KERNEL_MODE_NEON
  Revert "arm64/sve: Allow kernel-mode NEON to be disabled in Kconfig"
  arm64/sve: Restore working FPSIMD save/restore around signals
  arm64/sve: signal: Add SVE state record to sigcontext
  arm64/sve: signal: Dump Scalable Vector Extension registers to user
    stack
  arm64/sve: signal: Restore FPSIMD/SVE state in rt_sigreturn
  arm64/sve: Avoid corruption when replacing the SVE state
  arm64/sve: traps: Add descriptive string for SVE exceptions
  arm64/sve: Enable SVE on demand for userspace
  arm64/sve: Implement FPSIMD-only context for tasks not using SVE
  arm64/sve: Move ZEN handling to the common task_fpsimd_load() path
  arm64/sve: Discard SVE state on system call
  arm64/sve: Avoid preempt_disable() during sigreturn
  arm64/sve: Avoid stale user register state after SVE access exception
  arm64: KVM: Treat SVE use by guests as undefined instruction execution
  prctl: Add skeleton for PR_SVE_{SET,GET}_VL controls
  arm64/sve: Track vector length for each task
  arm64/sve: Set CPU vector length to match current task
  arm64/sve: Factor out clearing of tasks' SVE regs
  arm64/sve: Wire up vector length control prctl() calls
  arm64/sve: Disallow VL setting for individual threads by default
  arm64/sve: Add vector length inheritance control
  arm64/sve: ptrace: Wire up vector length control and reporting
  arm64/sve: Enable default vector length control via procfs
  arm64/sve: Detect SVE via the cpufeature framework
  arm64/sve: Migrate to cpucap based detection for runtime SVE code
  arm64/sve: Allocate task SVE context storage dynamically
  arm64/sve: Documentation: Add overview of the SVE userspace ABI

 Documentation/arm64/sve.txt              | 475 ++++++++++++++++++++++++
 arch/arm64/Kconfig                       |  12 +
 arch/arm64/include/asm/cpu.h             |   3 +
 arch/arm64/include/asm/cpucaps.h         |   3 +-
 arch/arm64/include/asm/cpufeature.h      |  13 +
 arch/arm64/include/asm/esr.h             |   3 +-
 arch/arm64/include/asm/fpsimd.h          |  72 ++++
 arch/arm64/include/asm/fpsimdmacros.h    | 150 ++++++++
 arch/arm64/include/asm/kvm_arm.h         |   1 +
 arch/arm64/include/asm/processor.h       |  14 +
 arch/arm64/include/asm/sysreg.h          |  15 +
 arch/arm64/include/asm/thread_info.h     |   2 +
 arch/arm64/include/uapi/asm/hwcap.h      |   1 +
 arch/arm64/include/uapi/asm/ptrace.h     | 130 +++++++
 arch/arm64/include/uapi/asm/sigcontext.h | 117 ++++++
 arch/arm64/kernel/cpufeature.c           |  39 ++
 arch/arm64/kernel/cpuinfo.c              |  14 +
 arch/arm64/kernel/entry-fpsimd.S         |  17 +
 arch/arm64/kernel/entry.S                |  18 +-
 arch/arm64/kernel/fpsimd.c               | 613 ++++++++++++++++++++++++++++++-
 arch/arm64/kernel/head.S                 |  15 +-
 arch/arm64/kernel/process.c              |   6 +-
 arch/arm64/kernel/ptrace.c               | 253 ++++++++++++-
 arch/arm64/kernel/setup.c                |   1 +
 arch/arm64/kernel/signal.c               | 500 +++++++++++++++++++++++--
 arch/arm64/kernel/signal32.c             |   2 +-
 arch/arm64/kernel/traps.c                |   1 +
 arch/arm64/kvm/handle_exit.c             |   8 +
 arch/arm64/mm/proc.S                     |  14 +-
 include/uapi/linux/elf.h                 |   1 +
 include/uapi/linux/prctl.h               |  11 +
 kernel/sys.c                             |  12 +
 32 files changed, 2474 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/arm64/sve.txt

-- 
2.1.4
