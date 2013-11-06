From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 6 Nov 2013 15:26:09 +0000
Subject: [PATCH] arm64: enable EDAC on arm64
In-Reply-To: <1383742944-28059-1-git-send-email-robherring2@gmail.com>
References: <1383742944-28059-1-git-send-email-robherring2@gmail.com>
Message-ID: <20131106152608.GD979@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 01:02:24PM +0000, Rob Herring wrote:
> +static inline void atomic_scrub(void *va, u32 size)
> +{
> +	unsigned int *virt_addr = va;
> +	unsigned int temp, temp2;
> +	unsigned int i;
> +
> +	for (i = 0; i < size / sizeof(*virt_addr); i++, virt_addr++) {
> +		/*
> +		 * No need to check for store failure, another write means
> +		 * the scrubbing has effectively already been done for us.
> +		 */
> +		asm volatile("\n"
> +			"	ldxr	%0, %2\n"
> +			"	stxr	%w1, %0, %2\n"
> +			: "=&r" (temp), "=&r" (temp2), "+Q" (virt_addr)
> +			: : "cc");

But failure of stxr does not necessarily mean another write. It can be
an interrupt, cache line migration etc. The exclusive monitor can be
emulated in many ways.

BTW, can you not use 64-bit loads/stores?

-- 
Catalin
