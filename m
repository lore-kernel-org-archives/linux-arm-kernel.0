From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 5 Jun 2013 18:29:21 -0700
Subject: [PATCH] ARM: avoid mis-detecting some V7 cores in the decompressor
In-Reply-To: <alpine.LFD.2.03.1306041751470.1200@syhkavp.arg>
References: <51AD0703.6050408@codeaurora.org>
 <20130603222321.GP18614@n2100.arm.linux.org.uk>
 <51AD1AB3.9050908@codeaurora.org>
 <20130603224555.GR18614@n2100.arm.linux.org.uk>
 <51AD1FE9.80709@codeaurora.org>
 <alpine.LFD.2.03.1306040032510.1200@syhkavp.arg>
 <20130604194705.GK599@codeaurora.org>
 <alpine.LFD.2.03.1306041559440.1200@syhkavp.arg>
 <20130604214501.GL599@codeaurora.org>
 <alpine.LFD.2.03.1306041751470.1200@syhkavp.arg>
Message-ID: <20130606012921.GO599@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04, Nicolas Pitre wrote:
> 
> The LC0 area should be considered read-only as it may be located in 
> flash.
> 
> Here's what I came with instead:
> 
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> Date: Tue, 4 Jun 2013 17:01:30 -0400
> Subject: [PATCH] ARM: zImage: don't overwrite ourself with a page table
> 
> When zImage is loaded into RAM at a low address but TEXT_OFFSET
> is set higher, we risk overwriting ourself with the page table
> needed to turn on the cache as it is located relative to the relocation
> address.  Let's defer the cache setup after relocation in that case.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Reported-by: Stephen Boyd <sboyd@codeurora.org>
Tested-by: Stephen Boyd <sboyd@codeurora.org>

This one passes testing on my two platforms with and without the
2Mb reservation at the beginning of ram. Seems like a good enough
compromise for me.

> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 9a94f344df..aa909393f2 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -182,7 +182,19 @@ not_angel:
>  		ldr	r4, =zreladdr
>  #endif
>  
> -		bl	cache_on
> +		/*
> +		 * Set up a page table only if it won't overwrite ourself.
> +		 * That means r4 < pc && r4 - 16k page directory > &_end.
> +		 * Given that r4 > &_en is most unfrequent, we add a rough

/s/_en/_end/

> +		 * additional 1MB of room for a possible appended DTB.
> +		 */
> +		mov	r0, pc
> +		cmp	r0, r4
> +		ldrcc	r0, LC0+32
> +		addcc	r0, r0, pc
> +		cmpcc	r4, r0
> +		orrcc	r4, r4, #1		@ remember we skipped cache_on
> +		blcs	cache_on
>  

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
