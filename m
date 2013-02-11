From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 11 Feb 2013 18:17:32 +0000
Subject: [PATCH] [RFC] arm: fix memset-related crashes caused by recent
 GCC (4.7.2) optimizations
In-Reply-To: <1359793988-6881-1-git-send-email-ivan.djelic@parrot.com>
References: <1359793988-6881-1-git-send-email-ivan.djelic@parrot.com>
Message-ID: <511935BC.8060105@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/13 08:33, Ivan Djelic wrote:
> Recent GCC versions (e.g. GCC-4.7.2) perform optimizations based on
> assumptions about the implementation of memset and similar functions.
> The current ARM optimized memset code does not return the value of
> its first argument, as is usually expected from standard implementations.
>
> For instance in the following function:
>
> void debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
> {
> 	memset(waiter, MUTEX_DEBUG_INIT, sizeof(*waiter));
> 	waiter->magic = waiter;
> 	INIT_LIST_HEAD(&waiter->list);
> }
>
> compiled as:
>
> 800554d0<debug_mutex_lock_common>:
> 800554d0:       e92d4008        push    {r3, lr}
> 800554d4:       e1a00001        mov     r0, r1
> 800554d8:       e3a02010        mov     r2, #16 ; 0x10
> 800554dc:       e3a01011        mov     r1, #17 ; 0x11
> 800554e0:       eb04426e        bl      80165ea0<memset>
> 800554e4:       e1a03000        mov     r3, r0
> 800554e8:       e583000c        str     r0, [r3, #12]
> 800554ec:       e5830000        str     r0, [r3]
> 800554f0:       e5830004        str     r0, [r3, #4]
> 800554f4:       e8bd8008        pop     {r3, pc}
>
> GCC assumes memset returns the value of pointer 'waiter' in register r0; causing
> register/memory corruptions.


> @@ -43,29 +47,28 @@ ENTRY(memset)
>   #if ! CALGN(1)+0
>
>   /*
> - * We need an extra register for this loop - save the return address and
> - * use the LR
> + * We need an 2 extra registers for this loop - use r8 and the LR
>    */
> -	str	lr, [sp, #-4]!
> -	mov	ip, r1
> +	stmfd	sp!, {r8, lr}
> +	mov	r8, r1
>   	mov	lr, r1

Out of interest, why not save {r0, lr} and avoid having to
re-write the entirety of the inner loop?

>
>   2:	subs	r2, r2, #64
> -	stmgeia	r0!, {r1, r3, ip, lr}	@ 64 bytes at a time.
> -	stmgeia	r0!, {r1, r3, ip, lr}
> -	stmgeia	r0!, {r1, r3, ip, lr}
> -	stmgeia	r0!, {r1, r3, ip, lr}
> +	stmgeia	ip!, {r1, r3, r8, lr}	@ 64 bytes at a time.
> +	stmgeia	ip!, {r1, r3, r8, lr}
> +	stmgeia	ip!, {r1, r3, r8, lr}
> +	stmgeia	ip!, {r1, r3, r8, lr}
>   	bgt	2b
> -	ldmeqfd	sp!, {pc}		@ Now<64 bytes to go.
> +	ldmeqfd	sp!, {r8, pc}		@ Now<64 bytes to go.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
