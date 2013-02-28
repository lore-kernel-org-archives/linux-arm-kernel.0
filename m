From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Thu, 28 Feb 2013 02:16:08 +0000
Subject: [PATCH Resend v5 00/16] spi/spi-atmel: add dmaengine support
 for atmel spi controller and to test the device tree support
In-Reply-To: <CAOCHtYhQsqhf1aBzh2giACMaeE0DXkcZm8qJ73rqn6njFcCaSA@mail.gmail.com>
References: <1361925297-11854-1-git-send-email-wenyou.yang@atmel.com>
 <CAOCHtYhQsqhf1aBzh2giACMaeE0DXkcZm8qJ73rqn6njFcCaSA@mail.gmail.com>
Message-ID: <B256D81BAE5131468A838E5D7A24364148FA439C@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Robert,

> -----Original Message-----
> From: Robert Nelson [mailto:robertcnelson at gmail.com]
> Sent: 2013?2?28? 1:52
> To: Yang, Wenyou
> Cc: linux-arm-kernel at lists.infradead.org; richard.genoud at gmail.com; Lin, JM;
> Ferre, Nicolas; grant.likely at secretlab.ca; plagnioj at jcrosoft.com;
> dgilbert at interlog.com
> Subject: Re: [PATCH Resend v5 00/16] spi/spi-atmel: add dmaengine support for
> atmel spi controller and to test the device tree support
> 
> On Tue, Feb 26, 2013 at 6:34 PM, Wenyou Yang <wenyou.yang@atmel.com>
> wrote:
> > Hi All,
> >
> > This set of patches is to add dmaengine support for atmel spi and to test
> device tree support.
> >
> > The work is based on Nicolas and Richard's work.
> >
> > Because the Atmel DMA device tree support hasn't on mainline, to
> at91sam9x5ek and at91sam9n12ek
> > with dma support, it doesn't work on the dmaengine mode, only on PIO mode
> so far.
> >
> > It has been tested as below:
> >  1./tested on v3.8, by using mtd utils, "mount", "umount" and "cp"
> commands.
> >  2./tested on "spi/next" git tree after removing commit "spi: make sure all
> transfer has proper speed set".
> >  3./tested by using Documentation/spi/spidev_test.c on "/dev/spidev".
> >  4./tested on on at91sam9x5ek, at91sam9m10g45ek, at91sam9263ek and
> at91sam9g20ek boards
> 
> Hi Wenyou,
> 
> Is this patchset missing another enablement patch? With v3.8.0 on the
> at91sam9g35ek (device tree boot) I'm getting..
> 
> debian at arm:~$ dmesg | grep -i spi
> [    0.890625] atmel_spi f0000000.spi: version: 0x212
> [    0.890625] atmel_spi f0000000.spi: DMA channel not available,
> unable to use SPI
> [    0.898437] atmel_spi f0000000.spi: Atmel SPI Controller using PIO only
> [    0.906250] atmel_spi f0000000.spi: Atmel SPI Controller at
> 0xf0000000 (irq 30)
> [    0.914062] atmel_spi f0000000.spi: master is unqueued, this is
> deprecated
> debian at arm:~$ ls /dev/spi*
> ls: cannot access /dev/spi*: No such file or directory
> 
> .config for reference, encase i missed something obvious:
> https://github.com/RobertCNelson/armv5_devel/blob/v3.8.x-at91/patches/def
> config
> 
> CONFIG_SPI=y
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=y
> 
> CONFIG_SPI_ATMEL=y
> 
> CONFIG_SPI_SPIDEV=y
> 
> Regards,
> 
> --
> Robert Nelson
> http://www.rcn-ee.com/

Thanks a lot for your feedback.
1./ using the at25df32 dataflash on the board, 
	based on at91_dt_defconfig default configuration, you need to add the below items:
	
	+CONFIG_MTD_M25P80=y
	+CONFIG_JFFS2_FS=y
	+CONFIG_AT_HDMAC=y

After running in the board, you will get the following message in the starting:

atmel_spi f0000000.spi: version: 0x212
atmel_spi f0000000.spi: DMA channel not available, unable to use SPI
atmel_spi f0000000.spi: Atmel SPI Controller using PIO only
atmel_spi f0000000.spi: Atmel SPI Controller at 0xf0000000 (irq 30)
atmel_spi f0000000.spi: master is unqueued, this is deprecated
m25p80 spi32766.0: at25df321a (4096 Kbytes)

# cat /proc/mtd | grep spi
mtd5: 00400000 00001000 "spi32766.0"

# ls /dev/mtdblock*
/dev/mtdblock0  /dev/mtdblock2  /dev/mtdblock4
/dev/mtdblock1  /dev/mtdblock3  /dev/mtdblock5


2./ using "spidev", based on at91_dt_defconfig default configuration, you need to add the below items:
	
	+CONFIG_SPI_SPIDEV=y

	And you need to change at91sam9x5ek.dtsi as below:

diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index 09f5e66..4c48ba2 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -89,7 +89,7 @@
                                status = "okay";
                                cs-gpios = <&pioA 14 0>, <0>, <0>, <0>;
                                m25p80 at 0 {
-                                       compatible = "atmel,at25df321a";
+                                       compatible = "spidev";
                                        spi-max-frequency = <50000000>;
                                        reg = <0>;
                                };

After running in the board, you will get the following message :

# ls /dev/spi*
/dev/spidev32766.0

Best Regards,
Wenyou Yang
