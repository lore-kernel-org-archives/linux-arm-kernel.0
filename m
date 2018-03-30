From: peda@axentia.se (Peter Rosin)
Date: Fri, 30 Mar 2018 23:43:27 +0200
Subject: [PATCH] mtd: nand: raw: atmel: add module param to avoid using dma
In-Reply-To: <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
References: <20180329131054.22506-1-peda@axentia.se>
 <20180329153322.5e2fc1e7@bbrezillon>
 <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
 <20180329154416.5c1a0013@bbrezillon>
 <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
Message-ID: <68b5f229-638f-e589-36e0-921eb9101848@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-03-29 16:27, Peter Rosin wrote:
> On 2018-03-29 15:44, Boris Brezillon wrote:
>> On Thu, 29 Mar 2018 15:37:43 +0200
>> Peter Rosin <peda@axentia.se> wrote:
>>
>>> On 2018-03-29 15:33, Boris Brezillon wrote:
>>>> On Thu, 29 Mar 2018 15:10:54 +0200
>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>   
>>>>> On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
>>>>> flash accesses have a tendency to cause display disturbances. Add a
>>>>> module param to disable DMA from the NAND controller, since that fixes
>>>>> the display problem for me.
>>>>>
>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>>> ---
>>>>>  drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
>>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>> index b2f00b398490..2ff7a77c7b8e 100644
>>>>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>> @@ -129,6 +129,11 @@
>>>>>  #define DEFAULT_TIMEOUT_MS			1000
>>>>>  #define MIN_DMA_LEN				128
>>>>>  
>>>>> +static bool atmel_nand_avoid_dma __read_mostly;
>>>>> +
>>>>> +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
>>>>> +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);  
>>>>
>>>> I'm not a big fan of those driver specific cmdline parameters. Can't we
>>>> instead give an higher priority to HLCDC master using the bus matrix?  
>>>
>>> I don't know if it will be enough, but we sure can try. However, I have
>>> no idea how to do that. I will happily test stuff though...
>>
>> There's no interface to configure that from Linux, but you can try to
>> tweak it with devmem and if that does the trick, maybe we can expose a
>> way to configure that from Linux. For more details, see the "Bus Matrix
>> (MATRIX)" section in Atmel datasheets.
> 
> I don't seem to succeed in changing the registers I think I need to change.
> I can poke the "Write Protection Mode Register" by writing MAT0 and MAT1 to
> it. But when I try to write to "Priority Registers B For Slaves" it doesn't
> take, regardless of write protect mode.
> 
> Can the relevant bits only be written when the HLCDC is inactive or
> something?

Here is someone else with what seems like very similar problems[1], however
also with USB disturbing the display. I can't test that (easily) since a
mux in front of the USB port was unfortunately wired incorrectly in this
first attempt. And USB disturbing the display is not a showstopper around
here, since USB will only be used for debugging etc in my case.

[1] https://www.avrfreaks.net/forum/sama5d31-ahb-bus-matrix-lcd

Cheers,
Peter
