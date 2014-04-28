From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Apr 2014 09:45:56 +0100
Subject: [RFC PATCH] arm64: make bitops 32-bit tolerant
In-Reply-To: <1398590477-15375-1-git-send-email-murzin.v@gmail.com>
References: <1398590477-15375-1-git-send-email-murzin.v@gmail.com>
Message-ID: <20140428084556.GA12090@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 27, 2014 at 10:21:17AM +0100, Vladimir Murzin wrote:
> Xen assumes that bit operations are able to operate on 32-bit size and
> alignment [1]. For arm64 bitops are based on atomic exclusive load/store
> instructions to guarantee that changes are made atomically. However, these
> instructions require that address to be aligned to the data size. Because, by
> default, bitops operates on 64-bit size it implies that address should be
> aligned appropriately. All these lead to breakage of Xen assumption for bitops
> properties.
> 
> This patch turns bitops to operate on 32-bit size/alignment.

Please stop sending this patch. I have _absolutely_ _no_ intention of
butchering our bitops in this way, and I don't think the Xen guys require
changing the core bitops like this either (certainly, Ian's last reply to
you suggested you should be doing this another way).

NAK.

Will

> [1] http://www.gossamer-threads.com/lists/xen/devel/325613
> 
> Cc: catalin.marinas at arm.com
> Cc: will.deacon at arm.com
> Cc: david.vrabel at citrix.com
> Cc: Ian.Campbell at citrix.com
> 
> Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
> ---
>  With this patch applied I was able to boot both Dom0 and DomU.
>  
>  @Pranav: Could I have your Tested-by on this patch?
>  
>  arch/arm64/lib/bitops.S          | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/lib/bitops.S b/arch/arm64/lib/bitops.S
> index 7dac371..a6acfff 100644
> --- a/arch/arm64/lib/bitops.S
> +++ b/arch/arm64/lib/bitops.S
> @@ -26,14 +26,14 @@
>   */
>  	.macro	bitop, name, instr
>  ENTRY(	\name	)
> -	and	w3, w0, #63		// Get bit offset
> +	and	w3, w0, #31		// Get bit offset
>  	eor	w0, w0, w3		// Clear low bits
>  	mov	x2, #1
>  	add	x1, x1, x0, lsr #3	// Get word offset
>  	lsl	x3, x2, x3		// Create mask
> -1:	ldxr	x2, [x1]
> -	\instr	x2, x2, x3
> -	stxr	w0, x2, [x1]
> +1:	ldxr	w2, [x1]
> +	\instr	w2, w2, w3
> +	stxr	w0, w2, [x1]
>  	cbnz	w0, 1b
>  	ret
>  ENDPROC(\name	)
> @@ -41,15 +41,15 @@ ENDPROC(\name	)
>  
>  	.macro	testop, name, instr
>  ENTRY(	\name	)
> -	and	w3, w0, #63		// Get bit offset
> +	and	w3, w0, #31		// Get bit offset
>  	eor	w0, w0, w3		// Clear low bits
>  	mov	x2, #1
>  	add	x1, x1, x0, lsr #3	// Get word offset
>  	lsl	x4, x2, x3		// Create mask
> -1:	ldxr	x2, [x1]
> +1:	ldxr	w2, [x1]
>  	lsr	x0, x2, x3		// Save old value of bit
> -	\instr	x2, x2, x4		// toggle bit
> -	stlxr	w5, x2, [x1]
> +	\instr	w2, w2, w4		// toggle bit
> +	stlxr	w5, w2, [x1]
>  	cbnz	w5, 1b
>  	dmb	ish
>  	and	x0, x0, #1
> -- 
> 1.8.3.2
> 
> 
