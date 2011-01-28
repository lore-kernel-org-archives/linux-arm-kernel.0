From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Jan 2011 14:10:32 +0000
Subject: [PATCH v2] ARM: map ATAGs when not in first 1MB of RAM
In-Reply-To: <1296223246-2934-1-git-send-email-robherring2@gmail.com>
References: <1296223246-2934-1-git-send-email-robherring2@gmail.com>
Message-ID: <20110128141031.GB12976@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 28, 2011 at 08:00:46AM -0600, Rob Herring wrote:
> @@ -206,11 +206,17 @@ __create_page_tables:
>  #endif
>  
>  	/*
> -	 * Then map first 1MB of ram in case it contains our boot params.
> +	 * Then map boot params address in r2 or
> +	 * the first 1MB of ram if boot params address is not specified.
>  	 */
> -	add	r0, r4, #PAGE_OFFSET >> 18
> -	orr	r6, r7, r8
> -	str	r6, [r0]
> +	mov	r0, r2, lsr #20
> +	movs	r0, r0, lsl #20
> +	moveq	r0, r8
> +	sub	r3, r0, r8
> +	add	r3, r3, #PAGE_OFFSET
> +	add	r3, r4, r3, lsr #18
> +	orr	r6, r7, r0
> +	str	r6, [r3]

Wouldn't:
	str	r6, [r4, r3, lsr #18]
work here?
