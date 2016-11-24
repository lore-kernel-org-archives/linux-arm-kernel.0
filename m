From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 24 Nov 2016 10:33:46 +0530
Subject: [PATCH v2] ARM: dts: da850: add the mstpri and ddrctl nodes
In-Reply-To: <f88df859-3c0f-38f2-275d-ce6a9996fb6e@lechnology.com>
References: <1479207611-18028-1-git-send-email-bgolaszewski@baylibre.com>
 <a39b9276-865b-6382-574e-a5ef040a452f@lechnology.com>
 <CAMpxmJVqog0Fno_DO0NQKmVNvzu5d=3GOLk145wBmB-V70BLeg@mail.gmail.com>
 <5e647eb0-2f8a-b46b-2048-7616bfb54ad7@lechnology.com>
 <m2bmx5x1y2.fsf@baylibre.com>
 <f88df859-3c0f-38f2-275d-ce6a9996fb6e@lechnology.com>
Message-ID: <20fbc946-d56c-31a3-4ae7-cf61df96a3c3@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 November 2016 04:18 AM, David Lechner wrote:
> On 11/23/2016 04:32 PM, Kevin Hilman wrote:
>> David Lechner <david@lechnology.com> writes:
>>
>>> On 11/23/2016 04:27 AM, Bartosz Golaszewski wrote:
>>>> 2016-11-22 23:23 GMT+01:00 David Lechner <david@lechnology.com>:
>>>>> On 11/15/2016 05:00 AM, Bartosz Golaszewski wrote:
>>>>>>
>>>>>> Add the nodes for the MSTPRI configuration and DDR2/mDDR memory
>>>>>> controller drivers to da850.dtsi.
>>>>>>
>>>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>> ---
>>>>>> v1 -> v2:
>>>>>> - moved the priority controller node above the cfgchip node
>>>>>> - renamed added nodes to better reflect their purpose
>>>>>>
>>>>>>  arch/arm/boot/dts/da850.dtsi | 8 ++++++++
>>>>>>  1 file changed, 8 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/da850.dtsi
>>>>>> b/arch/arm/boot/dts/da850.dtsi
>>>>>> index 1bb1f6d..412eec6 100644
>>>>>> --- a/arch/arm/boot/dts/da850.dtsi
>>>>>> +++ b/arch/arm/boot/dts/da850.dtsi
>>>>>> @@ -210,6 +210,10 @@
>>>>>>                         };
>>>>>>
>>>>>>                 };
>>>>>> +               prictrl: priority-controller at 14110 {
>>>>>> +                       compatible = "ti,da850-mstpri";
>>>>>> +                       reg = <0x14110 0x0c>;
>>>>>
>>>>>
>>>>> I think we should add status = "disabled"; here and let boards opt in.
>>>>>
>>>>>> +               };
>>>>>>                 cfgchip: chip-controller at 1417c {
>>>>>>                         compatible = "ti,da830-cfgchip", "syscon",
>>>>>> "simple-mfd";
>>>>>>                         reg = <0x1417c 0x14>;
>>>>>> @@ -451,4 +455,8 @@
>>>>>>                           1 0 0x68000000 0x00008000>;
>>>>>>                 status = "disabled";
>>>>>>         };
>>>>>> +       memctrl: memory-controller at b0000000 {
>>>>>> +               compatible = "ti,da850-ddr-controller";
>>>>>> +               reg = <0xb0000000 0xe8>;
>>>>>
>>>>>
>>>>> same here. status = "disabled";
>>>>>
>>>>>> +       };
>>>>>>  };
>>>>>>
>>>>
>>>> Hi David,
>>>>
>>>> I did that initially[1][2] and it was rejected by Kevin[3] and
>>>> Laurent[4].
>>>>
>>>> FYI this patch has already been queued by Sekhar.
>>>
>>> Thanks. I did not see those threads.
>>>
>>> FYI to maintainers, having these enabled by default causes error
>>> messages in the kernel log for other boards that are not supported by
>>> the drivers.
>>
>> Then the driver is too noisy and should be cleaned up.
>>
>>> Since there is only one board that is supported and soon
>>> to be 2 that are not, I would rather have this disabled by default to
>>> avoid the error messages.
>>
>> IMO, what exactly are the error messages? Sounds like the driver is
>> being too verbose, and calling things errors that are not really errors.
> 
> It is just one line per driver.
> 
>     dev_err(dev, "no master priorities defined for this board\n");
> 
> and
> 
>     dev_err(dev, "no settings defined for this board\n");
> 
> 
> Since "ti,da850-lcdk" is the only board supported in these drivers, all
> other boards will see these error messages.

Thats pretty bad. Sorry about that. The original justification for
keeping them enabled all the time was that they are in-SoC modules with
no external dependencies (like IO lines or voltage rails) so they can be
enabled on all boards that use DA850. While that remains true, the
configuration itself is board specific.

I think the error messages are still useful, so instead of silencing
them, I think we should go back to keeping these nodes disabled by
default and enabling only on boards which have support for it in the driver.

Thanks,
Sekhar
