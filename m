From: tthayer@opensource.altera.com (Thor Thayer)
Date: Fri, 17 Jun 2016 12:09:59 -0500
Subject: [PATCHv3 3/7] EDAC, altera: Share Arria10 check_deps & IRQ
 functions
In-Reply-To: <20160617170050.GG3912@pd.tnic>
References: <1465852752-11018-1-git-send-email-tthayer@opensource.altera.com>
 <1465852752-11018-4-git-send-email-tthayer@opensource.altera.com>
 <20160617170050.GG3912@pd.tnic>
Message-ID: <57642EE7.4060109@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 06/17/2016 12:00 PM, Borislav Petkov wrote:
> On Mon, Jun 13, 2016 at 04:19:08PM -0500, tthayer at opensource.altera.com wrote:
>> From: Thor Thayer <tthayer@opensource.altera.com>
>>
>> In preparation for additional memory module ECCs, the IRQ and
>> check_deps() functions are being made available to all the memory
>> buffers. Move them outside of the OCRAM only area.
>>
>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>> ---
>> v2  New patch. Move shared functions outside OCRAM only area.
>> v3  Change title line - check_deps & IRQ.
>> ---
>>   drivers/edac/altera_edac.c |   62 ++++++++++++++++++++++++--------------------
>>   1 file changed, 34 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
>> index a9d8fa7..a3f490d 100644
>> --- a/drivers/edac/altera_edac.c
>> +++ b/drivers/edac/altera_edac.c
>> @@ -825,9 +825,9 @@ static struct platform_driver altr_edac_device_driver = {
>>   };
>>   module_platform_driver(altr_edac_device_driver);
>>
>> -/*********************** OCRAM EDAC Device Functions *********************/
>> +/******************* Arria10 Device ECC Shared Functions *****************/
>>
>> -#ifdef CONFIG_EDAC_ALTERA_OCRAM
>> +#if defined(CONFIG_EDAC_ALTERA_OCRAM) || defined(CONFIG_EDAC_ALTERA_ETHERNET)
>
> Do you need the ifdeffery here at all?
>
> IOW, can we leave this function compiled-in unconditionally?
>
Since each peripheral's EDAC can be individually selected, the build 
generates a warning of an unused function if just L2 cache was selected.

The ifdeffery is ugly but it removes that warning in the L2 only case.

Thanks for reviewing!

Thor
