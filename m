From: lho@apm.com (Loc Ho)
Date: Thu, 30 Apr 2015 15:59:14 -0700
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <CAL_JsqL7emqq=bSaWSi_0G5qSJqO+nVH_JH7VY+ynbrHhaSf_g@mail.gmail.com>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <7128860.xHITr0VFap@wuerfel> <20150430094134.GD3488@pd.tnic>
 <10227049.9i19zDi2y3@wuerfel> <20150430130028.GF3488@pd.tnic>
 <CAPw-ZTnuyB2ne1C2-38qAxM_ANwdr9nuCYUMj=aTx7c90sVg+Q@mail.gmail.com>
 <20150430171846.GJ3488@pd.tnic>
 <CAPw-ZTksYNDE2zVD=ZjGzpKfXQN8KgW85ZnHoQ2eVmSGdSdMOw@mail.gmail.com>
 <CAL_JsqL7emqq=bSaWSi_0G5qSJqO+nVH_JH7VY+ynbrHhaSf_g@mail.gmail.com>
Message-ID: <CAPw-ZT=LT_7Ob4-JAzGmePnY2q6GW8HA9QO-AifQVSG4Hh8cdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>>
>>>> I had read all the emails interaction. Yes I can write a single EDAC
>>>> driver. But I actually have multiple instances and single instance of
>>>> the same IP's. For example, I have 4 DDR controllers, 4 CPU domains,
>>>> one L3 and one SoC. If you can suggest to me how this would work with
>>>> devicetree, I might be able to make it works. But from HW point of
>>>> view (take the memory controller as an example), there is really 4
>>>> hardware blocks and some shared IP's block for status. It is much
>>>> simple representation with multiple instance of the driver.
>>>
>>> Your whole error reporting is done roughly through the same registers,
>>> as Arnd pointed out. Why can't you build your single driver around that
>>> and based on the error type being reported, multiplex inside a *single*
>>> interrupt handler to the proper decoding routines.
>>
>> Yes... I can do this but I don't see how it will scale when some SoC
>> in the future may have more or less instance of the memory controllers
>> for example. I guess for now, I will just iteration 4 time with an
>> single base address or four resources in a loop. Let's agreed on the
>> DT layout and I will generate an new patch then. See below...
>
> You are right, it does not scale.

Glad that you agree and I would like to avoid.

>
>>>> I think we should first agreed on the DT binding and let's not worry
>>>> about APEI. Then, whether we have one file or multiple file. Again,
>>>> the HW consist of:
>>>>
>>>> 1. One top level interrupt and status registers
>
> For these registers, are there ECC specific functions here or just
> normal interrupt control/status bits (mask/unmask/status)?

It is just interrupt and status bit - a bit for an type of errors.

> Assuming
> the later, then you should make this block an interrupt-controller.
> Then this is the interrupt-parent for the rest of the blocks.

Okay... Let me see if I can find an example.

>
>>>> 2. CSW, MCB A and MCB B for detection of any active memory controllers
>>>> 3. 4 individual memory controller instance
>>>> 4. 4 CPU domain instance with its own individual L2 registers
>>>> 5. Each CPU has instance own L1
>>>> 6. One L3 instance
>>>> 7. One SoC instance
>>>
>>> And all of those are separate IP blocks and they can be integrated with
>>> other, non APM hardware, or do those things all belong together?
>>
>> The top level interrupt may be different and APM specific unless other
>> vendors adapt the same bit definitions. I highly doubt other vendor
>> will use the same bit definitions. The CSW is APM only. The MCB A, MCB
>> B, and memory controller are APM only. The L3, and SoC are APM specify
>> only. For L1 and L2, I will need to check with the CPU designer - but
>> likely APM specific.
>>
>>> IOW,
>>> can we expect such IP blocks to appear in other hw platforms or are
>>> they all custom APM design which need to go together due to proprietary
>>> coherency protocol or whatever, for example?
>>
>> See above.
>>
>>>
>>>> As for as what is useful, we find that the memory controller and the
>>>> L1 and L2 are useful as it provides info for errors - for HW/system
>>>> debugging as well as margin of DDR.
>>>
>>> Sounds like all is useful.
>>>
>>
>> Now let us discuss the DT layout if it is an single driver:
>>
>> xgeneedac: xgeneedac at 7e800000 {
>>         compatible = "apm,xgene-edac";
>>         regmap-efuse = <&efuse>; /* efuse */
>>         reg = <0x0 0x78800000 0x0 0x100>, /* Top level interrupt
>> status resource */
>>                 <0x0 0x7e200000 0x0 0x1000>, /* CSW for MCB active resource
>>                 <0x0 0x7e700000 0x0 0x1000>, /* MCB A resource */
>>                 <0x0 0x7e720000 0x0 0x1000>, /* MCB B resource */
>>                 <0x0 0x7e800000 0x0 0x1000>, /* MCU 0 resource */
>>                 <0x0 0x7e840000 0x0 0x1000>, /* MCU 1 resource */
>>                 <0x0 0x7e880000 0x0 0x1000>, /* MCU 2 resource */
>>                 <0x0 0x7e8c0000 0x0 0x1000>, /* MCU 3 resource */
>>                 <0x0 0x7c000000 0x0 0x200000>, /* CPU 0 domain for L1 and L2 */
>>                 <0x0 0x7c200000 0x0 0x200000>, /* CPU 1 domain for L1 and L2 */
>>                 <0x0 0x7c400000 0x0 0x200000>, /* CPU 2 domain for L1 and L2 */
>>                 <0x0 0x7c600000 0x0 0x200000>, /* CPU 3 domain for L1 and L2 */
>>                 <0x0 0x7e600000 0x0 0x1000>, /* L3 resource */
>>                 <0x0 0x7e930000 0x0 0x1000>, /* SoC bus resource */
>>                 <0x0 0x7e000000 0x0 0x1000>, /* SoC device resource */
>
> Uggg, no. You were on the right track earlier in the thread. One node
> per instance of each block.

Let me try just the memory controller. I will re-generate an patch for
just the memory controller.

>
>>       interrupts = <0x0 0x20 0x4>,
>>                        <0x0 0x21 0x4>,
>>                        <0x0 0x27 0x4>;
>
> Can you describe what each of these interrupts do?

IRQ 0x20 is used for un-correctable error for memory controller, L1,
L2 and some SoC IP parity errors.
IRQ 0x21 is used for correctable error for memory controller, and some
SoC IP parity errors.
IRQ 0x27 is used for SoC parity error.

-Loc
