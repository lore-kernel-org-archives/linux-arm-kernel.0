From: frank.wang@rock-chips.com (Frank Wang)
Date: Thu, 15 Dec 2016 14:41:17 +0800
Subject: [PATCH 3/3] arm64: dts: rockchip: add clk-480m for ehci and ohci
 of rk3399
In-Reply-To: <5ce521da-119a-2de8-026c-5992fedfef43@rock-chips.com>
References: <1481710301-1454-1-git-send-email-zhengxing@rock-chips.com>
 <1481710301-1454-4-git-send-email-zhengxing@rock-chips.com>
 <CAD=FV=UU4JdRjRgEvc_wxprvi6bo46+jd=x2m2QzOe4uJmuRPA@mail.gmail.com>
 <5ce521da-119a-2de8-026c-5992fedfef43@rock-chips.com>
Message-ID: <991221a4-3962-1bcb-7863-72f5553eba40@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brain, Doug and Heiko,

I would like to summarize why this story was constructed.

The ehci/ohci-platform suspend process are blocked due to UTMI clock 
which directly output from usb-phy has been disabled, and why the UTMI 
clock was disabled?

UTMI clock and 480m clock all output from the same internal PLL of 
usb-phy, and there is only one bit can use to control this PLL on or 
off, which we named "otg_commononn"(GRF, offset 0x0e450/0x0e460 bit4 ) 
in RK3399 TRM.

When system boot up, ehci/ohci-platform probe function invoke 
phy_power_on(), further invoke rockchip_usb2phy_power_on() to enable 
480m clock, actually, it sets the otg_commononn bit on, and then usb-phy 
will go to (auto)suspend if there is no devices plug-in after 1 minute, 
the rockchip_usb2phy_power_off() will be invoked and the 480m clock may 
be disabled in the (auto)suspend process. As a result, the otg_commononn 
bit may be turned off, and all output clock of usb-phy will be disabled. 
However, ehci/ohci-platform PM suspend operation (read/write controller 
register) are based on the UTMI clock.

So we introduced "clk_usbphy0_480m_src"/"clk_usbphy1_480m_src" as one 
input clock for ehci/ohci-platform, in this way, the otg_commononn bit 
is not turned off until ehci/ohci-platform go to PM suspend.


BR.
Frank

On 2016/12/15 10:41, Xing Zheng wrote:
> // Frank
>
> Hi Doug,  Brain,
>     Thanks for the reply.
>     Sorry I forgot these patches have been sent earlier, and Frank 
> have some explained and discussed with Heiko.
> Please see https://patchwork.kernel.org/patch/9255245/
>     Perhaps we can move to that patch tree to continue the discussion.
>
>     I think Frank and William will help us to continue checking these.
>
> Thanks
>
> ? 2016?12?15? 08:10, Doug Anderson ??:
>> Hi,
>>
>> On Wed, Dec 14, 2016 at 2:11 AM, Xing Zheng 
>> <zhengxing@rock-chips.com> wrote:
>>> From: William wu <wulf@rock-chips.com>
>>>
>>> We found that the suspend process was blocked when it run into
>>> ehci/ohci module due to clk-480m of usb2-phy was disabled.
>>>
>>> The root cause is that usb2-phy suspended earlier than ehci/ohci
>>> (usb2-phy will be auto suspended if no devices plug-in).
>> This is really weird, but I can confirm it is true on my system too
>> (kernel-4.4 based).  At least I see:
>>
>> [  208.012065] calling  usb1+ @ 4984, parent: fe380000.usb, cb: 
>> usb_dev_suspend
>> [  208.569112] calling  ff770000.syscon:usb2-phy at e450+ @ 4983, parent:
>> ff770000.syscon, cb: platform_pm_suspend
>> [  208.569113] call ff770000.syscon:usb2-phy at e450+ returned 0 after 0 
>> usecs
>> [  208.569439] calling  fe380000.usb+ @ 4983, parent: platform, cb:
>> platform_pm_suspend
>> [  208.569444] call fe380000.usb+ returned 0 after 4 usecs
>>
>>
>> In general I thought that suspend order was supposed to be related to
>> probe order.  So if your probe order is A, B, C then your suspend
>> order would be C, B, A.  ...and we know for sure that the USB PHY
>> needs to probe _before_ the main USB controller.  If it didn't then
>> you'd get an EPROBE_DEFER in the USB controller, right?  So that means
>> that the USB controller should be suspending before its PHY.
>>
>> Any chance this is somehow related to async probe?  I'm not a huge
>> expert on async probe but I guess I could imagine things getting
>> confused if you had a sequence like this:
>>
>> 1. Start USB probe (async)
>> 2. Start PHY probe
>> 3. Finish PHY probe
>> 4. In USB probe, ask for PHY--no problems since PHY probe finished
>> 5. Finish USB probe
>>
>> The probe order would be USB before PHY even though the USB probe
>> _depended_ on the PHY probe being finished...  :-/  Anyway, probably
>> I'm just misunderstanding something and someone can tell me how dumb I
>> am...
>>
>> I also notice that the ehci_platform_power_off() function we're
>> actually making PHY commands right before the same commands that turn
>> off our clocks.  Presumably those commands aren't really so good to do
>> if the PHY has already been suspended?
>>
>> Actually, does the PHY suspend from platform_pm_suspend() actually
>> even do anything?  It doesn't look like it.  It looks as if all the
>> PHY cares about is init/exit and on/off...  ...and it looks as if the
>> PHY should be turned off by the EHCI controller at about the same time
>> it turns off its clocks...
>>
>> I haven't fully dug, but is there any chance that things are getting
>> confused between the OTG PHY and the Host PHY?  Maybe when we turn off
>> the OTG PHY it turns off something that the host PHY needs?
>>
>>
>>> and the
>>> clk-480m provided by it was disabled if no module used. However,
>>> some suspend process related ehci/ohci are base on this clock,
>>> so we should refer it into ehci/ohci driver to prevent this case.
>> Though I don't actually have details about the internals of the chip,
>> it does seem highly likely that the USB block actually uses this clock
>> for some things, so it doesn't seem insane (to me) to have the USB
>> controller request that the clock be on.  So, in general, I don't have
>> lots of objections to including the USB PHY Clock here.
>>
>> ...but I think you have the wrong clock (please correct me if I'm
>> wrong).  I think you really wanted your input clock to be
>> "clk_usbphy0_480m", not "clk_usbphy0_480m_src".  Specifically I
>> believe there is a gate between the clock outputted by the PHY and the
>> USB Controller itself.  I'm guessing that the gate is only there
>> between the PHY and the "clk_usbphy_480m" MUX.
>>
>> As evidence, I have a totally functioning system right now where
>> "clk_usbphy0_480m_src" is currently gated.
>>
>> That means really you should be changing your clocks to this (untested):
>>
>>                 clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>,
>>                          <&u2phy0>;
>>
>> ...and then you could drop the other two patches in this series.
>>
>> ===
>>
>> OK, I actually briefly tested my proposed change and it at least seems
>> to build and boot OK.  You'd have to test it to make sure it makes
>> your tests pass...
>>
>> ===
>>
>> So I guess to summarize all the above:
>>
>> * It seems to me like there's some deeper root cause and your patch
>> will at most put a band-aid on it.  Seems like digging out the root
>> cause is a good idea.
>>
>> * Though I don't believe it solves the root problem, the idea of the
>> USB Controller holding onto the PHY clock doesn't seem wrong.
>>
>> * You're holding onto the wrong clock in your patch--you want the one
>> before the gate (I think).
>>
>>
>> -Doug
>>
>>
>>
>
>
