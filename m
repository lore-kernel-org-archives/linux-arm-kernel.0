From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 21 Jan 2015 11:46:24 +0800
Subject: [PATCH] mtd: atmel_nand: check NFC busy flag by HSMC_SR instead
 of NFC cmd regs
In-Reply-To: <20150120203144.GN9759@ld-irv-0074>
References: <1421318753-14960-1-git-send-email-josh.wu@atmel.com>
 <20150120203144.GN9759@ld-irv-0074>
Message-ID: <54BF2110.7070008@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Brain

On 1/21/2015 4:31 AM, Brian Norris wrote:
> On Thu, Jan 15, 2015 at 06:45:53PM +0800, Josh Wu wrote:
>
> Was this written by Boris?
yes, Boris write the code snippet. I taken it and format it as a patch.

> If so, then it needs a 'From:' line at the
> start of the body. (Make sure 'Author' is correct in git, then
> git-format-patch/git-send-email will get it right for you.)
sounds the proper way. I will do that.

>
>> Currently the driver read NFC command registers to get NFC busy flag.
>> Actually this flag also can be get by reading HSMC_SR register.
>>
>> Use the read NFC command registers need mapping a huge memory region.
>> To save the mapped memory region, we change to check NFC busy flag by
>> reading HSMC_SR register.
> Are we actually saving anything yet? You didn't change the requested
> region yet.
After this patch is applied, then we can apply following patch for NFC's 
dts,

                                 reg = <
-                                       0x90000000 0x10000000   /* NFC 
Command Registers */
+                                      0x90000000 0x08000000   /* NFC 
Command Registers */
                                         0xfc05c000 0x00000070   /* NFC 
HSMC regs */
                                         0x00100000 0x00100000   /* NFC 
SRAM banks */
                                          >;
                                 clocks = <&hsmc_clk>;

But as this change should go to the at91-dt, so I would like make the 
nand driver patch is accepted first. Then send out the dts changes.

>
>> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>> Acked-by: Josh Wu <josh.wu@atmel.com>
> Since this is passing through your hands, Josh, it should be
> 'Signed-off-by' not 'Acked-by'.
sure, I will change this.

>
>> ---
>>
>>   drivers/mtd/nand/atmel_nand.c     | 3 +--
>>   drivers/mtd/nand/atmel_nand_nfc.h | 1 +
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
>> index 3853597..125330b 100644
>> --- a/drivers/mtd/nand/atmel_nand.c
>> +++ b/drivers/mtd/nand/atmel_nand.c
>> @@ -1699,8 +1699,7 @@ static int nfc_send_command(struct atmel_nand_host *host,
>>   		cmd, addr, cycle0);
>>   
>>   	timeout = jiffies + msecs_to_jiffies(NFC_TIME_OUT_MS);
>> -	while (nfc_cmd_readl(NFCADDR_CMD_NFCBUSY, host->nfc->base_cmd_regs)
>> -			& NFCADDR_CMD_NFCBUSY) {
>> +	while (nfc_readl(host->nfc->hsmc_regs, SR) & NFC_SR_BUSY) {
>>   		if (time_after(jiffies, timeout)) {
>>   			dev_err(host->dev,
>>   				"Time out to wait CMD_NFCBUSY ready!\n");
> Change the timeout text?
I would change this to:

"Time out to wait for NFC ready!\n");


>
>> diff --git a/drivers/mtd/nand/atmel_nand_nfc.h b/drivers/mtd/nand/atmel_nand_nfc.h
>> index 85b8ca6..4d5d262 100644
>> --- a/drivers/mtd/nand/atmel_nand_nfc.h
>> +++ b/drivers/mtd/nand/atmel_nand_nfc.h
>> @@ -35,6 +35,7 @@
>>   #define		NFC_CTRL_DISABLE	(1 << 1)
>>   
>>   #define ATMEL_HSMC_NFC_SR	0x08		/* NFC Status Register */
>> +#define		NFC_SR_BUSY		(1 << 8)
>>   #define		NFC_SR_XFR_DONE		(1 << 16)
>>   #define		NFC_SR_CMD_DONE		(1 << 17)
>>   #define		NFC_SR_DTOE		(1 << 20)
> Brian

Thanks.
Best Regards,
Josh Wu
