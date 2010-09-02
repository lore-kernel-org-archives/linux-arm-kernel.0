From: jason77.wang@gmail.com (Jason Wang)
Date: Thu,  2 Sep 2010 15:51:58 +0800
Subject: [PATCH 0/6] add spi support for i.MX51 in the existing spi_imx driver
Message-ID: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some explanations:

This patchset is to add SPI support in the existing spi_imx driver for
i.MX51 and add SPI relating stuffs for mx51_3ds board level.

i.MX51 has two eCSPI controllers and one CSPI controller, CSPI
controller is 100% compatible with the one of i.MX35, so we don't need
to add new functions for this CSPI, only bind it with i.MX35 together,
while eCSPI isn't compatible with existing controllers of i.MX
platforms, so i add new functions for these two eCSPIs in the existing
spi_imx driver.

If these patches pass review, the first patch 0001-xxx.patch should be
merged by Grant.likely; other patches(0002-0006) are based off
imx-for-2.6.37 and should be handled by Sascha.

On mx51_3ds board, there is a SPI NOR flash connected through eCSPI2,
i have validated this patchset using this SPI NOR flash, see results:
(bootlogs)
<snip>
m25p80 spi1.1: found sst25vf016b, expected m25p80
m25p80 spi1.1: sst25vf016b (2048 Kbytes)
spi_imx spi_imx.1: probed
<snip>
(target tty console)
# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00200000 00001000 "spi1.1"
# mtd_debug read /dev/mtd0 0 0x100 /a.txt
Copied 256 bytes from address 0x00000000 in flash to /a.txt
# hexdump a.txt 
0000000 0000 eb00 0b53 eb00 002c e28f 0c00 e890
0000010 a000 e08a b000 e08b 7001 e24a 000b e15a
0000020 0000 1a00 0b4b eb00 000f e8ba e018 e24f
0000030 0001 e313 f003 1047 ff13 e12f 3720 0000
0000040 3730 0000 3000 e3b0 4000 e3b0 5000 e3b0
0000050 6000 e3b0 2010 e252 0078 28a1 fffc 8aff
0000060 2e82 e1b0 0030 28a1 3000 4581 ff1e e12f
0000070 e004 e52d 7000 e10f 700f e3c7 6001 e287
0000080 f006 e12f 0001 e040 d000 e1a0 6002 e287
0000090 f006 e12f 0001 e040 d000 e1a0 6006 e287
00000a0 f006 e12f 0001 e040 d000 e1a0 6007 e287
00000b0 f006 e12f 0001 e040 d000 e1a0 600b e287
00000c0 f006 e12f 0001 e040 d000 e1a0 600f e287
00000d0 f006 e12f 0001 e040 d000 e1a0 6003 e287
00000e0 60c0 e3c6 f006 e12f f004 e49d f003 e320
00000f0 ff1e e12f 4001 e92d 0f11 ee11 0001 e380


Thanks,
Jason.
