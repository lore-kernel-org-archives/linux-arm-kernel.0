From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 7 Jun 2011 14:19:05 +0300
Subject: [RFC 1/6] omap: iommu: generic iommu api migration
In-Reply-To: <201106071122.47804.laurent.pinchart@ideasonboard.com>
References: <1307053663-24572-1-git-send-email-ohad@wizery.com>
	<1307053663-24572-2-git-send-email-ohad@wizery.com>
	<201106071122.47804.laurent.pinchart@ideasonboard.com>
Message-ID: <BANLkTineGVvmph=Om2FGR_+mkiMW6k7UAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Tue, Jun 7, 2011 at 12:22 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> + ? ? BUG_ON(!IS_ALIGNED((long)omap_domain->pgtable, IOPGD_TABLE_SIZE));
>
> Either __get_free_pages() guarantees that the allocated memory will be aligned
> on an IOPGD_TABLE_SIZE boundary, in which case the BUG_ON() is unnecessary, or
> doesn't offer such guarantee, in which case the BUG_ON() will oops randomly.

Curious, does it oops randomly today ?
(i just copied this from omap_iommu_probe, where it always existed).

It is a bit ugly though, and thinking on it again, 16KB is not that
big. We can just use kmalloc here, which does ensure the alignment
(or, better yet, kzalloc, and then ditch the memset).

> In both cases BUG_ON() should probably be avoided.

I disagree; we must check this so user data won't be harmed (hardware
requirement), and if a memory allocation API fails to meet its
requirements - that's really bad and user data is again at stake (much
more will break, not only the iommu driver).

> This leaks omap_domain->pgtable.
>
> The free_pages() call in omap_iommu_remove() should be removed, as
> omap_iommu_probe() doesn't allocate the pages table anymore.

thanks !

> You can also remove the the struct iommu::iopgd field.

No, I can't; it's used when the device is attached to an address space domain.

> You return 0 in the bogus pte/pgd cases. Is that intentional ?

Yes, that's probably the most (if any) reasonable value to return here
(all other iommu implementations are doing so too).

Thanks,
Ohad.
