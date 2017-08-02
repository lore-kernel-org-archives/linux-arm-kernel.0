From: vasilyev@ispras.ru (Anton Vasilyev)
Date: Wed, 2 Aug 2017 19:59:30 +0300
Subject: net: thunderx: Buffer overwrite on bgx_probe
Message-ID: <86a1b4d9-db67-4380-13c9-f759d2e05ed9@ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

While searching for memory errors in Linux kernel I've come across
drivers/net/ethernet/cavium/thunder/thunder_bgx.ko module.

I've found buffer overwrite at bgx_probe():
Consider device PCI_SUBSYS_DEVID_83XX_BGX.
max_bgx_per_node is set to 4 by set_max_bgx_per_node().
Then on branch:
     pci_read_config_word(pdev, PCI_DEVICE_ID, &sdevid);
     if (sdevid != PCI_DEVICE_ID_THUNDER_RGX) {
         bgx->bgx_id = (pci_resource_start(pdev,
             PCI_CFG_REG_BAR_NUM) >> 24) & BGX_ID_MASK;
         bgx->bgx_id += nic_get_node_id(pdev) * max_bgx_per_node;

bgx->bgx_id could achieve value 3 + 3 * 4 = 15,
which lead to buffer overwrite on
         bgx_vnic[bgx->bgx_id] = bgx;

Question: is it enough for fix to change bgx_vnic's size?

Found by Linux Driver Verification project (linuxtesting.org).

-- 
Anton Vasilyev
Linux Verification Center, ISPRAS
web: http://linuxtesting.org
e-mail: vasilyev at ispras.ru
