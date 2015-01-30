From: hs@denx.de (Heiko Schocher)
Date: Fri, 30 Jan 2015 12:39:59 +0100
Subject: imx6dl, spi: read/write problem with SPI-NOR on imx6d
Message-ID: <54CB6D8F.5010804@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I just tried on the imx6dl based aristainetos board linux kernel:

Linux version 3.18.2+ (hs at pollux.denx.de) (gcc version 4.7.2 (GCC) ) #1 SMP Mon Jan 26 08:06:33 CET 2015

and detected problems with the SPI NOR flash on it. I found this patch:

commit f62caccd12c17e4cb516d43a6e4dd8a3abc1f7e0
Author: Robin Gong <b38343@freescale.com>
Date:   Thu Sep 11 09:18:44 2014 +0800

     spi: spi-imx: add DMA support

     Enable DMA support on i.mx6. The read speed can increase from 600KB/s
     to 1.2MB/s on i.mx6q. You can disable or enable dma function in dts.
     If not set "dma-names" in dts, spi will use PIO mode. This patch only
     validate on i.mx6, not i.mx5, but encourage ones to apply this patch
     on i.mx5 since they share the same IP.

     Note:
       Sometime, there is a weid data in rxfifo after one full tx/rx
     transfer finish by DMA on i.mx6dl, so we disable dma functhion on
     i.mx6dl.

     Signed-off-by: Frank Li <Frank.Li@freescale.com>
     Signed-off-by: Robin Gong <b38343@freescale.com>
     Acked-by: Marek Vasut <marex@denx.de>
     Signed-off-by: Mark Brown <broonie@kernel.org>

If I disable DMA with:

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 9596ed5..2ee9625 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -253,7 +253,6 @@
                                                  <&clks IMX6QDL_CLK_ECSPI4>;
                                         clock-names = "ipg", "per";
                                         dmas = <&sdma 9 7 1>, <&sdma 10 7 2>;
-                                       dma-names = "rx", "tx";
                                         status = "disabled";
                                 };



With this change it works again (slowly and with ~100% CPU load as PIO
mode is used)

First question:

I have a imx6 DL on this board:

CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d

and I could not see in the commit f62caccd, that DMA gets disabled
for imx6dl ... Is this missing? Or should this be done in the board
specific DTS?

Second question:

Commit messages says:

     Note:
       Sometime, there is a weid data in rxfifo after one full tx/rx
     transfer finish by DMA on i.mx6dl, so we disable dma functhion on
     i.mx6dl.

Do somebody have informations if this is a HW error, or could this
fixed in software somehow? Maybe there is an errata for it? Is there
some work pending on this issue?

Thanks in advance!

bye,
Heiko

PS: Here some more informations from Cajus to the problem:

we currently have two designs with the i.MX6 DL.
On both designs we use a 16M SPI NOR flash n25q128a1x. (x=1 is 1V8, x=3 is 3V3)
aristainetos target: 3V3 design, NOR flash is on chip select #0 of SPI3
aristainetos2 target: 1V8 design, NOR flash is on chip select #1 of SPI3
Both designs react differently.
When DMA is enabled, both targets show
   spi_master spi3: I/O Error in DMA RX
   spi_master spi3: failed to transfer one message from queue
when using the flashcp command.
The aristainetos target seem to write the data correctly and the processes will not freeze during read or write commands.
On the aristainetos2 target the read or write process will freeze. Sometimes during read, sometimes during write.

aristainetos target:
3V3 design, NOR flash is on chip select #0

without DMA
[    3.080308] of_dma_request_slave_channel: dma-names property of node '/soc/aips-bus at 02000000/spba-bus at 02000000/ecspi at 02014000' missing or empty
[    3.091939] spi_imx 2014000.ecspi: cannot get the TX DMA channel!
[    3.096771] spi_imx 2014000.ecspi: dma setup error,use pio instead
[    3.104825] m25p80 spi3.0: found n25q128a13, expected n25q128a11
[    3.109620] m25p80 spi3.0: n25q128a13 (16384 Kbytes)
[    3.113316] 4 cmdlinepart partitions found on MTD device spi3.0
[    3.117980] Creating 4 MTD partitions on "spi3.0":
[    3.121489] 0x000000000000-0x0000000d0000 : "u-boot"
[    3.129012] 0x0000000d0000-0x0000000e0000 : "env"
[    3.135416] 0x0000000e0000-0x0000000f0000 : "env-red"
[    3.142286] 0x0000000f0000-0x000001000000 : "rescue-system"

root at aristainetos:~# flashcp -v /boot/rescue.itb /dev/mtd4
Erasing blocks: 149/149 (100%)
Writing data: 9514k/0k (100%))
Verifying data: 9514k/0k (100%))


