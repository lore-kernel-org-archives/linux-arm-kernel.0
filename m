From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 24 Nov 2013 15:08:46 +0100
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
References: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <87d2lp28pd.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

Ezequiel Garcia <ezequiel.garcia@free-electrons.com> writes:

> Ezequiel Garcia (14):
>   mtd: nand: pxa3xx: Use a completion to signal device ready
>   mtd: nand: pxa3xx: Use waitfunc() to wait for the device to be ready
>   mtd: nand: pxa3xx: Add bad block handling
>   mtd: nand: pxa3xx: Add driver-specific ECC BCH support
>   mtd: nand: pxa3xx: Clear cmd buffer #3 (NDCB3) on command start
>   mtd: nand: pxa3xx: Add helper function to set page address
>   mtd: nand: pxa3xx: Remove READ0 switch/case falltrough
>   mtd: nand: pxa3xx: Split prepare_command_pool() in two stages
>   mtd: nand: pxa3xx: Move the data buffer clean to
>     prepare_start_command()
>   mtd: nand: pxa3xx: Fix SEQIN column address set
>   mtd: nand: pxa3xx: Add a read/write buffers markers
>   mtd: nand: pxa3xx: Introduce multiple page I/O support
>   mtd: nand: pxa3xx: Add multiple chunk write support
>   mtd: nand: pxa3xx: Add ECC BCH correctable errors detection
>
>  .../devicetree/bindings/mtd/pxa3xx-nand.txt        |   2 +
>  drivers/mtd/nand/pxa3xx_nand.c                     | 613 +++++++++++++++++----
>  include/linux/platform_data/mtd-nand-pxa3xx.h      |   3 +
>  3 files changed, 505 insertions(+), 113 deletions(-)

As ReadyNAS 102, 104 and 2120 all depend on your driver, I decided to
give v4 a change on a 102. As a side note, all those device have the
same NAND chip, i.e. a 128 MB hynix H27U1G8F2BTR. Additionally, this is
also the chip found on ReadyNAS Duo v2, which is perfectly handled by
orion-nand driver.

With your 31 patches in my quilt set against current linus tree (w/
2 to 4 of 31 disabled as they are already in Linus tree), I modified
my .dts in the following way:

 nand at d0000 {
         status = "okay";
         num-cs = <1>;
         marvell,nand-keep-config;
         marvell,nand-enable-arbiter;
         nand-on-flash-bbt;


  [followed by partitions]

 }

At boot, I get the following:

[   80.189852] pxa3xx-nand d00d0000.nand: This platform can't do DMA on this device
[   80.197454] NAND device: Manufacturer ID: 0xad, Chip ID: 0xf1 (Hynix H27U1G8F2BTR-BC)
[   80.205308] NAND device: 128MiB, SLC, page size: 2048, OOB size: 64
[   80.211594] pxa3xx-nand d00d0000.nand: ECC strength 1 at page size 2048 is not supported
[   80.219699] pxa3xx-nand d00d0000.nand: failed to scan nand at cs 0

I took a look and I guess this is due to armada370_ecc_init() (your
Armada version of the pxa_ecc_init() you also introduced) which contains
the following:

static int armada370_ecc_init(struct pxa3xx_nand_info *info,
			      struct nand_ecc_ctrl *ecc,
			      int strength, int page_size)
{
	if (strength == 4 && page_size == 4096) {
		info->ecc_bch = 1;
		info->chunk_size = 2048;
		info->spare_size = 32;
		info->ecc_size = 32;
		ecc->mode = NAND_ECC_HW;
		ecc->size = info->chunk_size;
		ecc->layout = &ecc_layout_4KB_bch4bit;
		ecc->strength = 16;
		return 1;

	} else if (strength == 8 && page_size == 4096) {
		info->ecc_bch = 1;
		info->chunk_size = 1024;
		info->spare_size = 0;
		info->ecc_size = 32;
		ecc->mode = NAND_ECC_HW;
		ecc->size = info->chunk_size;
		ecc->layout = &ecc_layout_4KB_bch8bit;
		ecc->strength = 16;
		return 1;
	}
	return 0;
}

i.e. return 0 because it does not support page size and strength of the
chip. I also guess this works fine on the Armada mirabox and XP GP
boards you have which both include a 1GB NAND flash w/ higher page size
and ECC strength.

I wonder if you could extend your support support to lower page size and
strength. I'd be happy to test it on a 370 and XP based platfom.

If it can help, here is what Netgear 2.6.31.8 kernel reports for the
chip on the Duo v2: 

Using Hamming 1-bit ECC for NAND device
NAND device: Manufacturer ID: 0xad, Chip ID: 0xf1 (Hynix NAND 128MiB 3,3V 8-bit)
Scanning device for bad blocks
Using static partition definition
Creating 5 MTD partitions on "nand_mtd":
0x000000000000-0x000000180000 : "u-boot"
0x000000180000-0x0000001a0000 : "u-boot-env"
0x000000200000-0x000000800000 : "uImage"
0x000000800000-0x000001800000 : "minirootfs"
0x000001800000-0x000008000000 : "jffs2"

Here is what 3.11 kernel reports for the chip on the duo v2:

ONFI param page 0 valid
ONFI flash detected
NAND device: Manufacturer ID: 0xad, Chip ID: 0xf1 (Hynix H27U1G8F2BTR-BC), 128MiB, page size: 2048, OOB size: 64
Scanning device for bad blocks
mtd: no mtd-id
5 ofpart partitions found on MTD device orion_nand
Creating 5 MTD partitions on "orion_nand":
0x000000000000-0x000000180000 : "u-boot"
0x000000180000-0x0000001a0000 : "u-boot-env"
0x000000200000-0x000000800000 : "uImage"
0x000000800000-0x000001800000 : "minirootfs"
0x000001800000-0x000008000000 : "jffs2"

Anyway, thanks for that work!

Cheers,

a+
