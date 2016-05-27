From: loic.pallardy@st.com (loic pallardy)
Date: Fri, 27 May 2016 09:23:20 +0200
Subject: [STLinux Kernel] [PATCH 02/11] drivers: clk: st: Add clock
 propagation for audio clocks
In-Reply-To: <CAL_JsqLeD8uTmMYLFZ5Sh9=JV5s1xthvruXL-W=c=zcVS=G-ZA@mail.gmail.com>
References: <1463560892-7209-1-git-send-email-gabriel.fernandez@linaro.org>
 <1463560892-7209-3-git-send-email-gabriel.fernandez@linaro.org>
 <20160525172409.GA27913@rob-hp-laptop>
 <CAG374jDTCJfZB+PuAnggjXhbcd3NjJqrESpe_EnMniCAeoph9A@mail.gmail.com>
 <CAL_JsqLOG4P0H+HkQ3mJhfibatuV2T51KqOn-+U+LK8WUx7QgA@mail.gmail.com>
 <5746F486.602@st.com>
 <CAL_JsqLeD8uTmMYLFZ5Sh9=JV5s1xthvruXL-W=c=zcVS=G-ZA@mail.gmail.com>
Message-ID: <5747F5E8.5030300@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/26/2016 03:20 PM, Rob Herring wrote:
> On Thu, May 26, 2016 at 8:05 AM, loic pallardy <loic.pallardy@st.com> wrote:
>>
>>
>> On 05/26/2016 02:46 PM, Rob Herring wrote:
>>>
>>> On Thu, May 26, 2016 at 4:49 AM, Gabriel Fernandez
>>> <gabriel.fernandez@linaro.org> wrote:
>>>>
>>>> On 25 May 2016 at 19:24, Rob Herring <robh@kernel.org> wrote:
>>>>>
>>>>>
>>>>> On Wed, May 18, 2016 at 10:41:23AM +0200, Gabriel Fernandez wrote:
>>>>>>
>>>>>> This patch allows fine tuning of the quads FS for audio clocks
>>>>>> accuracy.
>>>>>>
>>>>>> Signed-off-by: Olivier Bideau <olivier.bideau@st.com>
>>>>>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
>>>>>> ---
>>>>>>    .../devicetree/bindings/clock/st/st,flexgen.txt    |  1 +
>>>>>>    drivers/clk/st/clk-flexgen.c                       | 24
>>>>>> ++++++++++++++++++++++
>>>>>>    2 files changed, 25 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
>>>>>> b/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
>>>>>> index b7ee5c7..15b33c7 100644
>>>>>> --- a/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
>>>>>> +++ b/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
>>>>>> @@ -60,6 +60,7 @@ This binding uses the common clock binding[2].
>>>>>>    Required properties:
>>>>>>    - compatible : shall be:
>>>>>>      "st,flexgen"
>>>>>> +  "st,stih407-clkgend0", "st,flexgen" (enable clock propagation on
>>>>>> parent)
>>>>>
>>>>>
>>>>> What do "d0" and "d2" refer to?
>>>>>
>>>>> This seems to indicate you have too much clock detail in the DT (with
>>>>> individual clocks described) or not enough with genericish compatible
>>>>> strings. What happens for the mext clock you need to adjust the flags
>>>>> on? You should be able to make these adjustments without DT updates.
>>>>> Perhaps you need a wider fixing of clock compatible strings.
>>>>>
>>>>> Rob
>>>>
>>>>
>>>> Sorry i sent my response in html...
>>>>
>>>> Hi Rob,
>>>>
>>>> Thanks for reviewing.
>>>>
>>>> Can i remove
>>>> "
>>>> st,stih407-clkgend0" & "
>>>> st,stih407-clkgend2" compatible strings and add proprieties instead ?
>>>> I only need to activate 2 features and then we can keep generic
>>>> compatible strings.
>>>
>>>
>> Hi Rob,
>>>
>>> That is no different and suffers the same point I raised. It requires
>>> updating the DT for any clock configuration change or enhancement.
>>>
>> Agree with you, DT update is needed as soon as a clock configuration should
>> be changed. This is due to STiH clock driver design based on DT description
>> of SoC clock tree.
>>
>> This clock driver was accepted 2 years ago. At the time being there was
>> discussion about clock tree description location: driver or DT.
>> Bad choice was done for this driver...
>>
>> If we decide to redesign STiH clock driver using in-driver clock tree
>> description, this will modify STiH clock DT nodes description and so break
>> DT backward compatibility.
>>
>> What's from your pov the best option?
>
> You can break it once or every time you need a clock change. I'd go
> with the former. Maybe more specific compatible strings throughout
> alone would be enough rather than a flag day changing the binding.

So if I understand you correctly, main issue is d0 and d2 signification.
d0 and d2 are indeed location of the flexgen in the SoC. But that's 
right flexgen are dedicated to clocks generation for features (system, 
audio, video).
What about "st,flexgen-audio" and "st,flexgen-video"?

BR,
Loic

>
> Rob
>
