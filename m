From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Mar 2017 17:54:08 +0000
Subject: [PATCH 1/3] arm64: enable pci resource mapping using sysfs
In-Reply-To: <1489598266.86622.12.camel@infradead.org>
References: <1489598266.86622.12.camel@infradead.org>
Message-ID: <20170315175353.GA29452@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 15, 2017 at 05:17:46PM +0000, David Woodhouse wrote:
> From: Brijesh Singh <brijess@amazon.com>
> 
> To support pci resource mapping from userspace, pci_mmap_page_range
> implementation must be done for that platform. This support was
> broken for arm64.
> 
> This patch copies existing implementation from arm to
> enable sysfs mmap.

It's not so much "broken" as "not currently supported".

[...]

> +#define HAVE_PCI_MMAP
> +extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
> +			       enum pci_mmap_state mmap_state, int write_combine);
> +

Per the prior attempt at this [1], we only want to expose the sysfs
interface, and not the legacy procfs interface, and need the two
decoupled [2].

... or has something changed in the mean time, so that this only exposes
the sysfs interface?

[...]

> +int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
> +			enum pci_mmap_state mmap_state, int write_combine)
> +{
> +	if (mmap_state == pci_mmap_io)
> +		return -EINVAL;
> +
> +	if (write_combine)
> +		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> +	else
> +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

... as per Will's comment in [3], the latter of these should use
pgprot_device.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/421948.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/423083.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/422571.html
