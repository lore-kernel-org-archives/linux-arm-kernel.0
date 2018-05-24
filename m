From: will.deacon@arm.com (Will Deacon)
Date: Thu, 24 May 2018 13:49:21 +0100
Subject: [PATCH v4 2/2] arm64: signal: Report signal frame size to
 userspace via auxv
In-Reply-To: <1527097616-25214-3-git-send-email-Dave.Martin@arm.com>
References: <1527097616-25214-1-git-send-email-Dave.Martin@arm.com>
 <1527097616-25214-3-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180524124918.GG8689@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 06:46:56PM +0100, Dave Martin wrote:
> Stateful CPU architecture extensions may require the signal frame
> to grow to a size that exceeds the arch's MINSIGSTKSZ #define.
> However, changing this #define is an ABI break.
> 
> To allow userspace the option of determining the signal frame size
> in a more forwards-compatible way, this patch adds a new auxv entry
> tagged with AT_MINSIGSTKSZ, which provides the maximum signal frame
> size that the process can observe during its lifetime.
> 
> If AT_MINSIGSTKSZ is absent from the aux vector, the caller can
> assume that the MINSIGSTKSZ #define is sufficient.  This allows for
> a consistent interface with older kernels that do not provide
> AT_MINSIGSTKSZ.
> 
> The idea is that libc could expose this via sysconf() or some
> similar mechanism.
> 
> There is deliberately no AT_SIGSTKSZ.  The kernel knows nothing
> about userspace's own stack overheads and should not pretend to
> know.

[...]

> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index fac1c4d..9c18f0e 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -121,6 +121,9 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <linux/bug.h>
> +#include <asm/processor.h> /* for signal_minsigstksz, used by ARCH_DLINFO */
> +
>  typedef unsigned long elf_greg_t;
>  
>  #define ELF_NGREG (sizeof(struct user_pt_regs) / sizeof(elf_greg_t))
> @@ -148,6 +151,14 @@ typedef struct user_fpsimd_state elf_fpregset_t;
>  do {									\
>  	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
>  		    (elf_addr_t)current->mm->context.vdso);		\
> +									\
> +	/*								\
> +	 * Should always be nonzero unless there's a kernel bug.  If	\
> +	 * the we haven't determined a sensible value to give to	\

"If the we"?

> +	 * userspace, omit the entry:					\
> +	 */								\
> +	if (likely(signal_minsigstksz))					\
> +		NEW_AUX_ENT(AT_MINSIGSTKSZ, signal_minsigstksz);	\
>  } while (0)
>  
>  #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 7675989..65ab83e 100644
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
> +extern unsigned long __ro_after_init signal_minsigstksz; /* sigframe size */
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

Curious: but how do we avoid/detect conflicts at -rc1? I guess somebody just
needs to remember to run grep? (I know you have another series consolidating
the ID allocations).

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
> index 154b7d3..00b9990 100644
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
> @@ -591,8 +599,14 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
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
> +			vq = sve_vq_from_vl(vl);
> +		}
>  
>  		err = sigframe_alloc(user, &user->sve_offset,
>  				     SVE_SIG_CONTEXT_SIZE(vq));
> @@ -603,7 +617,6 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
>  	return sigframe_alloc_end(user);
>  }
>  
> -
>  static int setup_sigframe(struct rt_sigframe_user_layout *user,
>  			  struct pt_regs *regs, sigset_t *set)
>  {
> @@ -701,7 +714,7 @@ static int get_sigframe(struct rt_sigframe_user_layout *user,
>  	int err;
>  
>  	init_user_layout(user);
> -	err = setup_sigframe_layout(user);
> +	err = setup_sigframe_layout(user, false);
>  	if (err)
>  		return err;
>  
> @@ -936,3 +949,28 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
>  		thread_flags = READ_ONCE(current_thread_info()->flags);
>  	} while (thread_flags & _TIF_WORK_MASK);
>  }
> +
> +unsigned long __ro_after_init signal_minsigstksz;
> +
> +/*
> + * Determine the stack space required for guaranteed signal devliery.
> + * This function is used to populate AT_MINSIGSTKSZ at process startup.
> + * cpufeatures setup is assumed to be complete.
> + */
> +void __init minsigstksz_setup(void)
> +{
> +	struct rt_sigframe_user_layout user;
> +
> +	init_user_layout(&user);
> +
> +	/*
> +	 * If this fails, SIGFRAME_MAXSZ needs to be enlarged.  It won't
> +	 * be big enough, but it's our best guess:
> +	 */
> +	if (WARN_ON(setup_sigframe_layout(&user, true)))
> +		signal_minsigstksz = SIGFRAME_MAXSZ;

Can we not leave signal_minsigstksz as zero in this case?

Will
