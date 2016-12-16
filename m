From: dianders@google.com (Doug Anderson)
Date: Fri, 16 Dec 2016 09:28:21 -0800
Subject: [PATCH 3/3] arm64: dts: rockchip: add clk-480m for ehci and ohci
 of rk3399
In-Reply-To: <5853903D.8030605@rock-chips.com>
References: <1481710301-1454-1-git-send-email-zhengxing@rock-chips.com>
 <991221a4-3962-1bcb-7863-72f5553eba40@rock-chips.com>
 <CAD=FV=XKQaqRS4jUM7NpN2KEV8USj_cVWbh7q4274n3jBtwORg@mail.gmail.com>
 <2526685.VC5cUs58On@phil> <5853903D.8030605@rock-chips.com>
Message-ID: <CAD=FV=W1BW6FSZ6MSxR6RhvtZyGsdQbz9vU_QshaQ5A65ENMCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 15, 2016 at 10:57 PM, Xing Zheng <zhengxing@rock-chips.com> wrote:
> Hi Heiko, Doug,
>
> On 2016?12?16? 02:18, Heiko Stuebner wrote:
>
> Am Donnerstag, 15. Dezember 2016, 08:34:09 CET schrieb Doug Anderson:
>
>
> I still need to digest all of the things that were added to this
> thread overnight, but nothing I've seen so far indicates that you need
> the post-gated clock.  AKA I still think you need to redo your patch
> to replace:
>
>               clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>,
>                        <&cru SCLK_USBPHY0_480M_SRC>;
>
> with:
>
>               clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>,
>                         <&u2phy0>;
>
> Can you please comment on that?
>
> Also, with the change, the ehci will keep the clock (and thus the phy)
> always
> on. Does the phy-autosuspend even save anything now?
>
> In any case, could we make the clock-names entry sound nicer than
> usbphy0_480m
> please? bindings/usb/atmel-usb.txt calls its UTMI clock simply "usb_clk",
> but
> something like "utmi" should also work.
> While at it you could also fix up the other clock names to something like
> "host" and "arbiter" or so?.
>
>
> Heiko
>
>
> The usbphy related clock tress like this:
>
>
> Actually, at drivers/phy/phy-rockchip-inno-usb2.c, we can only
> enable/disable the master gate via GRF is PHY_PLL, not UTMI_CLK.
>
> And the naming style of the "hclk_host0" keep the name "hclk_host0" on the
> clcok tree diagram:
>
>
> Therefore, could we rename the clock name like this:
> ----
> for usb_host0_ehci and usb_host0_ohci:
>         clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>,
>              <&cru SCLK_U2PHY0>;
>         clock-names = "hclk_host0", "hclk_host0_arb",
>                   "sclk_u2phy0";
>
> for usb_host1_ehci and usb_host1_ohci:
>         clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST1_ARB>,
>              <&cru SCLK_U2PHY1>;
>         clock-names = "hclk_host1", "hclk_host1_arb",
>                   "sclk_u2phy1";
> ----
>
> BTW, the "arb" is an abbreviation for arbiter.

You don't specify what this new "SCLK_U2PHY0" ID is, so it's a little
hard for me to know what you're intending.

...however, I still don't see any reason why you can't just use the
solution I proposed.  Specifying the clock as "<&u2phy0>" is the
correct thing to do.  The input clock to the EHCI driver is exactly
the clock provided by the USB PHY with no gate in between (just as I
said).  There is no reason to somehow buffer it by the cru.  The cru
doesn't see this clock and has no reason to be involved.


> Thanks.

Note that there were many other comments on this thread besides mine.
Are you planning to address any of them?

-Doug
