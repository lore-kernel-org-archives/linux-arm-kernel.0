From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Thu, 15 Dec 2016 19:20:11 +0300
Subject: arm64: mm: bug around swiotlb_dma_ops
Message-ID: <8862fe21-0a82-a09a-c1cb-aa79d46179ec@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

Per Documentation/DMA-API-HOWTO.txt, driver of device capable of 64-bit
DMA addressing, should call dma_set_mask_and_coherent(dev,
DMA_BIT_MASK(64)) and if that succeeds, assume that 64-bit DMA
addressing is available.

This behaves incorrectly on arm64 system (Renesas r8a7795-h3ulcb) here.

- Device (NVME SSD) has it's dev->archdata.dma_ops set to swiotlb_dma_ops.

- swiotlb_dma_ops.dma_supported is set to swiotlb_dma_supported():

int swiotlb_dma_supported(struct device *hwdev, u64 mask)
{
        return phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
}

this definitely returns true for mask=DMA_BIT_MASK(64) since that is
maximum possible 64-bit value.

- Thus device dma_mask is unconditionally updated, and
dma_set_mask_and_coherent() succeeds.

- Later, __swiotlb_map_page() / __swiotlb_map_sg_attr() will consult
this updated mask, and return high addresses as valid DMA addresses.


Thus recommended dma_set_mask_and_coherent() call, instead of checking
if platform supports 64-bit DMA addressing, unconditionally enables
64-bit DMA addressing. In case of device actually can't do DMA to 64-bit
addresses (e.g. because of limitations in PCIe controller), this breaks
things. This is exactly what happens here.


Not sure what is proper fix for this though.

Nikita
