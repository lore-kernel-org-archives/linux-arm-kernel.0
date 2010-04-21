From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 21 Apr 2010 20:25:14 +0100
Subject: Simply disabling MMU in cpu_v7_reset doesn't work for kexec
In-Reply-To: <n2jf17812d71004210619qee8b8467u135fdbb44ff33049@mail.gmail.com>
References: <w2mf17812d71004210618vc68963cbn7ed50483a56140b7@mail.gmail.com>
	<n2jf17812d71004210619qee8b8467u135fdbb44ff33049@mail.gmail.com>
Message-ID: <20100421192514.GP27575@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao wrote:
> On Wed, Apr 21, 2010 at 9:18 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> > Tried the following simple code to disable MMU in cpu_v7_reset()
> > doesn't seem to work for kexec reboot. I was expecting the
> > following instructions after MMU is disabled are still reachable
> > in the instruction fetching pipe.
> 
> 	.align	5
>  ENTRY(cpu_v7_reset)
> +	mrc	p15, 0, r1, c1, c0, 0		@ ctrl register
> +	bic	r1, r1, #0x0001			@ ...............m
> +	mcr	p15, 0, r1, c1, c0, 0		@ disable MMU
> +	mcr	p15, 0, ip, c8, c7, 0		@ invalidate I and D TLBs
>  	mov	pc, r0
>  ENDPROC(cpu_v7_reset)

Judging by

    http://lists.infradead.org/pipermail/barebox/2010-January/000528.html

(Scroll down to the cache-armv7.c version)

Turning off the MMU might be a bit more complicated.

-- Jamie
