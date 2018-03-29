From: peda@axentia.se (Peter Rosin)
Date: Thu, 29 Mar 2018 16:23:32 +0200
Subject: [PATCH] mtd: nand: raw: atmel: add module param to avoid using dma
In-Reply-To: <30d8bd45-4e5d-3703-5f41-07f5fc70f09d@microchip.com>
References: <20180329131054.22506-1-peda@axentia.se>
 <30d8bd45-4e5d-3703-5f41-07f5fc70f09d@microchip.com>
Message-ID: <12f7f95a-0e1d-14d0-b402-10d1172004b3@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-03-29 16:20, Nicolas Ferre wrote:
> On 29/03/2018 at 15:10, Peter Rosin wrote:
>> On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
>> flash accesses have a tendency to cause display disturbances. Add a
>> module param to disable DMA from the NAND controller, since that fixes
>> the display problem for me.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>   drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
>> index b2f00b398490..2ff7a77c7b8e 100644
>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
>> @@ -129,6 +129,11 @@
>>   #define DEFAULT_TIMEOUT_MS			1000
>>   #define MIN_DMA_LEN				128
>>   
>> +static bool atmel_nand_avoid_dma __read_mostly;
>> +
>> +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
>> +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);
> 
> We had the DT parameter "atmel,nand-has-dma" for this purpose and it was 
> associated with a module parameter as well (use_dma,).
> 
> Is it only managed by old DT binding?

Saw it, but I need the reverse. I.e. *not* using DMA.

And I didn't think this belonged in DT since in some sense it doesn't really
describe HW so I went with a module parameter.

Cheers,
Peter
