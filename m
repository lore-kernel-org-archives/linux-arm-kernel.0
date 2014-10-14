From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Oct 2014 20:18:47 +0100
Subject: [PATCHv3] arm: socfpga: fix fetching cpu1start_addr for SMP
In-Reply-To: <1413313448-5835-1-git-send-email-dinguyen@opensource.altera.com>
References: <1413313448-5835-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <20141014191847.GE27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 02:04:08PM -0500, dinguyen at opensource.altera.com wrote:
>  ENTRY(secondary_trampoline)
> -	movw	r2, #:lower16:cpu1start_addr
> -	movt  r2, #:upper16:cpu1start_addr
> -
> -	/* The socfpga VT cannot handle a 0xC0000000 page offset when loading
> -		the cpu1start_addr, we bit clear it. Tested on HW and VT. */
> -	bic	r2, r2, #0x40000000
> -
> -	ldr	r0, [r2]
> -	ldr	r1, [r0]
> -	bx	r1
> +	adr	r0, 1f
> +	ldmia	r0, {r1, r2}
> +	sub	r2, r2, #PAGE_OFFSET
> +	ldr	r3, [r2]
> +	ldr	r4, [r3]
> +	bx	r4
>  
> +	.align
> +1:	.long	.
> +	.long	socfpga_cpu1start_addr

I'm still not happy with this.

The old code used to take the socfpga_cpu1start_addr address (which will
probably have both bits 31 and 30 set), and clear bit 30.  That made the
address in the range of 0x80000000 - 0xbfffffff.

What you're doing above is taking the socfpga_cpu1start_addr address and
subtracting PAGE_OFFSET from it.  This will give an address in the
0x00000000 - 0x3fffffff range.

PAGE_OFFSET is *not* the offset between physical and virtual addresses.
It is the offset from _zero_ of the start of the kernel lowmem mapping.

In other words, if lowmem starts at 0xc0000000, then PAGE_OFFSET will be
0xc0000000 whether or not your physical memory starts at 0, 0x10000000,
0x40000000, 0x50000000 or whatever.

So, what this new code implies is that the start of physical memory is
at zero on this platform.  A comment to that effect in the code would
be nice so that people understand what's going on here, and also know
not to copy this code...

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
