From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Mon, 12 Mar 2018 17:55:26 +0100
Subject: [PATCH v2] mtd: nand: marvell: Fix clock resource by adding a
 register clock
In-Reply-To: <20180307204418.014622b8@bbrezillon> (Boris Brezillon's message
 of "Wed, 7 Mar 2018 20:44:18 +0100")
References: <20180307161316.14612-1-gregory.clement@bootlin.com>
 <20180307204418.014622b8@bbrezillon>
Message-ID: <87vae11bep.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,
 
 On mer., mars 07 2018, Boris Brezillon <boris.brezillon@bootlin.com> wrote:

>>    NAND controller related registers (only required with the
>>    "marvell,armada-8k-nand[-controller]" compatibles).
>> diff --git a/drivers/mtd/nand/marvell_nand.c b/drivers/mtd/nand/marvell_nand.c
>> index 2196f2a233d6..072e23635375 100644
>> --- a/drivers/mtd/nand/marvell_nand.c
>> +++ b/drivers/mtd/nand/marvell_nand.c
>> @@ -321,6 +321,7 @@ struct marvell_nfc {
>>  	struct device *dev;
>>  	void __iomem *regs;
>>  	struct clk *ecc_clk;
>> +	struct clk *reg_clk;
>
> There's a kernel-doc header describing the marvell_nfc fields, could
> you add an entry for reg_clk?

OK I will

>
>>  	struct completion complete;
>>  	unsigned long assigned_cs;
>>  	struct list_head chips;
>> @@ -2747,12 +2748,24 @@ static int marvell_nfc_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		return ret;
>>  
>> +	nfc->reg_clk = devm_clk_get(&pdev->dev, "reg");
>> +	if (PTR_ERR(nfc->reg_clk) != -ENOENT) {
>> +		if (!IS_ERR(nfc->reg_clk)) {
>> +			ret = clk_prepare_enable(nfc->reg_clk);
>> +			if (ret)
>> +				goto unprepare_clk;
>
> I already suggested to move the devm_clk_get(&pdev->dev, "reg") before
> the clk_prepare_enable(nfc->ecc_clk) one to simplify the error path.
>

Actually I started to implement your suggestion but unlike what you
though it made the code less simpler. Indeed by having the mandatory
clock first than in case of failure we can directly exit the function.

If the reg clock was initialized first, then if the core/ecc clock fail
in soem case we woudl need to daisbel the reg clock and in other case we
could directly exit.


>> +		} else {
>> +			ret = PTR_ERR(nfc->reg_clk);
>> +			goto unprepare_clk;
>> +		}
>> +	}
>
> So nfc->reg_clk stays assigned to -ENOENT if the clk is not present, and
> clk_disable_unprepare() will manipulate an invalid pointer when called
> from the error or ->remove() path.

I think you missed the fact that the clk_disable_unprepare() function
managed the invalid pointer, have a look on the functions and you will
see that IS_ERR() is used, so there is no point to set the pointer to NULL.

>
> Could be addressed/simplified with something like that:
>
> 	/*
> 	 * The register clk is only required on armada 8k. By assigning
> 	 * ->reg_clk to NULL when -ENOENT is returned, we make sure all
> 	 * clk_prepare_enable()/clk_disable_unprepare() calls work
> 	 * correctly even if the clk is missing.
> 	 */
> 	nfc->reg_clk = devm_clk_get(&pdev->dev, "reg");
> 	if (PTR_ERR(nfc->reg_clk) == -ENOENT)
> 		nfc->reg_clk = NULL;
>
> 	if (IS_ERR(nfc->reg_clk))
> 		return PTR_ERR(nfc->reg_clk);
>
> 	...
>
> 	ret = clk_prepare_enable(nfc->reg_clk);
> 	if (ret)
> 		goto unprepare_ecc_clk;
>
>
>> +
>>  	marvell_nfc_disable_int(nfc, NDCR_ALL_INT);
>>  	marvell_nfc_clear_int(nfc, NDCR_ALL_INT);
>>  	ret = devm_request_irq(dev, irq, marvell_nfc_isr,
>>  			       0, "marvell-nfc", nfc);
>>  	if (ret)
>> -		goto unprepare_clk;
>> +		goto unprepare_clk_reg;
>>  
>>  	/* Get NAND controller capabilities */
>>  	if (pdev->id_entry)
>> @@ -2763,22 +2776,24 @@ static int marvell_nfc_probe(struct platform_device *pdev)
>>  	if (!nfc->caps) {
>>  		dev_err(dev, "Could not retrieve NFC caps\n");
>>  		ret = -EINVAL;
>> -		goto unprepare_clk;
>> +		goto unprepare_clk_reg;
>>  	}
>>  
>>  	/* Init the controller and then probe the chips */
>>  	ret = marvell_nfc_init(nfc);
>>  	if (ret)
>> -		goto unprepare_clk;
>> +		goto unprepare_clk_reg;
>>  
>>  	platform_set_drvdata(pdev, nfc);
>>  
>>  	ret = marvell_nand_chips_init(dev, nfc);
>>  	if (ret)
>> -		goto unprepare_clk;
>> +		goto unprepare_clk_reg;
>>  
>>  	return 0;
>>  
>> +unprepare_clk_reg:
>> +	clk_disable_unprepare(nfc->reg_clk);
>>  unprepare_clk:
>
> Please rename the label (unprepare_clk -> unprepare_ecc_clk).

OK

>
>>  	clk_disable_unprepare(nfc->ecc_clk);
>>  
>> @@ -2796,6 +2811,7 @@ static int marvell_nfc_remove(struct platform_device *pdev)
>>  		dma_release_channel(nfc->dma_chan);
>>  	}
>>  
>> +	clk_disable_unprepare(nfc->reg_clk);
>>  	clk_disable_unprepare(nfc->ecc_clk);
>>  
>>  	return 0;
>
>
>
> -- 
> Boris Brezillon, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
