From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Dec 2015 17:42:32 +0000
Subject: [PATCH v3 10/10] arm64: kernel: Add support for
 hibernate/suspend-to-disk.
In-Reply-To: <1448559168-8363-11-git-send-email-james.morse@arm.com>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
 <1448559168-8363-11-git-send-email-james.morse@arm.com>
Message-ID: <20151215174231.GC24286@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 05:32:48PM +0000, James Morse wrote:
> +static int copy_page_tables(pgd_t *new_pgd, unsigned long start_addr)
> +{
> +	int i;
> +	int rc = 0;
> +	pud_t *new_pud;
> +	pgd_t *old_pgd = pgd_offset_k(start_addr);
> +
> +	new_pgd += pgd_index(start_addr);
> +
> +	for (i = pgd_index(start_addr); i < PTRS_PER_PGD;
> +	     i++, start_addr += PGDIR_SIZE, old_pgd++, new_pgd++) {
> +		if (!pgd_val(*old_pgd))
> +			continue;
> +
> +		if (PTRS_PER_PUD != 1) {
> +			new_pud = (pud_t *)get_safe_page(GFP_ATOMIC);
> +			if (!new_pud) {
> +				rc = -ENOMEM;
> +				break;
> +			}
> +
> +			set_pgd(new_pgd, __pgd(virt_to_phys(new_pud)
> +					       | PUD_TYPE_TABLE));
> +		}
> +
> +		rc = copy_pud(new_pgd, old_pgd, &start_addr);
> +		if (rc)
> +			break;
> +
> +		start_addr &= PGDIR_MASK;
> +	}
> +
> +	return rc;
> +}

I think you could implement the above with fewer lines if you followed a
common pattern for page table walking based on do...while(),
pgd_addr_end() etc. See copy_page_range() as a (more complex) example.

-- 
Catalin
