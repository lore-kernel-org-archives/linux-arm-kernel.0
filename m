From: megous@megous.com (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Wed, 29 Jun 2016 23:11:11 +0200
Subject: [PATCH 06/14] ARM: dts: sun8i: Add cpu0 label to sun8i-h3.dtsi
In-Reply-To: <20160629204553.GJ6095@lukather>
References: <20160623192104.18720-1-megous@megous.com>
 <20160623192104.18720-7-megous@megous.com>
 <CAGb2v66eskVAxdz8VtjBJBCO7VV9WL4bdFDVrPWrSmxk4RASCw@mail.gmail.com>
 <adaf7f61-af80-cc02-8c47-af721b86f81e@megous.com>
 <CAGb2v665O75vQEfo5WdWtWJSbKEbLi6MBAHbgZC7pyrOCOu+6g@mail.gmail.com>
 <20160625070208.GA4000@lukather>
 <380ebf34-fd4a-ea2d-f9cf-68b8ede44757@megous.com>
 <20160629204553.GJ6095@lukather>
Message-ID: <a3cf3531-93a5-de35-b7f4-03d28cfebb3d@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.6.2016 22:45, Maxime Ripard wrote:
> Hi,
> 
> On Sat, Jun 25, 2016 at 04:50:24PM +0200, Ond?ej Jirman wrote:
>> On 25.6.2016 09:02, Maxime Ripard wrote:
>>> On Sat, Jun 25, 2016 at 09:02:48AM +0800, Chen-Yu Tsai wrote:
>>>> On Sat, Jun 25, 2016 at 6:51 AM, Ond?ej Jirman <megous@megous.com> wrote:
>>>>> Hello,
>>>>>
>>>>> comments below.
>>>>>
>>>>> On 24.6.2016 05:48, Chen-Yu Tsai wrote:
>>>>>> On Fri, Jun 24, 2016 at 3:20 AM,  <megous@megous.com> wrote:
>>>>>>> From: Ondrej Jirman <megous@megous.com>
>>>>>>>
>>>>>>> Add label to the first cpu so that it can be referenced
>>>>>>> from derived dts files.
>>>>>>>
>>>>>>> Signed-off-by: Ondrej Jirman <megous@megous.com>
>>>>>>> ---
>>>>>>>  arch/arm/boot/dts/sun8i-h3.dtsi | 2 +-
>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
>>>>>>> index 9938972..82faefc 100644
>>>>>>> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
>>>>>>> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>>>>>>> @@ -52,7 +52,7 @@
>>>>>>>                 #address-cells = <1>;
>>>>>>>                 #size-cells = <0>;
>>>>>>>
>>>>>>> -               cpu at 0 {
>>>>>>> +               cpu0: cpu at 0 {
>>>>>>>                         compatible = "arm,cortex-a7";
>>>>>>>                         device_type = "cpu";
>>>>>>>                         reg = <0>;
>>>>>>
>>>>>> Can you also set the cpu clock here? It is part of the SoC
>>>>>> and does not belong in the board DTS files.
>>>>>
>>>>> Do you mean operating-points, or something else? Different SBCs will
>>>>> probably require different combinations of operating points just for
>>>>> safety's sake, because they have different regulators and [some have
>>>>> botched] thermal designs, so it might make sense to customize it for
>>>>> differnt boards, and I don't feel adventurous enough setting it for all
>>>>> H3 boards out there.
>>>>
>>>> I meant clocks = <...> and clock-latency = <...>.
>>>>
>>>> These 2 are part of the SoC.
>>>>
>>>> The OPP can stay in the board files. It's a pity there's no standard
>>>> OPP table for H3 though. :(
>>>
>>> This has never been the case, and we always had some deviation in the
>>> FEX files for all the SoCs.
>>>
>>> If we could come up with standard OPPs that work for every one,
>>> there's no reason it can't happen here.
>>>
>>> I don't really see why the thermal design should change anything. If a
>>> boards heats faster, it will throttle down to a lower OPP faster, but
>>> those OPPs are not going to change.
>>
>> I've no way to test, but I've been told some Sinovoip boards are really
>> bad in this regard (SoC is not even well thermally connected to the
>> PCB/PCB not having copper layer to spread the heat). Thermal sensor
>> readings happen at fixed intervals, so the question is if you can heat
>> up the soc from say 80?C (first trip point) to over 110?C in less than
>> that period (330ms currently).
>>
>> I say it shouldn't be a problem, if that small thing is drawing say 2W
>> at max load. It will burn or trigger a second trip point before the
>> first one has a chance to trigger and the kernel will shut down. I
>> remember tkaiser saying that he has to run that board at 240MHz max. But
>> perhaps I'm misremembering.
>>
>> I'm just speculating.
> 
> Yes, but that's just poor thermal design. What I was saying is that
> even if we really need to throttle the SoC to 240 MHz on that board
> because it heats too much, the couple of the frequency and the voltage
> will likely be the same across all boards. It's just the amount of
> time we'll spend using it that will differ.
> 
> But that's just my understanding, I might be speaking non-sense :)
> 
> Maxime
> 

You're probably right. Operating points should be part of h3.dtsi, and
if some board is particularly bad, and can't handle being above certain
frequency safely, due to thermal design issues, we can override
operating points in its dts file.

regards,
  Ondrej

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160629/efad3e48/attachment.sig>
