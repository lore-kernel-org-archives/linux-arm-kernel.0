From: james.morse@arm.com (James Morse)
Date: Wed, 09 Nov 2016 10:48:43 +0000
Subject: [PATCH] arm64: acpi: arch_apei_get_mem_attributes() should use
 memblock
In-Reply-To: <168e341f-2377-2962-34a4-63043d5ab6d6@codeaurora.org>
References: <20161108102714.29931-1-james.morse@arm.com>
 <168e341f-2377-2962-34a4-63043d5ab6d6@codeaurora.org>
Message-ID: <5822FF0B.2080109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

On 08/11/16 18:41, Baicar, Tyler wrote:
> This patch seems fine, APEI/GHES functionality still works properly for me.
> I tested on a 4.8 kernel with the patch you mention below from Jonathan and
> my patchset https://lkml.org/lkml/2016/10/21/746

What are the memory attributes of the region your firmware writes the error
status data to?

I guess its attributes in the UEFI memory map must be 'NC' or <empty>. In which
case the current default of Device_nGnRnE isn't so wrong. Otherwise your
firmware must be doing some cache cleaning, which shouldn't be necessary.


> My only question is when you say that this may be called from an NMI context.
> arch_apei_get_mem_attributes() only gets called from ghes_ioremap_pfn_irq()
> which only appears to get called if we are not in an NMI context.

Yes, that's broken too.
ghes_ioremap_pfn_nmi() assumes PAGE_KERNEL. If firmware writes the error data
via a non-cachable mapping, it will tell us this via the UEFI memory map, which
we currently misread.

I have patches to fix this too, but it isn't needed until someone turns on
CONFIG_HAVE_ACPI_APEI_NMI on arm64 (or ia64...).


> So can this really be called from an NMI context?

Not today, but it may be in the future. Re-mapping the EFI memory map to read it
is possible in the short term, but generates more work if we ever want to
support CONFIG_HAVE_ACPI_APEI_NMI. I implied all this into the word 'may', I
will try to be clearer next time!


Thanks,

James
