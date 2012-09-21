From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 21 Sep 2012 16:21:27 +0100
Subject: Mismatched aliases with DMA mappings?
Message-ID: <20120921152127.GA2106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

I've been trying to understand whether (and if so, how) and DMA buffer
allocation code in dma-mapping.c avoids mismatched alises in the kernel
linear map.


I need a way of getting some uncached memory for communicating with
temporarily noncoherent CPUs during CPU bringup/teardown.  Although
the DMA API does not seem quite the right solution for this, nothing
else currently feels like quite the right solution either.  Approaches
based on memblock_steal() and on using cacheable memory with explicit
flushing both have problems, and reserving specific physical memory
via DT seems ugly, because we really don't care where the memory is.

What is needed is something like an ioremap of anonymous memory with
specific attributes, using largely the same infrastructure as the DMA
API, but eliminating a mismatched alias of the allocated memory in the
kernel linear mapping is likely to be important.

Can you explain how the DMA mapping code eliminates mismatched aliases?
I can see the attributes of new mappings being set, but currently I
don't see how the linear map gets modified.

Cheers
---Dave
