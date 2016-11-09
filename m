From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Nov 2016 18:25:39 +0000
Subject: [PATCH] arm64: acpi: arch_apei_get_mem_attributes() should use
 memblock
In-Reply-To: <5823677D.3050803@arm.com>
References: <20161108102714.29931-1-james.morse@arm.com>
 <CAKv+Gu9+T0TYqk+uTUWa5K0E49WXDBpUK4Px_q=52jR0ON1zGA@mail.gmail.com>
 <5823677D.3050803@arm.com>
Message-ID: <20161109182538.GL17771@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 06:14:21PM +0000, James Morse wrote:
> On 09/11/16 12:12, Ard Biesheuvel wrote:
> > This means that in this case, you may be returning PAGE_KERNEL for
> > regions that are lacking the EFI_MEMORY_WB attribute, which kind of
> > defeats the purpose of this function (AIUI), to align the kernel's
> > view of the region's attributes with the view of the firmware. I would
> > expect that, for use cases like this one, the burden is on the
> > firmware to ensure that only a single EFI_MEMORY_xx attribute is set
> > if any kind of coherency between UEFI and the kernel is expected. If
> > that single attribute is WT or WC, PAGE_KERNEL is most certainly
> > wrong.
> 
> I've been trying to test some of the APEI code using some hacks on top of
> kvmtool. (actually, quite a lot of hacks).
> 
> When I trigger an event, I see efi_mem_attributes() always return 0 because the
> EFI memory map isn't mapped. This turns out to be because I have 'efi=noruntime'
> on the command line. I stopped digging when I found this previously-dead code,
> but should have gone further.
> 
> If this is an expected interaction, we can ignore this as a bug in my test
> setup. (and I have to work out how to get efi runtime services going...)
> 
> If not, I can try always mapping the EFI memory map in
> arm_enable_runtime_services() if we booted via ACPI, as in this case runtime
> services isn't the only user of the memory map.
> 
> 
> My intention here was to just mirror acpi_os_ioremap(), which will call
> ioremap_cache() for WB/WC/WT regions, which (also) ends up using PROT_NORMAL. We
> may get away with this, but you're right, we are less likely to here.

I'd certainly be interested in opinions as to what acpi_os_ioremap is
supposed to do, since it has fingers in the NOMAP pie and if we change the
polarity of pfn_valid() for NOMAP mappings (as suggested by Robert Richter
to fix his NUMA issue), then acpi_os_ioremap will actually *fail* for
these WB/WC regions.

Will
