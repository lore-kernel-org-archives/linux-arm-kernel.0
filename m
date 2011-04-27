From: saeed.bishara@gmail.com (saeed bishara)
Date: Wed, 27 Apr 2011 14:42:57 +0300
Subject: RAID/dmaengine violates the dma-streaming API
In-Reply-To: <BANLkTinMA_U1r6K4t8UZKUr4nZBsWPSv9w@mail.gmail.com>
References: <BANLkTinMA_U1r6K4t8UZKUr4nZBsWPSv9w@mail.gmail.com>
Message-ID: <BANLkTi=30Q5=TAaPcE8SXt417S6e=RaY3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 17, 2011 at 7:00 PM, saeed bishara <saeed.bishara@gmail.com> wrote:
> Hi,
> ? ? when md uses the dma for offloading xor and memcpy operations, it
> violates the dma-mapping API. ?here is the scenario I'm taking about
> (under write to degraded raid5):
> 1. ops_run_prexor sends xor operation from buffers A and B, and the
> destination is A.
> 2. ops_run_biodrain: sends mempcy operation from C to B.
> 3. ops_run_reconstruct5: sends xor operation from A and B, and the
> destination is A again.
>
> in step 1, the async tx maps A using dma_map_page, and in step 3, it
> maps again the same buffer. but, if the request from step 1 still
> being handled the dma engine, then we end with a case where the buffer
> mapped while it still belongs to the dma hw.
> when the arch is ARMv6/SMP mode (without io coherency), the cache
> maintenance involves read/write access to the buffers, that means, the
> second mapping above may access the buffer(with read/write) while the
> dma is writing to it!!.
>
Russell/Dan,
     can you have a look into this issue? what I see here is that the
raid stack issues dma_map_page to a buffer that still owned by DMA.

saeed

> also, from performance sake, it would be great if this multiple
> mappings get avoided.
>
> saeed
>
