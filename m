From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 2 Feb 2011 16:54:52 -0500 (EST)
Subject: [PATCH] ARM: bitops: Fix low-level code to be Thumb-2 compatible
In-Reply-To: <20110202212449.GF31043@n2100.arm.linux.org.uk>
References: <1296672824-22743-1-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1102021421160.8580@xanadu.home>
	<20110202212449.GF31043@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1102021650040.8212@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Feb 2011, Russell King - ARM Linux wrote:

> On Wed, Feb 02, 2011 at 02:33:55PM -0500, Nicolas Pitre wrote:
> > On Wed, 2 Feb 2011, Dave Martin wrote:
> > 
> > > The new bitops code cunningly str <Rt>, [r1, -r1] to trigger
> > > a fault by attempting to store to address zero.
> > > 
> > > This code doesn't assemble in Thumb-2, since Thumb-2 doesn't
> > > allow negative register offsets at all for loads and stores.
> > > 
> > > The patch loads 0 into r2 and uses that as a base register
> > > instead for the Thumb-2 case: r2 seems non-live at every
> > > instance of this problem.
> > > 
> > > The ARM case is unaffected.
> > > 
> > > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > 
> > Russell proposed a better solution already:
> > 
> > http://mid.gmane.org/alpine.LFD.2.00.1101181312360.8580 at xanadu.home
> > 
> > No idea why this wasn't folded in his series yet though.
> 
> Now added, and original tested-by's dropped.  It now needs re-testing.
> 
> 8<----
> Subject: [PATCH] ARM: bitops: ensure set/clear/change bitops take a word-aligned pointer
> 
> Add additional instructions to our assembly bitops functions to ensure
> that they only operate on word-aligned pointers.  This will be necessary
> when we switch these operations to use the word-based exclusive
> operations.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested-by: Nicolas Pitre <nicolas.pitre@linaro.org>

And this has been tested by many people already as this is the version 
I've been carrying in the Linaro kernel tree for a while.




> ---
>  arch/arm/lib/bitops.h |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
> index d422529..bd00551 100644
> --- a/arch/arm/lib/bitops.h
> +++ b/arch/arm/lib/bitops.h
> @@ -1,6 +1,8 @@
>  
>  #if __LINUX_ARM_ARCH__ >= 6 && defined(CONFIG_CPU_32v6K)
>  	.macro	bitop, instr
> +	ands	ip, r1, #3
> +	strneb	r1, [ip]		@ assert word-aligned
>  	mov	r2, #1
>  	and	r3, r0, #7		@ Get bit offset
>  	add	r1, r1, r0, lsr #3	@ Get byte offset
> @@ -14,6 +16,8 @@
>  	.endm
>  
>  	.macro	testop, instr, store
> +	ands	ip, r1, #3
> +	strneb	r1, [ip]		@ assert word-aligned
>  	and	r3, r0, #7		@ Get bit offset
>  	mov	r2, #1
>  	add	r1, r1, r0, lsr #3	@ Get byte offset
> @@ -32,6 +36,8 @@
>  	.endm
>  #else
>  	.macro	bitop, instr
> +	ands	ip, r1, #3
> +	strneb	r1, [ip]		@ assert word-aligned
>  	and	r2, r0, #7
>  	mov	r3, #1
>  	mov	r3, r3, lsl r2
> @@ -52,6 +58,8 @@
>   * to avoid dirtying the data cache.
>   */
>  	.macro	testop, instr, store
> +	ands	ip, r1, #3
> +	strneb	r1, [ip]		@ assert word-aligned
>  	add	r1, r1, r0, lsr #3
>  	and	r3, r0, #7
>  	mov	r0, #1
> -- 
> 1.6.2.5
> 
