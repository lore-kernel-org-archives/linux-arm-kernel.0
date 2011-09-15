From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 15 Sep 2011 09:55:57 +0200
Subject: [PATCH v12 0/3] add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <1315450031-6371-1-git-send-email-b32955@freescale.com>
References: <1315450031-6371-1-git-send-email-b32955@freescale.com>
Message-ID: <20081.44941.12535.496764@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Huang Shijie writes:
> The patch set is based on Artem's tree:
> 	http://git.infradead.org/users/dedekind/l2-mtd-2.6.git
> 
> The general-purpose media interface(GPMI) controller is a flexible interface
> to up to several NAND flashs.
> 
> The Bose Ray-Choudhury Hocquenghem(BCH) module is a hardware ECC accelerator.
> 
> With the help of BCH, the GPMI controller can choose to do the hardware ECC or
> not.
> 
> This driver is a _pure_ MTD NAND controller driver now.
> 
> 
> The driver depends on another GPMI-NAND device patch set, you can find them at :
> 	[1] http://marc.info/?l=linux-arm-kernel&m=131416901319573&w=2
> 	[2] http://marc.info/?l=linux-arm-kernel&m=131416912319668&w=2
> 	[3] http://marc.info/?l=linux-arm-kernel&m=131416891119504&w=2
> 	[4] http://marc.info/?l=linux-arm-kernel&m=131416896219539&w=2
> 
> Test environment:
> 	Using imx23 and imx28 boards for test. 
> 
> 	imx23 :
> 	console=ttyAMA0,115200 mtdparts=gpmi-nfc:20m(boot),-(user)
> 	Tested by USB boot and NAND boot.
> 
>         imx28 :
> 	#console=ttyAMA0,115200 root=/dev/mmcblk0p3 rw rootwait 
> 	Tested by SD card boot mode.
> 
How did you perform your tests?

I tried this driver on our TX28 board with the result that with
concurrent access of the SD card and the NAND flash, I still get the
dreaded DMA timeouts within seconds:
DMA timeout, last DMA :1
GPMI regs:
            HW_GPMI_CTRL0[000]=21800001
          HW_GPMI_COMPARE[010]=00000000
          HW_GPMI_ECCCTRL[020]=00000000
         HW_GPMI_ECCCOUNT[030]=00000840
          HW_GPMI_PAYLOAD[040]=46578000
        HW_GPMI_AUXILIARY[050]=46578800
            HW_GPMI_CTRL1[060]=0004000c
          HW_GPMI_TIMING0[070]=00010203
          HW_GPMI_TIMING1[080]=05000000
          HW_GPMI_TIMING2[090]=09020101
             HW_GPMI_STAT[0b0]=0d000003
            HW_GPMI_DEBUG[0c0]=01000000
BCH regs:
              HW_BCH_CTRL[000]=00000100
           HW_BCH_STATUS0[010]=00000010
              HW_BCH_MODE[020]=00000000
         HW_BCH_ENCODEPTR[030]=00000000
           HW_BCH_DATAPTR[040]=00000000
           HW_BCH_METAPTR[050]=00000000
      HW_BCH_LAYOUTSELECT[070]=00000000
     HW_BCH_FLASH0LAYOUT0[080]=030a4200
     HW_BCH_FLASH0LAYOUT1[090]=08404200
            HW_BCH_DEBUG0[100]=00000000
DMA regs:
           HW_APBHX_CTRL0[000]=30000000
           HW_APBHX_CTRL1[010]=ffff0000
           HW_APBHX_CTRL2[020]=00000000
    HW_APBHX_CHANNEL_CTRL[030]=00000000
    HW_APBHX_CHn_CURCMDAR(0)[100]=46e1c000
    HW_APBHX_CHn_NXTCMDAR(0)[110]=46e1c04c
         HW_APBHX_CHn_CMD(0)[120]=000001c8
         HW_APBHX_CHn_BAR(0)[130]=00000000
        HW_APBHX_CHn_SEMA(0)[140]=00000000
      HW_APBHX_CHn_DEBUG1(0)[150]=00a0001e
      HW_APBHX_CHn_DEBUG2(0)[160]=00000000
    HW_APBHX_CHn_CURCMDAR(4)[2c0]=4652c098
    HW_APBHX_CHn_NXTCMDAR(4)[2d0]=4652c0e4
         HW_APBHX_CHn_CMD(4)[2e0]=000001c9
         HW_APBHX_CHn_BAR(4)[2f0]=46553241
        HW_APBHX_CHn_SEMA(4)[300]=00010000
      HW_APBHX_CHn_DEBUG1(4)[310]=27a00015
      HW_APBHX_CHn_DEBUG2(4)[320]=00000000
BCH Geometry :
GF length              : 13
ECC Strength           : 8
Page Size in Bytes     : 2112
Metadata Size in Bytes : 10
ECC Chunk Size in Bytes: 512
ECC Chunk Count        : 4
Payload Size in Bytes  : 2048
Auxiliary Size in Bytes: 16
Auxiliary Status Offset: 12
Block Mark Byte Offset : 1999
Block Mark Bit Offset  : 0

I'm doing a:
dd if=/dev/mtd0 > /dev/null & dd if=/dev/mmcblk0 > /dev/null
Sometimes the 'dd' accessing the SD card will stall indefinitely.
Also copying data from SD card to flash will produce the error, though
less likely.

This looks like the problem arises in the DMA driver when multiple
channels are being used concurrently. The GPMI driver will bail out
with the timeout error while the MMC driver obviously has no timeout
check for this situation.

I can mostly rule out HW problems, because the same board works
perfectly well with WindowsCE (tested with a copy operation between
flash and SD card).


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
