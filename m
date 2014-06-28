From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Jun 2014 10:53:14 +0100
Subject: [PATCH v7 7/9] ARM: add vdso user-space code
In-Reply-To: <1403493118-7597-8-git-send-email-nathan_lynch@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-8-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20140628095314.GC32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 22, 2014 at 10:11:56PM -0500, Nathan Lynch wrote:
> Place vdso-related user-space code in arch/arm/kernel/vdso/.
> 
> It is almost completely written in C with some assembly helpers to
> load the data page address, sample the counter, and fall back to
> system calls when necessary.
> 
> If CONFIG_ARM_ARCH_TIMER is not enabled, the vdso cannot service
> high-resolution clocks and falls back to syscalls.  Low-resolution
> clocks e.g. CLOCK_REALTIME_COARSE can be serviced regardless.
> 
> Of particular note is that a post-processing step ("vdsomunge") is
> necessary to produce a shared object which is architecturally allowed
> to be used by both soft- and hard-float EABI programs.
> 
> The 2012 edition of the ARM ABI defines Tag_ABI_VFP_args = 3 "Code is
> compatible with both the base and VFP variants; the user did not
> permit non-variadic functions to pass FP parameters/results."
> Unfortunately current toolchains do not support this tag, which is
> ideally what we would use.
> 
> The best available option is to ensure that both EF_ARM_ABI_FLOAT_SOFT
> and EF_ARM_ABI_FLOAT_HARD are unset in the ELF header's e_flags,
> indicating that the shared object is "old" and should be accepted for
> backward compatibility's sake.  While binutils < 2.24 appear to
> produce a vdso.so with both flags clear, 2.24 always sets
> EF_ARM_ABI_FLOAT_SOFT, with no way to inhibit this behavior.  So we
> have to fix things up with a custom post-processing step.
> 
> In fact, the VDSO code in glibc does much less validation (including
> checking these flags) than the code for handling conventional
> file-backed shared libraries, so this is a bit moot unless glibc's
> VDSO code becomes more strict.
> 
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> ---
>  arch/arm/kernel/asm-offsets.c        |   5 +
>  arch/arm/kernel/vdso/.gitignore      |   1 +
>  arch/arm/kernel/vdso/Makefile        |  59 +++++++
>  arch/arm/kernel/vdso/checkundef.sh   |   9 +
>  arch/arm/kernel/vdso/datapage.S      |  15 ++
>  arch/arm/kernel/vdso/vdso.S          |  35 ++++
>  arch/arm/kernel/vdso/vdso.lds.S      |  88 ++++++++++
>  arch/arm/kernel/vdso/vdsomunge.c     | 193 +++++++++++++++++++++
>  arch/arm/kernel/vdso/vgettimeofday.c | 320 +++++++++++++++++++++++++++++++++++
>  9 files changed, 725 insertions(+)
>  create mode 100644 arch/arm/kernel/vdso/.gitignore
>  create mode 100644 arch/arm/kernel/vdso/Makefile
>  create mode 100755 arch/arm/kernel/vdso/checkundef.sh
>  create mode 100644 arch/arm/kernel/vdso/datapage.S
>  create mode 100644 arch/arm/kernel/vdso/vdso.S
>  create mode 100644 arch/arm/kernel/vdso/vdso.lds.S
>  create mode 100644 arch/arm/kernel/vdso/vdsomunge.c
>  create mode 100644 arch/arm/kernel/vdso/vgettimeofday.c

One change I would like to see (to stop the directory tree getting soo
deep) is to move this to arch/arm/vdso - just like x86 is arch/x86/vdso.
Was there a pressing reason to have it in arch/arm/kernel ?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
