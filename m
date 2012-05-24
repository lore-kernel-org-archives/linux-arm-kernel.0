From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 24 May 2012 16:05:08 +0800
Subject: [PATCH v8 1/3] MTD: at91: extract hw ecc initialization to one
 function
In-Reply-To: <20120523095141.GE3377@game.jcrosoft.org>
References: <1337759274-9921-1-git-send-email-josh.wu@atmel.com>
 <1337759274-9921-2-git-send-email-josh.wu@atmel.com>
 <20120523095141.GE3377@game.jcrosoft.org>
Message-ID: <4FBDEBB4.1040806@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 5/23/2012 5:51 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 15:47 Wed 23 May     , Josh Wu wrote:
>> Signed-off-by: Hong Xu<hong.xu@atmel.com>
>> Signed-off-by: Josh Wu<josh.wu@atmel.com>
>> ---
>>   drivers/mtd/nand/atmel_nand.c     |  147 ++++++++++++++++++++-----------------
>>   drivers/mtd/nand/atmel_nand_ecc.h |    8 +-
>>   2 files changed, 85 insertions(+), 70 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
>> index 2165576..9723702 100644
>> --- a/drivers/mtd/nand/atmel_nand.c
>> +++ b/drivers/mtd/nand/atmel_nand.c
>> @@ -42,20 +42,15 @@
>>
>>   #include<mach/cpu.h>
>>
>> +/* Hardware ECC registers */
>> +#include "atmel_nand_ecc.h"
>> +
>>   static int use_dma = 1;
>>   module_param(use_dma, int, 0);
>>
>>   static int on_flash_bbt = 0;
>>   module_param(on_flash_bbt, int, 0);
>>
>> -/* Register access macros */
>> -#define ecc_readl(add, reg)				\
>> -	__raw_readl(add + ATMEL_ECC_##reg)
>> -#define ecc_writel(add, reg, value)			\
>> -	__raw_writel((value), add + ATMEL_ECC_##reg)
>> -
>> -#include "atmel_nand_ecc.h"	/* Hardware ECC registers */
>> -
>>   /* oob layout for large page size
>>    * bad block info is on bytes 0 and 1
>>    * the bytes have to be consecutives to avoid
>> @@ -523,6 +518,75 @@ static int __devinit atmel_of_init_port(struct atmel_nand_host *host,
>>   }
>>   #endif
>>
>> +static int __init atmel_hw_nand_init_params(struct platform_device *pdev,
>> +					 struct atmel_nand_host *host)
>> +{
>> +	struct resource		*regs;
>> +	struct mtd_info		*mtd;
>> +	struct nand_chip	*nand_chip;
>> +
>> +	nand_chip =&host->nand_chip;
>> +	mtd =&host->mtd;
>> +
>> +	nand_chip->ecc.mode = NAND_ECC_SOFT;
>> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +	if (!regs) {
>> +		dev_err(host->dev,
>> +			"Can't get I/O resource regs, use software ECC\n");
> just return 0 and avoid the if else

sure. I'll fix it.

>
> Best Regards,
> J.

And I have same question about the relaxed version of read/write device.

this source code file still use __raw_readl/writel(), I think I can 
convert it all to relaxed version, except that the ECC control reset 
should use NO relaxed version.
so the patch to convert it will look like following:

diff --git a/drivers/mtd/nand/atmel_nand_ecc.h 
b/drivers/mtd/nand/atmel_nand_ecc.h
index b437567..dc49dc9 100644
--- a/drivers/mtd/nand/atmel_nand_ecc.h
+++ b/drivers/mtd/nand/atmel_nand_ecc.h
@@ -37,9 +37,11 @@
  #define                ATMEL_ECC_NPARITY       (0xffff << 0)           
/* NParity */

  /* Register Access Macros */
-#define ecc_readl(add, reg)                            \
-       __raw_readl(add + ATMEL_ECC_##reg)
-#define ecc_writel(add, reg, value)                    \
-       __raw_writel((value), add + ATMEL_ECC_##reg)
+#define ecc_readl_relaxed(add, reg)                            \
+       readl_relaxed(add + ATMEL_ECC_##reg)
+#define ecc_writel_relaxed(add, reg, value)                    \
+       writel_relaxed((value), add + ATMEL_ECC_##reg)
+#define ecc_writel(add, reg, value)                            \
+       writel((value), add + ATMEL_ECC_##reg)


diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 9723702..ba61153 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -299,13 +299,13 @@ static int atmel_nand_calculate(struct mtd_info *mtd,
         unsigned int ecc_value;

         /* get the first 2 ECC bytes */
-       ecc_value = ecc_readl(host->ecc, PR);
+       ecc_value = ecc_readl_relaxed(host->ecc, PR);

         ecc_code[0] = ecc_value & 0xFF;
         ecc_code[1] = (ecc_value >> 8) & 0xFF;

         /* get the last 2 ECC bytes */
-       ecc_value = ecc_readl(host->ecc, NPR) & ATMEL_ECC_NPARITY;
+       ecc_value = ecc_readl_relaxed(host->ecc, NPR) & ATMEL_ECC_NPARITY;

         ecc_code[2] = ecc_value & 0xFF;
         ecc_code[3] = (ecc_value >> 8) & 0xFF;
@@ -401,16 +401,16 @@ static int atmel_nand_correct(struct mtd_info 
*mtd, u_char *dat,
         unsigned int ecc_word, ecc_bit;

         /* get the status from the Status Register */
-       ecc_status = ecc_readl(host->ecc, SR);
+       ecc_status = ecc_readl_relaxed(host->ecc, SR);

         /* if there's no error */
         if (likely(!(ecc_status & ATMEL_ECC_RECERR)))
                 return 0;

         /* get error bit offset (4 bits) */
-       ecc_bit = ecc_readl(host->ecc, PR) & ATMEL_ECC_BITADDR;
+       ecc_bit = ecc_readl_relaxed(host->ecc, PR) & ATMEL_ECC_BITADDR;
         /* get word address (12 bits) */
-       ecc_word = ecc_readl(host->ecc, PR) & ATMEL_ECC_WORDADDR;
+       ecc_word = ecc_readl_relaxed(host->ecc, PR) & ATMEL_ECC_WORDADDR;
         ecc_word >>= 4;
....
+       case 512:
+               nand_chip->ecc.layout = &atmel_oobinfo_small;
+               ecc_writel_relaxed(host->ecc, MR, ATMEL_ECC_PAGESIZE_528);
+               break;
+       case 1024:
+               nand_chip->ecc.layout = &atmel_oobinfo_large;
+               ecc_writel_relaxed(host->ecc, MR, ATMEL_ECC_PAGESIZE_1056);
+               break;
+       case 2048:
+               nand_chip->ecc.layout = &atmel_oobinfo_large;
+               ecc_writel_relaxed(host->ecc, MR, ATMEL_ECC_PAGESIZE_2112);
+               break;
+       case 4096:
+               nand_chip->ecc.layout = &atmel_oobinfo_large;
+               ecc_writel_relaxed(host->ecc, MR, ATMEL_ECC_PAGESIZE_4224);
+               break;
...


Best Regards,
Josh Wu
