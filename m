From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 26 Nov 2013 00:04:52 +0100
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
In-Reply-To: <20131125120335.GD2408@localhost> (Ezequiel Garcia's message of
 "Mon, 25 Nov 2013 09:03:36 -0300")
References: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <87d2lp28pd.fsf@natisbad.org> <20131125120335.GD2408@localhost>
Message-ID: <87r4a4f5gr.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Ezequiel Garcia <ezequiel.garcia@free-electrons.com> writes:

> On Sun, Nov 24, 2013 at 03:08:46PM +0100, Arnaud Ebalard wrote:
>> 
>> As ReadyNAS 102, 104 and 2120 all depend on your driver, I decided to
>> give v4 a change on a 102. As a side note, all those device have the
>> same NAND chip, i.e. a 128 MB hynix H27U1G8F2BTR. Additionally, this is
>> also the chip found on ReadyNAS Duo v2, which is perfectly handled by
>> orion-nand driver.
>> 
>> With your 31 patches in my quilt set against current linus tree (w/
>> 2 to 4 of 31 disabled as they are already in Linus tree), I modified
>> my .dts in the following way:
>> 
>>  nand at d0000 {
>>          status = "okay";
>>          num-cs = <1>;
>>          marvell,nand-keep-config;
>>          marvell,nand-enable-arbiter;
>>          nand-on-flash-bbt;
>> 
>
> Great! Thanks for giving NAND a chance :-)
>
> Could you try using the devicetree snippet below?
>
> nand at d0000 {
> 	/* HACK: Use legacy compatible to handle smaller pages */
> 	compatible = "marvell,pxa3xx-nand";
> 	status = "okay";
> 	num-cs = <1>;
> 	marvell,nand-keep-config;
> 	marvell,nand-enable-arbiter;
> 	nand-on-flash-bbt;
>
> 	/* partitions */
> };


The snippet above gave me the following:

pxa3xx-nand d00d0000.nand: This platform can't do DMA on this device
pxa3xx-nand d00d0000.nand: Wait time out!!!
pxa3xx-nand d00d0000.nand: Wait time out!!!
pxa3xx-nand d00d0000.nand: Wait time out!!!
pxa3xx-nand d00d0000.nand: failed to scan nand at cs 0

So, I then tried and match the chip->chip_delay with the one in
kirkwood.dtsi (by setting it to 25) but this provided the same
result.


Then, I tried a different approach: use the armada370 variant but w/ a
small extension of your armada370_ecc_init():

@@ -1388,6 +1388,14 @@
                ecc->layout = &ecc_layout_4KB_bch8bit;
                ecc->strength = 16;
                return 1;
+       } else if (page_size == 2048) {
+               info->chunk_size = 2048;
+               info->spare_size = 40;
+               info->ecc_size = 24;
+               ecc->mode = NAND_ECC_HW;
+               ecc->size = 2048;
+               ecc->strength = 1;
+               return 1;
        }
        return 0;
 }

For the record, my .dts had the following at that point:

	nand at d0000 {
		status = "okay";
		num-cs = <1>;
		marvell,nand-keep-config;
		marvell,nand-enable-arbiter;
		nand-on-flash-bbt;

                /* partitions */

        };

And \o/ i.e. here is what I get:

root at mood:~# dmesg
...
pxa3xx-nand d00d0000.nand: This platform can't do DMA on this device
NAND device: Manufacturer ID: 0xad, Chip ID: 0xf1 (Hynix H27U1G8F2BTR-BC)
NAND device: 128MiB, SLC, page size: 2048, OOB size: 64
Bad block table found at page 65472, version 0x01
Bad block table found at page 65408, version 0x01
5 ofpart partitions found on MTD device pxa3xx_nand-0
Creating 5 MTD partitions on "pxa3xx_nand-0":
0x000000000000-0x000000180000 : "u-boot"
0x000000180000-0x0000001a0000 : "u-boot-env"
0x000000200000-0x000000800000 : "uImage"
0x000000800000-0x000001800000 : "minirootfs"
0x000001800000-0x000008000000 : "jffs2"
...

root at mood:~# ls /dev/mtd
mtd0       mtd1ro     mtd3       mtd4ro     mtdblock2  
mtd0ro     mtd2       mtd3ro     mtdblock0  mtdblock3  
mtd1       mtd2ro     mtd4       mtdblock1  mtdblock4  

root at mood:~# dd if=/dev/mtd2ro of=/tmp/foo
12288+0 records in
12288+0 records out
6291456 bytes (6.3 MB) copied, 1.98731 s, 3.2 MB/s

root at mood:~# file /tmp/foo 
/tmp/foo: u-boot legacy uImage, Linux-3.12.0.rn102-00048-gbe408c, Linux/ARM, OS Kernel Image (Not compressed), 3740317 bytes, Tue Nov  5 22:24:01 2013, Load Address: 0x00008000, Entry Point: 0x00008000, Header CRC: 0xD84586E1, Data CRC: 0xC4357CED

But then /o\ i.e. write does not seem to work out of the box ;-)

root at mood:~# flash_erase /dev/mtd2 0 0 
Erasing 128 Kibyte @ 5e0000 -- 100 % complete 
root at mood:~# nand
nanddump   nandtest   nandwrite  
root at mood:~# nandwrite -p /dev/mtd2 /tmp/uImage
Writing data to block 0 at offset 0x0
[ 1456.154142] pxa3xx-nand d00d0000.nand: Wait time out!!!
[ 1456.354143] pxa3xx-nand d00d0000.nand: Wait time out!!!
[ 1456.554144] pxa3xx-nand d00d0000.nand: Wait time out!!!
[ 1456.754141] pxa3xx-nand d00d0000.nand: Wait time out!!!
[ 1456.954140] pxa3xx-nand d00d0000.nand: Wait time out!!!
[ 1457.154140] pxa3xx-nand d00d0000.nand: Wait time out!!!
[ 1457.354140] pxa3xx-nand d00d0000.nand: Wait time out!!!
[ 1457.554140] pxa3xx-nand d00d0000.nand: Wait time out!!!
[ 1457.754140] pxa3xx-nand d00d0000.nand: Wait time out!!!
[ 1457.954197] pxa3xx-nand d00d0000.nand: Wait time out!!!
[ 1458.154140] pxa3xx-nand d00d0000.nand: Wait time out!!!

But I guess this gives you some hints on possible directions.

Cheers,

a+

ps: I will not be available tomorrow but can test whatever you
    come with the day after tomorrow.
