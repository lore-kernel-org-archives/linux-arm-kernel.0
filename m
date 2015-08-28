From: msalter@redhat.com (Mark Salter)
Date: Fri, 28 Aug 2015 11:56:36 -0400
Subject: [PATCH] ARM64: kernel: implement ACPI parking protocol
In-Reply-To: <20150828153212.GG15924@red-moon>
References: <1436959990-32054-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1437063431.3583.2.camel@redhat.com> <20150716171221.GB18582@red-moon>
 <1437068449.3583.4.camel@redhat.com> <20150828102314.GC15924@red-moon>
 <1440772186.31961.8.camel@redhat.com> <20150828153212.GG15924@red-moon>
Message-ID: <1440777396.31961.13.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-08-28 at 16:32 +0100, Lorenzo Pieralisi wrote:
> [Cc'ing Leif and Ard]
> 
> On Fri, Aug 28, 2015 at 03:29:46PM +0100, Mark Salter wrote:
> > On Fri, 2015-08-28 at 11:23 +0100, Lorenzo Pieralisi wrote:
> > > Mark,
> > > 
> > > On Thu, Jul 16, 2015 at 06:40:49PM +0100, Mark Salter wrote:
> > > 
> > > [...]
> > > 
> > > > On Thu, 2015-07-16 at 18:12 +0100, Lorenzo Pieralisi wrote:
> > > > > > The kernel will only add cached memory regions to linear 
> > > > > > mapping 
> > > > > > and
> > > > > > presumably, the FW will mark the mailboxes as uncached. 
> > > > > > Otherwise, 
> > > > > > it
> > > > > > is a FW bug. But I suppose we could run into problems with 
> > > > > > kernels
> > > > > > using 64K pagesize since firmware assumes 4k.
> > > > > 
> > > > > Nope, ioremap takes care of that, everything should be fine.
> > > > 
> > > > The mailbox is 4K. If it is next to a cached UEFI region, the 
> > > > kernel 
> > > > may
> > > > have to overlap the mailbox with a cached 64K mapping in order to 
> > > > include
> > > > the adjoining UEFI region in the linear map. Then the ioremap would 
> > > > fail
> > > > because the mailbox is included in the linear mapping.
> > > 
> > > So that I understand: are you referring to memrange_efi_to_native()
> > > in arch/arm64/kernel/efi.c ? Is it safe to round up (and add it to
> > > the memblock layer) the memory region size to PAGE_SIZE without 
> > > checking
> > > attributes of overlapping (within PAGE_SIZE) UEFI regions ?
> > 
> > The problem is that nothing in the UEFI spec or parking protocol spec
> > prevents firmware from placing a 4K parking protocol mailbox area in
> > the same 64K page as normal cached memory which winds up mapped in
> > the kernel linear mapping. The kernel might be able to work around
> > that by not putting the 64K page in the linear map. There's nothing
> > the kernel could do if the mailbox is in same 64K page with UEFI 
> > runtime
> > memory which would use a cached mapping.
> 
> Ok, I failed to explain myself. Let's imagine that we have a, say, 64k
> aligned memory region (EFI_MEMORY_WB - size 16k) that lives in the same
> 64K memory frame as a device's registers memory space.
> The code I pointed at above creates a 64K memory frame out of the 16K
> region and adds it to the memblock so that it ends up in the kernel 
> linear
> mapping which ends up mapping the device registers too with cacheable
> attributes and that's not correct.
> 
> I am not sure what's the best way to solve that, probably we should
> amend the UEFI specs to enforce uniform 64K memory region attributes,
> comments welcome.

OIC. Well it is a potential problem. Hardware designers do some whacky
things, but I'd like to think I/O regions and cached mem regions bordering
on such a small power of two boundary is not one of them.

> 
> Thanks,
> Lorenzo
