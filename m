From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 15 Mar 2017 19:18:16 +0000
Subject: [PATCH 1/3] arm64: enable pci resource mapping using sysfs
In-Reply-To: <20170315175353.GA29452@leverpostej>
References: <1489598266.86622.12.camel@infradead.org>
 <20170315175353.GA29452@leverpostej>
Message-ID: <1489605496.4195.182.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-03-15 at 17:54 +0000, Mark Rutland wrote:
> It's not so much "broken" as "not currently supported".

Yeah, I thought that when I inherited the commit, but didn't get as far
as rephrasing it. Will do so.

> [...]
> 
> > 
> > +#define HAVE_PCI_MMAP
> > +extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
> > +			???????enum pci_mmap_state mmap_state, int write_combine);
> > +
> Per the prior attempt at this [1], we only want to expose the sysfs
> interface, and not the legacy procfs interface, and need the two
> decoupled [2].

I do not like that idea. The procfs horridness is legacy, sure, but
it's not actually an arch-specific interface. You get to mess with
'legacy' syscalls all you like on a new architecture, but there could
exist arch-agnostic code which uses the procfs interface, surely?

> > +	if (write_combine)
> > +		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> > +	else
> > +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> ... as per Will's comment in [3], the latter of these should use
> pgprot_device.

Will fix that; thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170315/29227397/attachment-0001.bin>
