From: mike@compulab.co.il (Mike Rapoport)
Date: Sun, 07 Feb 2010 08:53:27 +0200
Subject: [PXA320] How to find I/O registers, base address of ASIX ethernet
	chip?
In-Reply-To: <33291265356930@webmail116.yandex.ru>
References: <19621265275300@webmail108.yandex.ru>	<20100205042655.GR28972@buzzloop.caiaq.de>
	<33291265356930@webmail116.yandex.ru>
Message-ID: <4B6E6367.40306@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dennis Semakin wrote:
> Hello
> 
> I use u-boot.
> 
>>  
>>  The addresses passed to the driver is the I/O area of the chip select
>>  signal used for the Ethernet chip. This setting should be alright, as it
>>  worked well for me.
>>  
>>  If your kernel hangs when accessing this area, you most probably haven't
>>  set up your static bus correctly. The bootloader is in charge of doing
>>  this, and the correct value for CSADRCFG2 is 0x0032C809.
>>  
>>  Also see http://openpxa.sourceforge.net/ for patches to U-Boot and more
>>  information about replacing the native bootloader the modules ships
>>  with.
>>  
>>  Daniel
>>  
> 
> In U-BOOT:
> 
> MSC1 (address 0x4a00000c) - 0x0779
> $ md.w 0x4a00000c
> 4a00000c: 0779 0000 0000 0000 0000 0000 0000 0000 y...............
> 4a00001c: 0008 0000 0000 0000 0000 0000 0000 0000 ................
> 4a00002c: 0000 0000 0000 0000 0000 0000 0000 0000 ................
> 4a00003c: 0000 0000 0000 0000 0000 0000 0000 0000 ................
> 
> CSADRCFG2 (address 0x4a000088) - 0032c809
> $ md.l 0x4a000088
> 4a000088: 0032c809 00020000 00020000 00000000 ..2.............
> 4a000098: 00000000 00000000 00000000 00000000 ................
> 4a0000a8: 00000000 00000000 00000000 00000000 ................
> 4a0000b8: 00000000 00000000 00000000 00000000 ................
> 4a0000c8: 00000000 00000000 00000000 00000000 ................
> 
> As I think everythig is right and corresponds to a code
> 
> int board_init (void)
> {
> /* arch number for linux kernel */
> gd->bd->bi_arch_number = MACH_TYPE_COLIBRI320;
> 
> /* adress of boot parameters */
> gd->bd->bi_boot_params = 0x80000100;
> 
> /* configuration for ethernet chip */
> CKENB |= CKENB_7_GPIO;
> GPIO3 = 0x00001c01;
> MSC1 = 0x779;
> CSADRCFG2 = 0x0032C809;
> 
> return 0;
> }
> 

As far as I remember I had to set CSMSADRCFG to allow access CS1 region
on PXA300. Probably that's the bit that is missing in your setup as
well. The PXA300 developer manual states that "The Chip Select
Configuration Register (CSMSADRCFG) ... must be programmed with 0x02."
It does not explain anything, but without explicit setting of this bit I
had no CS1 activity at all ...

> Thanks
> Best regards
> Dennis Semakin 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Sincerely yours,
Mike.
