From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Dec 2014 17:17:47 +0100
Subject: [PATCH 1/2] arm64: amd-seattle: Fix dma-ranges property
In-Reply-To: <D0A3B11F.AAC8%suravee.suthikulpanit@amd.com>
References: <D0A3B11F.AAC8%suravee.suthikulpanit@amd.com>
Message-ID: <2491716.6gErSSjiAc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 December 2014 14:12:48 Suthikulpanit, Suravee wrote:
> 
> Would you minding adding the following detail in the commit message?

I was going to, but then decided not to. It's usually better if you
just send a new patch when requested to update the changelog, so
please do that.
 
> - BEGIN -
> AMD Seattle supports 40-bit DMA, which includes two ranges:
>     1. GICv2m MSI register frame at 0xe0080000
>     2. DRAM range [0x8000000000 to 0xffffffffff]
> 
> Since the current parsing logic handles only single range, this patch
> specifies the range from zero to 0x10000000000 to cover the whole
> 40-bit range.
> 
> However, it expects DMA allocation/mapping logic to check the specified
> DMA range against the reported DRAM range, which starts from
> 0x8000000000 in this case.

Unfortunately the description is (for the most part) wrong:

- It doesn't matter whatsoever what the target of the DMA is or
  how large the DRAM can be. The only thing that matters is the
  transformation that the bus physically performs. If the AXI bus
  is (as you said earlier, though I'm no longer sure about it
  after your text above) limited to 40 bit address, you should
  use the 40-bit mask you gave above. If the 40-bit address is not
  a result of a limitation of the AXI bus but of the memory
  controller, you should just list a full 64-bit mask here.
  In that case, you actually have to use '0xffffffff 0xffffffff'
  as the length, which is one byte short as before, but we can't
  express that otherwise.

- Furthermore it does not matter at all what the Linux implementation
  does. If your hardware does a transformation that the current
  code can't handle, we need to fix the code rather than work around
  the implementation bug by putting incorrect data into the DT.

	Arnd
