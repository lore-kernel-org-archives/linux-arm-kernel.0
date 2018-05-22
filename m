From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 May 2018 18:19:16 +0100
Subject: [PATCH v3] arm64: signal: Report signal frame size to userspace
 via auxv
In-Reply-To: <1526571941-9816-1-git-send-email-Dave.Martin@arm.com>
References: <1526571941-9816-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180522171916.GL26955@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Thu, May 17, 2018 at 04:45:41PM +0100, Dave Martin wrote:
> Stateful CPU architecture extensions may require the signal frame
> to grow to a size that exceeds the arch's MINSIGSTKSZ #define.
> However, changing this #define is an ABI break.

[...]

> For arm64 SVE:
> 
> The SVE context block in the signal frame needs to be considered
> too when computing the maximum possible signal frame size.
> 
> Because the size of this block depends on the vector length, this
> patch computes the size based not on the thread's current vector
> length but instead on the maximum possible vector length: this
> determines the maximum size of SVE context block that can be
> observed in any signal frame for the lifetime of the process.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Alex Benn?e <alex.bennee@linaro.org>
> 
> ---
> 
> Changes since v2:
> 
>  * Redefine AT_MINSIGSTKSZ as 51 to avoid clash with values defined by
>    other architectures.
> 
>    This turns out to be a problem for glibc; also random userspace
>    software does not necessary check the architecture before using
>    getauxval() or otherwise parsing the aux vector, which can make
>    aliased tags problematic.
> 
>    Really, the headers need cleaning up tree-wide in such away that the
>    AT_* definitions do not appear to be arch-private.  To be addressed
>    separately.
> ---
>  arch/arm64/include/asm/elf.h         | 11 ++++++++
>  arch/arm64/include/asm/processor.h   |  5 ++++
>  arch/arm64/include/uapi/asm/auxvec.h |  3 ++-
>  arch/arm64/kernel/cpufeature.c       |  1 +
>  arch/arm64/kernel/signal.c           | 51 +++++++++++++++++++++++++++++++-----
>  5 files changed, 63 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index fac1c4d..dc32adb 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -24,6 +24,11 @@
>  #include <asm/ptrace.h>
>  #include <asm/user.h>
>  
> +#ifndef __ASSEMBLY__
> +#include <linux/bug.h>
> +#include <asm/processor.h> /* for signal_minsigstksz, used by ARCH_DLINFO */
> +#endif

Maybe move these inside the pre-existing #ifndef __ASSEMBLY__ block.

>  /*
>   * AArch64 static relocation types.
>   */
> @@ -146,8 +151,14 @@ typedef struct user_fpsimd_state elf_fpregset_t;
>  /* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
>  #define ARCH_DLINFO							\
>  do {									\
> +	int minsigstksz = signal_minsigstksz;				\
> +									\
> +	if (WARN_ON(minsigstksz <= 0))					\
> +		minsigstksz = MINSIGSTKSZ;				\
> +									\

How can this happen?

>  	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
>  		    (elf_addr_t)current->mm->context.vdso);		\
> +	NEW_AUX_ENT(AT_MINSIGSTKSZ, minsigstksz);			\
>  } while (0)
>  
>  #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 7675989..6f60e92 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -35,6 +35,8 @@
>  #ifdef __KERNEL__
>  
>  #include <linux/build_bug.h>
> +#include <linux/cache.h>
> +#include <linux/init.h>
>  #include <linux/stddef.h>
>  #include <linux/string.h>
>  
> @@ -244,6 +246,9 @@ void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused);
>  void cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused);
>  void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused);
>  
> +extern int __ro_after_init signal_minsigstksz;	/* user signal frame size */

Probably better as unsigned long, to be consistent with the size field
of the sigframe user layout structure.

