From: josh.wu@atmel.com (Josh Wu)
Date: Fri, 29 Jun 2012 17:00:27 +0800
Subject: [PATCH v12 0/2] MTD: at91: Add PMECC support for at91 nand flash
 driver
In-Reply-To: <1340898021.3070.123.camel@sauron.fi.intel.com>
References: <1340871698-477-1-git-send-email-josh.wu@atmel.com>
 <1340898021.3070.123.camel@sauron.fi.intel.com>
Message-ID: <4FED6EAB.3000802@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Artem

On 6/28/2012 11:40 PM, Artem Bityutskiy wrote:
> On Thu, 2012-06-28 at 16:21 +0800, Josh Wu wrote:
>> Those patches is based on the l2-mtd.git three.
>>
>> Since there are two patches of v11 already pushed, so this version v12 only includes the left two patches.
>> which includes the modification according to Richard Genoud's review suggestion.
>>
>> Changes since v11,
>> 	add documentation for atmel nand reg parameter and one example for PMECC support.
>> 	fix the bug: no error reported when fail to get resoures of PMECC ERRLOC or ROM.
>> 	fix the bug: no correction when ecc data has bit flipped.
>> 	add clearer debug information for data correction.
>>
>> Josh Wu (2):
>>    MTD: at91: add dt parameters for Atmel PMECC
>>    MTD: at91: atmel_nand: Update driver to support Programmable Multibit
>>      ECC controller
>>
>>   .../devicetree/bindings/mtd/atmel-nand.txt         |   40 +-
>>   drivers/mtd/nand/atmel_nand.c                      |  801 +++++++++++++++++++-
>>   drivers/mtd/nand/atmel_nand_ecc.h                  |  114 ++-
>>   3 files changed, 951 insertions(+), 4 deletions(-)
> Aiaiai is not 100% happy, could you take a look?
>
> dedekind at blue:~/git/maintaining$ ../aiaiai/aiaiai-concat-mboxes ~/tmp/wu* | ./verify ../l2-mtd/ atmel_nand
> Tested the patch(es) on top of the following commits:
> 9328bb5 Quick fixes - applied by aiaiai
> ea3b6ef mtd: fix bogus inequation
> 0960e57 mtd: move mtd_read_oob() definition out of mtd.h
> 0560176 mtd: nand_bbt: refactor check_pattern_no_oob()
>
> --------------------------------------------------------------------------------
>
> Successfully built configuration "arm-at91cap9_defconfig,arm,arm-unknown-linux-gnueabi-", results:
>
> --- before_patching.log
> +++ after_patching.log
> @@ @@
> +drivers/mtd/nand/atmel_nand.c: In function 'pmecc_correct_data':
> +drivers/mtd/nand/atmel_nand.c:680:38: warning: variable 'ecc_size' set but not used [-Wunused-but-set-variable]

oops, I'll fix this warning in next version.

> +drivers/mtd/nand/atmel_nand.c:480:32: error: bad constant expression [sparse]
> +drivers/mtd/nand/atmel_nand.c:488:35: error: bad constant expression [sparse]
> +drivers/mtd/nand/atmel_nand.c:633:32: error: bad constant expression [sparse]
> +drivers/mtd/nand/atmel_nand.c:635:35: error: bad constant expression [sparse]

I use CodeSourcery 2010q1, and no any error reported. So it seems 
related with the compiler.

 From the log, I think the error is caused by the dynamic 2d array: 
smu[cap + 2][2 * cap + 1]. which is used to calculate the sigma table.

Since the smu is allocated when driver is probed, and the length of the 
smu depend on PMECC correction capablity. So when I declare the type of 
smu by following line: (cap is declared as const type)
          int16_t (*smu)[2 * cap + 1];
That make Sparse compiler not happy, since the cap is a variable. so it 
reports an error. But for this case, the CodeSourcery works fine.

For fixing this compile error, in next version,  I will use 1D array 
instead of 2D array, for instance: all smu[i][j] changes to smu[i * num 
+ j].  // in this line, num equal to 2 * cap + 1.
I think in such way, all compiler should be happy. :)

When I send out the next version of the patch, Could you please test it 
about above fix? since I don't have Sparse compiler in my hand. Thanks.

>
> --------------------------------------------------------------------------------
>
>

Best Regards,
Josh Wu
