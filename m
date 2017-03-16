From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 16 Mar 2017 12:17:27 +0000
Subject: [PATCH v2] arm64: pci: add support for pci_mmap_page_range
In-Reply-To: <20160415130953.GI22906@arm.com>
References: <1460581856-12380-1-git-send-email-jerin.jacob@caviumnetworks.com>
 <20160415130953.GI22906@arm.com>
Message-ID: <1489666647.4195.238.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-04-15 at 14:09 +0100, Will Deacon wrote:
> 
> > +?????if (write_combine)
> > +?????????????vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> > +?????else
> > +?????????????vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> 
> For consistency with ioremap, this should be pgprot_device.

What's the difference?

I note that VFIO is using pgprot_noncached() too, in vfio_pci_mmap() ?
where it open-codes an entirely arch-agnostic version of
pci_mmap_page_range() all for itself. Should that be changed to
pgprot_device() too?

Let me see if I can get this straight...

We have the legacy interface through /proc/bus/pci, where the user
passes a "user-visible" bus address not necessarily (on platforms with
HAVE_PCI_RESOURCE_TO_USER) a host physical address.

The arch-specific pci_mmap_page_range() exists to work around that
translation, on the two platforms which need it. It *also* has (on
about three platforms) support for a write-combining mapping.

The sysfs interface theough /sys/bus/pci/devices/*/resource* probably
doesn't need to use pci_mmap_page_range() at all, *except* for the
'resourceX_wc' variant which has write-combining support.

How about we do the following (probably not in this order):
?? Kill pci_mmap_page_range() entirely.
?? Implement a generic version which has (arch-assisted) WC support
? ?but no knowledge of the horrid pci_resource_to_user() mapping.
?? Require pci_user_to_resource() to be provided by platforms with
? ?HAVE_ARCH_PCI_RESOURCE_TO_USER, and call that from *generic* code,
? ?for the legacy procfs interface, before invoking the generic
? ?replacement for pci_mmap_page_range().

(Yes, we still need to support mmap of I/O resources on... is it only
powerpc? And there are a few inconsistencies, like powerpc forcing WC
even on the sysfs files that *don't* have _wc in their name, that
probably want to be cleaned up as we consolidate...)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170316/f016edd6/attachment.bin>
