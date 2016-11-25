From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 25 Nov 2016 11:40:31 +0100
Subject: [PATCH] mtd: nand: mxc: Fix mxc_v1 ooblayout
In-Reply-To: <20161125112725.0ee9d49d@bbrezillon>
References: <1480065209-4179-1-git-send-email-boris.brezillon@free-electrons.com>
 <58eed307-ee50-9727-7b64-891d1b969790@gmail.com>
 <20161125112725.0ee9d49d@bbrezillon>
Message-ID: <26b566f7-dca0-247b-5aa8-b11cffa31463@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2016 11:27 AM, Boris Brezillon wrote:
> On Fri, 25 Nov 2016 10:58:26 +0100
> Marek Vasut <marek.vasut@gmail.com> wrote:
> 
>> On 11/25/2016 10:13 AM, Boris Brezillon wrote:
>>> Commit a894cf6c5a82 ("mtd: nand: mxc: switch to mtd_ooblayout_ops")
>>> introduced a bug in the OOB layout description. Even if the driver claims
>>> that 3 ECC bytes are reserved to protect 512 bytes of data, it's actually
>>> 5 ECC bytes to protect 512+6 bytes of data (some OOB bytes are also
>>> protected using extra ECC bytes).
>>>
>>> Fix the mxc_v1_ooblayout_{free,ecc}() functions to reflect this behavior.
>>>
>>> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>>> Fixes: a894cf6c5a82 ("mtd: nand: mxc: switch to mtd_ooblayout_ops")
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>>  drivers/mtd/nand/mxc_nand.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
>>> index 61ca020c5272..c19ec4f0983e 100644
>>> --- a/drivers/mtd/nand/mxc_nand.c
>>> +++ b/drivers/mtd/nand/mxc_nand.c
>>> @@ -886,7 +886,7 @@ static int mxc_v1_ooblayout_ecc(struct mtd_info *mtd, int section,
>>>  		return -ERANGE;
>>>  
>>>  	oobregion->offset = (section * 16) + 6;
>>> -	oobregion->length = nand_chip->ecc.bytes;
>>> +	oobregion->length = 5;  
>>
>> Use a macro instead of hard-coding a value please :)
> 
> Ideally, we should change ->eccbytes value in the
> imx27_nand_devtype_data and imx21_nand_devtype_data definitions, but I
> fear it could break other things.

I was wondering about that too :) Break what things ?

> I'll define a macro.

Thanks!

>>
>>>  	return 0;
>>>  }
>>> @@ -908,8 +908,7 @@ static int mxc_v1_ooblayout_free(struct mtd_info *mtd, int section,
>>>  			oobregion->length = 4;
>>>  		}
>>>  	} else {
>>> -		oobregion->offset = ((section - 1) * 16) +
>>> -				    nand_chip->ecc.bytes + 6;
>>> +		oobregion->offset = ((section - 1) * 16) + 5 + 6;  
>>
>> DTTO here, the math here is cryptic enough.
>>
>>>  		if (section < nand_chip->ecc.steps)
>>>  			oobregion->length = (section * 16) + 6 -
>>>  					    oobregion->offset;
>>>   
>>
>>
> 


-- 
Best regards,
Marek Vasut
