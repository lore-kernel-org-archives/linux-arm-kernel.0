From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Dec 2011 21:57:36 +0000
Subject: arm and patch phys offset
In-Reply-To: <alpine.LFD.2.02.1112121627030.2907@xanadu.home>
References: <201112112255.32534.michael@walle.cc>
 <alpine.LFD.2.02.1112111935590.2907@xanadu.home>
 <201112122212.35506.michael@walle.cc>
 <alpine.LFD.2.02.1112121627030.2907@xanadu.home>
Message-ID: <20111212215736.GE20178@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 04:38:07PM -0500, Nicolas Pitre wrote:
> You could try instrumenting the patching code, although it is a bit 
> tricky because of the non-standard register life rules in that file.  
> But something like this should tell you if the expected amount of fixups 
> were applied:
> 
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 08c82fd844..7f43d1fe01 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -530,14 +530,23 @@ __fixup_a_pv_table:
>  	bcc	1b
>  	bx	lr
>  #else
> +	mov	r0, #0
>  	b	2f
>  1:	ldr	ip, [r7, r3]
>  	bic	ip, ip, #0x000000ff
>  	orr	ip, ip, r6	@ mask in offset bits 31-24
>  	str	ip, [r7, r3]
> +	add	r0, r0, #1
>  2:	cmp	r4, r5
>  	ldrcc	r7, [r4], #4	@ use branch for delay slot
>  	bcc	1b

If you look at this code, there is _no_ way it can fixup only some entries
in the table and not others - unless the CPU starts executing something
which isn't this code.

It quite simply loads the address of each entry in the table, incrementing
the pointer by a word size.  It then _unconditionally_ loads, modifies
and stores the instruction at the location in question.

The termination condition is when r4 >= r5, which will prevent the loading
of the next pointer _and_ prevent the looping, thus terminating the fixup
altogether.

So, something else is going on.  If I had to guess, I'd suspect the kernel
is being called with caches enabled - which violates the expectations of
the kernel set down many years ago.
