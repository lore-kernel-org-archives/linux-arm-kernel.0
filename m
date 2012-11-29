From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 29 Nov 2012 15:45:22 +0800
Subject: [PATCH v2] MTD: at91: atmel_nand: return bit flips for the PMECC
 read_page()
In-Reply-To: <50B51605.9040703@newsguy.com>
References: <1354013431-13598-1-git-send-email-josh.wu@atmel.com>
 <50B50D81.3060401@newsguy.com> <50B51605.9040703@newsguy.com>
Message-ID: <50B71292.4020604@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mike

On 11/28/2012 3:35 AM, Mike Dunn wrote:
> On 11/27/2012 10:59 AM, Mike Dunn wrote:
>> On 11/27/2012 02:50 AM, Josh Wu wrote:
>>> This patch fix pmecc's read_page() to return maximum number of bitflips, 0 if uncorrectable.
>>>
>>> In the commit: 3f91e94f7f511de74c0d2abe08672ccdbdd1961c ("mtd: nand: read_page() returns max_bitflips ()"),
>>> The ecc.read_page() is changed to return the maximum number of bitflips.
>>> And when meet uncorrectable bitflips it needs to return 0.
>>>
>>> See the comment in nand.h:
>>>   * @read_page:	function to read a page according to the ECC generator
>>>   *		requirements; returns maximum number of bitflips corrected in
>>>   *		any single ECC step, 0 if bitflips uncorrectable, -EIO hw error
>>>
>>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>>> ---
>>> change since v1:
>>>    1. add detail commit message for the fix.
>>>    2. return 0 when meet uncorrectable bitflips according to Mike Dunn's suggestion.
>>
>> Reviewed-by: Mike Dunn <mikedunn@newsguy.com>
>>
>> I see now the pmecc controller patch in the git log.  Nice work.
>
> BTW, with such a wide range for ecc strength - up to 24 bits, according to the
> commit message for the pmecc patch - you may want to think about setting an
> appropriate bitflip_threshold in the driver.  I'm not a nand expert, and I don't
> know much about the atmel_nand specifically, but I would think that if 23 bits
> are corrected on a page of size 2k (or less), maybe a return code of -EUCLEAN
> from mtd_read() might be appropriate.

After checking the nand_base.c, I saw it will set the 
mtd.bitflip_threshold to mtd->ecc.strength during nand_scan_tail().
in the atmel_nand code, the ecc strength will be set correctly, that 
means bitflip_threashold should be set up correctly by default.
so I think I don't need set up the the bitflip_threshold anymore if I 
set ecc strength correctly. Am I missing any point here?

Thanks,
Josh Wu

>
> Mike