> +extern void __init minsigstksz_setup(void);
> +
>  /* Userspace interface for PR_SVE_{SET,GET}_VL prctl()s: */
>  #define SVE_SET_VL(arg)	sve_set_current_vl(arg)
>  #define SVE_GET_VL()	sve_get_current_vl()
> diff --git a/arch/arm64/include/uapi/asm/auxvec.h b/arch/arm64/include/uapi/asm/auxvec.h
> index ec0a86d..743c0b8 100644
> --- a/arch/arm64/include/uapi/asm/auxvec.h
> +++ b/arch/arm64/include/uapi/asm/auxvec.h
> @@ -19,7 +19,8 @@
>  
>  /* vDSO location */
>  #define AT_SYSINFO_EHDR	33
> +#define AT_MINSIGSTKSZ	51	/* stack needed for signal delivery */
>  
> -#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
> +#define AT_VECTOR_SIZE_ARCH 2 /* entries in ARCH_DLINFO */
>  
>  #endif
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9d1b06d..0e0b53d 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1619,6 +1619,7 @@ void __init setup_cpu_features(void)
>  		pr_info("emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching\n");
>  
>  	sve_setup();
> +	minsigstksz_setup();
>  
>  	/* Advertise that we have computed the system capabilities */
>  	set_sys_caps_initialised();
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 154b7d3..ae8d4ea 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -17,6 +17,7 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#include <linux/cache.h>
>  #include <linux/compat.h>
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
> @@ -570,8 +571,15 @@ asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
>  	return 0;
>  }
>  
> -/* Determine the layout of optional records in the signal frame */
> -static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
> +/*
> + * Determine the layout of optional records in the signal frame
> + *
> + * add_all: if true, lays out the biggest possible signal frame for
> + *	this task; otherwise, generates a layout for the current state
> + *	of the task.
> + */
> +static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
> +				 bool add_all)
>  {
>  	int err;
>  
> @@ -581,7 +589,7 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
>  		return err;
>  
>  	/* fault information, if valid */
> -	if (current->thread.fault_code) {
> +	if (add_all || current->thread.fault_code) {
>  		err = sigframe_alloc(user, &user->esr_offset,
>  				     sizeof(struct esr_context));
>  		if (err)
> @@ -591,8 +599,18 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
>  	if (system_supports_sve()) {
>  		unsigned int vq = 0;
>  
> -		if (test_thread_flag(TIF_SVE))
> -			vq = sve_vq_from_vl(current->thread.sve_vl);
> +		if (add_all || test_thread_flag(TIF_SVE)) {
> +			int vl = sve_max_vl;
> +
> +			if (!add_all)
> +				vl = current->thread.sve_vl;
> +
> +			/* Fail safe if something wasn't initialised */
> +			if (WARN_ON(!sve_vl_valid(vl)))
> +				vl = SVE_VL_MIN;

How can this happen?

> +
> +			vq = sve_vq_from_vl(vl);
> +		}
>  
>  		err = sigframe_alloc(user, &user->sve_offset,
>  				     SVE_SIG_CONTEXT_SIZE(vq));
> @@ -603,7 +621,6 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
>  	return sigframe_alloc_end(user);
>  }
>  
> -
>  static int setup_sigframe(struct rt_sigframe_user_layout *user,
>  			  struct pt_regs *regs, sigset_t *set)
>  {
> @@ -701,7 +718,7 @@ static int get_sigframe(struct rt_sigframe_user_layout *user,
>  	int err;
>  
>  	init_user_layout(user);
> -	err = setup_sigframe_layout(user);
> +	err = setup_sigframe_layout(user, false);
>  	if (err)
>  		return err;
>  
> @@ -936,3 +953,23 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
>  		thread_flags = READ_ONCE(current_thread_info()->flags);
>  	} while (thread_flags & _TIF_WORK_MASK);
>  }
> +
> +int __ro_after_init signal_minsigstksz;
> +
> +/*
> + * Determine the stack space required for guaranteed signal devliery.
> + * This function is used to populate AT_MINSIGSTKSZ at process startup.
> + */
> +void __init minsigstksz_setup(void)
> +{
> +	struct rt_sigframe_user_layout user;
> +
> +	init_user_layout(&user);
> +
> +	if (WARN_ON(setup_sigframe_layout(&user, true)))
> +		signal_minsigstksz = SIGSTKSZ;

Why not just omit the aux record in this case? Something has gone badly
wrong, so it's unlikely we're going to get much further anyway.

Will
