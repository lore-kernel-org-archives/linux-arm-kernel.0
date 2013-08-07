From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 7 Aug 2013 17:20:16 +0800
Subject: [PATCH 2/6] mtd: atmel_nand: replace pmecc enable code with one
 function.
In-Reply-To: <20130807072055.GA26025@norris.computersforpeace.net>
References: <1375701279-11495-1-git-send-email-josh.wu@atmel.com>
 <1375701279-11495-3-git-send-email-josh.wu@atmel.com>
 <20130807072055.GA26025@norris.computersforpeace.net>
Message-ID: <52021150.1090707@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Brian

On 8/7/2013 3:20 PM, Brian Norris wrote:
> Hi Josh,
>
> On Mon, Aug 05, 2013 at 07:14:34PM +0800, Josh Wu wrote:
>> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
>> index 3d7db95..28d159a 100644
>> --- a/drivers/mtd/nand/atmel_nand.c
>> +++ b/drivers/mtd/nand/atmel_nand.c
>> @@ -746,6 +746,30 @@ normal_check:
>>   	return total_err;
>>   }
>>   
>> +static void pmecc_enable(struct atmel_nand_host *host, int ecc_op)
>> +{
>> +	u32 val;
>> +
>> +	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
>> +	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
>> +	val = pmecc_readl_relaxed(host->ecc, CFG);
>> +
>> +	if (ecc_op != NAND_ECC_READ && ecc_op != NAND_ECC_WRITE) {
>> +		dev_err(host->dev, "atmel_nand: wrong pmecc operation type!");
>> +		return;
>> +	}
> Why is this check after the reset and disable? Shouldn't it be placed at
> the beginning of the function? But this is a somewhat strange check
> anyway, since this function is private to the driver (static).

yes, you are right, this check code should put in the beginning of the 
function.

I will send out a patch in the top of the l2-mtd.git soon. thanks

>
>> +
>> +	if (ecc_op == NAND_ECC_READ)
>> +		pmecc_writel(host->ecc, CFG, (val & ~PMECC_CFG_WRITE_OP)
>> +			| PMECC_CFG_AUTO_ENABLE);
>> +	else
>> +		pmecc_writel(host->ecc, CFG, (val | PMECC_CFG_WRITE_OP)
>> +			& ~PMECC_CFG_AUTO_ENABLE);
>> +
>> +	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_ENABLE);
>> +	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DATA);
>> +}
>> +
>>   static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
>>   	struct nand_chip *chip, uint8_t *buf, int oob_required, int page)
>>   {
> Brian
Best Regards,
Josh Wu
