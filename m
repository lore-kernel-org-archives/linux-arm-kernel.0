From: peda@axentia.se (Peter Rosin)
Date: Thu, 12 Apr 2018 09:18:19 +0200
Subject: [PATCH] mtd: nand: raw: atmel: add module param to avoid using dma
In-Reply-To: <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
References: <20180329131054.22506-1-peda@axentia.se>
 <20180329153322.5e2fc1e7@bbrezillon>
 <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
 <20180329154416.5c1a0013@bbrezillon>
 <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
 <20180402142249.7e076a64@bbrezillon>
 <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
 <20180402212843.164d5d21@bbrezillon> <20180402222020.1d344c14@bbrezillon>
 <d7e6f78d-b57b-4d0f-c07c-ca6c1930cd51@axentia.se>
 <20180403091813.5fb5c18c@bbrezillon>
 <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
 <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
Message-ID: <36fd2204-50dc-329d-ff13-0dd11490cda5@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-04-11 17:34, Nicolas Ferre wrote:
> On 11/04/2018 at 16:44, Peter Rosin wrote:
>> Hi Nicolas,
>>
>> Boris asked for your input on this (the datasheet difference appears to
>> have no bearing on the issue) elsewhere in the tree of messages. It's
>> now been a week or so and I'm starting to wonder if you missed this
>> altogether or if you are simply out of office or something?
> 
> Hi Peter,
> 
> I didn't dig into this issue with matrix datasheet reset values and your 
> findings below. I'll try to move forward with your detailed explanation 
> and with my contacts within the "product" team internally.

Thanks, I feel that experimenting with the matrix with bogus documentation
is harder than needed, so I'm waiting for that information.

> However, I have the feeling that this sounds a little bit familiar to me 
> and that the pins drive strength for the NAND Flash *and* LCD must be 
> positioned to "Medium drive" at least for these interfaces (register 
> PIO_CFGR).
> 
> We use this particular setting for our own vendor branch and found that 
> the LCD and NAND Flash was far more sable on *some HW boards*. Here is 
> an example for NAND but you can find the same for LCD:
> https://github.com/linux4sam/linux-at91/commit/99d9e4c8848a2f16cc5b34bb27e588ca7504b695
> Obviously the "drive strength" property added by Ludovic has been 
> proposed but is not accepted yet in Mainline and this is why you don't 
> see it positioned here.

Ok, translating this from SAMA5D2 to SAMA5D3 (which is what I have), I
assume this is PIO_DRIVER1 and PIO_DRIVER2 instead. Peeking at those
registers they all contain 0xaaaaaaaa, so I guess all pins are already
"Medium drive" on my board. Also, looking at that sama5d2-ptc-ek patch
it seems possible to adjust the drive strength of the nand D<x> lines,
and I don't think that's possible on the SAMA5D3? The NAND uses D0-D15
on our board, but there is no alternative use for those pins.

So I can change the drive-strength for these LCD pins: LCDDAT0-15 (only
using rgb565), LCDVSYNC, LCDHSYNC, LCDPCK and LCDDEN (LCDDISP is not
used). And for the NAND I can fiddle with NANDALE and NANDCLE.

I.e. PA0-15, PA26-29 and PE21-22

I tried to change the drive strength of these pins to both "Low Drive"
and "High Drive" and it didn't have any visible effect on the display
artifacts during NAND accesses.

> If it feels like an issue with "crosstalk" it might be the reason why. 
> For overruns or underruns, it's true that I would say that it's not 
> related and that dealing with the matrix is the way to go.

It does feel like underruns and that the LCD controller isn't able to
keep up with the needed tempo of the display output. At least that is
consistent with how the artifacts look.

> You can simply test this using devmem2 and see if it's better.

See above.

> Hope that it helps.

Sorry, but no disco. Thanks though!

Cheers,
Peter

