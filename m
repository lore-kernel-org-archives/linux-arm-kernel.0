From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 30 Nov 2017 17:36:04 +0000
Subject: [PATCH v2 03/18] arm64: mm: Move ASID from TTBR0 to TTBR1
In-Reply-To: <1512059986-21325-4-git-send-email-will.deacon@arm.com>
References: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
 <1512059986-21325-4-git-send-email-will.deacon@arm.com>
Message-ID: <20171130173604.yjbbhnjvxgavaacz@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Thu, Nov 30, 2017 at 04:39:31PM +0000, Will Deacon wrote:
> In preparation for mapping kernelspace and userspace with different
> ASIDs, move the ASID to TTBR1 and update switch_mm to context-switch
> TTBR0 via an invalid mapping (the zero page).
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

[...]

> +#define cpu_switch_mm(pgd,mm)				\
> +do {							\
> +	BUG_ON(pgd == swapper_pg_dir);			\
> +	cpu_set_reserved_ttbr0();			\
> +	cpu_do_switch_mm(virt_to_phys(pgd),mm);		\
> +} while (0)

A minor thing, but could we please fix the spacing for the
cpu_do_switch_mm() arguments while we move this?

AFAICT, there's no reason this needs to be a macro, and the following
works with v4.15-rc1 defconfig:

static inline void cpu_switch_mm(pgd_t *pgd, struct mm_struct *mm)
{
	BUG_ON(pgd == swapper_pg_dir);
	cpu_set_reserved_ttbr0();
	cpu_do_switch_mm(virt_to_phys(pgd), mm);
}

Otherwise, the patch looks good to me.

Thanks,
Mark.
