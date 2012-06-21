From: mikedunn@newsguy.com (Mike Dunn)
Date: Thu, 21 Jun 2012 10:58:01 -0700
Subject: [RFC PATCH v2] MTD: nand: add return value for
 write_page()/write_page_raw() functions in structure of nand_ecc_ctrl.
In-Reply-To: <CAN8TOE8iDtzw4eTKa6tJ5oBxbaDUxg9nDLaKBhW4D86vGWxGJg@mail.gmail.com>
References: <1339567570-4816-1-git-send-email-josh.wu@atmel.com>
 <4FE13CB2.3000605@atmel.com>
 <CAN8TOE8iDtzw4eTKa6tJ5oBxbaDUxg9nDLaKBhW4D86vGWxGJg@mail.gmail.com>
Message-ID: <4FE360A9.4040102@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2012 11:43 AM, Brian Norris wrote:
> 
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
>>>                                 const uint8_t *buf, int oob_required)
>>>  {
>>>        return write_page(mtd, nand, buf, false);
>>>  }
> 
> Hmm, this used to be a void function, returning the result of another
> void function? I would think the compiler would have warned about
> these issues before. Anyway, this is a useless 'return' statement and
> can be killed with no real effect.


Oops, yes, this must have been a careless mistake when I combined the read_page
and read_page_raw functions into one, with wrappers for each case.  Oddly, no
compiler warning.  I'm trying to get around to putting together a patch with a
couple minor fixes for the docg4, and I'll add this to the list.

Thanks Brian,
Mike
