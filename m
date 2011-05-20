From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Fri, 20 May 2011 12:44:00 +0530
Subject: [PATCH v4 08/11] tty: add pruss SUART driver
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024CF13FC2@dbde02.ent.ti.com>
References: <78EB813416554F1A973EF20AA714ADF8@subhasishg>
	<B85A65D85D7EB246BE421B3FB0FBB593024CF13FC2@dbde02.ent.ti.com>
Message-ID: <B7F8B2D7C5D5428B911477CBC0320090@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

>> > ok, so what you are suggesting is that I implement some
>> > callbacks (like .fifo_alloc, .fifo_dealloc) which can allocate
>> > memory using sram_alloc.
>> > My doubt is, if already such API's are there (by Russel) or you
>> > are suggesting to implement them.
>>
>> I can add the fifo_alloc/dealloc as part of the suart platform_data,
>> Is that's what you are suggesting. If you may please point me out
>> to any example. I am just not clear with this.
>
> Yes, that's what I am suggesting. I don't have an exact example
> for you, but for an example of how function pointers can be passed
> along in platform data you can look at the platform data for
> DA8x FB driver in include/video/da8xx-fb.h.
>

Does this look ok.
This code snippet is in the driver file.

        if (soft_uart->use_sram) {
                soft_uart->suart_iomap.p_fifo_buff_virt_base =
                pdata->fifo_alloc(SUART_CNTX_SZ * NR_SUART * 2,
                (dma_addr_t *) 
&soft_uart->suart_iomap.p_fifo_buff_phys_base);
                if (!soft_uart->suart_iomap.p_fifo_buff_virt_base) {
                        soft_uart->suart_iomap.p_fifo_buff_virt_base =
                        dma_alloc_coherent(&pdev->dev,
                        SUART_CNTX_SZ * NR_SUART * 2,
                        (dma_addr_t *) &soft_uart->suart_iomap.
                        p_fifo_buff_phys_base, GFP_KERNEL);
                        soft_uart->use_sram = false;
                        if (!soft_uart->suart_iomap.p_fifo_buff_virt_base)
                                goto probe_exit_iounmap;
                }
        } else {
                soft_uart->suart_iomap.p_fifo_buff_virt_base =
                dma_alloc_coherent(&pdev->dev,
                SUART_CNTX_SZ * NR_SUART * 2,
                (dma_addr_t *) &soft_uart->suart_iomap.
                p_fifo_buff_phys_base, GFP_KERNEL);
                if (!soft_uart->suart_iomap.p_fifo_buff_virt_base)
                        goto probe_exit_iounmap;
        }

I added the fifo_alloc into the suart_data of the board file.

static struct da850_evm_pruss_suart_data suart_data = {
        .version        = 1,
        .setup          = da850_evm_pruss_suart_setup,
        .fifo_alloc     = sram_alloc,
        .fifo_free      = sram_free,
};

Best Regards,
Subhasish Ghosh
 
