From: dennis.chen@arm.com (Dennis Chen)
Date: Fri, 2 Dec 2016 14:04:41 +0800
Subject: [PATCH] PCI:MSI Return -ENOSPC when requested vectors is not
 enough
In-Reply-To: <20161201085243.GA24684@lst.de>
References: <1480558504-18691-1-git-send-email-dennis.chen@arm.com>
 <20161201085243.GA24684@lst.de>
Message-ID: <20161202060440.GA16167@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 09:52:43AM +0100, Christoph Hellwig wrote:
> Hi Dennis,
> 
> I've fixed ahci to treat all errors the same in the meantime, please
> try latest Linux tree.  That being said I don't like the different
> error returns from __pci_enable_msi_range (and __pci_enable_msix_range),
> but they have been there for a while.

Ah, I've noticed that you have the fix recently which is somehow to weaken
the necessary of the change. But, that also being said that I don't like we insist
at least the inconsistent either just because something has been there *for a while*.
Both below comments from cpi_alloc_irq_vectors_affinity() and the logic itself
leads us to think that the correct return value is -NOSPC:
/**
 *...
 *Return the number of vectors allocated,
 * (which might be smaller than @max_vecs) if successful, or a negative
 * error code on error. If less than @min_vecs interrupt vectors are
 * available for @dev the function will fail with -ENOSPC.
 * ...
*/

People maybe argue that almost has no device drivers depending on the different
return value, then why we still need to do that?

Thanks,
Dennis 
