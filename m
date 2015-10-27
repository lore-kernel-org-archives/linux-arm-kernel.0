From: kernel@tekno-soft.it (Roberto Fichera)
Date: Tue, 27 Oct 2015 15:45:11 +0100
Subject: iMX6 SSI in TDM master mode and SDMA
Message-ID: <562F8DF7.2000704@tekno-soft.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi There,

I'm having an SDMA freeze when putting the SSI in TDM master mode while
developing a DAHDI kernel driver. Kernel is the official freescale v3.14.28.

The DTS is setting the pinmux as:

        /*
         * set IOMUX SD3_DATA0-3 to PCM SLIC signal
         */
        pinctrl_audmux_1: audmuxgrp-3 {
            fsl,pins = <
                MX6SX_PAD_SD3_DATA1__AUDMUX_AUD6_TXC    0x130B1    /* PCLK */
                MX6SX_PAD_SD3_DATA2__AUDMUX_AUD6_TXFS   0x130B1    /* FSYNC */
                MX6SX_PAD_SD3_DATA0__AUDMUX_AUD6_RXD    0x130B1    /* DTX */
                MX6SX_PAD_SD3_DATA3__AUDMUX_AUD6_TXD    0x130B1    /* DRX */
            >;
        };

SSI1 is the default in imx6sx.dtsi but enabled in my custom DTS, the DMA use
the mode 1 IMX_DMATYPE_SSI_SP

                ssi1: ssi at 02028000 {
                    compatible = "fsl,imx6sx-ssi", "fsl,imx21-ssi";
                    reg = <0x02028000 0x4000>;
                    interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
                    clocks = <&clks IMX6SX_CLK_SSI1_IPG>,
                         <&clks IMX6SX_CLK_SSI1>;
                    clock-names = "ipg", "baud";
                    dmas = <&sdma 37 1 0>, <&sdma 38 1 0>;
                    dma-names = "rx", "tx";
                    status = "disabled"; 
                };

The SSI1 is connected in PCM mode to a SiLabs SLIC Si32178 and from
hardware point of view all PCLK and FSYNC are correct (2048KHz having 8 slots @ 32bit width).
The SLIC is reporting stable both PCLK and FSYNC while running for a day.

Both RX and TX FIFOs are setup to trigger DMA transfer once
their related watermarks reach 8 slots of 8bits each.

So far so good I've setup a DMA transfer for both TX and RX FIFOs, in the _probe() function

tdm_real_slots are the number of masked slots, currently 2 and the both TX and RX watermarks
are set to tdm_real_slots * 4 = 8 bytes

          ssi_private->tx_chan = dma_request_slave_channel_reason(&pdev->dev, "tx");
          if (IS_ERR(ssi_private->tx_chan))
          {
        dev_err(&pdev->dev, "could not get TX DMA\n");
            ssi_private->tx_chan = NULL;
          }
          else
          {
            slave_config.direction = DMA_MEM_TO_DEV;
            slave_config.dst_addr = ssi_private->ssi_phys + offsetof(struct ccsr_ssi, stx0);
            slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
            slave_config.dst_maxburst = ssi_private->tdm_real_slots * 4;
            ret = dmaengine_slave_config(ssi_private->tx_chan, &slave_config);
            if (ret) {
                    dev_err(&pdev->dev, "error in TX DMA configuration.\n");
            }
          }

          ssi_private->rx_chan = dma_request_slave_channel_reason(&pdev->dev, "rx");
          if (IS_ERR(ssi_private->rx_chan))
          {
        printk("could not get RX DMA\n");
            ssi_private->rx_chan = NULL;
          }
          else
          {
            slave_config.direction = DMA_DEV_TO_MEM;
            slave_config.src_addr = ssi_private->ssi_phys + offsetof(struct ccsr_ssi, srx0);
            slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
            slave_config.src_maxburst = ssi_private->tdm_real_slots * 4;
            ret = dmaengine_slave_config(ssi_private->rx_chan, &slave_config);
            if (ret) {
                    dev_err(&pdev->dev, "error in RX DMA configuration.\n");
            }
          }

