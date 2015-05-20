From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Wed, 20 May 2015 11:05:13 -0300
Subject: [PATCH v5 05/12] mtd: pxa3xx_nand: rework flash detection and
 timing setup
In-Reply-To: <20150520140348.GL22054@kwain>
References: <1431356341-31640-1-git-send-email-antoine.tenart@free-electrons.com>
 <1431356341-31640-6-git-send-email-antoine.tenart@free-electrons.com>
 <5557BE85.4050208@vanguardiasur.com.ar> <20150520140348.GL22054@kwain>
Message-ID: <555C9499.10606@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/20/2015 11:03 AM, Antoine Tenart wrote:
> Ezequiel,
> 
> On Sat, May 16, 2015 at 07:02:45PM -0300, Ezequiel Garcia wrote:
>> On 05/11/2015 11:58 AM, Antoine Tenart wrote:
> 
>>> -
>>>  	ndcr |= (pdata->enable_arbiter) ? NDCR_ND_ARB_EN : 0;
>>>  	ndcr |= (host->col_addr_cycles == 2) ? NDCR_RA_START : 0;
>>> -	ndcr |= (f->page_per_block == 64) ? NDCR_PG_PER_BLK : 0;
>>> -	ndcr |= (f->page_size == 2048) ? NDCR_PAGE_SZ : 0;
>>> -	ndcr |= (f->flash_width == 16) ? NDCR_DWIDTH_M : 0;
>>> -	ndcr |= (f->dfc_width == 16) ? NDCR_DWIDTH_C : 0;
>>> +	ndcr |= (chip->page_shift == 6) ? NDCR_PG_PER_BLK : 0;
>>> +	ndcr |= (mtd->writesize == 2048) ? NDCR_PAGE_SZ : 0;
>>
>> By the time you call this, there's no detected flash, so there's
>> no geometry information such as mtd->writesize, chip->page_shift, etc.
> 
> I'll move this to pxa3xx_nand_init_timings().
> 

Well, please don't call it init_timings() if you are doing more than
timings setup.

>>> @@ -1577,64 +1558,20 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
>>>  		return ret;
>>>  	}
>>>  
>>> -	chip->cmdfunc(mtd, NAND_CMD_READID, 0, 0);
>>> -	id = *((uint16_t *)(info->data_buff));
>>> -	if (id != 0)
>>> -		dev_info(&info->pdev->dev, "Detect a flash id %x\n", id);
>>> -	else {
>>> -		dev_warn(&info->pdev->dev,
>>> -			 "Read out ID 0, potential timing set wrong!!\n");
>>> -
>>> -		return -EINVAL;
>>> -	}
>>> -
>>> -	num = ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1;
>>> -	for (i = 0; i < num; i++) {
>>> -		if (i < pdata->num_flash)
>>> -			f = pdata->flash + i;
>>> -		else
>>> -			f = &builtin_flash_types[i - pdata->num_flash + 1];
>>> -
>>> -		/* find the chip in default list */
>>> -		if (f->chip_id == id)
>>> -			break;
>>> -	}
>>> -
>>> -	if (i >= (ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1)) {
>>> -		dev_err(&info->pdev->dev, "ERROR!! flash not defined!!!\n");
>>> -
>>> -		return -EINVAL;
>>> -	}
>>> -
>>> -	ret = pxa3xx_nand_config_flash(info, f);
>>
>> This second call to pxa3xx_nand_config_flash was in charge of re-configuring
>> the device after proper identification.
>>
>> I'd say a proper approach is to configure default parameters,
>> call nand_scan_ident, and finally re-configure using the detected values.
> 
> That's what is done already, default parameters are setup in
> pxa3xx_nand_sensing(), using onfi_async_timing_mode_to_sdr_timings(0).
> Then once the device is recognized, the proper timings are used by
> calling pxa3xx_nand_init_timings().
> 
> Did I miss something here?
> 

I'm not talking about the timings but about ndcr configuration. You can
only do that once the device is detected, not before.

The timing stuff look OK.

-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
