From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 27 Nov 2012 10:31:51 +0800
Subject: [PATCH] MTD: at91: atmel_nand: return bit flips for the PMECC
 read_page()
In-Reply-To: <50B3D35C.2000704@newsguy.com>
References: <1353474863-28430-1-git-send-email-josh.wu@atmel.com>
 <50B3D35C.2000704@newsguy.com>
Message-ID: <50B42617.3060701@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mike

On 11/27/2012 4:38 AM, Mike Dunn wrote:
> Hi Josh, sorry for the delay.
>
> I guess maybe I missed this one when I did the bitflips patch?

no, it seems that my patch is merged in mtd git tree after your changes. 
So when you do the bitflips patch, my patch is not existed in that 
moment.  :)

> Anyway, please
> see below...
>
>
> On 11/20/2012 09:14 PM, Josh Wu wrote:
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>> ---
>>   drivers/mtd/nand/atmel_nand.c |   13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
>> index 9144557..860dd36 100644
>> --- a/drivers/mtd/nand/atmel_nand.c
>> +++ b/drivers/mtd/nand/atmel_nand.c
>> @@ -723,6 +723,7 @@ static int pmecc_correction(struct mtd_info *mtd, u32 pmecc_stat, uint8_t *buf,
>>   	struct atmel_nand_host *host = nand_chip->priv;
>>   	int i, err_nbr, eccbytes;
>>   	uint8_t *buf_pos;
>> +	int total_err = 0;
>>   
>>   	eccbytes = nand_chip->ecc.bytes;
>>   	for (i = 0; i < eccbytes; i++)
>> @@ -750,12 +751,13 @@ normal_check:
>>   				pmecc_correct_data(mtd, buf_pos, ecc, i,
>>   					host->pmecc_bytes_per_sector, err_nbr);
>>   				mtd->ecc_stats.corrected += err_nbr;
>> +				total_err += err_nbr;
>>   			}
>>   		}
>>   		pmecc_stat >>= 1;
>>   	}
>>   
>> -	return 0;
>> +	return total_err;
>>   }
>>   
>>   static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
>> @@ -767,6 +769,7 @@ static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
>>   	uint32_t *eccpos = chip->ecc.layout->eccpos;
>>   	uint32_t stat;
>>   	unsigned long end_time;
>> +	int bitflips = 0;
>>   
>>   	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
>>   	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
>> @@ -789,11 +792,13 @@ static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
>>   	}
>>   
>>   	stat = pmecc_readl_relaxed(host->ecc, ISR);
>> -	if (stat != 0)
>> -		if (pmecc_correction(mtd, stat, buf, &oob[eccpos[0]]) != 0)
>> +	if (stat != 0) {
>> +		bitflips = pmecc_correction(mtd, stat, buf, &oob[eccpos[0]]);
>> +		if (bitflips < 0)
>>   			return -EIO;
>
> This is wrong.  In the case of uncorrectible bitflips, read_page() should return
> 0.  The nand infrastructure code is alerted to the uncorrectible bitflips case
> by the ecc_stats, and returns -EBADMSG.  This is the correct return code from
> the mtd layer (i.e., mtd_read()) for uncorrectible bitflips.  (See the bottom of
> nand_do_read_ops() in nand_base.c.)
>
> Returning 0 when uncorrectible bitflips occur is a bit counter-intuitive and
> potentially confusing, I know.  (Fixing that would involve some rework to
> nand_base.c.)  This prompted me to add this comment in nand.h:
>
>   * @read_page:	function to read a page according to the ECC generator
>   *		requirements; returns maximum number of bitflips corrected in
>   *		any single ECC step, 0 if bitflips uncorrectable, -EIO hw error

yes, I just noticed this. I think in the v2 patch, I included this fix too.
>
> I made a similiar mistake in the docg4 driver, where I returned -EBADMSG on
> uncorrectible errors.  One consequence of that mistake was that mtdchar returned
> 0 to userspace, which user code interprets as 0 bytes read, and typically
> re-issues the read.  When I ran nanddump, the read of a page containing the
> uncorrectible errors was repeated over and over.  In the case of this patch as
> currently implemented, -EIO will get propagated up as-is, and the entire read
> operation will be aborted with an error.  -EIO should only be returned in the
> case of a hardware error.

Thanks for all the detail information, that is very clear to me. I will 
send out v2 patch soon.

Best Regards,
Josh Wu

>
> Hope this makes sense.
>
> Mike
>
>
>> +	}
>>   
>> -	return 0;
>> +	return bitflips;
>>   }
>>   
>>   static int atmel_nand_pmecc_write_page(struct mtd_info *mtd,
