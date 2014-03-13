From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 Mar 2014 10:13:09 +0000
Subject: [PATCH] arm64: Add CONFIG_DEBUG_SET_MODULE_RONX support
In-Reply-To: <1394055789-31479-1-git-send-email-lauraa@codeaurora.org>
References: <1394055789-31479-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140313101308.GB30339@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Wed, Mar 05, 2014 at 09:43:09PM +0000, Laura Abbott wrote:
> +#define PTE_SET_FN(_name, pteop) \
> +static int pte_set_##_name(pte_t *ptep, pgtable_t token, unsigned long addr, \
> +			void *data) \
> +{ \
> +	pte_t pte = pteop(*ptep); \
> +\
> +	set_pte(ptep, pte); \
> +	return 0; \
> +} \
> +
> +#define SET_MEMORY_FN(_name, callback) \
> +int set_memory_##_name(unsigned long addr, int numpages) \
> +{ \
> +	unsigned long start = addr; \
> +	unsigned long size = PAGE_SIZE*numpages; \
> +	unsigned long end = start + size; \
> +\
> +	if (start < MODULES_VADDR || start >= MODULES_END) \
> +		return -EINVAL;\
> +\
> +	if (end < MODULES_VADDR || end >= MODULES_END) \
> +		return -EINVAL; \
> +\
> +	apply_to_page_range(&init_mm, start, size, callback, NULL); \
> +	flush_tlb_kernel_range(start, end); \
> +	return 0;\
> +}

The code seems correct but I don't really like this macro expansion. We
changed the pte_mk* functions already to inline functions, so we should
do the same with these set_memory_*() functions. Similar to s390, we
could have a change_module_page_attr() or have two set/clear functions
like x86 that just change the pte attribute (I think the latter allows
us to no longer define pte_mkexec etc).

Thanks.

-- 
Catalin
