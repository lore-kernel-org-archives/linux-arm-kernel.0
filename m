From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 5 Jan 2016 15:22:18 +0000
Subject: [PATCHv2 07/18] arm64: mm: add code to safely replace TTBR1_EL1
In-Reply-To: <1451930211-22460-8-git-send-email-mark.rutland@arm.com>
References: <1451930211-22460-1-git-send-email-mark.rutland@arm.com>
 <1451930211-22460-8-git-send-email-mark.rutland@arm.com>
Message-ID: <20160105152218.GH6301@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 05:56:40PM +0000, Mark Rutland wrote:
> +	.pushsection ".idmap.text", "ax"
> +/*
> + * void idmap_cpu_replace_ttbr1(phys_addr_t new_pgd, phys_addr_t reserved_pgd)
> + *
> + * This is the low-level counterpart to cpu_replace_ttbr1, and should not be
> + * called by anything else. It can only be executed from a TTBR0 mapping.
> + */
> +ENTRY(idmap_cpu_replace_ttbr1)
> +	mrs	x2, daif
> +	msr	daifset, #0xf
> +
> +	msr	ttbr1_el1, x1

Would it work to avoid the second argument and only use adrp, now that
empty_zero_page is at a fixed offset relative to this function?

-- 
Catalin
