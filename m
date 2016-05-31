From: dianders@chromium.org (Doug Anderson)
Date: Tue, 31 May 2016 12:57:17 -0700
Subject: [PATCH 2/6] Documentation: bindings: add dt doc for Rockchip USB
 Type-C PHY
In-Reply-To: <5748094F.6030204@rock-chips.com>
References: <1464328939-8073-1-git-send-email-zyw@rock-chips.com>
 <1464328939-8073-3-git-send-email-zyw@rock-chips.com>
 <2812026.ptEv4ktvbn@phil> <5748094F.6030204@rock-chips.com>
Message-ID: <CAD=FV=W9iFXX_BfORP-9=8tnu9Ea_f2k1wK_T2j=ZAVA9cFSwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On Fri, May 27, 2016 at 1:46 AM, Chris Zhong <zyw@rock-chips.com> wrote:
> Hi Heiko
>
>
> On 05/27/2016 04:29 PM, Heiko Stuebner wrote:
>>
>> Hi Chris,
>>
>> Am Freitag, 27. Mai 2016, 14:02:15 schrieb Chris Zhong:
>>>
>>> This patch adds a binding that describes the Rockchip USB Type-C PHY
>>> for rk3399.
>>>
>>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>>> ---
>>>
>>>   .../devicetree/bindings/phy/phy-rockchip-typec.txt | 55
>>> ++++++++++++++++++++++ 1 file changed, 55 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>>> b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt new file
>>> mode 100644
>>> index 0000000..402f667
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>>> @@ -0,0 +1,55 @@
>>> +ROCKCHIP type-c PHY
>>> +
>>> +Required properties:
>>> + - compatible: should be "rockchip,rk3399-typec-phy"
>>> + - reg : Address and length of the usb phy control register set
>>> + - rockchip,grf : phandle to the syscon managing the "general
>>> +   register files"
>>> + - clocks : phandle + clock specifier for the phy clocks
>>> + - clock-names: string, clock name, must be "tcpdcore", "tcpdphy_ref";
>>> + - resets : a list of phandle + reset specifier pairs
>>> + - reset-names : string reset name, must be:
>>> +                "tcphy_rst", "tcphy_pipe_rst", "uphy_tcphy_rst"

In other contexts I believe Heiko has requested that a suffix like
"_rst" not be present in the names of reset signals.  We already know
that this is a list of reset names so the "_rst" is redundant.

>>> + - #phy-cells: Must be 0.  See ./phy-bindings.txt for details.
>>> + - rockchip,usb3phy*: phy registers embed in grf
>>> +
>>> +Example:
>>> +       tcphy0: phy at ff7c0000 {
>>> +               compatible = "rockchip,rk3399-typec-phy";
>>> +               reg = <0x0 0xff7c0000 0x0 0x40000>;
>>> +               #phy-cells = <0>;
>>> +               rockchip,grf = <&grf>;
>>> +               clocks = <&cru SCLK_UPHY0_TCPDCORE>,
>>> +                        <&cru SCLK_UPHY0_TCPDPHY_REF>;
>>> +               clock-names = "tcpdcore", "tcpdphy_ref";
>>> +               resets = <&cru SRST_UPHY0>,
>>> +                        <&cru SRST_UPHY0_PIPE_L00>,
>>> +                        <&cru SRST_P_UPHY0_TCPHY>;
>>> +               reset-names = "tcphy_rst", "tcphy_pipe_rst",
>>> "uphy_tcphy_rst";
>>> +               rockchip,usb3phy_con0 = <0x0e580 0 16>;
>>> +               rockchip,usb3phy_con1 = <0x0e584 0 16>;
>>> +               rockchip,usb3phy_con2 = <0x0e588 0 16>;
>>> +               rockchip,usb3phy_status0 = <0x0e5c0 0 13>;
>>> +               rockchip,usb3phy_status1 = <0x0e5c4 0 12>;
>>
>> please embedded this register data in the driver instead (not in the
>> devicetree), matched against the compatible value.
>> See Frank's usb2phy driver for reference if needed.
>
> Okay, I will move them to driver file next version, Thanks.

Just making sure: I saw a RESEND of your original version get posted,
but nothing that addresses Heiko's comments, right?

Also: note that bindings should be sent in the patch _before_ the
code.  So instead of:
  [1] phy: Add USB Type-C PHY driver for rk3399
  [2] Documentation: bindings: add dt doc for Rockchip USB Type-C PHY
  [3] drm/rockchip: vop: add cdn DP support for rk3399
  [4] Documentation: bindings: add dt documentation for cdn DP controller

You should have:
  [1] Documentation: bindings: add dt doc for Rockchip USB Type-C PHY
  [2] phy: Add USB Type-C PHY driver for rk3399
  [3] Documentation: bindings: add dt documentation for cdn DP controller
  [4] drm/rockchip: vop: add cdn DP support for rk3399


-Doug
