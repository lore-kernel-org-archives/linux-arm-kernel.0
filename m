From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 25 Sep 2010 12:34:13 +0100
Subject: [PATCH] ARM: SECCOMP support
In-Reply-To: <alpine.LFD.2.00.1009231709230.13233@xanadu.home>
References: <alpine.LFD.2.00.1009231709230.13233@xanadu.home>
Message-ID: <20100925113413.GA3044@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 23, 2010 at 05:11:36PM -0400, Nicolas Pitre wrote:
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index f05a35a..cdd0a88 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -314,6 +314,16 @@ ENTRY(vector_swi)
>  	tst	ip, #_TIF_SYSCALL_TRACE		@ are we tracing syscalls?
>  	bne	__sys_trace
>  
> +#ifdef CONFIG_SECCOMP
> +	tst	ip, #_TIF_SECCOMP
> +	beq	1f
> +	mov	r0, scno
> +	bl	__secure_computing	
> +	add	r0, sp, #S_R0 + S_OFF		@ pointer to regs
> +	ldmia	r0, {r0 - r3}			@ have to reload r0 - r3
> +1:
> +#endif

Why not do this before the test for TIF_SYSCALL_TRACE?  You're doing
the same check in both paths, and x86 checks for secure computing
before any syscall tracing stuff.