Both TX and RX dma descriptors are initialized like this:

    if ( ssi_private->use_dma )
    {
        struct dma_async_tx_descriptor *desc;

        ssi_private->rx_callback = callback;
        ssi_private->rx_userparam = userparam;
        ssi_private->rx_buffer_len = buffer_len;
        ssi_private->rx_buffer_count = buffer_len;
        ssi_private->rx_buf = dma_alloc_coherent(NULL, buffer_len,
                                        &ssi_private->rx_dmaaddr, GFP_KERNEL);
        if (!ssi_private->rx_buf) {
                printk("cannot alloc RX DMA buffer.\n");
                return -ENOMEM;
        }

        desc = dmaengine_prep_dma_cyclic(ssi_private->rx_chan, ssi_private->rx_dmaaddr,
                buffer_len, ssi_private->tdm_real_slots*4,
                DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
        if (!desc) {
                printk("Prepare for the RX slave dma failed!\n");
                return -EINVAL;
        }

        desc->callback = dma_rx_callback;
        desc->callback_param = ssi_private;

        printk("RX: prepare for the DMA.\n");
        dmaengine_submit(desc);
        dma_async_issue_pending(ssi_private->rx_chan);
    }

    if ( ssi_private->use_dma )
    {
        struct dma_async_tx_descriptor *desc;

        ssi_private->tx_callback = callback;
        ssi_private->tx_userparam = userparam;
        ssi_private->tx_buffer_len = buffer_len;
        ssi_private->tx_buffer_count = buffer_len;
        ssi_private->tx_buf = dma_alloc_coherent(NULL, buffer_len,
                                        &ssi_private->tx_dmaaddr, GFP_KERNEL);
        if (!ssi_private->tx_buf) {
                printk("cannot alloc TX DMA buffer.\n");
                return -ENOMEM;
        }

        desc = dmaengine_prep_dma_cyclic(ssi_private->tx_chan, ssi_private->tx_dmaaddr,
                buffer_len, ssi_private->tdm_real_slots*4,
                DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
        if (!desc) {
                printk("Prepare for the TX slave dma failed!\n");
                return -EINVAL;
        }

        desc->callback = dma_tx_callback;
        desc->callback_param = ssi_private;

        printk("TX: prepare for the DMA.\n");
        dmaengine_submit(desc);
        dma_async_issue_pending(ssi_private->tx_chan);
    }

Once I'll enable the SSI clock to enable the TDM, I'm getting only 2000 or so interrupts and then everything freeze.
Below some log related to the imx-sdma reporting correctly all wml, shp_addr and 2 entry having 8 bytes each

dmaengine: private_candidate: wrong capabilities
dmaengine: __dma_request_channel: success (dma1chan0)
imx-sdma 20ec000.sdma: load_address = 960
imx-sdma 20ec000.sdma: wml = 0x00000008
imx-sdma 20ec000.sdma: shp_addr = 0x02028000
imx-sdma 20ec000.sdma: per_addr = 0x00000000
imx-sdma 20ec000.sdma: event_mask0 = 0x00000000
imx-sdma 20ec000.sdma: event_mask1 = 0x00000040
dmaengine: private_candidate: wrong capabilities
dmaengine: private_candidate: dma1chan0 busy
dmaengine: __dma_request_channel: success (dma1chan1)
imx-sdma 20ec000.sdma: load_address = 891
imx-sdma 20ec000.sdma: wml = 0x00000008
imx-sdma 20ec000.sdma: shp_addr = 0x02028008
imx-sdma 20ec000.sdma: per_addr = 0x00000000
imx-sdma 20ec000.sdma: event_mask0 = 0x00000000
imx-sdma 20ec000.sdma: event_mask1 = 0x00000020
si3217x_ssi_probe: SSI base is 0xa0b10000 clock rate is 2048000Hz, TDM Frame rate 8000Hz, channels 8 having 8 bits word
length
si3217x_audmux_probe: AUDMUX base is 0xa0b18000
si3217x_probe: SPI setup mode 3, 8 bits/w, 10000000 Hz max
imx-sdma 20ec000.sdma: sdma_prep_dma_cyclic channel: 2
imx-sdma 20ec000.sdma: load_address = 891
imx-sdma 20ec000.sdma: wml = 0x00000008
imx-sdma 20ec000.sdma: shp_addr = 0x02028008
imx-sdma 20ec000.sdma: per_addr = 0x00000000
imx-sdma 20ec000.sdma: event_mask0 = 0x00000000
imx-sdma 20ec000.sdma: event_mask1 = 0x00000020
imx-sdma 20ec000.sdma: entry 0: count: 8 dma: 0x9c4a0000  intr
imx-sdma 20ec000.sdma: entry 1: count: 8 dma: 0x9c4a0008 wrap intr
RX: prepare for the DMA.
imx-sdma 20ec000.sdma: sdma_prep_dma_cyclic channel: 1
imx-sdma 20ec000.sdma: load_address = 960
imx-sdma 20ec000.sdma: wml = 0x00000008
imx-sdma 20ec000.sdma: shp_addr = 0x02028000
imx-sdma 20ec000.sdma: per_addr = 0x00000000
imx-sdma 20ec000.sdma: event_mask0 = 0x00000000
imx-sdma 20ec000.sdma: event_mask1 = 0x00000040
imx-sdma 20ec000.sdma: entry 0: count: 8 dma: 0x9c495000  intr
imx-sdma 20ec000.sdma: entry 1: count: 8 dma: 0x9c495008 wrap intr
TX: prepare for the DMA.
si3217x_ssi_setup: tdm_slots_enabled=0x00000003, 0xfffffffc
si3217x_ssi_setup: SSI_STMSK=0x000000fc,SSI_SRMSK=0x000000fc
si3217x_ssi_set_clock: BIT_CLK=53248000

Finally the SSI1 registers are set like this:

        ssi_scr=0x000000bf
        ssi_sier=0x01d005f5
        ssi_stcr=0x000002e8
        ssi_srcr=0x00000288
        ssi_stccr=0x0000670b
        ssi_srccr=0x0000670b
        ssi_sfcsr=0x0088f088
        ssi_stmsk=0xfffffffc
        ssi_srmsk=0xfffffffc

and the statistics related to DMA freeze as

        RX DMA frame count=1001
        RX DMA addr=0x9c659000
        RX DMA buffer len=16
        TX DMA frame count=1003
        TX DMA addr=0x9c658000
        TX DMA buffer len=16

Does anyone can suggest how to make the DMA working?

Thanks in advance,
Roberto Fichera.
