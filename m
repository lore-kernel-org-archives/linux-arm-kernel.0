From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 28 Mar 2013 14:58:32 -0700
Subject: [PATCH v3] ARM: add support for context tracking subsystem
In-Reply-To: <1364502344-12189-1-git-send-email-khilman@linaro.org> (Kevin
 Hilman's message of "Thu, 28 Mar 2013 13:25:44 -0700")
References: <1364502344-12189-1-git-send-email-khilman@linaro.org>
Message-ID: <871uaz425z.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@linaro.org> writes:

> commit 91d1aa43 (context_tracking: New context tracking susbsystem)
> generalized parts of the RCU userspace extended quiescent state into
> the context tracking subsystem.  Context tracking is then used
> to implement adaptive tickless (a.k.a extended nohz)
>
> To support the new context tracking subsystem on ARM, the user/kernel
> boundary transtions need to be instrumented.
>
> For exceptions and IRQs in usermode, the existing usr_entry macro is
> used to instrument the user->kernel transition.  For the return to
> usermode path, the ret_to_user* path is instrumented.  Using the
> usr_entry macro, this covers interrupts in userspace, data abort and
> prefetch abort exceptions in userspace as well as undefined exceptions
> in userspace (which is where FP emulation and VFP are handled.)
>
> For syscalls, the slow return path is covered by instrumenting the
> ret_to_user path.  In addition, the syscall entry point is
> instrumented which covers the user->kernel transition for both fast
> and slow syscalls, and an additional instrumentation point is added
> for the fast syscall return path (ret_fast_syscall).
>
> Cc: Mats Liljegren <mats.liljegren@enea.com>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>

This version has been submitted to Russell's patch tracker as patch
7688[1] after making the minor change below.

[...]

> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index 0f82098..3449d30 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -396,6 +396,7 @@ ENDPROC(__pabt_svc)
>  #ifdef CONFIG_IRQSOFF_TRACER
>  	bl	trace_hardirqs_off
>  #endif
> +	ct_user_exit, save = 0
>  	.endm

Removed the ',' after the macro here an elsewhere.  

It's harmless, but not needed and removing it makes this look like other
macro usage throughout.

Kevin

[1] http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7688/1
