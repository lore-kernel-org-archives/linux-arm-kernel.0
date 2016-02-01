From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 1 Feb 2016 19:01:18 +0100
Subject: [PATCH v4 2/6] dt-bindings: ARM: Mediatek: Document bindings for
 MT2701
In-Reply-To: <CAL_JsqLJVLDbPqynmD9-Yc=JVGH4iLPfb2keA5G7c2fjitAsSQ@mail.gmail.com>
References: <1453271747-57397-1-git-send-email-jamesjj.liao@mediatek.com>
 <1453271747-57397-3-git-send-email-jamesjj.liao@mediatek.com>
 <20160120163236.GA21035@rob-hp-laptop> <1453353537.5384.33.camel@mtksdaap41>
 <CAL_JsqLJVLDbPqynmD9-Yc=JVGH4iLPfb2keA5G7c2fjitAsSQ@mail.gmail.com>
Message-ID: <56AF9D6E.80305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/02/16 16:55, Rob Herring wrote:
> On Wed, Jan 20, 2016 at 11:18 PM, James Liao <jamesjj.liao@mediatek.com> wrote:
>> Hi Rob,
>>
>> On Wed, 2016-01-20 at 10:32 -0600, Rob Herring wrote:
>>> On Wed, Jan 20, 2016 at 02:35:43PM +0800, James Liao wrote:
>>>> This patch adds the binding documentation for apmixedsys, bdpsys,
>>>> ethsys, hifsys, imgsys, infracfg, mmsys, pericfg, topckgen and
>>>> vdecsys for Mediatek MT2701.
>>>>
>>>> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
>>>> Tested-by: John Crispin <blogic@openwrt.org>
>>>> ---
>>>>   .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |  1 +
>>>>   .../bindings/arm/mediatek/mediatek,bdpsys.txt      | 22 ++++++++++++++++++++++
>>>>   .../bindings/arm/mediatek/mediatek,ethsys.txt      | 22 ++++++++++++++++++++++
>>>>   .../bindings/arm/mediatek/mediatek,hifsys.txt      | 22 ++++++++++++++++++++++
>>>>   .../bindings/arm/mediatek/mediatek,imgsys.txt      |  1 +
>>>>   .../bindings/arm/mediatek/mediatek,infracfg.txt    |  1 +
>>>>   .../bindings/arm/mediatek/mediatek,mmsys.txt       |  1 +
>>>>   .../bindings/arm/mediatek/mediatek,pericfg.txt     |  1 +
>>>>   .../bindings/arm/mediatek/mediatek,topckgen.txt    |  1 +
>>>>   .../bindings/arm/mediatek/mediatek,vdecsys.txt     |  1 +
>>>>   10 files changed, 73 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
>>>>   create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
>>>>   create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
>>>> index 936166f..a701e19 100644
>>>> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
>>>> @@ -6,6 +6,7 @@ The Mediatek apmixedsys controller provides the PLLs to the system.
>>>>   Required Properties:
>>>>
>>>>   - compatible: Should be:
>>>> +   - "mediatek,mt2701-apmixedsys"
>>>>      - "mediatek,mt8135-apmixedsys"
>>>>      - "mediatek,mt8173-apmixedsys"
>>>>   - #clock-cells: Must be 1
>>>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
>>>> new file mode 100644
>>>> index 0000000..4137196
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
>>>> @@ -0,0 +1,22 @@
>>>> +Mediatek bdpsys controller
>>>> +============================
>>>> +
>>>> +The Mediatek bdpsys controller provides various clocks to the system.
>>>
>>> As you clarified these blocks provide more that just clocks. Please list
>>> all the functions here and on the others.
>>
>> Some blocks may provide clock and reset controller at the same time. But
>
> Then say the block provides clocks and resets is all I'm asking for.
>
>> most of them will not provide functions directly. Instead, some DT
>> blocks which provide specific functions may refer to these controller
>> nodes due to it need to access the same register space.
>>
>> For example, scpsys (the power domain provider) refers to infracfg
>> because it need to control infracfg registers when power on/off domains:
>>
>>          scpsys: scpsys at 10006000 {
>>                  compatible = "mediatek,mt2701-scpsys";
>>                  #power-domain-cells = <1>;
>>                  reg = <0 0x10006000 0 0x1000>;
>>                  infracfg = <&infracfg>;
>>          };
>>
>> So I think it should not need to list all functions for each blocks
>> here.
>
> Sorry, but you do need to describe what functions the blocks provide.
>
> Also, if you are accessing the infracfg regs directly to modify clock
> registers outside of the clock driver, that is very bad design. The
> clock driver could assume that register values are not changing behind
> its back and it bypasses any locks around register accesses. I can see
> why it is needed though, but we really need a proper interface.
>

Some of the register blocks like infracfg is a potpourri of different 
functions. Clocks and power domains are some of them. In the drivers 
this is isolated, but there are many blocks which are not used at the 
moment and therefor are not documented in bindings description (e.g. 
debug control for the very same block, not sure if that will be 
implemented one day).

Would it be ok for you, if James just lists the blocks which already 
have an implementation and leaving apart the rest of it?

Regards,
Matthias
