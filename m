From: dianders@google.com (Doug Anderson)
Date: Thu, 15 Dec 2016 08:34:09 -0800
Subject: [PATCH 3/3] arm64: dts: rockchip: add clk-480m for ehci and ohci
 of rk3399
In-Reply-To: <991221a4-3962-1bcb-7863-72f5553eba40@rock-chips.com>
References: <1481710301-1454-1-git-send-email-zhengxing@rock-chips.com>
 <1481710301-1454-4-git-send-email-zhengxing@rock-chips.com>
 <CAD=FV=UU4JdRjRgEvc_wxprvi6bo46+jd=x2m2QzOe4uJmuRPA@mail.gmail.com>
 <5ce521da-119a-2de8-026c-5992fedfef43@rock-chips.com>
 <991221a4-3962-1bcb-7863-72f5553eba40@rock-chips.com>
Message-ID: <CAD=FV=XKQaqRS4jUM7NpN2KEV8USj_cVWbh7q4274n3jBtwORg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 14, 2016 at 10:41 PM, Frank Wang <frank.wang@rock-chips.com> wrote:
> Hi Brain, Doug and Heiko,
>
> I would like to summarize why this story was constructed.
>
> The ehci/ohci-platform suspend process are blocked due to UTMI clock which
> directly output from usb-phy has been disabled, and why the UTMI clock was
> disabled?
>
> UTMI clock and 480m clock all output from the same internal PLL of usb-phy,
> and there is only one bit can use to control this PLL on or off, which we
> named "otg_commononn"(GRF, offset 0x0e450/0x0e460 bit4 ) in RK3399 TRM.
>
> When system boot up, ehci/ohci-platform probe function invoke
> phy_power_on(), further invoke rockchip_usb2phy_power_on() to enable 480m
> clock, actually, it sets the otg_commononn bit on, and then usb-phy will go
> to (auto)suspend if there is no devices plug-in after 1 minute, the
> rockchip_usb2phy_power_off() will be invoked and the 480m clock may be
> disabled in the (auto)suspend process. As a result, the otg_commononn bit
> may be turned off, and all output clock of usb-phy will be disabled.
> However, ehci/ohci-platform PM suspend operation (read/write controller
> register) are based on the UTMI clock.
>
> So we introduced "clk_usbphy0_480m_src"/"clk_usbphy1_480m_src" as one input
> clock for ehci/ohci-platform, in this way, the otg_commononn bit is not
> turned off until ehci/ohci-platform go to PM suspend.

I still need to digest all of the things that were added to this
thread overnight, but nothing I've seen so far indicates that you need
the post-gated clock.  AKA I still think you need to redo your patch
to replace:

              clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>,
                       <&cru SCLK_USBPHY0_480M_SRC>;

with:

              clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>,
                        <&u2phy0>;

Can you please comment on that?

-Doug
