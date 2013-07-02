From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 2 Jul 2013 15:29:54 +1000
Subject: linux-next: manual merge of the arm-soc tree with the l2-mtd tree
Message-ID: <20130702152954.f25bbf51c1a79aa4437e22ee@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
Documentation/devicetree/bindings/mtd/gpmc-nand.txt between commits
6c88058ef927 ("ARM: OMAP2+: cleaned-up DT support of various ECC
schemes") and 212012138deb ("mtd: nand: omap2: updated support for BCH4
ECC scheme") from the l2-mtd tree and commit 496c8a0bbb72 ("ARM: OMAP2+:
Allow NAND transfer mode to be specified in DT") from the arm-soc tree.

I fixed it up (maybe - see below) and can carry the fix as necessary (no
action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index b3f23df,df338cb..0000000
--- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@@ -17,59 -17,27 +17,66 @@@ Required properties
  
  Optional properties:
  
 - - nand-bus-width: 		Set this numeric value to 16 if the hardware
 -				is wired that way. If not specified, a bus
 -				width of 8 is assumed.
 + - nand-bus-width: 		Determines data-width of the connected device
 +				x16 = "16"
 +				x8  = "8" (default)
  
 - - ti,nand-ecc-opt:		A string setting the ECC layout to use. One of:
  
 -		"sw"		Software method (default)
 -		"hw"		Hardware method
 -		"hw-romcode"	gpmc hamming mode method & romcode layout
 -		"bch4"		4-bit BCH ecc code
 -		"bch8"		8-bit BCH ecc code
 + - ti,nand-ecc-opt:		Determines the ECC scheme used by driver.
 +				It can be any of the following strings:
 +
 +	"hamming_code_sw"		1-bit Hamming ECC
 +					- ECC calculation in software
 +					- Error detection in software
 +					- ECC layout compatible with S/W scheme
 +
 +	"hamming_code_hw"		1-bit Hamming ECC
 +					- ECC calculation in hardware
 +					- Error detection in software
 +					- ECC layout compatible with S/W scheme
 +
 +	"hamming_code_hw_romcode"	1-bit Hamming ECC
 +					- ECC calculation in hardware
 +					- Error detection in software
 +					- ECC layout compatible with ROM code
 +
 +	"bch4_code_hw_detection_sw"	4-bit BCH ECC
 +					- ECC calculation in hardware
 +					- Error detection in software
 +					- ECC layout compatible with S/W scheme
 +					* depends on CONFIG_MTD_NAND_ECC_BCH
 +
 +	"bch4_code_hw"             	4-bit BCH ECC
 +					- ECC calculation in hardware
 +					- Error detection in hardware
 +					- ECC layout compatible with ROM code
 +					* depends on CONFIG_MTD_NAND_OMAP_BCH
 +					* requires <elm_id> to be specified
 +
 +	"bch8_code_hw_detection_sw"	8-bit BCH ECC
 +					- ECC calculation in hardware
 +					- Error detection in software
 +					- ECC layout compatible with S/W scheme
 +					* depends on CONFIG_MTD_NAND_ECC_BCH
 +
 +	"bch8_code_hw"             	8-bit BCH ECC
 +					- ECC calculation in hardware
 +					- Error detection in hardware
 +					- ECC layout compatible with ROM code
 +					* depends on CONFIG_MTD_NAND_OMAP_BCH
 +					* requires <elm_id> to be specified
  
+  - ti,nand-xfer-type:		A string setting the data transfer type. One of:
+ 
+ 		"prefetch-polled"	Prefetch polled mode (default)
+ 		"polled"		Polled mode, without prefetch
+ 		"prefetch-dma"		Prefetch enabled sDMA mode
+ 		"prefetch-irq"		Prefetch enabled irq mode
+ 
 - - elm_id:	Specifies elm device node. This is required to support BCH
 - 		error correction using ELM module.
 +
 + - elm_id:			Specifies elm device node. This is required to
 +				support some BCH ECC schemes mentioned above.
 +
  
  For inline partiton table parsing (optional):
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130702/9d37f3fa/attachment.sig>
