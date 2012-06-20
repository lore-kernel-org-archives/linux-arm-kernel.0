From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 20 Jun 2012 11:43:33 -0700
Subject: [RFC PATCH v2] MTD: nand: add return value for
 write_page()/write_page_raw() functions in structure of nand_ecc_ctrl.
In-Reply-To: <4FE13CB2.3000605@atmel.com>
References: <1339567570-4816-1-git-send-email-josh.wu@atmel.com>
 <4FE13CB2.3000605@atmel.com>
Message-ID: <CAN8TOE8iDtzw4eTKa6tJ5oBxbaDUxg9nDLaKBhW4D86vGWxGJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On Tue, Jun 19, 2012 at 8:00 PM, Josh Wu <josh.wu@atmel.com> wrote:
> Hi, Artem
>
> Ping? Do you have any comments for this patch?

I'm not Artem, but I have some comments :)

> On 6/13/2012 2:06 PM, Josh Wu wrote:
>>
>> There is an implemention of hardware ECC write page function which may
>> return an error indication. But now the definition of 'write_page' function
>> in struct nand_ecc_ctrl is 'void'.

I think it would help reviewers (and changelog readers) to note which
implementations are the real issue, if there are a small number of
implementations targeted.

I noticed, for instance, that docg4.c has some strange code involving
a return in a void function (comment below). If that is the *only*
existing return statement within an 'ecc_ctrl.write_page'
implmentation, then this whole patch is unneeded; you can just remove
the 'return' in docg4.c.

>> diff --git a/drivers/mtd/nand/docg4.c b/drivers/mtd/nand/docg4.c
>> index a225e49..0f2ffd7 100644
>> --- a/drivers/mtd/nand/docg4.c
>> +++ b/drivers/mtd/nand/docg4.c
...
>> -static void docg4_write_page_raw(struct mtd_info *mtd, struct nand_chip
>> *nand,
>> +static int docg4_write_page_raw(struct mtd_info *mtd, struct nand_chip
>> *nand,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? const uint8_t *buf, int oob_required)
>> ?{
>> ? ? ? ?return write_page(mtd, nand, buf, false);
>> ?}

Hmm, this used to be a void function, returning the result of another
void function? I would think the compiler would have warned about
these issues before. Anyway, this is a useless 'return' statement and
can be killed with no real effect.

>> -static void docg4_write_page(struct mtd_info *mtd, struct nand_chip
>> *nand,
>> +static int docg4_write_page(struct mtd_info *mtd, struct nand_chip *nand,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? const uint8_t *buf, int oob_required)
>> ?{
>> ? ? ? ?return write_page(mtd, nand, buf, true);

Ditto. Are these the only "issues" being addressed in this patch?

>> --- a/drivers/mtd/nand/nand_base.c
>> +++ b/drivers/mtd/nand/nand_base.c
...
>> @@ -2096,9 +2104,14 @@ static int nand_write_page(struct mtd_info *mtd,
>> struct nand_chip *chip,
>> ? ? ? ?chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0x00, page);
>>
>> ? ? ? ?if (unlikely(raw))
>> - ? ? ? ? ? ? ? chip->ecc.write_page_raw(mtd, chip, buf, oob_required);
>> + ? ? ? ? ? ? ? status = chip->ecc.write_page_raw(mtd, chip, buf,
>> oob_required);
>> ? ? ? ?else
>> - ? ? ? ? ? ? ? chip->ecc.write_page(mtd, chip, buf, oob_required);
>> + ? ? ? ? ? ? ? status = chip->ecc.write_page(mtd, chip, buf, oob_required);
>> +
>> + ? ? ? if (status< ?0) {
>> + ? ? ? ? ? ? ? pr_warn("Error happened when calling nand_write_page()\n");
>> + ? ? ? ? ? ? ? return status;
>> + ? ? ? }

I'm not sure this is the most informative error message. (Similar
comment applies in cafe_nand.c, which imitates a lot of nand_base.c
code)

Brian
