From: parkch98@gmail.com (Chanho Park)
Date: Tue, 5 Jul 2011 17:08:33 +0900
Subject: [PATCH 3/7] DMA: PL330: Add DMA capabilities
In-Reply-To: <00be01cc3ae2$9d3b7080$d7b25180$%kim@samsung.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
	<1309781915-31549-4-git-send-email-kgene.kim@samsung.com>
	<CAPTzV15Y7JFDKsec8x-M0C1AFLOMp39QvHpRCsO=E001P_tH9A@mail.gmail.com>
	<00be01cc3ae2$9d3b7080$d7b25180$%kim@samsung.com>
Message-ID: <CAPTzV17yr5hw=QukGdWJr_0uS2O4VwdCQsgZb1euzonVCLj+6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> Basically, src_addr_width is defined as a 'enum dma_slave_buswidth' so I
> think we don't need to consider it.
>

Client D/D normally uses 'enum dma_slave_buswidth' type.
However, dmaengine driver cannot guarantee all client D/D uses it.
See below your spi driver. Thus, the dmaengine driver check it correctly.

+#if defined(CONFIG_DMADEV_PL330)
+                       memset(&slave_config, 0, sizeof(slave_config));
+                       slave_config.direction = DMA_TO_DEVICE;
+                       slave_config.src_addr = xfer->tx_dma;
+                       slave_config.dst_addr =
+                               sdd->sfr_start + S3C64XX_SPI_TX_DATA;
+                       slave_config.dst_addr_width = sdd->cur_bpw / 8;
+                       dmaengine_slave_config(sdd->tx_chan, &slave_config);

-- 
Best Regards,
Chanho Park
