From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 7 Nov 2018 10:11:38 +0100
Subject: [PATCH v3 17/25] dt-bindings: panel: Add Bananapi S070WV20-CT16
 ICN6211 MIPI-DSI to RGB bridge
In-Reply-To: <CAMty3ZAWkX8YSRzFs_GS2O4+=pf68e4EuSMym+_XpCe3_4-2yw@mail.gmail.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <CGME20181029111305epcas5p2ee0ca644470de4e036762e000afbb71b@epcas5p2.samsung.com>
 <20181026144344.27778-18-jagan@amarulasolutions.com>
 <3c4c8a08-8c1e-1ac6-2b53-81389d69c97b@samsung.com>
 <CAGb2v66ENhmNXPz4PfdRJjNUNdpDNZYX2a3SH8AD6SMe9g2zLA@mail.gmail.com>
 <bfe28e8d-3786-d35d-a589-abed9ee8e7d5@samsung.com>
 <CAMty3ZAWkX8YSRzFs_GS2O4+=pf68e4EuSMym+_XpCe3_4-2yw@mail.gmail.com>
Message-ID: <25c24350-4acd-68b8-ef5d-75a60094f0b6@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.11.2018 19:08, Jagan Teki wrote:
> On Wed, Oct 31, 2018 at 2:45 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>> On 31.10.2018 09:58, Chen-Yu Tsai wrote:
>>> On Wed, Oct 31, 2018 at 4:53 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>> On 26.10.2018 16:43, Jagan Teki wrote:
>>>>> Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB
>>>>> bridge panel, which is available on same PCB with 24-bit RGB interface.
>>>>>
>>>>> So, this patch adds DSI specific binding details on existing
>>>>> dt-bindings file.
>>>>>
>>>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>>>> ---
>>>>> Changes for v3:
>>>>> - Use existing binding doc and update dsi details
>>>>> Changes for v2:
>>>>> - none
>>>>>
>>>>>  .../display/panel/bananapi,s070wv20-ct16.txt  | 31 +++++++++++++++++--
>>>>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>>>> index 35bc0c839f49..b7855dc7c66f 100644
>>>>> --- a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>>>> +++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>>>> @@ -1,12 +1,39 @@
>>>>>  Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
>>>>>
>>>>> +S070WV20-CT16 is 7" 800x480 panel connected through a 24-bit RGB interface.
>>>>> +
>>>>> +Depending on the variant, the PCB attached to the panel module either
>>>>> +supports DSI, or DSI + 24-bit RGB. DSI is converted to 24-bit RGB via
>>>>> +an onboard ICN6211 MIPI DSI - RGB bridge chip, then fed to the panel
>>>>> +itself
>>>> As I understand this is display board, which contains 'pure' RGB panel
>>>> S070WV20-CT16 and optionally ICN6211 DSI->RGB bridge.
>>>> These are separate devices, just connected by vendor to simplify its
>>>> assembly. Why don't you create then bridge driver for ICN6211 and RGB
>>>> panel driver for S070WV20-CT16 - it looks more generic.
>>>> Then you can describe both in dts and voila.
>>>> Creating drivers for every combo of devices (panel + bridge), just
>>>> because some vendor sells them together seems incorrect - we have
>>>> devicetree for it.
>>> Rob suggested this, and also the opposite: using the same
>>> "bananapi,s070wv20-ct16"
>>> compatible string for both types of connections, and have the driver deal with
>>> detecting the bus type.
>>>
>>> The thing about the bridge chip is that there's no available datasheet that
>>> describes all the parts of the init sequence, in fact none at all. I managed
>>> to work out some bits, but the others remain a mystery and must be hard-coded
>>> to match the panel. That would work against having a generic bridge driver.
>>
>> But it is common for many chips - 1st version of the driver is developed
>> on one platform and it supports only one configuration, if next platform
>> with the same cheap appears the driver is augmented if necessary.
> At-least few of the commands from panel initialization code, the
> respective opcode data values are based on panel timings and even
> clock value is different in DSI. I think it look hard to try bridge
> driver for these restrictions, do you have any suggestions?


Where do you see an issue? Since panel is RGB it should have no
initialization sequence (beside regulator/gpio power on/off), so the
only thing to do is to figure out which regulators/gpios belongs to
which component - with publicly available specs it should be doable.

The whole initialization sequence is for the bridge, so you put it into
bridge driver, for starters it can be hardcoded.

Then you can:

1. Try to find other users of this ICN6211 chip and compare
initialization sequences to guess purpose of registers.

2. Try to get specs of the chip (ask vendor, distributor, grep Internet).

3. Do nothing - if there will be other users of the bridge they will do
this work.


Regards

Andrzej
