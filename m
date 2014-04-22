From: ritesh.harjani@gmail.com (Ritesh Harjani)
Date: Tue, 22 Apr 2014 18:18:12 +0530
Subject: arm64: default dma_ops is set to coherent_dma_ops results into DMA
 FAILURE
Message-ID: <CALk7dXpKGdYd7K4M68KbBgv9a7oHWhPPLER297xFgkYnEiv8Ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin/Will,

This is regarding the default dma_ops that we populate for arm64.

PROBLEM:
Currently in arch/arm64/mm/dma-mapping.c we set dma_ops =
&coherent_swiotlb_dma_ops.

The problem with this is, lets say that there is a dma device which
has not populated its dev->archdata.dma_ops, then this dma device will
get the coherent dma_ops in which we dont do any cache maintainance.

So, if the dma driver do kmalloc, make some changes to the buffer and
after dma_map_single gives it to the dma for the transfer, due to no
cache maintenance performed, result will be DMA transfer failed.



Earlier noncoherent ops code was not present at all for arm64, so may
be we were setting default ops to coherent ops. But now that we have
noncoherent ops in place shall we make the default dma_ops to
noncoherent (as what arm also does) ?


Please let me know if I am missing something here.


Thanks
Ritesh
