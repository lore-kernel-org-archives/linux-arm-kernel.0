From: gabriel.fernandez@st.com (Gabriel Fernandez)
Date: Thu, 25 Aug 2016 16:51:59 +0200
Subject: [RESEND PATCH v2 02/13] drivers: clk: st: Simplify clock binding
 of STiH4xx platforms
In-Reply-To: <147208387070.66208.10807364446051184867@resonance>
References: <1466068833-5055-1-git-send-email-gabriel.fernandez@linaro.org>
 <1466068833-5055-3-git-send-email-gabriel.fernandez@linaro.org>
 <20160619150458.GA26824@rob-hp-laptop>
 <146794221378.73491.2803164814485320331@resonance> <577F6E83.3080006@st.com>
 <146799410307.73491.9408637761157902031@resonance> <578343A2.6090801@st.com>
 <7b3f45bf-2fba-7563-f2a2-c74e759f6316@st.com>
 <147208387070.66208.10807364446051184867@resonance>
Message-ID: <52c1f647-7719-715c-270e-0779038b856b@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 08/25/2016 02:11 AM, Michael Turquette wrote:
> Quoting Gabriel Fernandez (2016-08-22 09:06:20)
>> Hi Mike,
>>
>> you forgot me ?
>>
>> Best Regards
>>
>> Gabriel
>>
>>
>> On 07/11/2016 08:58 AM, Gabriel Fernandez wrote:
>>>
>>> On 07/08/2016 06:08 PM, Michael Turquette wrote:
>>>> Quoting Gabriel Fernandez (2016-07-08 02:12:35)
>>>>> Hi Mike,
>>>>>
>>>>> On 07/08/2016 03:43 AM, Michael Turquette wrote:
>>>>>> Quoting Rob Herring (2016-06-19 08:04:58)
>>>>>>> On Thu, Jun 16, 2016 at 11:20:22AM +0200, Gabriel Fernandez wrote:
>>>>>>>> This patch reworks the clock binding to avoid too much detail in DT.
>>>>>>>> Now we have only compatible string per type of clock
>>>>>>>> (remark from Rob https://lkml.org/lkml/2016/5/25/492)
>>>>>>>>
>>>>>>> I have no idea what the clock trees and clock controller in these
>>>>>>> chips
>>>>>>> look like, so it's hard to say if the changes here are good. It still
>>>>>>> looks like things are somewhat fine grained clocks in DT. I'll leave
>>>>>>> it up to the platform maintainers to decide...
>>>>>> Is this series breaking ABI? If yes, why not do what Maxime did for
>>>>>> the
>>>>>> Allwinner/sunxi clocks and just fully convert over to a
>>>>>> one-node-per-clock-controller binding? This one-node-per-clock
>>>>>> stuff is
>>>>>> pretty unfortunate, and if we're deprecating platforms (patch #1) then
>>>>>> now might be a good time to re-evaluate the whole thing.
>>>>> The goal of my patchset was to be aligned with DRM / KMS development
>>>>> and
>>>>> to offer
>>>>> the possibility to make a correct video playback on STiH407/STiH410
>>>>> platform.
>>>>> Our milestone is the 4.8 for that.
>>>>>
>>>>> Currently people need these patches to work.
>>>>> I'm not sure it's a good time to re-evaluate the whole thing.
>>>>>
>>>>> Is it possible to re-evaluate later ?
>>>> Are you OK to break ABI later? Or at a minimum, deprecate the current
>>>> binding (maintain it forever for legacy platforms) and create a new
>>>> clock controller binding description that supersedes the legacy binding
>>>> for all new platforms?
>>>>
>>>> If the answer to either question is "yes", then I'm OK to put it aside
>>>> for now. But if the answer to both is "no", and this patch series is
>>>> breaking ABI, then we really should fix it now.
>>> Hi Mike,
>>> i m ok to break ABI later.
> Hi Gabriel,
>
> This change never received any other reviews, and no pings before v4.7
> was released. Sorry that it fell through the cracks, but always feel
> free to re-ping leading up to the merge window.
>
> Can you rebase this against -rc1? Also, do you have a plan to rework the
> binding to move away from the one-node-per-clock style?
>
> Regards,
> Mike

Hi  Mike,

Ok i will send a v3 rebased on a rc1.

Concerning the binding rework, i plan to start work at the end of October.

Thanks

Gabriel

>>> Many Thanks !
>>>
>>> Best Regards
>>>
>>> Gabriel.
>>>
>>>> Regards,
>>>> Mike
>>>>
>>>>> Best regards,
>>>>> Gabriel
>>>>>
>>>>>> Regards,
>>>>>> Mike
>>>>>>
>>>>>>>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
>>>>>>>> ---
>>>>>>>>     .../devicetree/bindings/clock/st/st,clkgen-mux.txt | 2 +-
>>>>>>>>     .../devicetree/bindings/clock/st/st,clkgen-pll.txt | 11 ++--
>>>>>>>>     .../devicetree/bindings/clock/st/st,clkgen.txt     | 2 +-
>>>>>>>>     .../devicetree/bindings/clock/st/st,quadfs.txt     | 6 +--
>>>>>>>>     drivers/clk/st/clkgen-fsyn.c                       | 41
>>>>>>>> ++++++--------
>>>>>>>>     drivers/clk/st/clkgen-mux.c                        | 28
>>>>>>>> ++++------
>>>>>>>>     drivers/clk/st/clkgen-pll.c                        | 62
>>>>>>>> ++++++++++------------
>>>>>>>>     7 files changed, 65 insertions(+), 87 deletions(-)
>>>>>>>>
>>>>>>>> diff --git
>>>>>>>> a/Documentation/devicetree/bindings/clock/st/st,clkgen-mux.txt
>>>>>>>> b/Documentation/devicetree/bindings/clock/st/st,clkgen-mux.txt
>>>>>>>> index 4d277d6..9a46cb1d7 100644
>>>>>>>> --- a/Documentation/devicetree/bindings/clock/st/st,clkgen-mux.txt
>>>>>>>> +++ b/Documentation/devicetree/bindings/clock/st/st,clkgen-mux.txt
>>>>>>>> @@ -10,7 +10,7 @@ This binding uses the common clock binding[1].
>>>>>>>>     Required properties:
>>>>>>>>        - compatible : shall be:
>>>>>>>> -     "st,stih407-clkgen-a9-mux",     "st,clkgen-mux"
>>>>>>>> +     "st,stih407-clkgen-a9-mux"
>>>>>>>>        - #clock-cells : from common clock binding; shall be set to 0.
>>>>>>>>     diff --git
>>>>>>>> a/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
>>>>>>>> b/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
>>>>>>>> index c9fd674..be0b043 100644
>>>>>>>> --- a/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
>>>>>>>> +++ b/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
>>>>>>>> @@ -9,11 +9,10 @@ Base address is located to the parent node. See
>>>>>>>> clock binding[2]
>>>>>>>>     Required properties:
>>>>>>>>        - compatible : shall be:
>>>>>>>> -     "st,stih407-plls-c32-a0", "st,clkgen-plls-c32"
>>>>>>>> -     "st,stih407-plls-c32-a9", "st,clkgen-plls-c32"
>>>>>>>> -     "sst,plls-c32-cx_0", "st,clkgen-plls-c32"
>>>>>>>> -     "sst,plls-c32-cx_1", "st,clkgen-plls-c32"
>>>>>>>> -     "st,stih418-plls-c28-a9", "st,clkgen-plls-c32"
>>>>>>>> +     "st,clkgen-pll0"
>>>>>>>> +     "st,clkgen-pll0"
>>>>>>> Repeated. Supposed to be 0 and 1? This seems a bit generic, too.
>>>>>>>
>>>>>>>> +     "st,stih407-clkgen-plla9"
>>>>>>>> +     "st,stih418-clkgen-plla9"
