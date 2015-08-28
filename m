From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 28 Aug 2015 11:23:14 +0100
Subject: [PATCH] ARM64: kernel: implement ACPI parking protocol
In-Reply-To: <1437068449.3583.4.camel@redhat.com>
References: <1436959990-32054-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1437063431.3583.2.camel@redhat.com>
 <20150716171221.GB18582@red-moon>
 <1437068449.3583.4.camel@redhat.com>
Message-ID: <20150828102314.GC15924@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Thu, Jul 16, 2015 at 06:40:49PM +0100, Mark Salter wrote:

[...]

> On Thu, 2015-07-16 at 18:12 +0100, Lorenzo Pieralisi wrote:
> > > The kernel will only add cached memory regions to linear mapping and
> > > presumably, the FW will mark the mailboxes as uncached. Otherwise, it
> > > is a FW bug. But I suppose we could run into problems with kernels
> > > using 64K pagesize since firmware assumes 4k.
> >
> > Nope, ioremap takes care of that, everything should be fine.
> 
> The mailbox is 4K. If it is next to a cached UEFI region, the kernel may
> have to overlap the mailbox with a cached 64K mapping in order to include
> the adjoining UEFI region in the linear map. Then the ioremap would fail
> because the mailbox is included in the linear mapping.

So that I understand: are you referring to memrange_efi_to_native()
in arch/arm64/kernel/efi.c ? Is it safe to round up (and add it to
the memblock layer) the memory region size to PAGE_SIZE without checking
attributes of overlapping (within PAGE_SIZE) UEFI regions ?

Thanks,
Lorenzo
