From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 8 Dec 2015 09:42:26 +0200
Subject: [PATCH] ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
In-Reply-To: <20151204215115.GP23396@atomide.com>
References: <1449225915-28879-1-git-send-email-peter.ujfalusi@ti.com>
 <87wpsunn82.fsf@saruman.tx.rr.com> <20151204184706.GO23396@atomide.com>
 <5617214.abxPrpfVaF@wuerfel> <20151204215115.GP23396@atomide.com>
Message-ID: <566689E2.7060907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2015 11:51 PM, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [151204 13:38]:
>> On Friday 04 December 2015 10:47:07 Tony Lindgren wrote:
>>>> Peter Ujfalusi <peter.ujfalusi@ti.com> writes:
>>>>> @@ -174,12 +182,44 @@
>>>>>             };
>>>>>  
>>>>>             edma: edma at 49000000 {
>>>>> -                   compatible = "ti,edma3";
>>>>> -                   ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
>>>>> -                   reg =   <0x49000000 0x10000>,
>>>>> -                           <0x44e10f90 0x40>;
>>>>> +                   compatible = "ti,edma3-tpcc";
>>>>> +                   ti,hwmods = "tpcc";
>>>>> +                   reg =   <0x49000000 0x10000>;
>>>>> +                   reg-names = "edma3_cc";
>>>>>                     interrupts = <12 13 14>;
>>>>> -                   #dma-cells = <1>;
>>>>> +                   interrupt-names = "edma3_ccint", "emda3_mperr",
>>>>> +                                     "edma3_ccerrint";
>>>>> +                   dma-requests = <64>;
>>>>> +                   #dma-cells = <2>;
>>>>> +
>>>>> +                   ti,tptcs = <&edma_tptc0 7>, <&edma_tptc1 5>,
>>>>> +                              <&edma_tptc2 0>;
>>>>> +
>>>>> +                   ti,edma-memcpy-channels = /bits/ 16 <20 21>;
>>>>
>>>> can you explain this property here ? Are you setting bits 20 and 21 on a
>>>> 16-bit field ?
>>>
>>> I think it's an arry of u16 dma channels.. But could it be just /bits/ 8
>>> instead of /bits/ 16?
>>>
>>
>> Please just drop the /bits/ 16 and use normal cells.
> 
> Yeah agreed, makes things less confusing for sure :)

4.4 will be the first kernel where we will have the new eDMA bindings. I have
chosen to use 16bit array for specifying the channels used for memcpy
(ti,edma-memcpy-channels) and for the reserving paRAM slots
(ti,edma-reserved-slot-ranges). As of now we have maximum of 64 channels and
512 paRAM slots. 16bit is more than enough to store this information and it
even gives us enough room if ever in the future these numbers are going to
increase (which  they are not).

But in order to change them to 32bit the driver needs to be changed as well.
Currently we do not have drivers (in 4.4) using the new bindings, 4.4 is not
yet out, so it might be possible to change the binding document and the driver
to use 32bit arrays. The driver internally uses 16bit type for these which I'm
not going to change, but the code parsing the DT needs to be adjusted for the
new data type.

If Vinod is willing to take update for the DT binding of eDMA for 4.4-rc, I
can cook up the patch(es) to do so.

-- 
P?ter