with DMA
[    3.086308] m25p80 spi3.0: found n25q128a13, expected n25q128a11
[    3.091047] m25p80 spi3.0: n25q128a13 (16384 Kbytes)
[    3.094738] 4 cmdlinepart partitions found on MTD device spi3.0
[    3.099469] Creating 4 MTD partitions on "spi3.0":
[    3.102980] 0x000000000000-0x0000000d0000 : "u-boot"
[    3.110572] 0x0000000d0000-0x0000000e0000 : "env"
[    3.117091] 0x0000000e0000-0x0000000f0000 : "env-red"
[    3.123885] 0x0000000f0000-0x000001000000 : "rescue-system"
[    3.133588] spi_imx 2014000.ecspi: probed

root at aristainetos:~# flashcp -v /boot/rescue.itb /dev/mtd4
Erasing blocks: 149/149 (100%)
Writing data: 290k/0k (9514%)
spi_master spi3: I/O Error in DMA RX
spi_master spi3: failed to transfer one message from queue
Writing data: 9514k/0k (100%))
Verifying data: 9514k/0k (100%))

##############################################################################################################################

aristainetos2 target:
1V8 design, NOR flash is on chip select #1

without DMA
[    3.750335] of_dma_request_slave_channel: dma-names property of node '/soc/aips-bus at 02000000/spba-bus at 02000000/ecspi at 02014000' missing or empty
[    3.762025] spi_imx 2014000.ecspi: cannot get the TX DMA channel!
[    3.766833] spi_imx 2014000.ecspi: dma setup error,use pio instead
[    3.774578] m25p80 spi3.1: n25q128a11 (16384 Kbytes)
[    3.778276] 4 cmdlinepart partitions found on MTD device spi3.1
[    3.783013] Creating 4 MTD partitions on "spi3.1":
[    3.786526] 0x000000000000-0x0000000d0000 : "u-boot"
[    3.794276] 0x0000000d0000-0x0000000e0000 : "env"
[    3.801002] 0x0000000e0000-0x0000000f0000 : "env-red"
[    3.807761] 0x0000000f0000-0x000001000000 : "rescue-system"
[    3.816809] spi_imx 2014000.ecspi: probed


root at aristainetos2:~# flashcp -v /boot/rescue.itb /dev/mtd4
Erasing blocks: 152/152 (100%)
Writing data: 9685k/0k (100%))
Verifying data: 9685k/0k (100%))


with DMA
[    3.746736] m25p80 spi3.1: n25q128a11 (16384 Kbytes)
[    3.750434] 4 cmdlinepart partitions found on MTD device spi3.1
[    3.755105] Creating 4 MTD partitions on "spi3.1":
[    3.758615] 0x000000000000-0x0000000d0000 : "u-boot"
[    3.766305] 0x0000000d0000-0x0000000e0000 : "env"
[    3.772835] 0x0000000e0000-0x0000000f0000 : "env-red"
[    3.779549] 0x0000000f0000-0x000001000000 : "rescue-system"
[    3.788521] spi_imx 2014000.ecspi: probed

root at aristainetos2:~# flashcp -v /boot/rescue.itb /dev/mtd4
Erasing blocks: 152/152 (100%)
Writing data: 5810k/0k (9685%)
spi_master spi3: I/O Error in DMA RX
spi_master spi3: failed to transfer one message from queue
Writing data: 9685k/0k (100%))
Verifying data: 10k/0k (9685%)   at this point the task freezes.
the [spi3] process is shown as "D" in ps, the flashcp process is "D+".
The flashcp process cannot be killed, not even with kill -9.
It seems like everything was written correctly (verified with u-boot), but trying to read the content with hexdump failed after multiples of 0x1000 bytes read. hexdump freezes.
It is not always freezing at the same address!

root at aristainetos2:~# flash_erase /dev/mtd4 0 0
Erasing 64 Kibyte @ f00000 -- 100 % complete
root at aristainetos2:~# dd if=/boot/rescue.itb of=/dev/mtd4  dd also freezes very fast, hexdump shows, that only 0x20f0 bytes have been written.

root at aristainetos2:~# hexdump /dev/mtd4
00020b0 530f 00e3 2cdd 5df4 0fd6 165c f005 9da8
00020c0 1088 87e0 7ee5 6387 0d33 f057 2b5c e801
00020d0 a60e fe80 ebab 204a 7e15 3e1f bd00 70fb
00020e0 4a0e 4d03 2b5e 4028 090d 0ca0 0f7f 05e8
00020f0 44e0 0ee0 9740 04e7 8770 0ee2 9780 1ce7
0002100 ffff ffff ffff ffff ffff ffff ffff ffff
*
0f10000
This time hexdump completed without freezing!

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
