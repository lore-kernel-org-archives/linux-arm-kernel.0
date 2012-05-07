From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 07 May 2012 10:47:30 +0800
Subject: [PATCH v5] MTD: atmel_nand: Update driver to support Programmable
 Multibit ECC controller
In-Reply-To: <20120503134254.GA7788@game.jcrosoft.org>
References: <1336048655-29486-1-git-send-email-josh.wu@atmel.com>
 <20120503134254.GA7788@game.jcrosoft.org>
Message-ID: <4FA737C2.9040806@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, J.C.

On 5/3/2012 9:42 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 20:37 Thu 03 May     , Josh Wu wrote:
>> The Programmable Multibit ECC (PMECC) controller is a programmable binary
>> BCH(Bose, Chaudhuri and Hocquenghem) encoder and decoder. This controller
>> can be used to support both SLC and MLC NAND Flash devices. It supports to
>> generate ECC to correct 2, 4, 8, 12 or 24 bits of error per sector of data.
>>
>> To use this driver, the user needs to pass in the correction capability and
>> the sector size.
>>
>> This driver has been tested on AT91SAM9X5-EK and AT91SAM9N12-EK with JFFS2,
>> YAFFS2, UBIFS and mtd-utils.
>>
>> Signed-off-by: Hong Xu<hong.xu@atmel.com>
>> Signed-off-by: Josh Wu<josh.wu@atmel.com>
>> ---
>> Hi,
>>
>> Since Hong Xu will not work on pmecc part. so I send out this patch base Hong Xu's latest work.
>>
>> Changes since v4,
>> 	fix typo and checkpatch warnings.
>> 	fix according to JC's suggestion. replace cpu_is_xxx() with DT
>> 	modify dt binding atmel nand document to add pmecc support.
>> 	tested in sam9263 without break hw ecc.
>> 	add ecc.strength.
>>
>>   .../devicetree/bindings/mtd/atmel-nand.txt         |    5 +
>>   drivers/mtd/nand/atmel_nand.c                      |  955 ++++++++++++++++++--
>>   drivers/mtd/nand/atmel_nand_ecc.h                  |  123 ++-
>>   3 files changed, 1004 insertions(+), 79 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
>> index a200695..8936175 100644
>> --- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
>> +++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
>> @@ -16,9 +16,14 @@ Optional properties:
>>   - nand-ecc-mode : String, operation mode of the NAND ecc mode, soft by default.
>>     Supported values are: "none", "soft", "hw", "hw_syndrome", "hw_oob_first",
>>     "soft_bch".
>> +- atmel,pmecc-cap : error correct capability for Programmable Multibit ECC
>> +  Controller. Supported values are: 2, 4, 8, 12, 24.
> you need to use it in the code instead of hardcoding it so
>> +- atmel,sector-size : sector size for ECC computation. Supported values are:
>> +  512, 1024.
>>   - nand-bus-width : 8 or 16 bus width if not present 8
>>   - nand-on-flash-bbt: boolean to enable on flash bbt option if not present false
>>
>> +
>>   Examples:
>>   nand0: nand at 40000000,0 {
>>   	compatible = "atmel,at91rm9200-nand";
> <snip>
>> +
>> +	cap = host->correction_cap;
>> +	sector_size = host->sector_size;
>> +	dev_info(host->dev, "Initialize PMECC params, cap: %d, sector: %d\n",
>> +		 cap, sector_size);
>> +
>> +	/* Sanity check */
>> +	if ((sector_size != 512)&&  (sector_size != 1024)) {
>> +		dev_err(host->dev, "Unsupported PMECC sector size: %d; " \
>> +			"Valid sector size: 512 or 1024 bytes\n", sector_size);
>> +		return -EINVAL;
>> +	}
>> +	if ((cap != 2)&&  (cap != 4)&&  (cap != 8)&&  (cap != 12)&&
>> +	    (cap != 24)) {
>> +		dev_err(host->dev, "Unsupported PMECC correction capability," \
>> +			" Valid one is either 2, 4, 8, 12 or 24\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	nand_chip =&host->nand_chip;
>> +	mtd =&host->mtd;
>> +
>> +	nand_chip->ecc.mode = NAND_ECC_SOFT;	/* By default */
>> +
>> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +	if (!regs) {
>> +		dev_warn(host->dev, "Can't get I/O resource regs, " \
>> +				"rolling back on software ECC\n");
>> +		return 0;
>> +	}
>> +
>> +	host->ecc = ioremap(regs->start, resource_size(regs));
>> +	if (host->ecc == NULL) {
>> +		dev_err(host->dev, "ioremap failed\n");
>> +		err_no = -EIO;
>> +		goto err_pmecc_ioremap;
>> +	}
>> +
>> +	regs_pmerr = platform_get_resource(pdev, IORESOURCE_MEM, 2);
>> +	regs_rom = platform_get_resource(pdev, IORESOURCE_MEM, 3);
>> +	if (regs_pmerr&&  regs_rom) {
>> +		host->pmerrloc_base = ioremap(regs_pmerr->start,
>> +			resource_size(regs_pmerr));
>> +		host->rom_base = ioremap(regs_rom->start,
>> +			resource_size(regs_rom));
>> +
>> +		if (host->pmerrloc_base&&  host->rom_base) {
>> +			nand_chip->ecc.mode = NAND_ECC_HW;
>> +			nand_chip->ecc.read_page =
>> +				atmel_nand_pmecc_read_page;
>> +			nand_chip->ecc.write_page =
>> +				atmel_nand_pmecc_write_page;
>> +		} else {
>> +			dev_err(host->dev, "Can not get I/O resource" \
>> +				" for HW PMECC controller!\n");
>> +			err_no = -EIO;
>> +			goto err_pmloc_ioremap;
>> +		}
>> +	}
>> +
>> +	/* ECC is calculated for the whole page (1 step) */
>> +	nand_chip->ecc.size = mtd->writesize;
>> +
>> +	/* set ECC page size and oob layout */
>> +	switch (mtd->writesize) {
>> +	case 2048:
>> +		host->degree = GF_DIMENSION_13;
>> +		host->cw_len = (1<<  host->degree) - 1;
>> +		host->cap = cap;
>> +		host->sector_number = mtd->writesize / sector_size;
>> +		host->ecc_bytes_per_sector = pmecc_get_ecc_bytes(
>> +			host->cap, sector_size);
>> +		host->alpha_to = pmecc_get_alpha_to(host);
>> +		host->index_of = pmecc_get_index_of(host);
>> +
>> +		nand_chip->ecc.steps = 1;
>> +		nand_chip->ecc.strength = cap;
>> +		nand_chip->ecc.bytes = host->ecc_bytes_per_sector *
>> +				       host->sector_number;
>> +		if (nand_chip->ecc.bytes>  mtd->oobsize - 2) {
>> +			dev_err(host->dev, "No room for ECC bytes\n");
>> +			err_no = -EINVAL;
>> +			goto err;
>> +		}
>> +		pmecc_config_ecc_layout(&atmel_pmecc_oobinfo,
>> +					mtd->oobsize,
>> +					nand_chip->ecc.bytes);
>> +		nand_chip->ecc.layout =&atmel_pmecc_oobinfo;
>> +		break;
>> +	case 512:
>> +	case 1024:
>> +	case 4096:
>> +		/* TODO */
>> +		dev_warn(host->dev, "Only 2048 page size is currently " \
>> +			"supported for PMECC, rolling back to Software ECC\n");
>> +	default:
>> +		/* page size not handled by HW ECC */
>> +		/* switching back to soft ECC */
>> +		nand_chip->ecc.mode = NAND_ECC_SOFT;
>> +		nand_chip->ecc.calculate = NULL;
>> +		nand_chip->ecc.correct = NULL;
>> +		nand_chip->ecc.hwctl = NULL;
>> +		nand_chip->ecc.read_page = NULL;
>> +		nand_chip->ecc.write_page = NULL;
>> +		nand_chip->ecc.postpad = 0;
>> +		nand_chip->ecc.prepad = 0;
>> +		nand_chip->ecc.bytes = 0;
>> +		err_no = 0;
>> +		goto err;
>> +	}
>> +
>> +	atmel_pmecc_core_init(mtd);
>> +
>> +	return 0;
>> +
>> +err:
>> +err_pmloc_ioremap:
>> +	iounmap(host->ecc);
>> +	if (host->pmerrloc_base)
>> +		iounmap(host->pmerrloc_base);
>> +	if (host->rom_base)
>> +		iounmap(host->rom_base);
>> +err_pmecc_ioremap:
>> +	return err_no;
>> +}
>> +
>> +/*
>>    * Calculate HW ECC
>>    *
>>    * function called after a write
>> @@ -474,6 +1212,15 @@ static void atmel_nand_hwctl(struct mtd_info *mtd, int mode)
>>   }
>>
>>   #if defined(CONFIG_OF)
>> +static int cpu_has_pmecc(void)
>> +{
>> +	unsigned long dt_root;
>> +
>> +	dt_root = of_get_flat_dt_root();
>> +	return of_flat_dt_is_compatible(dt_root, "atmel,at91sam9n12") ||
>> +		of_flat_dt_is_compatible(dt_root, "atmel,at91sam9x5");
> you need to detect it at probe time
OK. I will do it.
> and you need to put the first compatbile only no need to put a list
Do you mean only need check the compatible string "atmel,at91sam9n12"? 
Since 9x5 and 9n12 both support pmecc. so I check whether is 9n12 or 9x5.

or you mean the 9n12 is subset from 9x5. I checked at91sam9n12ek.dts, 
there is no compatible string like: "atmel,at91sam9x5".
>
> Best Regards,
> J.
Thanks.
Best Regards,
Josh Wu
