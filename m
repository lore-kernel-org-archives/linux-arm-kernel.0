From: stigge@antcom.de (Roland Stigge)
Date: Mon, 03 Sep 2012 11:10:27 +0200
Subject: mxc_nand.c on mach-imx/imx53
In-Reply-To: <20120903085517.GE26594@pengutronix.de>
References: <5035F84E.3000901@antcom.de>
 <20120829074122.GV26594@pengutronix.de> <503E3331.8050203@antcom.de>
 <20120829172820.43bbe68e@eb-e6520> <50407E44.5080408@antcom.de>
 <504098A1.4050208@antcom.de> <20120903085517.GE26594@pengutronix.de>
Message-ID: <50447403.4010003@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2012 10:55 AM, Sascha Hauer wrote:
> On Fri, Aug 31, 2012 at 12:57:37PM +0200, Roland Stigge wrote:
>> On 08/31/2012 11:05 AM, Roland Stigge wrote:
>>> I tried to port this on top of Sascha's patches for imx53, only for mxc v3 for now, as below.
>>>
>>> Unfortunately, I still get:
>>>
>>> ...
>>> UnCorrectable RS-ECC Error
>>> UnCorrectable RS-ECC Error
>>> UnCorrectable RS-ECC Error
>>> UnCorrectable RS-ECC Error
>>> UnCorrectable RS-ECC Error
> 
> Have you written the data you are unable to read with this driver?

No, maybe that's one of the reasons. The bootloader also seems to
implement a different on-flash layout. But as written, the problem is
gone with the below fix.

>> --- linux-2.6.orig/drivers/mtd/nand/mxc_nand.c
>> +++ linux-2.6/drivers/mtd/nand/mxc_nand.c
>> @@ -1141,14 +1141,14 @@ static void mxc_nand_command(struct mtd_
>>                 host->devtype_data->send_cmd(host, command, true);
>>                 mxc_do_addr_cycle(mtd, column, page_addr);
>>                 host->devtype_data->send_read_id(host);
>> -               host->buf_start = column;
>> +               host->buf_start = 0;
>>                 break;
>>  
>>         case NAND_CMD_PARAM:
>>                 host->devtype_data->send_cmd(host, command, true);
>>                 mxc_do_addr_cycle(mtd, column, page_addr);
>>                 host->devtype_data->send_read_param(host);
>> -               host->buf_start = column;
>> +               host->buf_start = 0;
> 
> On what tree are you working? I cannot find a handling of
> NAND_CMD_PARAM in my tree.

That's on top of the patch I ported from Eric's barebox driver (other
mail, but only for imx53/v3 for now). Sorry for the confusion.

I can prepare a single patch, but maybe Eric's more knowledgeable on
this driver (including v1/v2 that I can't test), he announced a patch
for this week.

Roland
