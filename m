From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 08 Nov 2011 08:54:35 -0800
Subject: [PATCH v8 15/16] ARM: LPAE: add support for ATAG_MEM64
In-Reply-To: <1320682618-1182-16-git-send-email-catalin.marinas@arm.com>
References: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
 <1320682618-1182-16-git-send-email-catalin.marinas@arm.com>
Message-ID: <4EB95ECB.8060905@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/7/2011 8:16 AM, Catalin Marinas wrote:
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 7e7977a..223af71 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -638,6 +638,29 @@ static int __init parse_tag_mem32(const struct tag *tag)
>  
>  __tagtable(ATAG_MEM, parse_tag_mem32);
>  
> +static int __init parse_tag_mem64(const struct tag *tag)
> +{
> +	/* We only use 32-bits for the size. */
> +	unsigned long size;
> +	phys_addr_t start, end;
> +
> +	start = tag->u.mem64.start;
> +	size = tag->u.mem64.size;
> +	end = start + size;
> +
> +	/* Ensure that the memory region is in range. */
> +	if (end & ~PHYS_MASK)
> +		pr_warning("Ignoring out-of-range mem64 tag (%.8llx-%.8llx)\n",

Can you add 0x (or #) here so we can see the 0x hex part?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
