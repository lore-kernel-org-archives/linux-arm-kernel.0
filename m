From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 2 Jul 2013 15:33:48 +1000
Subject: linux-next: manual merge of the arm-soc tree with the l2-mtd tree
Message-ID: <20130702153348.ce27e4a6185c0b403e039e06@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/mtd/nand/Kconfig between commit 212012138deb ("mtd: nand: omap2:
updated support for BCH4 ECC scheme") from the l2-mtd tree and commit
930d800bded7 ("mtd: omap2: allow bulding as a module") from the arm-soc
tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/mtd/nand/Kconfig
index a6e247c,50543f1..0000000
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@@ -95,13 -95,35 +95,13 @@@ config MTD_NAND_OMAP
  
  config MTD_NAND_OMAP_BCH
  	depends on MTD_NAND && MTD_NAND_OMAP2 && ARCH_OMAP3
- 	bool "Support hardware based BCH error correction"
 -	tristate "Enable support for hardware BCH error correction"
++	tristate "Support hardware based BCH error correction"
  	default n
  	select BCH
 -	select BCH_CONST_PARAMS
  	help
 -	 Support for hardware BCH error correction.
 -
 -choice
 -	prompt "BCH error correction capability"
 -	depends on MTD_NAND_OMAP_BCH
 -
 -config MTD_NAND_OMAP_BCH8
 -	bool "8 bits / 512 bytes (recommended)"
 -	help
 -	 Support correcting up to 8 bitflips per 512-byte block.
 -	 This will use 13 bytes of spare area per 512 bytes of page data.
 -	 This is the recommended mode, as 4-bit mode does not work
 -	 on some OMAP3 revisions, due to a hardware bug.
 -
 -config MTD_NAND_OMAP_BCH4
 -	bool "4 bits / 512 bytes"
 -	help
 -	 Support correcting up to 4 bitflips per 512-byte block.
 -	 This will use 7 bytes of spare area per 512 bytes of page data.
 -	 Note that this mode does not work on some OMAP3 revisions, due to a
 -	 hardware bug. Please check your OMAP datasheet before selecting this
 -	 mode.
 -
 -endchoice
 +	  Some devices have built-in ELM hardware engine, which can be used to
 +	  locate and correct errors when using BCH ECC scheme. This enables the
 +	  driver support for same.
  
  if MTD_NAND_OMAP_BCH
  config BCH_CONST_M
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130702/008501bf/attachment.sig>
