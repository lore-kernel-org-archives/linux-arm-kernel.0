From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 20 Jun 2011 12:19:22 +0100
Subject: [PATCH 1/2] ARM: kuser: move interface documentation out of the
	source code
In-Reply-To: <1308502494-20938-2-git-send-email-nico@fluxnic.net>
References: <1308502494-20938-1-git-send-email-nico@fluxnic.net>
	<1308502494-20938-2-git-send-email-nico@fluxnic.net>
Message-ID: <20110620111922.GB2067@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 19, 2011 at 12:54:53PM -0400, Nicolas Pitre wrote:
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> Digging into some assembly file in order to get information about the
> kuser helpers is not that convivial.  Let's move that information to
> a better formatted file in Documentation/arm/ and improve on it a bit.
> 
> Thanks to Dave Martin <dave.martin@linaro.org> for the initial cleanup and
> clarifications.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Good to see this, thanks.

Since the technical content is mostly pasted from entry-armv.S, I asssume that
it is still correct.

Acked-by: Dave Martin <dave.martin@linaro.org>

> ---
>  Documentation/arm/kernel_user_helpers.txt |  204 +++++++++++++++++++++++++++++
>  arch/arm/kernel/entry-armv.S              |  152 +---------------------
>  2 files changed, 205 insertions(+), 151 deletions(-)
>  create mode 100644 Documentation/arm/kernel_user_helpers.txt
> 
> diff --git a/Documentation/arm/kernel_user_helpers.txt b/Documentation/arm/kernel_user_helpers.txt
> new file mode 100644
> index 0000000..fa42426
> --- /dev/null
> +++ b/Documentation/arm/kernel_user_helpers.txt
> @@ -0,0 +1,204 @@
> +Kernel-provided User Helpers
> +============================
> +
> +These are segment of kernel provided user code reachable from user space 
> +at a fixed address in kernel memory.  This is used to provide user space 
> +with some operations which require kernel help because of unimplemented 
> +native feature and/or instructions in many ARM CPUs. The idea is for this 
> +code to be executed directly in user mode for best efficiency but which is 
> +too intimate with the kernel counter part to be left to user libraries.  
> +In fact this code might even differ from one CPU to another depending on 
> +the available instruction set, or whether it is a SMP systems. In other 
> +words, the kernel reserves the right to change this code as needed without 
> +warning. Only the entry points and their results as documented here are 
> +guaranteed to be stable.
> +
> +This is different from (but doesn't preclude) a full blown VDSO 
> +implementation, however a VDSO would prevent some assembly tricks with 
> +constants that allows for efficient branching to those code segments. And 
> +since those code segments only use a few cycles before returning to user 
> +code, the overhead of a VDSO indirect far call would add a measurable 
> +overhead to such minimalistic operations.
> +
> +User space is expected to bypass those helpers and implement those things 
> +inline (either in the code emitted directly by the compiler, or part of 
> +the implementation of a library call) when optimizing for a recent enough 
> +processor that has the necessary native support, but only if resulting 
> +binaries are already to be incompatible with earlier ARM processors due to 
> +useage of similar native instructions for other things.  In other words 
> +don't make binaries unable to run on earlier processors just for the sake 
> +of not using these kernel helpers if your compiled code is not going to 
> +use new instructions for other purpose.
> +
> +New helpers may be added over time, so an older kernel may be missing some 
> +helpers present in a newer kernel.  For this reason, programs must check 
> +the value of __kuser_helper_version (see below) before assuming that it is 
> +safe to call any particular helper.  This check should ideally be 
> +performed only once at process startup time, and execution aborted early 
> +if the required helpers are not provided by the kernel version that 
> +process is running on.
> +
> +kuser_helper_version
> +--------------------
> +
> +Location:	0xffff0ffc
> +
> +Reference declaration:
> +
> +  extern int32_t __kuser_helper_version;
> +
> +Definition:
> +
> +  This field contains the number of helpers being implemented by the
> +  running kernel.  User space may read this to determine the availability
> +  of a particular helper.
> +
> +Usage example:
> +
> +#define __kuser_helper_version (*(int32_t *)0xffff0ffc)
> +
> +void check_kuser_version(void)
> +{
> +	if (__kuser_helper_version < 2) {
> +		fprintf(stderr, "can't do atomic operations, kernel too old\n");
> +		abort();
> +	}
> +}
> +
> +Notes:
> +
> +  User space may assume that the value of this field never changes
> +  during the lifetime of any single process.  This means that this
> +  field can be read once during the initialisation of a library or
> +  startup phase of a program.
> +
> +kuser_get_tls
> +-------------
> +
> +Location:	0xffff0fe0
> +
> +Reference prototype:
> +
> +  void * __kuser_get_tls(void);
> +
> +Input:
> +
> +  lr = return address
> +
> +Output:
> +
> +  r0 = TLS value
> +
> +Clobbered registers:
> +
> +  none
> +
> +Definition:
> +
> +  Get the TLS value as previously set via the __ARM_NR_set_tls syscall.
> +
> +Usage example:
> +
> +typedef void * (__kuser_get_tls_t)(void);
> +#define __kuser_get_tls (*(__kuser_get_tls_t *)0xffff0fe0)
> +
> +void foo()
> +{
> +	void *tls = __kuser_get_tls();
> +	printf("TLS = %p\n", tls);
> +}
> +
> +Notes:
> +
> +  - Valid only if __kuser_helper_version >= 1 (from kernel version 2.6.12).
> +
> +kuser_cmpxchg
> +-------------
> +
> +Location:	0xffff0fc0
> +
> +Reference prototype:
> +
> +  int __kuser_cmpxchg(int32_t oldval, int32_t newval, volatile int32_t *ptr);
> +
> +Input:
> +
> +  r0 = oldval
> +  r1 = newval
> +  r2 = ptr
> +  lr = return address
> +
> +Output:
> +
> +  r0 = success code (zero or non-zero)
> +  C flag = set if r0 == 0, clear if r0 != 0
> +
> +Clobbered registers:
> +
> +  r3, ip, flags
> +
> +Definition:
> +
> +  Atomically store newval in *ptr only if *ptr is equal to oldval.
> +  Return zero if *ptr was changed or non-zero if no exchange happened.
> +  The C flag is also set if *ptr was changed to allow for assembly
> +  optimization in the calling code.
> +
> +Usage example:
> +
> +typedef int (__kuser_cmpxchg_t)(int oldval, int newval, volatile int *ptr);
> +#define __kuser_cmpxchg (*(__kuser_cmpxchg_t *)0xffff0fc0)
> +
> +int atomic_add(volatile int *ptr, int val)
> +{
> +	int old, new;
> +
> +	do {
> +		old = *ptr;
> +		new = old + val;
> +	} while(__kuser_cmpxchg(old, new, ptr));
> +
> +	return new;
> +}
> +
> +Notes:
> +
> +  - This routine already includes memory barriers as needed.
> +
> +  - Valid only if __kuser_helper_version >= 2 (from kernel version 2.6.12).
> +
> +kuser_memory_barrier
> +--------------------
> +
> +Location:	0xffff0fa0
> +
> +Reference prototype:
> +
> +  void __kuser_memory_barrier(void);
> +
> +Input:
> +
> +  lr = return address
> +
> +Output:
> +
> +  none
> +
> +Clobbered registers:
> +
> +  none
> +
> +Definition:
> +
> +  Apply any needed memory barrier to preserve consistency with data modified
> +  manually and __kuser_cmpxchg usage.
> +
> +Usage example:
> +
> +typedef void (__kuser_dmb_t)(void);
> +#define __kuser_dmb (*(__kuser_dmb_t *)0xffff0fa0)
> +
> +Notes:
> +
> +  - Valid only if __kuser_helper_version >= 3 (from kernel version 2.6.15).
> +
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index 5d444b5..63f7907 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -754,36 +754,12 @@ ENDPROC(__switch_to)
>  /*
>   * User helpers.
>   *
> - * These are segment of kernel provided user code reachable from user space
> - * at a fixed address in kernel memory.  This is used to provide user space
> - * with some operations which require kernel help because of unimplemented
> - * native feature and/or instructions in many ARM CPUs. The idea is for
> - * this code to be executed directly in user mode for best efficiency but
> - * which is too intimate with the kernel counter part to be left to user
> - * libraries.  In fact this code might even differ from one CPU to another
> - * depending on the available  instruction set and restrictions like on
> - * SMP systems.  In other words, the kernel reserves the right to change
> - * this code as needed without warning. Only the entry points and their
> - * results are guaranteed to be stable.
> - *
>   * Each segment is 32-byte aligned and will be moved to the top of the high
>   * vector page.  New segments (if ever needed) must be added in front of
>   * existing ones.  This mechanism should be used only for things that are
>   * really small and justified, and not be abused freely.
>   *
> - * User space is expected to implement those things inline when optimizing
> - * for a processor that has the necessary native support, but only if such
> - * resulting binaries are already to be incompatible with earlier ARM
> - * processors due to the use of unsupported instructions other than what
> - * is provided here.  In other words don't make binaries unable to run on
> - * earlier processors just for the sake of not using these kernel helpers
> - * if your compiled code is not going to use the new instructions for other
> - * purpose.
> - *
> - * New helpers may be added over time, so an older kernel may be missing
> - * some helpers present in a newer kernel.  For this reason, programs
> - * must check the value of __kernel_helper_version (see below) before
> - * assuming that it is safe to call any particular helper.
> + * See Documentation/arm/kernel_user_helpers.txt for formal definitions.
>   */
>   THUMB(	.arm	)
>  
> @@ -799,93 +775,12 @@ ENDPROC(__switch_to)
>  	.globl	__kuser_helper_start
>  __kuser_helper_start:
>  
> -/*
> - * Reference prototype:
> - *
> - *	void __kernel_memory_barrier(void)
> - *
> - * Input:
> - *
> - *	lr = return address
> - *
> - * Output:
> - *
> - *	none
> - *
> - * Clobbered:
> - *
> - *	none
> - *
> - * Definition and user space usage example:
> - *
> - *	typedef void (__kernel_dmb_t)(void);
> - *	#define __kernel_dmb (*(__kernel_dmb_t *)0xffff0fa0)
> - *
> - * Apply any needed memory barrier to preserve consistency with data modified
> - * manually and __kuser_cmpxchg usage.
> - *
> - * Do not attempt to call this function unless __kernel_helper_version >= 3.
> - */
> -
>  __kuser_memory_barrier:				@ 0xffff0fa0
>  	smp_dmb	arm
>  	usr_ret	lr
>  
>  	.align	5
>  
> -/*
> - * Reference prototype:
> - *
> - *	int __kernel_cmpxchg(int oldval, int newval, int *ptr)
> - *
> - * Input:
> - *
> - *	r0 = oldval
> - *	r1 = newval
> - *	r2 = ptr
> - *	lr = return address
> - *
> - * Output:
> - *
> - *	r0 = returned value (zero or non-zero)
> - *	C flag = set if r0 == 0, clear if r0 != 0
> - *
> - * Clobbered:
> - *
> - *	r3, ip, flags
> - *
> - * Definition and user space usage example:
> - *
> - *	typedef int (__kernel_cmpxchg_t)(int oldval, int newval,
> - *					 int volatile *ptr);
> - *	#define __kernel_cmpxchg (*(__kernel_cmpxchg_t *)0xffff0fc0)
> - *
> - * Atomically store newval in *ptr if *ptr is equal to oldval for user space.
> - * Return zero if *ptr was changed or non-zero if no exchange happened.
> - * The C flag is also set if *ptr was changed to allow for assembly
> - * optimization in the calling code.
> - *
> - * Do not attempt to call this function unless __kernel_helper_version >= 2.
> - *
> - * Notes:
> - *
> - *    - This routine already includes memory barriers as needed.
> - *
> - * For example, a user space atomic_add implementation could look like this:
> - *
> - * int atomic_add(int volatile *ptr, int val)
> - * {
> - *	int newval;
> - *	do {
> - *		int oldval = *ptr;
> - *
> - *		newval = oldval + val;
> - *	while(__kernel_cmpxchg(oldval, newval, ptr));
> - *
> - *	return newval;
> - * }
> - */
> -
>  __kuser_cmpxchg:				@ 0xffff0fc0
>  
>  #if defined(CONFIG_NEEDS_SYSCALL_FOR_CMPXCHG)
> @@ -959,33 +854,6 @@ kuser_cmpxchg_fixup:
>  
>  	.align	5
>  
> -/*
> - * Reference prototype:
> - *
> - *	int __kernel_get_tls(void)
> - *
> - * Input:
> - *
> - *	lr = return address
> - *
> - * Output:
> - *
> - *	r0 = TLS value
> - *
> - * Clobbered:
> - *
> - *	none
> - *
> - * Definition and user space usage example:
> - *
> - *	typedef int (__kernel_get_tls_t)(void);
> - *	#define __kernel_get_tls (*(__kernel_get_tls_t *)0xffff0fe0)
> - *
> - * Get the TLS value as previously set via the __ARM_NR_set_tls syscall.
> - *
> - * Do not attempt to call this function unless __kernel_helper_version >= 1.
> - */
> -
>  __kuser_get_tls:				@ 0xffff0fe0
>  	ldr	r0, [pc, #(16 - 8)]	@ read TLS, set in kuser_get_tls_init
>  	usr_ret	lr
> @@ -994,24 +862,6 @@ __kuser_get_tls:				@ 0xffff0fe0
>  	.word	0			@ 0xffff0ff0 software TLS value, then
>  	.endr				@ pad up to __kuser_helper_version
>  
> -/*
> - * Reference declaration:
> - *
> - *	extern unsigned int __kernel_helper_version;
> - *
> - * Definition and user space usage example:
> - *
> - *	#define __kernel_helper_version (*(unsigned int *)0xffff0ffc)
> - *
> - * User space may read this to determine the curent number of helpers
> - * available.
> - *
> - * User space may assume that the value of this field never changes
> - * during the lifetime of any single process.  This means that this
> - * field can be read once during the initialisation of a library or
> - * startup phase of a program.
> - */
> -
>  __kuser_helper_version:				@ 0xffff0ffc
>  	.word	((__kuser_helper_end - __kuser_helper_start) >> 5)
>  
> -- 
> 1.7.4
> 
