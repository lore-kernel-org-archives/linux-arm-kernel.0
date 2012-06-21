From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 21 Jun 2012 12:02:00 +0800
Subject: [RFC PATCH v2] MTD: nand: add return value for
 write_page()/write_page_raw() functions in structure of nand_ecc_ctrl.
In-Reply-To: <CAN8TOE8iDtzw4eTKa6tJ5oBxbaDUxg9nDLaKBhW4D86vGWxGJg@mail.gmail.com>
References: <1339567570-4816-1-git-send-email-josh.wu@atmel.com>
 <4FE13CB2.3000605@atmel.com>
 <CAN8TOE8iDtzw4eTKa6tJ5oBxbaDUxg9nDLaKBhW4D86vGWxGJg@mail.gmail.com>
Message-ID: <4FE29CB8.3000404@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Brian

On 6/21/2012 2:43 AM, Brian Norris wrote:
> Hi Josh,
>
> On Tue, Jun 19, 2012 at 8:00 PM, Josh Wu<josh.wu@atmel.com>  wrote:
>> Hi, Artem
>>
>> Ping? Do you have any comments for this patch?
> I'm not Artem, but I have some comments :)

sure,  thanks for the comments. :)

>
>> On 6/13/2012 2:06 PM, Josh Wu wrote:
>>> There is an implemention of hardware ECC write page function which may
>>> return an error indication. But now the definition of 'write_page' function
>>> in struct nand_ecc_ctrl is 'void'.
> I think it would help reviewers (and changelog readers) to note which
> implementations are the real issue, if there are a small number of
> implementations targeted.

Currently, I am introducing the atmel pragrammable multibit ECC(PMECC) 
hardware code to nand flash. I meet following situation that I need 
change the write_page()'s return value to 'int':

when writing one page into a nand flash with PMECC enabled, the hardware 
engine will compute the BCH ecc code for this page. so we need read a 
the status register to theck whether the ecc code is generated.
But we cannot assume the status register always can be ready, (for 
instance, incorrect hardware configuration or hardware issue), in such 
case I need write_page() to return a error code.

So this is the reason that I push this patch to change the return value 
to int.

> I noticed, for instance, that docg4.c has some strange code involving
> a return in a void function (comment below). If that is the *only*
> existing return statement within an 'ecc_ctrl.write_page'
> implmentation, then this whole patch is unneeded; you can just remove
> the 'return' in docg4.c.
>
>>> diff --git a/drivers/mtd/nand/docg4.c b/drivers/mtd/nand/docg4.c
>>> index a225e49..0f2ffd7 100644
>>> --- a/drivers/mtd/nand/docg4.c
>>> +++ b/drivers/mtd/nand/docg4.c
> ...
>>> -static void docg4_write_page_raw(struct mtd_info *mtd, struct nand_chip
>>> *nand,
>>> +static int docg4_write_page_raw(struct mtd_info *mtd, struct nand_chip
>>> *nand,
>>>                                  const uint8_t *buf, int oob_required)
>>>   {
>>>         return write_page(mtd, nand, buf, false);
>>>   }
> Hmm, this used to be a void function, returning the result of another
> void function? I would think the compiler would have warned about
> these issues before. Anyway, this is a useless 'return' statement and
> can be killed with no real effect.

In original version seems the 'return' is useless. I change this only 
because the write_page() function's return type is changed.

>
>>> -static void docg4_write_page(struct mtd_info *mtd, struct nand_chip
>>> *nand,
>>> +static int docg4_write_page(struct mtd_info *mtd, struct nand_chip *nand,
>>>                              const uint8_t *buf, int oob_required)
>>>   {
>>>         return write_page(mtd, nand, buf, true);
> Ditto. Are these the only "issues" being addressed in this patch?

No. This is not the reason for this patch as I said above.

>
>>> --- a/drivers/mtd/nand/nand_base.c
>>> +++ b/drivers/mtd/nand/nand_base.c
> ...
>>> @@ -2096,9 +2104,14 @@ static int nand_write_page(struct mtd_info *mtd,
>>> struct nand_chip *chip,
>>>         chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0x00, page);
>>>
>>>         if (unlikely(raw))
>>> -               chip->ecc.write_page_raw(mtd, chip, buf, oob_required);
>>> +               status = chip->ecc.write_page_raw(mtd, chip, buf,
>>> oob_required);
>>>         else
>>> -               chip->ecc.write_page(mtd, chip, buf, oob_required);
>>> +               status = chip->ecc.write_page(mtd, chip, buf, oob_required);
>>> +
>>> +       if (status<    0) {
>>> +               pr_warn("Error happened when calling nand_write_page()\n");
>>> +               return status;
>>> +       }
> I'm not sure this is the most informative error message. (Similar
> comment applies in cafe_nand.c, which imitates a lot of nand_base.c
> code)

Maybe in this case I need print the error code as well.

>
> Brian

Best Regards,
Josh Wu
