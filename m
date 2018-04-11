From: julien.grall@arm.com (Julien Grall)
Date: Wed, 11 Apr 2018 10:45:53 +0100
Subject: [PATCH v4] xen/privcmd: add IOCTL_PRIVCMD_MMAP_RESOURCE
In-Reply-To: <20180410075820.11081-1-paul.durrant@citrix.com>
References: <20180410075820.11081-1-paul.durrant@citrix.com>
Message-ID: <8fff31d5-7eb4-33e8-0fc8-c5bb1ab47eba@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/04/18 08:58, Paul Durrant wrote:
> +static long privcmd_ioctl_mmap_resource(struct file *file, void __user *udata)
> +{
> +	struct privcmd_data *data = file->private_data;
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma;
> +	struct privcmd_mmap_resource kdata;
> +	xen_pfn_t *pfns = NULL;
> +	struct xen_mem_acquire_resource xdata;
> +	int rc;
> +
> +	if (copy_from_user(&kdata, udata, sizeof(kdata)))
> +		return -EFAULT;
> +
> +	/* If restriction is in place, check the domid matches */
> +	if (data->domid != DOMID_INVALID && data->domid != kdata.dom)
> +		return -EPERM;
> +
> +	down_write(&mm->mmap_sem);
> +
> +	vma = find_vma(mm, kdata.addr);
> +	if (!vma || vma->vm_ops != &privcmd_vm_ops) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	pfns = kcalloc(kdata.num, sizeof(*pfns), GFP_KERNEL);
> +	if (!pfns) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (xen_feature(XENFEAT_auto_translated_physmap)) {
> +		struct page **pages;
> +		unsigned int i;
> +
> +		rc = alloc_empty_pages(vma, kdata.num);
> +		if (rc < 0)
> +			goto out;
> +
> +		pages = vma->vm_private_data;
> +		for (i = 0; i < kdata.num; i++)
> +			pfns[i] = page_to_pfn(pages[i]);

I don't think this is going to work well if the hypervisor is using a 
different granularity for the page.

Imagine Xen is using 4K but the kernel 64K. You would end up to have the 
resource not mapped contiguously in the memory.

Cheers,

-- 
Julien Grall
