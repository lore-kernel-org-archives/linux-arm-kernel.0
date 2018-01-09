From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Tue, 9 Jan 2018 12:06:09 +0100
Subject: [PATCH 00/12] Marvell NAND controller rework with ->exec_op()
In-Reply-To: <87zi5nbh14.fsf@belgarion.home>
References: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
 <20171214070930.0b885f6d@bbrezillon>
 <877etkecig.fsf@belgarion.home> <20171218092535.2ca1fe13@xps13>
 <87y3lxccr7.fsf@belgarion.home>
 <20171220224121.2cb6f690@bbrezillon>
 <87lghucykr.fsf@belgarion.home>
 <20171222222441.0fd77df9@bbrezillon>
 <20171222233730.68d9cb9d@xps13> <87k1xdblxf.fsf@belgarion.home>
 <20171223155709.2ba16e95@xps13> <87fu81bc45.fsf@belgarion.home>
 <20180102120326.7a2cf1d1@xps13> <87d12scbiy.fsf@belgarion.home>
 <20180103084037.422b239a@xps13> <878tded89m.fsf@belgarion.home>
 <20180103211028.619cd16d@bbrezillon>
 <20180103215206.5d85b41b@bbrezillon>
 <87zi5nbh14.fsf@belgarion.home>
Message-ID: <20180109120609.153b6bde@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Robert,

On Tue, 09 Jan 2018 08:57:59 +0100
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Boris Brezillon <boris.brezillon@free-electrons.com> writes:
> 
> Ok I recovered my NAND.
> 
> For the next try, I'd like you to provide another "temporary patch"
> to disable BBT actual writing, just to be sure. Once the driver is
> working properly, I'll make another try without the temporary patch.

The best way to do it is to avoid using the BBT at all, and while I was
looking for the right line to comment in the Zylonite's board file I
found out that the boolean flash_bbt is not actually set and then I
remembered an old mail from you, then you should:

----->8-----
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 0534949d63f6..d247ef01dc62 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -378,6 +378,8 @@ static struct mtd_partition
zylonite_nand_partitions[] = { static struct pxa3xx_nand_platform_data
zylonite_nand_info = { .parts		= zylonite_nand_partitions,
 	.nr_parts	= ARRAY_SIZE(zylonite_nand_partitions),
-	.flash_bbt	= 1,
	.keep_config	= 1,
 };
 
 static void __init zylonite_init_nand(void)
-----8<-----

Then, do not forget to resize the partition that stores the BBT to
remove the last 4 erase blocks from it to avoid UBI/UBIFS smashing it.

Then you should be fine.

You can test this branch (updated with last version I sent earlier):
https://github.com/miquelraynal/linux/tree/marvell/nand-next/nfc


Thanks,
Miqu?l
