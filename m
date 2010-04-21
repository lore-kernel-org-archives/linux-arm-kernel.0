From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Apr 2010 20:48:44 +0100
Subject: Simply disabling MMU in cpu_v7_reset doesn't work for kexec
In-Reply-To: <n2jf17812d71004210619qee8b8467u135fdbb44ff33049@mail.gmail.com>
References: <w2mf17812d71004210618vc68963cbn7ed50483a56140b7@mail.gmail.com>
	<n2jf17812d71004210619qee8b8467u135fdbb44ff33049@mail.gmail.com>
Message-ID: <20100421194844.GF26616@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 09:19:06PM +0800, Eric Miao wrote:
> On Wed, Apr 21, 2010 at 9:18 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> > Tried the following simple code to disable MMU in cpu_v7_reset() doesn't
> > seem to work for kexec reboot. I was expecting the following instructions
> > after MMU is disabled are still reachable in the instruction fetching pipe.
> >
> 
> 	.align	5
>  ENTRY(cpu_v7_reset)
> +	mrc	p15, 0, r1, c1, c0, 0		@ ctrl register
> +	bic	r1, r1, #0x0001			@ ...............m
> +	mcr	p15, 0, r1, c1, c0, 0		@ disable MMU
> +	mcr	p15, 0, ip, c8, c7, 0		@ invalidate I and D TLBs
>  	mov	pc, r0
>  ENDPROC(cpu_v7_reset)

The procedure expected here is:

1. invalidate caches
2. drain buffers
3. invalidate TLBs
4. disable MMU et.al.
5. jump to the address in r0.

The reason this is permitted is because cpu_v7_proc_fin _must_ be called
before hand, which is expected to disable all interrupts, and flush and
disable the caches.

It might be worth given the speculative behaviour of V7 to also invalidate
TLBs after a dsb and isb after step 4 instead of before step 4 - and (iirc)
also doing an isb after invalidating the TLBs.
