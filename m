From: sstabellini@kernel.org (Stefano Stabellini)
Date: Thu, 1 Dec 2016 14:17:49 -0800 (PST)
Subject: [PATCH 2/2] arm64: xen: Split architecture-specific headers from
 32bit ARM
In-Reply-To: <1480589074-809-3-git-send-email-marc.zyngier@arm.com>
References: <1480589074-809-1-git-send-email-marc.zyngier@arm.com>
 <1480589074-809-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.10.1612011412120.2781@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Dec 2016, Marc Zyngier wrote:
> ARM and arm64 Xen ports share a number of headers, leading to
> packaging issues when these headers needs to be exported, as it
> breaks the reasonable requirement that an architecture port
> is standalone.
> 
> Solve the issue by copying the 5 header files over the arch
> barrier.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

I might be unhappy about making life more difficult for people building
out of tree modules (not really, but I can pretend), but copying the
headers over is not a solution. I really don't want two copies of them.

What does "standalone" mean in this context? What is the failure exactly?

If moving the headers out of arch/arm is necessary, then please move
them to another shared directory, maybe include/xen/arm.



>  arch/arm64/include/asm/xen/hypercall.h     |  88 ++++++++++++++++++++-
>  arch/arm64/include/asm/xen/hypervisor.h    |  40 +++++++++-
>  arch/arm64/include/asm/xen/interface.h     |  86 +++++++++++++++++++-
>  arch/arm64/include/asm/xen/page-coherent.h |  99 ++++++++++++++++++++++-
>  arch/arm64/include/asm/xen/page.h          | 123 ++++++++++++++++++++++++++++-
>  5 files changed, 431 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/xen/hypercall.h b/arch/arm64/include/asm/xen/hypercall.h
> index 74b0c42..9d874db 100644
> --- a/arch/arm64/include/asm/xen/hypercall.h
> +++ b/arch/arm64/include/asm/xen/hypercall.h
> @@ -1 +1,87 @@
> -#include <../../arm/include/asm/xen/hypercall.h>
> +/******************************************************************************
> + * hypercall.h
> + *
> + * Linux-specific hypervisor handling.
> + *
> + * Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Citrix, 2012
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation; or, when distributed
> + * separately from the Linux kernel or incorporated into other
> + * software packages, subject to the following license:
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this source file (the "Software"), to deal in the Software without
> + * restriction, including without limitation the rights to use, copy, modify,
> + * merge, publish, distribute, sublicense, and/or sell copies of the Software,
> + * and to permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
> + * IN THE SOFTWARE.
> + */
> +
> +#ifndef _ASM_ARM_XEN_HYPERCALL_H
> +#define _ASM_ARM_XEN_HYPERCALL_H
> +
> +#include <linux/bug.h>
> +
> +#include <xen/interface/xen.h>
> +#include <xen/interface/sched.h>
> +#include <xen/interface/platform.h>
> +
> +long privcmd_call(unsigned call, unsigned long a1,
> +		unsigned long a2, unsigned long a3,
> +		unsigned long a4, unsigned long a5);
> +int HYPERVISOR_xen_version(int cmd, void *arg);
> +int HYPERVISOR_console_io(int cmd, int count, char *str);
> +int HYPERVISOR_grant_table_op(unsigned int cmd, void *uop, unsigned int count);
> +int HYPERVISOR_sched_op(int cmd, void *arg);
> +int HYPERVISOR_event_channel_op(int cmd, void *arg);
> +unsigned long HYPERVISOR_hvm_op(int op, void *arg);
> +int HYPERVISOR_memory_op(unsigned int cmd, void *arg);
> +int HYPERVISOR_physdev_op(int cmd, void *arg);
> +int HYPERVISOR_vcpu_op(int cmd, int vcpuid, void *extra_args);
> +int HYPERVISOR_tmem_op(void *arg);
> +int HYPERVISOR_vm_assist(unsigned int cmd, unsigned int type);
> +int HYPERVISOR_platform_op_raw(void *arg);
> +static inline int HYPERVISOR_platform_op(struct xen_platform_op *op)
> +{
> +	op->interface_version = XENPF_INTERFACE_VERSION;
> +	return HYPERVISOR_platform_op_raw(op);
> +}
> +int HYPERVISOR_multicall(struct multicall_entry *calls, uint32_t nr);
> +
> +static inline int
> +HYPERVISOR_suspend(unsigned long start_info_mfn)
> +{
> +	struct sched_shutdown r = { .reason = SHUTDOWN_suspend };
> +
> +	/* start_info_mfn is unused on ARM */
> +	return HYPERVISOR_sched_op(SCHEDOP_shutdown, &r);
> +}
> +
> +static inline void
> +MULTI_update_va_mapping(struct multicall_entry *mcl, unsigned long va,
> +			unsigned int new_val, unsigned long flags)
> +{
> +	BUG();
> +}
> +
> +static inline void
> +MULTI_mmu_update(struct multicall_entry *mcl, struct mmu_update *req,
> +		 int count, int *success_count, domid_t domid)
> +{
> +	BUG();
> +}
> +
> +#endif /* _ASM_ARM_XEN_HYPERCALL_H */
> diff --git a/arch/arm64/include/asm/xen/hypervisor.h b/arch/arm64/include/asm/xen/hypervisor.h
> index f263da8..9525151 100644
> --- a/arch/arm64/include/asm/xen/hypervisor.h
> +++ b/arch/arm64/include/asm/xen/hypervisor.h
> @@ -1 +1,39 @@
> -#include <../../arm/include/asm/xen/hypervisor.h>
> +#ifndef _ASM_ARM_XEN_HYPERVISOR_H
> +#define _ASM_ARM_XEN_HYPERVISOR_H
> +
> +#include <linux/init.h>
> +
> +extern struct shared_info *HYPERVISOR_shared_info;
> +extern struct start_info *xen_start_info;
> +
> +/* Lazy mode for batching updates / context switch */
> +enum paravirt_lazy_mode {
> +	PARAVIRT_LAZY_NONE,
> +	PARAVIRT_LAZY_MMU,
> +	PARAVIRT_LAZY_CPU,
> +};
> +
> +static inline enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
> +{
> +	return PARAVIRT_LAZY_NONE;
> +}
> +
> +extern struct dma_map_ops *xen_dma_ops;
> +
> +#ifdef CONFIG_XEN
> +void __init xen_early_init(void);
> +#else
> +static inline void xen_early_init(void) { return; }
> +#endif
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +static inline void xen_arch_register_cpu(int num)
> +{
> +}
> +
> +static inline void xen_arch_unregister_cpu(int num)
> +{
> +}
> +#endif
> +
> +#endif /* _ASM_ARM_XEN_HYPERVISOR_H */
> diff --git a/arch/arm64/include/asm/xen/interface.h b/arch/arm64/include/asm/xen/interface.h
> index 44457ae..75d5968 100644
> --- a/arch/arm64/include/asm/xen/interface.h
> +++ b/arch/arm64/include/asm/xen/interface.h
> @@ -1 +1,85 @@
> -#include <../../arm/include/asm/xen/interface.h>
> +/******************************************************************************
> + * Guest OS interface to ARM Xen.
> + *
> + * Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Citrix, 2012
> + */
> +
> +#ifndef _ASM_ARM_XEN_INTERFACE_H
> +#define _ASM_ARM_XEN_INTERFACE_H
> +
> +#include <linux/types.h>
> +
> +#define uint64_aligned_t uint64_t __attribute__((aligned(8)))
> +
> +#define __DEFINE_GUEST_HANDLE(name, type) \
> +	typedef struct { union { type *p; uint64_aligned_t q; }; }  \
> +        __guest_handle_ ## name
> +
> +#define DEFINE_GUEST_HANDLE_STRUCT(name) \
> +	__DEFINE_GUEST_HANDLE(name, struct name)
> +#define DEFINE_GUEST_HANDLE(name) __DEFINE_GUEST_HANDLE(name, name)
> +#define GUEST_HANDLE(name)        __guest_handle_ ## name
> +
> +#define set_xen_guest_handle(hnd, val)			\
> +	do {						\
> +		if (sizeof(hnd) == 8)			\
> +			*(uint64_t *)&(hnd) = 0;	\
> +		(hnd).p = val;				\
> +	} while (0)
> +
> +#define __HYPERVISOR_platform_op_raw __HYPERVISOR_platform_op
> +
> +#ifndef __ASSEMBLY__
> +/* Explicitly size integers that represent pfns in the interface with
> + * Xen so that we can have one ABI that works for 32 and 64 bit guests.
> + * Note that this means that the xen_pfn_t type may be capable of
> + * representing pfn's which the guest cannot represent in its own pfn
> + * type. However since pfn space is controlled by the guest this is
> + * fine since it simply wouldn't be able to create any sure pfns in
> + * the first place.
> + */
> +typedef uint64_t xen_pfn_t;
> +#define PRI_xen_pfn "llx"
> +typedef uint64_t xen_ulong_t;
> +#define PRI_xen_ulong "llx"
> +typedef int64_t xen_long_t;
> +#define PRI_xen_long "llx"
> +/* Guest handles for primitive C types. */
> +__DEFINE_GUEST_HANDLE(uchar, unsigned char);
> +__DEFINE_GUEST_HANDLE(uint,  unsigned int);
> +DEFINE_GUEST_HANDLE(char);
> +DEFINE_GUEST_HANDLE(int);
> +DEFINE_GUEST_HANDLE(void);
> +DEFINE_GUEST_HANDLE(uint64_t);
> +DEFINE_GUEST_HANDLE(uint32_t);
> +DEFINE_GUEST_HANDLE(xen_pfn_t);
> +DEFINE_GUEST_HANDLE(xen_ulong_t);
> +
> +/* Maximum number of virtual CPUs in multi-processor guests. */
> +#define MAX_VIRT_CPUS 1
> +
> +struct arch_vcpu_info { };
> +struct arch_shared_info { };
> +
> +/* TODO: Move pvclock definitions some place arch independent */
> +struct pvclock_vcpu_time_info {
> +	u32   version;
> +	u32   pad0;
> +	u64   tsc_timestamp;
> +	u64   system_time;
> +	u32   tsc_to_system_mul;
> +	s8    tsc_shift;
> +	u8    flags;
> +	u8    pad[2];
> +} __attribute__((__packed__)); /* 32 bytes */
> +
> +/* It is OK to have a 12 bytes struct with no padding because it is packed */
> +struct pvclock_wall_clock {
> +	u32   version;
> +	u32   sec;
> +	u32   nsec;
> +	u32   sec_hi;
> +} __attribute__((__packed__));
> +#endif
> +
> +#endif /* _ASM_ARM_XEN_INTERFACE_H */
> diff --git a/arch/arm64/include/asm/xen/page-coherent.h b/arch/arm64/include/asm/xen/page-coherent.h
> index 2052102..95ce6ac 100644
> --- a/arch/arm64/include/asm/xen/page-coherent.h
> +++ b/arch/arm64/include/asm/xen/page-coherent.h
> @@ -1 +1,98 @@
> -#include <../../arm/include/asm/xen/page-coherent.h>
> +#ifndef _ASM_ARM_XEN_PAGE_COHERENT_H
> +#define _ASM_ARM_XEN_PAGE_COHERENT_H
> +
> +#include <asm/page.h>
> +#include <linux/dma-mapping.h>
> +
> +void __xen_dma_map_page(struct device *hwdev, struct page *page,
> +	     dma_addr_t dev_addr, unsigned long offset, size_t size,
> +	     enum dma_data_direction dir, unsigned long attrs);
> +void __xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
> +		size_t size, enum dma_data_direction dir,
> +		unsigned long attrs);
> +void __xen_dma_sync_single_for_cpu(struct device *hwdev,
> +		dma_addr_t handle, size_t size, enum dma_data_direction dir);
> +
> +void __xen_dma_sync_single_for_device(struct device *hwdev,
> +		dma_addr_t handle, size_t size, enum dma_data_direction dir);
> +
> +static inline void *xen_alloc_coherent_pages(struct device *hwdev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t flags, unsigned long attrs)
> +{
> +	return __generic_dma_ops(hwdev)->alloc(hwdev, size, dma_handle, flags, attrs);
> +}
> +
> +static inline void xen_free_coherent_pages(struct device *hwdev, size_t size,
> +		void *cpu_addr, dma_addr_t dma_handle, unsigned long attrs)
> +{
> +	__generic_dma_ops(hwdev)->free(hwdev, size, cpu_addr, dma_handle, attrs);
> +}
> +
> +static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
> +	     dma_addr_t dev_addr, unsigned long offset, size_t size,
> +	     enum dma_data_direction dir, unsigned long attrs)
> +{
> +	unsigned long page_pfn = page_to_xen_pfn(page);
> +	unsigned long dev_pfn = XEN_PFN_DOWN(dev_addr);
> +	unsigned long compound_pages =
> +		(1<<compound_order(page)) * XEN_PFN_PER_PAGE;
> +	bool local = (page_pfn <= dev_pfn) &&
> +		(dev_pfn - page_pfn < compound_pages);
> +
> +	/*
> +	 * Dom0 is mapped 1:1, while the Linux page can span across
> +	 * multiple Xen pages, it's not possible for it to contain a
> +	 * mix of local and foreign Xen pages. So if the first xen_pfn
> +	 * == mfn the page is local otherwise it's a foreign page
> +	 * grant-mapped in dom0. If the page is local we can safely
> +	 * call the native dma_ops function, otherwise we call the xen
> +	 * specific function.
> +	 */
> +	if (local)
> +		__generic_dma_ops(hwdev)->map_page(hwdev, page, offset, size, dir, attrs);
> +	else
> +		__xen_dma_map_page(hwdev, page, dev_addr, offset, size, dir, attrs);
> +}
> +
> +static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	unsigned long pfn = PFN_DOWN(handle);
> +	/*
> +	 * Dom0 is mapped 1:1, while the Linux page can be spanned accross
> +	 * multiple Xen page, it's not possible to have a mix of local and
> +	 * foreign Xen page. Dom0 is mapped 1:1, so calling pfn_valid on a
> +	 * foreign mfn will always return false. If the page is local we can
> +	 * safely call the native dma_ops function, otherwise we call the xen
> +	 * specific function.
> +	 */
> +	if (pfn_valid(pfn)) {
> +		if (__generic_dma_ops(hwdev)->unmap_page)
> +			__generic_dma_ops(hwdev)->unmap_page(hwdev, handle, size, dir, attrs);
> +	} else
> +		__xen_dma_unmap_page(hwdev, handle, size, dir, attrs);
> +}
> +
> +static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
> +		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> +{
> +	unsigned long pfn = PFN_DOWN(handle);
> +	if (pfn_valid(pfn)) {
> +		if (__generic_dma_ops(hwdev)->sync_single_for_cpu)
> +			__generic_dma_ops(hwdev)->sync_single_for_cpu(hwdev, handle, size, dir);
> +	} else
> +		__xen_dma_sync_single_for_cpu(hwdev, handle, size, dir);
> +}
> +
> +static inline void xen_dma_sync_single_for_device(struct device *hwdev,
> +		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> +{
> +	unsigned long pfn = PFN_DOWN(handle);
> +	if (pfn_valid(pfn)) {
> +		if (__generic_dma_ops(hwdev)->sync_single_for_device)
> +			__generic_dma_ops(hwdev)->sync_single_for_device(hwdev, handle, size, dir);
> +	} else
> +		__xen_dma_sync_single_for_device(hwdev, handle, size, dir);
> +}
> +
> +#endif /* _ASM_ARM_XEN_PAGE_COHERENT_H */
> diff --git a/arch/arm64/include/asm/xen/page.h b/arch/arm64/include/asm/xen/page.h
> index bed87ec..415dbc6 100644
> --- a/arch/arm64/include/asm/xen/page.h
> +++ b/arch/arm64/include/asm/xen/page.h
> @@ -1 +1,122 @@
> -#include <../../arm/include/asm/xen/page.h>
> +#ifndef _ASM_ARM_XEN_PAGE_H
> +#define _ASM_ARM_XEN_PAGE_H
> +
> +#include <asm/page.h>
> +#include <asm/pgtable.h>
> +
> +#include <linux/pfn.h>
> +#include <linux/types.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <xen/xen.h>
> +#include <xen/interface/grant_table.h>
> +
> +#define phys_to_machine_mapping_valid(pfn) (1)
> +
> +/* Xen machine address */
> +typedef struct xmaddr {
> +	phys_addr_t maddr;
> +} xmaddr_t;
> +
> +/* Xen pseudo-physical address */
> +typedef struct xpaddr {
> +	phys_addr_t paddr;
> +} xpaddr_t;
> +
> +#define XMADDR(x)	((xmaddr_t) { .maddr = (x) })
> +#define XPADDR(x)	((xpaddr_t) { .paddr = (x) })
> +
> +#define INVALID_P2M_ENTRY      (~0UL)
> +
> +/*
> + * The pseudo-physical frame (pfn) used in all the helpers is always based
> + * on Xen page granularity (i.e 4KB).
> + *
> + * A Linux page may be split across multiple non-contiguous Xen page so we
> + * have to keep track with frame based on 4KB page granularity.
> + *
> + * PV drivers should never make a direct usage of those helpers (particularly
> + * pfn_to_gfn and gfn_to_pfn).
> + */
> +
> +unsigned long __pfn_to_mfn(unsigned long pfn);
> +extern struct rb_root phys_to_mach;
> +
> +/* Pseudo-physical <-> Guest conversion */
> +static inline unsigned long pfn_to_gfn(unsigned long pfn)
> +{
> +	return pfn;
> +}
> +
> +static inline unsigned long gfn_to_pfn(unsigned long gfn)
> +{
> +	return gfn;
> +}
> +
> +/* Pseudo-physical <-> BUS conversion */
> +static inline unsigned long pfn_to_bfn(unsigned long pfn)
> +{
> +	unsigned long mfn;
> +
> +	if (phys_to_mach.rb_node != NULL) {
> +		mfn = __pfn_to_mfn(pfn);
> +		if (mfn != INVALID_P2M_ENTRY)
> +			return mfn;
> +	}
> +
> +	return pfn;
> +}
> +
> +static inline unsigned long bfn_to_pfn(unsigned long bfn)
> +{
> +	return bfn;
> +}
> +
> +#define bfn_to_local_pfn(bfn)	bfn_to_pfn(bfn)
> +
> +/* VIRT <-> GUEST conversion */
> +#define virt_to_gfn(v)		(pfn_to_gfn(virt_to_phys(v) >> XEN_PAGE_SHIFT))
> +#define gfn_to_virt(m)		(__va(gfn_to_pfn(m) << XEN_PAGE_SHIFT))
> +
> +/* Only used in PV code. But ARM guests are always HVM. */
> +static inline xmaddr_t arbitrary_virt_to_machine(void *vaddr)
> +{
> +	BUG();
> +}
> +
> +/* TODO: this shouldn't be here but it is because the frontend drivers
> + * are using it (its rolled in headers) even though we won't hit the code path.
> + * So for right now just punt with this.
> + */
> +static inline pte_t *lookup_address(unsigned long address, unsigned int *level)
> +{
> +	BUG();
> +	return NULL;
> +}
> +
> +extern int set_foreign_p2m_mapping(struct gnttab_map_grant_ref *map_ops,
> +				   struct gnttab_map_grant_ref *kmap_ops,
> +				   struct page **pages, unsigned int count);
> +
> +extern int clear_foreign_p2m_mapping(struct gnttab_unmap_grant_ref *unmap_ops,
> +				     struct gnttab_unmap_grant_ref *kunmap_ops,
> +				     struct page **pages, unsigned int count);
> +
> +bool __set_phys_to_machine(unsigned long pfn, unsigned long mfn);
> +bool __set_phys_to_machine_multi(unsigned long pfn, unsigned long mfn,
> +		unsigned long nr_pages);
> +
> +static inline bool set_phys_to_machine(unsigned long pfn, unsigned long mfn)
> +{
> +	return __set_phys_to_machine(pfn, mfn);
> +}
> +
> +#define xen_remap(cookie, size) ioremap_cache((cookie), (size))
> +#define xen_unmap(cookie) iounmap((cookie))
> +
> +bool xen_arch_need_swiotlb(struct device *dev,
> +			   phys_addr_t phys,
> +			   dma_addr_t dev_addr);
> +unsigned long xen_get_swiotlb_free_pages(unsigned int order);
> +
> +#endif /* _ASM_ARM_XEN_PAGE_H */
> -- 
> 2.1.4
> 
