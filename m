From: ml@communistcode.co.uk (Jack Mitchell)
Date: Wed, 03 Jul 2013 16:01:04 +0100
Subject: socfpga: mmc problems
Message-ID: <51D43CB0.4070104@communistcode.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having received one of the new Arrow SoCkit boards at a recent training 
day I set about seeing how far mainline was in successfully booting this 
board.

As I wanted to boot from mmc, I first checked out linux-next [1] in 
order to get the newly merged mmc driver, I then applied the device-tree 
enablement series [2] on top before finally attempting to boot. I then 
found that the standard socfpga_defconfig didn't enable the MMC drivers, 
which I also did (should this be part of the socfpga_defconfig...?).

However, the boot hangs at:

Synopsys Designware Multimedia Card Interface Driver
dwmmc_socfpga ff704000.dwmmc0: Using internal DMA controller.
dwmmc_socfpga ff704000.dwmmc0: DW MMC controller at irq 171, 32 bit host 
data width, 1024 deep fifo

To fix this I checked out the diff between the Altera vendor mmc driver 
and the mainline driver and found that if I added this small change:


   if (of_property_read_u32(dev->of_node, "pwr-en", &pwr_en)) {
     dev_info(dev, "couldn't determine pwr-en, assuming pwr-en = 0\n");
     pwr_en = 0;
   }

   /* Set PWREN bit */
   mci_writel(host, PWREN, pwr_en);

In the dw_mci_socfpga_priv_init function, the board would boot.

Synopsys Designware Multimedia Card Interface Driver
dwmmc_socfpga ff704000.dwmmc0: couldn't determine pwr-en, assuming 
pwr-en = 0
dwmmc_socfpga ff704000.dwmmc0: Using internal DMA controller.
dwmmc_socfpga ff704000.dwmmc0: DW MMC controller at irq 171, 32 bit host 
data width, 1024 deep fifo
mmc_host mmc0: Bus speed (slot 0) = 100000000Hz (slot req 400000Hz, 
actual 400000HZ div = 125)
dwmmc_socfpga ff704000.dwmmc0: 1 slots initialized
dwmmc_socfpga ff704000.dwmmc0: Version ID is 240a
.....
.....
.....


Has this been overlooked, or are there some other changes elsewhere that 
I haven't yet come across which addresses this?

Cheers,

[1] fa1383200d289afdff2f5678eb89483daa537465
[2] http://comments.gmane.org/gmane.linux.ports.arm.kernel/243529

-- 

   Jack Mitchell (jack at embed.me.uk)
   Embedded Systems Engineer
   http://www.embed.me.uk

--
