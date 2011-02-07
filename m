From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Feb 2011 18:13:00 +0100
Subject: Short excursion into mmci.c vs msm_sdcc.c
Message-ID: <AANLkTik24N+BerdrQ8RQK7_5oWSrZJmk5tNwuetDLjN+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As some of the readers of ARM PL180 MMCI MMC driver might have
already noticed the driver in drivers/mmc/host/msm_sdcc.c is a fork
of mmci.c.

There are some bugs in msm_sdcc.c that we fixed over the
last few weeks in mmci.c too I think. Check the latest error handling
and how we determine how much data has been transferred on error
for example, you just error out in this driver.

Look here:

        n = dma_map_sg(mmc_dev(host->mmc), host->dma.sg,
                        host->dma.num_ents, host->dma.dir);
       /* dsb inside dma_map_sg will write nc out to mem as well */

        if (n != host->dma.num_ents) {
                printk(KERN_ERR "%s: Unable to map in all sg elements\n",
                        mmc_hostname(host->mmc));
                host->dma.sg = NULL;
                host->dma.num_ents = 0;
                return -ENOMEM;
        }

This is wrong. The DMA API does not work like that, as I
learned some weeks ago writing code for MMCI. It is prefectly
legal for the mapping function to return fewer number of
entries than were passed in.

When you do this in msmsdcc_dma_complete_tlet():

        dma_unmap_sg(mmc_dev(host->mmc), host->dma.sg, host->dma.num_ents,
                     host->dma.dir);

        if (host->curr.user_pages) {
                struct scatterlist *sg = host->dma.sg;
                int i;

                for (i = 0; i < host->dma.num_ents; i++)
                        flush_dcache_page(sg_page(sg++));
        }

Why are you explicitly flushing the sglist after dma_unmap_sg()?
At this point it should be synced for the CPU already if I'm not
mistaken.

I could write up patches for this and probably some more,
but that's not the point.

The real question: how different is this hardware really? It looks
very, very similar. I guess there are changes in it as with all hardware
vendors, but I suspect they may be similar to what we have. Have
you contemplated just using mmci.c?

Yours,
Linus Walleij
