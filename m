From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 16 May 2012 12:17:38 +0300
Subject: [PATCH v7 0/3] Add PMECC support for at91 nand flash driver
In-Reply-To: <1337093256-19117-1-git-send-email-josh.wu@atmel.com>
References: <1337093256-19117-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1337159858.24809.21.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-05-15 at 22:47 +0800, Josh Wu wrote:
> Changes since v6,
> 	split into 3 patches.
> 	remove of_flat_dt_is_compatible() function. use additional dt parameter "has-pmecc".
> 	refine the error handling code.
> 	refine original atmel_nand_init_params() function.
> 
> Changes since v5,
> 	add has_pmecc field to replace cpu_has_pmecc() function. Use compatible check in when proble.
> 	simplify the pmecc_get_ecc_bytes() function.
> 
> Changes since v4,
> 	fix typo and checkpatch warnings.
> 	fix according to JC's suggestion. replace cpu_is_xxx() with DT
> 	modify dt binding atmel nand document to add pmecc support.
> 	tested in sam9263 without break hw ecc.
> 	add ecc.strength.

Hi,

Aiaiai identified the following issues with your patch-set - could you
please take a look?

--------------------------------------------------------------------------------

Successfully built configuration "arm-at91cap9_defconfig,arm,arm-unknown-linux-gnueabi-", results:

--- before_patching.log
+++ after_patching.log
@@ @@
+drivers/mtd/nand/atmel_nand.c: In function 'atmel_pmecc_nand_init_params':
+drivers/mtd/nand/atmel_nand.c:910:29: warning: assignment from incompatible pointer type [enabled by default]
+drivers/mtd/nand/atmel_nand.c:910:50: warning: incorrect type in assignment (different argument counts) [sparse]
+drivers/mtd/nand/atmel_nand.c:910:50:    expected int ( *read_page )( ... ) [sparse]
+drivers/mtd/nand/atmel_nand.c:910:50:    got int ( static [toplevel] *<noident> )( ... ) [sparse]
+drivers/mtd/nand/atmel_nand.c:912:30: warning: assignment from incompatible pointer type [enabled by default]
+drivers/mtd/nand/atmel_nand.c:912:51: warning: incorrect type in assignment (different argument counts) [sparse]
+drivers/mtd/nand/atmel_nand.c:912:51:    expected void ( *write_page )( ... ) [sparse]
+drivers/mtd/nand/atmel_nand.c:912:51:    got void ( static [toplevel] *<noident> )( ... ) [sparse]

--------------------------------------------------------------------------------

checkpatch.pl has some complaints:

--------------------------------------------------------------------------------

checkpatch.pl results for patch "[PATCH 3/3] MTD: atmel_nand: Update driver to support Programmable  Multibit ECC controller"

WARNING:LONG_LINE: line over 80 characters
#60: FILE: drivers/mtd/nand/atmel_nand.c:115:
+       int16_t                 smu[AT_NB_ERROR_MAX + 2][2 * AT_NB_ERROR_MAX + 1];

WARNING:LONG_LINE: line over 80 characters
#326: FILE: drivers/mtd/nand/atmel_nand.c:567:
+                               a = readw_relaxed(alpha_to + tmp % host->cw_len);

WARNING:LONG_LINE: line over 80 characters
#348: FILE: drivers/mtd/nand/atmel_nand.c:589:
+                               a = readw_relaxed(index_of + host->smu[i + 1][k]);

total: 0 errors, 3 warnings, 879 lines checked

--------------------------------------------------------------------------------

checkpatch.pl results for the entire squashed patch-set

WARNING:LONG_LINE: line over 80 characters
#376: FILE: drivers/mtd/nand/atmel_nand.c:115:
+       int16_t                 smu[AT_NB_ERROR_MAX + 2][2 * AT_NB_ERROR_MAX + 1];

WARNING:LONG_LINE: line over 80 characters
#642: FILE: drivers/mtd/nand/atmel_nand.c:567:
+                               a = readw_relaxed(alpha_to + tmp % host->cw_len);

WARNING:LONG_LINE: line over 80 characters
#664: FILE: drivers/mtd/nand/atmel_nand.c:589:
+                               a = readw_relaxed(index_of + host->smu[i + 1][k]);

total: 0 errors, 3 warnings, 1136 lines checked

--------------------------------------------------------------------------------

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120516/34eaf287/attachment.sig>
