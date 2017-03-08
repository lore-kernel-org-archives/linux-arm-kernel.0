From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 8 Mar 2017 19:59:48 +0900
Subject: [Question] devm_kmalloc() for DMA ?
Message-ID: <CAK7LNARbD262isY7yOgQKAcbWQHV+3dsoRjtu6S+qUpPr98qSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi experts,

I have a question about
how to allocate DMA-safe buffer.


In my understanding, kmalloc() returns
memory with DMA safe alignment
in order to avoid cache-sharing problem when used for DMA.

The alignment is decided by ARCH_DMA_MINALIGN.
For example, on modern ARM 32bit boards, this value is typically 64.
So, memory returned by kmalloc() has
at least 64 byte alignment.


On the other hand, devm_kmalloc() does not return
enough-aligned memory.


On my board (ARM 32bit), devm_kmalloc() returns
(ARCH_DMA_MINALIGN aligned address) + 0x10.



The reason of the offset 0x10 is obvious.

struct devres {
        struct devres_node node;
        /* -- 3 pointers */
        unsigned long long data[]; /* guarantee ull alignment */
};


Management data is located at the top of struct devres.
Then, devm_kmalloc() returns dr->data.

The "unsigned long long" guarantees
the returned memory has 0x10 alignment,
but I think this may not be enough for DMA.

I noticed this when I was seeing drivers/mtd/nand/denali.c

The code looks as follows:


        denali->buf.buf = devm_kzalloc(denali->dev,
                             mtd->writesize + mtd->oobsize,
                             GFP_KERNEL);
        if (!denali->buf.buf) {
                ret = -ENOMEM;
                goto failed_req_irq;
        }

        /* Is 32-bit DMA supported? */
        ret = dma_set_mask(denali->dev, DMA_BIT_MASK(32));
        if (ret) {
                dev_err(denali->dev, "No usable DMA configuration\n");
                goto failed_req_irq;
        }

        denali->buf.dma_buf = dma_map_single(denali->dev, denali->buf.buf,
                             mtd->writesize + mtd->oobsize,
                             DMA_BIDIRECTIONAL);




Memory buffer is allocated by devm_kzalloc(), then
passed to dma_map_single().



Could this be a potential problem in general?

Is devm_kmalloc() not recommended
for buffer that can be DMA-mapped?


Any advice is appreciated.


-- 
Best Regards
Masahiro Yamada
