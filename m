From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 07 Oct 2014 23:39:47 +0200
Subject: [RFC 2/4] PCI: generic: Add support for ARM64 and MSI(x)
In-Reply-To: <20141007144750.GB30590@e102568-lin.cambridge.arm.com>
References: <1411937610-22125-1-git-send-email-suravee.suthikulpanit@amd.com>
 <3659934.boXsmm8jcn@wuerfel>
 <20141007144750.GB30590@e102568-lin.cambridge.arm.com>
Message-ID: <3978481.XNAIA6gzAG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 October 2014 15:47:50 Lorenzo Pieralisi wrote:
> On Tue, Oct 07, 2014 at 02:52:27PM +0100, Arnd Bergmann wrote:
> > On Tuesday 07 October 2014 13:06:59 Lorenzo Pieralisi wrote:
> > > On Wed, Oct 01, 2014 at 10:38:45AM +0100, Arnd Bergmann wrote:
> > > 
> > > [...]
> > > 
> > > > pci_mmap_page_range could either get generalized some more in an attempt
> > > > to have a __weak default implementation that works on ARM, or it could
> > > > be changed to lose the dependency on pci_sys_data instead. In either
> > > > case, the change would involve using the generic pci_host_bridge_window
> > > > list.
> > > 
> > > On ARM pci_mmap_page_range requires pci_sys_data to retrieve its
> > > mem_offset parameter. I had a look, and I do not understand *why*
> > > it is required in that function, so I am asking. That function
> > > is basically used to map PCI resources to userspace, IIUC, through
> > > /proc or /sysfs file mappings. As far as I understand those mappings
> > > expect VMA pgoff to be the CPU address when files representing resources
> > > are mmapped from /proc and 0 when mmapped from /sys (I mean from
> > > userspace, then VMA pgoff should be updated by the kernel to map the
> > > resource).
> > 
> > Applying the mem_offset is certainly the more intuitive way, since
> > that lets you read the PCI BAR values from a device and access the
> > device with the appropriate offsets.
> 
> Ok, but I am referring to this snippet (drivers/pci/pci-sysfs.c):
> 
> /* pci_mmap_page_range() expects the same kind of entry as coming
>  * from /proc/bus/pci/ which is a "user visible" value. If this is
>  * different from the resource itself, arch will do necessary fixup.
>  */
> pci_resource_to_user(pdev, i, res, &start, &end);
> 
> --> Here start represents a CPU physical address, if pci_resource_to_user()
>     does not fix it up, correct ?
> 
> vma->vm_pgoff += start >> PAGE_SHIFT;
> 
> [...]
> 
> return pci_mmap_page_range(...);
> 
> pci_mmap_page_range() applies (mem_offset >> PAGE_SHIFT) to pgoff in the
> ARM implemention.
> 
> Is not there a mismatch here on platforms where mem_offset != 0 ?

Yes, I think that's right: ARM never gained its own pci_resource_to_user()
implementation, presumably because nobody ran into this problem and
debugged it all the way.

	Arnd