> Best regards,
>    Nicolas
> 
>> On 2018-04-03 09:18, Boris Brezillon wrote:
>>> On Tue, 3 Apr 2018 08:11:30 +0200
>>> Peter Rosin <peda@axentia.se> wrote:
>>>
>>>> On 2018-04-02 22:20, Boris Brezillon wrote:
>>>>> On Mon, 2 Apr 2018 21:28:43 +0200
>>>>> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>>>>>    
>>>>>> On Mon, 2 Apr 2018 19:59:39 +0200
>>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>>   
>>>>>>> On 2018-04-02 14:22, Boris Brezillon wrote:
>>>>>>>> On Thu, 29 Mar 2018 16:27:12 +0200
>>>>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>>>>        
>>>>>>>>> On 2018-03-29 15:44, Boris Brezillon wrote:
>>>>>>>>>> On Thu, 29 Mar 2018 15:37:43 +0200
>>>>>>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>>>>>>          
>>>>>>>>>>> On 2018-03-29 15:33, Boris Brezillon wrote:
>>>>>>>>>>>> On Thu, 29 Mar 2018 15:10:54 +0200
>>>>>>>>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>>>>>>>>            
>>>>>>>>>>>>> On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
>>>>>>>>>>>>> flash accesses have a tendency to cause display disturbances. Add a
>>>>>>>>>>>>> module param to disable DMA from the NAND controller, since that fixes
>>>>>>>>>>>>> the display problem for me.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>   drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
>>>>>>>>>>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>>>>>>>>> index b2f00b398490..2ff7a77c7b8e 100644
>>>>>>>>>>>>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>>>>>>>>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>>>>>>>>> @@ -129,6 +129,11 @@
>>>>>>>>>>>>>   #define DEFAULT_TIMEOUT_MS			1000
>>>>>>>>>>>>>   #define MIN_DMA_LEN				128
>>>>>>>>>>>>>   
>>>>>>>>>>>>> +static bool atmel_nand_avoid_dma __read_mostly;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
>>>>>>>>>>>>> +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);
>>>>>>>>>>>>
>>>>>>>>>>>> I'm not a big fan of those driver specific cmdline parameters. Can't we
>>>>>>>>>>>> instead give an higher priority to HLCDC master using the bus matrix?
>>>>>>>>>>>
>>>>>>>>>>> I don't know if it will be enough, but we sure can try. However, I have
>>>>>>>>>>> no idea how to do that. I will happily test stuff though...
>>>>>>>>>>
>>>>>>>>>> There's no interface to configure that from Linux, but you can try to
>>>>>>>>>> tweak it with devmem and if that does the trick, maybe we can expose a
>>>>>>>>>> way to configure that from Linux. For more details, see the "Bus Matrix
>>>>>>>>>> (MATRIX)" section in Atmel datasheets.
>>>>>>>>>
>>>>>>>>> I don't seem to succeed in changing the registers I think I need to change.
>>>>>>>>> I can poke the "Write Protection Mode Register" by writing MAT0 and MAT1 to
>>>>>>>>> it.
>>>>>>>>
>>>>>>>> You mean 0x4D415400, right? ("MAT0" != 0x4D415400).
>>>>>>>
>>>>>>> Bits 1 through 7 do not matter, so even though not equal they are (or
>>>>>>> should be) equivalent. But I did use 0x4d415400. I simply used the
>>>>>>> shorter syntax since that was easier to type and conveyed the relevant
>>>>>>> info.
>>>>>>
>>>>>> Ok.
>>>>>>   
>>>>>>>      
>>>>>>>>> But when I try to write to "Priority Registers B For Slaves" it doesn't
>>>>>>>>> take, regardless of write protect mode.
>>>>>>>>
>>>>>>>> Did you check MATRIX_WPSR after writing to MATRIX_PRXSY?
>>>>>>>
>>>>>>> No, but did it again and checked, see transcript below.
>>>>>>
>>>>>> I don't use devmem2. Is 'readback' information accurate or is it
>>>>>> always what's been written? Because when you write 0x33 to 0xFFFFECBC,
>>>>>> 0x33 is read back, but just after that, when you read it again it's 0.
>>>>>>   
>>>>>>> BTW, how do I
>>>>>>> know which master is in use for the LCD controller? 8 or 9? Both?
>>>>>>
>>>>>> It's configurable on a per-layer basis through the SIF bit in
>>>>>> LCDC_<layer>CFG0. The driver tries to dispatch the load on those 2 AHB
>>>>>> masters [1].
>>>>>>   
>>>>>>> And
>>>>>>> which DDR slave is the target? 7, 8, 9 or 10? More than one?
>>>>>>
>>>>>> This, I don't know. I guess all of them can be used.
>>>>>
>>>>> Looks like I was wrong. According to "Table 15-3. SAMA5D3 Master to
>>>>> Slave Access", LCDC port 0 can only access DDR port 2 and LCDC port 1
>>>>> can only access DDR port 3.
>>>>
>>>> About that table, someone with HW-knowledge should have a real close
>>>> look at it! Why?
>>>>
>>>> I peeked at all the PRxSy registers and there are a lot of '3' entries
>>>> for all the MxPR fields. In fact, the '3' entries align very neatly
>>>> with the checks in this "Master to Slave Access" table. Except they
>>>> don't, after a while.
>>>>
>>>> Here's how the table looks in my datasheet:
>>>>
>>>>   0 vv--v--v--vvvv-
>>>>   1 vv--v--v--vvvv-
>>>>   2 vv-------------
>>>>   3 vv--------vvv--
>>>>   4 vv-------------
>>>>   5 v--------------
>>>>   6 vv--vv-vvvvvvvv
>>>>     v--------------
>>>>   7 v--------------
>>>>   8 --v-v--v-------
>>>>   9 -v---v--v--v---
>>>> 10 ---------vv-vvv
>>>> 11 v--v-----------
>>>> 12 v-----v--------
>>>>
>>>> And here's the '3' entries when digging in the registers (the extra
>>>> dash at the end is for the 16th non-existent slave):
>>>>
>>>>   0 33--3--3--3333--
>>>>   1 33--3--3--3333--
>>>>   2 33--------------
>>>>   3 -3--------333---
>>>>   4 33--------------
>>>>   5 3---------------
>>>>   6 33--33-33333333-
>>>>   7 --3-3--3--------
>>>>   8 -3---3--3--3----
>>>>   9 --3-3--3-33-333-
>>>> 10 3--3------------
>>>> 11 3-----3---------
>>>> 12 ----------------
>>>> 13 ----------------
>>>> 14 ----------------
>>>> 15 ----------------
>>>>
>>>> There's a big mismatch for the four DDR2 lines in the table; they
>>>> seem to map to only three registers. Other than that, the only tweak
>>>> or anomaly is that first entry (Cortex A5) for master 3 (Int ROM).
>>>>
>>>> *time passes*
>>>>
>>>> Arrrgh!! You say "Table 15-3". This is Table 14-3 for me! I believe
>>>> I'm using the latest datasheet (02-Feb-16). What are you reading???!?
>>>
>>> Oops, I was reading an old datasheet (from 2014).
>>
> 
> 
