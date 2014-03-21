From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 21 Mar 2014 14:53:16 -0600
Subject: drivers/dma/edma.c unconditional registration
Message-ID: <532CA6BC.9010506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I see the following code which unconditionally registers an SoC-specific
DMA driver in drivers/dma/edma.c:

static int edma_init(void)
{
        int ret = platform_driver_register(&edma_driver);

        if (ret == 0) {
                pdev0 = platform_device_register_full(&edma_dev_info0);
...
}
subsys_initcall(edma_init);

This means that when I boot multi_v7_defconfig on a Tegra system, that
driver probes. Luckily, this doesn't actually seem to cause any visible
symptoms beyond the syslog entry "edma-dma-engine edma-dma-engine.0:
Can't allocate PaRAM dummy slot", but still should be fixed.
