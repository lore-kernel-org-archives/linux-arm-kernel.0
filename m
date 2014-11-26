From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Nov 2014 13:52:10 +0000
Subject: [PATCH v3] arm: Support for the PXN CPU feature on ARMv7
In-Reply-To: <1417008840-27591-1-git-send-email-js07.lee@gmail.com>
References: <1417008840-27591-1-git-send-email-js07.lee@gmail.com>
Message-ID: <20141126135210.GJ3836@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 10:34:00PM +0900, Jungseung Lee wrote:
> +/*
> + * Once this call has completed the variable @vmsa is set to 'VMSA support'
> + * in case of ARMv7.
> + */
> +static inline bool cpu_has_classic_pxn(void)
> +{
> +	if (__LINUX_ARM_ARCH__ >= 6 && !IS_ENABLED(CONFIG_ARM_LPAE)) {
> +		static unsigned int vmsa = ~0UL;
> +
> +		if (cpu_architecture() != CPU_ARCH_ARMv7)
> +			return false;
> +		if (vmsa == 4)
> +			return true;
> +
> +		vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
> +		return vmsa == 4;
> +	} else
> +		return false;
> +}

Take a moment to consider whether this should be an inline function.  It's
rather complex, involves calling out to a function, reading a variable,
etc...

>  static inline void
>  pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
>  {
> -	__pmd_populate(pmdp, page_to_phys(ptep), _PAGE_USER_TABLE);
> +	pmdval_t pmdval = _PAGE_USER_TABLE;
> +
> +	if (cpu_has_classic_pxn())
> +		pmdval |= PMD_PXNTABLE;
> +	__pmd_populate(pmdp, page_to_phys(ptep), pmdval);
>  }
>  #define pmd_pgtable(pmd) pmd_page(pmd)

It's also used in another inline function.

Now, consider if we did this:

extern pmdval_t user_pmd_table;

static inline void
pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
{
	__pmd_populate(pmdp, page_to_phys(ptep), user_pmd_table);
}

This means that pmd_populate() only has to load the value instead, which
is far simpler.  All the setup complexity can live in build_mem_type_table()
which means that it only happens once, and we don't have to have checks
in these paths to see whether we've done that.

What would also be acceptable is to have the constant tests here, so the
compiler can eliminate the unnecessary load when we have no hope of ever
supporting PXN:

static inline void
pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
{
	pmdval_t prot;

	if (__LINUX_ARM_ARCH__ >= 6 && !IS_ENABLED(CONFIG_ARM_LPAE))
		prot = user_pmd_table;
	else
		prot = _PAGE_USER_TABLE;

	__pmd_populate(pmdp, page_to_phys(ptep), prot);
}

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
