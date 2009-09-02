From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Sep 2009 14:24:23 +0100
Subject: [PATCH 2/2] ARM: copy_page.S: take into account the size of
	the cache line
In-Reply-To: <1251907913-16261-2-git-send-email-kirill@shutemov.name>
References: <1251907913-16261-1-git-send-email-kirill@shutemov.name>
	<1251907913-16261-2-git-send-email-kirill@shutemov.name>
Message-ID: <20090902132423.GA12595@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2009 at 07:11:53PM +0300, Kirill A. Shutemov wrote:
>  ENTRY(copy_page)
>  		stmfd	sp!, {r4, lr}			@	2
>  	PLD(	pld	[r1, #0]		)
> -	PLD(	pld	[r1, #32]		)
> +	PLD(	pld	[r1, #L1_CACHE_BYTES]		)
>  		mov	r2, #COPY_COUNT			@	1
>  		ldmia	r1!, {r3, r4, ip, lr}		@	4+1
> -1:	PLD(	pld	[r1, #64]		)
> -	PLD(	pld	[r1, #96]		)
> -2:		stmia	r0!, {r3, r4, ip, lr}		@	4
> -		ldmia	r1!, {r3, r4, ip, lr}		@	4+1
> -		stmia	r0!, {r3, r4, ip, lr}		@	4
> -		ldmia	r1!, {r3, r4, ip, lr}		@	4+1
> +1:	PLD(	pld	[r1, #(2*L1_CACHE_BYTES)])
> +	PLD(	pld	[r1, #(3*L1_CACHE_BYTES)])

I really hate unnecessary parens - please remove them, and put a space
each side of the '*'.

> +2:
> +	.rept	(2 * (L1_CACHE_BYTES) / 16 - 1)

Parens are not required around L1_CACHE_BYTES either.

Other than that, patch is fine.
