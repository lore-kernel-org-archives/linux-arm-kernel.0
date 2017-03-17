From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 17 Mar 2017 07:46:17 +0100
Subject: [PATCH v2] ARM: zynq: Add #io-channel-cells to (x)adc node for
 iio-hwmon
In-Reply-To: <1027ba77-6141-5d6e-e5e8-b15df29957f2@metafoo.de>
References: <1489003884-2489-1-git-send-email-mdf@kernel.org>
 <e6da3f38-7039-66e5-5b9d-a44ff42aa9c9@xilinx.com>
 <CAJYdmeNc48=OOvRiUjqPBJhz9RCbzeaRGu1Tfm=hrvzkJrSsag@mail.gmail.com>
 <7e4fbe16-8686-5399-748d-af222c630338@xilinx.com>
 <37f29986-6491-67ab-144c-eb485cc1fdcc@metafoo.de>
 <6767a340-b150-c21a-b6cb-5ca1ce2cd721@xilinx.com>
 <1027ba77-6141-5d6e-e5e8-b15df29957f2@metafoo.de>
Message-ID: <1cb2a735-59cd-3d8c-b55e-bd775ded3fc0@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.3.2017 22:20, Lars-Peter Clausen wrote:
> On 03/16/2017 07:06 PM, Michal Simek wrote:
>> On 16.3.2017 17:51, Lars-Peter Clausen wrote:
>>> On 03/16/2017 05:45 PM, Michal Simek wrote:
>>>> On 16.3.2017 17:39, Moritz Fischer wrote:
>>>>> On Thu, Mar 16, 2017 at 9:16 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 8.3.2017 21:11, Moritz Fischer wrote:
>>>>>>> Fix
>>>>>>>
>>>>>>> OF: /iio_hwmon: could not get #io-channel-cells for
>>>>>>> /amba/adc at f8007100
>>>>>>> OF: /iio_hwmon: could not get #io-channel-cells for
>>>>>>> /amba/adc at f8007100
>>>>>>> OF: /iio_hwmon: could not get #io-channel-cells for
>>>>>>> /amba/adc at f8007100
>>>>>>>
>>>>>>> by adding the #io-channel-cells property.
>>>>>>>
>>>>>>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>>>>>>> Cc: Michal Simek <michal.simek@xilinx.com>
>>>>>>> Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
>>>>>>> Cc: Julia Cartwright <julia@ni.com>
>>>>>>> Cc: linux-kernel at vger.kernel.org
>>>>>>> Cc: devicetree at vger.kernel.org
>>>>>>> ---
>>>>>>>
>>>>>>> Changes from v1:
>>>>>>> - fix messed up commit message
>>>>>>> ---
>>>>>>>  arch/arm/boot/dts/zynq-7000.dtsi | 1 +
>>>>>>>  1 file changed, 1 insertion(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>>>>>>> index f3ac9bf..98233a8 100644
>>>>>>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>>>>>>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>>>>>>> @@ -72,6 +72,7 @@
>>>>>>>                       interrupts = <0 7 4>;
>>>>>>>                       interrupt-parent = <&intc>;
>>>>>>>                       clocks = <&clkc 12>;
>>>>>>> +                     #io-channel-cells = <1>;
>>>>>>>               };
>>>>>>>
>>>>>>>               can0: can at e0008000 {
>>>>>>>
>>>>>>
>>>>>> I think it will be good to the next step too.
>>>>>> It means also add iio-hwmon node too.
>>>>>>
>>>>>> What do you think?
>>>>>
>>>>> I hadn't put it in there since dts is supposed to describe hw,
>>>>> but obviously putting the actual hwmon in there makes it more useful.
>>>>
>>>> I had one discussion about this with Grant in past and it is common
>>>> mistake. It is simplification of purpose of dts.
>>>>
>>>
>>> If the iio-hwmon binding had gone through review it would have been rejected.
>>
>> Isn't it a time to deprecate it?
> 
> Well, it's ABI now and has to stay forever. Deprecating it makes only sense
> if there is a replacement, which there is not. The iio-hwmon bridge has its
> usecases it's just instantiating it via devicetree which is not so nice.
> 
>>
>>>
>>>>>
>>>>> I can resubmit with the hwmon node in there.
>>>>
>>>> If you grep kernel tree you will see that others are using it too.
>>>> Also there is accepted binding for that that's why I can't see big
>>>> problem with it.
>>>
>>> Since this is an application specific binding I wouldn't put it in the
>>> generic DT include file. It's a bit like adding a gpio-key binding for each
>>> of the GPIOs just in case somebody wants to use it.
>>
>> psci is system specific too.
>>
>> IIRC this driver for zynq was written by ADI or with ADI help that's why
>> you know much better than I what's the correct configuration.
>>
>> This targets PS IP which should be present in the hw all the time.
>> Not sure if for all configuration but I expect at least the part of it
>> is there all them time.
>>
>> If binding is incorrect then please remove it with removing from all
>> dts/dtsi files which have this. The same is for of probe function in the
>> driver itself.
>> If this is not done then this is just +1 case.
>>
>> If you still insist that we shouldn't do it then please at least extend
>> commit message and put there example how to wire it on zynq.
> 
> There is a IIO driver for the XADC, this driver has a userspace interface
> that exposes the measurements provided by the hardware. Using the hwmon
> bridge will expose the same information just through a hwmon interface.
> 
> One reason for using the iio-hwmon bridge is because you have a legacy
> application that expects the a hwmon interface. But new applications that
> want to access the XADC should really use the IIO interface if possible.
> 
> In my opinion instantiating the hwmon bridge by default will only cause
> confusion. There are now redundant interfaces and users will wonder what is
> the difference between the two. Is it the same data, is it different data?
> Which is the preferred interface? Which one is 'better'?

IMHO this should be covered by documentation. One paragraph in iio-hwmon
binding can have answers for this and it will be very clear what people
should use.

Thanks,
Michal
