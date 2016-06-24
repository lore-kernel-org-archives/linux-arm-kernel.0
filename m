From: zyw@rock-chips.com (Chris Zhong)
Date: Fri, 24 Jun 2016 10:48:23 +0800
Subject: [v3 PATCH 3/5] phy: Add USB Type-C PHY driver for rk3399
In-Reply-To: <CABXOdTdH-jNVx1b3R+=Z712Zcs8c6q3Hq1iwt_i7foe3K3SAVw@mail.gmail.com>
References: <1466686264-6744-1-git-send-email-zyw@rock-chips.com>
 <1466686264-6744-4-git-send-email-zyw@rock-chips.com>
 <CABXOdTcZ2O7tK8yNSJH_Unap8RweUa_iW8aT3Hb_NWCZRoyAzQ@mail.gmail.com>
 <576C800D.2050006@rock-chips.com>
 <CABXOdTdH-jNVx1b3R+=Z712Zcs8c6q3Hq1iwt_i7foe3K3SAVw@mail.gmail.com>
Message-ID: <576C9F77.6000702@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter

On 06/24/2016 10:10 AM, Guenter Roeck wrote:
> Hi Chris,
>
> On Thu, Jun 23, 2016 at 5:34 PM, Chris Zhong <zyw@rock-chips.com> wrote:
>> Hi Guenter
>>
>>
>> On 06/24/2016 05:47 AM, Guenter Roeck wrote:
>>> Hi Chris,
>>>
>>> On Thu, Jun 23, 2016 at 5:51 AM, Chris Zhong <zyw@rock-chips.com> wrote:
>>>> Add a PHY provider driver for the rk3399 SoC Type-c PHY. The USB
>>>> Type-C PHY is designed to support the USB3 and DP applications. The
>>>> PHY basically has two main components: USB3 and DisplyPort. USB3
>>>> operates in SuperSpeed mode and the DP can operate at RBR, HBR and
>>>> HBR2 data rates.
>>>>
>>>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>>>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>>>>
>>> [ ... ]
>>>
>>>> +
>>>> +static void tcphy_get_state(struct rockchip_typec_phy *tcphy,
>>>> +                           struct extcon_dev *edev)
>>>> +{
>>>> +       int mode;
>>>> +       bool plugged, flip, pin_assign, dfp, ufp, dp;
>>>> +
>>>> +       ufp = extcon_get_cable_state_(edev, EXTCON_USB);
>>>> +       dfp = extcon_get_cable_state_(edev, EXTCON_USB_HOST);
>>>> +       dp = extcon_get_cable_state_(edev, EXTCON_DISP_DP);
>>>> +       flip = extcon_get_cable_state_(edev, EXTCON_TYPEC_POLARITY);
>>>> +       pin_assign = extcon_get_cable_state_(edev,
>>>> EXTCON_TYPEC_PIN_ASSIGN);
>>>> +
>>>> +       plugged = ufp | dfp | dp;
>>>> +       tcphy->flip = flip;
>>>> +
>>>> +       if (plugged) {
>>>> +               if (ufp) {
>>>> +                       mode = MODE_UFP_USB;
>>>> +               } else if (dfp && !dp) {
>>>> +                       mode = MODE_DFP_USB;
>>>> +               } else if (dfp && dp) {
>>>> +                       mode = MODE_DFP_USB | MODE_DFP_DP;
>>>> +                       tcphy->pin_assign = pin_assign ? PIN_MAP_D :
>>>> PIN_MAP_B;
>>>> +               } else {
>>>> +                       mode = MODE_DFP_DP;
>>>> +                       tcphy->pin_assign = pin_assign ? PIN_MAP_C :
>>>> PIN_MAP_A;
>>> I am having trouble extracting pin_assign from our code. What
>>> determines if map A or C should be selected ?
>>>
>>> Thanks,
>>> Guenter
>> Oh, forgot rename the macro:
>>
>> PIN_MAP_ should be PIN_ASSIGN_
>>
>>
>>   IF EXTCON_TYPEC_PIN_ASSIGN is attached, Type-C get
>>   Pin_Assignment_C(for DP only mode) or Pin_Assignment_D(for DP alt mode),
>>    if detached, it get the default Assignment: A(for DP only mode) or B(for
>> DP alt mode),.
>>
> So we are really talking about DP only vs. DP Alt mode ? If so, do we
> even need PIN_ASSIGN ? Why not just use EXTCON_DISP_DP_ALT directly ?
>
> Also, I'll have to get a better understanding what "DP only mode" and
> "DP Alt mode" actually means. DisplayPort is already a Type-C
> alternate mode, so the terminology is a bit confusing. Do you happen
> to have a description somewhere, by any chance ?
>
> Thanks,
> Guenter
The Pin Assignments is come from:
VESA DisplayPort Alt Mode on USB Type-C Standard

There are 2 mode for DP: DP only mode, and DP+USB3 mode(EXTCON_DISP_DP_ALT )
At DP only mode, DP has 4 lanes of Type-C;
At DP+USB3 mode, DP has 2 lanes, and USB3 has the other 2 lanes.

For DP only mode, there are 3 kind of pin assignments: A, C, E.
For DP + USB3 mode, there are 3 kind of pin assignments: B, D, F.

Pin Assignments C and D use the same assignments as Pin Assignments E and F.
Thence, we just need to distinguish A and C for DP only mode.
and distinguish B and D for DP + USB3 mode.
That why the phy need a PIN_ASSIGN cable.


The name of "DP Alt mode", it is DP+USB3 mode, actually.
I think if the name makes anyone confused, it can be changed to DP_USB3 mode:
The cable list could be:
EXTCON_DISP_DP
EXTCON_DISP_DP_USB3


>
>> I am going to add a comment for describe which PIN_ASSIGN_ should be
>> selected
>> in next version, if no one disagrees the usage of cable
>>
>>
>>>
>>
>
>
