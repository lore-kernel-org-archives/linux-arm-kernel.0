From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Jul 2010 14:52:59 +0100
Subject: [RFC,PATCH 2/2] arm: use addruart macro to establish debug
	mappings
In-Reply-To: <1278903792.388155.428219242752.2.gpush@pororo>
References: <1278903792.387175.713057245098.0.gpush@pororo>
	<1278903792.388155.428219242752.2.gpush@pororo>
Message-ID: <20100712135259.GC6577@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 12, 2010 at 11:03:12AM +0800, Jeremy Kerr wrote:
> -	ldr	r3, [r8, #MACHINFO_PGOFFIO]
> +	mov	r3, #1
> +	addruart r3, r0
> +	lsr	r3, r3, #20
> +	lsl	r3, r3, #2
> +
>  	add	r0, r4, r3
>  	rsb	r3, r3, #0x4000			@ PTRS_PER_PGD*sizeof(long)
>  	cmp	r3, #0x0800			@ limit to 512MB
>  	movhi	r3, #0x0800
>  	add	r6, r0, r3
> -	ldr	r3, [r8, #MACHINFO_PHYSIO]
> +	mov	r3, #0
> +	addruart r3, r7

This is insufficient.  We are setting up section mappings here, which
must have both the physical and virtual addresses aligned to a megabyte
boundary.  You're aligning the virtual address but doing nothing with
the physical one.

I also agree with Nicolas - if we're going to do this, we want addruart
to return the virtual and physical addresses in two separate registers,
and then have the debug code select the appropriate one itself.  That
will simply this code.

So I suggest:

Patch #1 - re-jig addruart to return both virtual and physical addresses.
Patch #2 - implement setup of debug mapping using addruart.
Patch #3 - remove phys_io and pgoffio from machine_desc.

I'd also suggest that the patches are against a recent kernel, esp.
patch #3 as there's been some changes recently in some of the
initializers.
