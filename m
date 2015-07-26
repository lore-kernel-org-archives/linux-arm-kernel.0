From: dan.j.williams@intel.com (Dan Williams)
Date: Sun, 26 Jul 2015 11:11:44 -0700
Subject: [PATCH v2 25/25] pmem: convert to generic memremap
In-Reply-To: <20150726173317.GD29513@lst.de>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150725024020.8664.52581.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150726173317.GD29513@lst.de>
Message-ID: <CAPcyv4jsnQ1CzgXkkpzJnfjnKMmxiwyhQ_3osgo9vmjceP+rZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 26, 2015 at 10:33 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Fri, Jul 24, 2015 at 10:40:20PM -0400, Dan Williams wrote:
>> Update memremap_pmem() to query the architecture for the mapping type of
>> the given persistent memory range  and then pass those flags to generic
>> memremap().  arch_memremap_pmem_flags() is provided an address range to
>> evaluate in the event an arch has a need for different mapping types by
>> address range.  For example the ACPI NFIT carries EFI mapping types in
>> its memory range description table.
>
> I don't think the pmem driver should look at a arch hook here, please
> communicate this through the nvdimm subsystem.
>
> Btw, looking at these changes I also think the __pmem annotations
> are mistake.  We might have all kinds of ways to write to pmem,
> and as long as we properly flush it we don't need to force it
> through the special accessors.  This becomes really interesting
> for PCI DMA access.

I don't follow.  We have __iomem for the cpu mapping of a resource and
dma_map() for a PCI device.  __pmem works the same and is there to
make sure someone doesn't simply de-reference a pointer to pmem and
hope that the write is persistent.
