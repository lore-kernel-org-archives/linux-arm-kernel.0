From: mbrugger@suse.com (Matthias Brugger)
Date: Wed, 21 Nov 2018 18:09:52 +0100
Subject: [PATCH v5 08/12] dt-bindings: mediatek: Change the binding for
 mmsys clocks
In-Reply-To: <154281878765.88331.10581984256202566195@swboyd.mtv.corp.google.com>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-9-matthias.bgg@kernel.org>
 <20181116231522.GA18006@bogus>
 <2a23e407-4cd4-2e2b-97a5-4e2bb96846e0@gmail.com>
 <CAL_JsqKJQwfDJbpmwW+oCxiDkSp5+6mG-uoURmCQVEMP_jFOEg@mail.gmail.com>
 <154281878765.88331.10581984256202566195@swboyd.mtv.corp.google.com>
Message-ID: <458178ac-c0fc-9671-7fc8-ed2d6f61424c@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/11/2018 17:46, Stephen Boyd wrote:
> Quoting Rob Herring (2018-11-19 11:15:16)
>> On Sun, Nov 18, 2018 at 11:12 AM Matthias Brugger
>> <matthias.bgg@gmail.com> wrote:
>>> On 11/17/18 12:15 AM, Rob Herring wrote:
>>>> On Fri, Nov 16, 2018 at 01:54:45PM +0100, matthias.bgg at kernel.org wrote:
>>>>> -    #clock-cells = <1>;
>>>>> +
>>>>> +    mmsys_clk: clock-controller at 14000000 {
>>>>> +            compatible = "mediatek,mt2712-mmsys-clk";
>>>>> +            #clock-cells = <1>;
>>>>
>>>> This goes against the general direction of not defining separate nodes
>>>> for providers with no resources.
>>>>
>>>> Why do you need this and what does it buy if you have to continue to
>>>> support the existing chips?
>>>>
>>>
>>> It would show explicitly that the mmsys block is used to probe two
>>> drivers, one for the gpu and one for the clocks. Otherwise that is
>>> hidden in the drm driver code. I think it is cleaner to describe that in
>>> the device tree.
>>
>> No, that's maybe cleaner for the driver implementation in the Linux
>> kernel. What about other OS's or when Linux drivers and subsystems
>> needs change? Cleaner for DT is design bindings that reflect the h/w.
>> Hardware is sometimes just messy.
>>
> 
> I agree. I fail to see what this patch series is doing besides changing
> driver probe and device creation methods and making a backwards
> incompatible change to DT. Is there any other benefit here?
> 

You are referring whole series?
Citing the cover letter:
"MMSYS in Mediatek SoCs has some registers to control clock gates (which is
used in the clk driver) and some registers to set the routing and enable
the differnet (sic!) blocks of the display subsystem.

Up to now both drivers, clock and drm are probed with the same device tree
compatible. But only the first driver get probed, which in effect breaks
graphics on mt8173 and mt2701.

This patch uses a platform device registration in the DRM driver, which
will trigger the probe of the corresponding clock driver. It was tested on the
bananapi-r2 and the Acer R13 Chromebook."

DT is broken right now, because two drivers rely on the same node, which gets
consumed just once. The new DT introduced does not break anything because it is
only used for boards that: "[..] are not available to the general public
(mt2712e) or only have the mmsys clock driver part implemented (mt6797)."

Anyway, I'll send a new version which uses the platform device in the DRM driver
for all SoCs.

Regards,
Matthias
