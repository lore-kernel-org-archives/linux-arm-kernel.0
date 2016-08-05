From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 05 Aug 2016 18:05:51 +0200
Subject: [PATCH v3 2/7] clk: rockchip: rk3399: export 480M_SRC clock id
 for usbphy0/usbphy1
In-Reply-To: <cba79ba6-7f41-5398-389c-7fd3fe5e0089@rock-chips.com>
References: <1470122401-31934-1-git-send-email-zhengxing@rock-chips.com>
 <1918977.W0kRfKbZsD@diego>
 <cba79ba6-7f41-5398-389c-7fd3fe5e0089@rock-chips.com>
Message-ID: <1570410.dThJclhmJd@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

Am Freitag, 5. August 2016, 16:34:42 schrieb Frank Wang:
> On 2016/8/5 3:10, Heiko St?bner wrote:
> > Am Dienstag, 2. August 2016, 15:19:56 schrieb Xing Zheng:
> >> Export these source clocks for usbphy.
> >> 
> >> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> > 
> > can you please provide a rationale why you need manual control over that
> > intermediate clock?
> 
> Well, From below graph, you can see that 'clk_usbphyX_480m' is generated
> from usb2phy, and 'clk_usbphy_480m' which select from
> clk_usbphyX_480m_src via a gate (G13[12])  provided 480M clock to other
> modules.
> 
>    xin24m
> 
>        |__ clk_usb2phy0_ref
>        |
>        |                 |__ clk_usbphy0_480m
>        |                 |
>        |                                   |__clk_usbphy0_480m_src
>        | |
>        | |__clk_usbphy_480m
>        | |
>        |         |__ ... ...
>        |
>        |__ clk_usb2phy1_ref
>        |
>                           |__ clk_usbphy1_480m
>                           |
>                                           |__clk_usbphy1_480m_src
> > 
> > The two usbphys seem to use the  clk_usb2phyX_ref clocks, generate the
> > 480m
> > clocks, but do not seem to need the clk_usbphyX_480m_src gates.
> 
> Yeah, they used to be. However, the story went something like this,
> 
> Some PM suspend process related ehci/ohci controller are base on 480m
> clocks, unfortunately, usb2-phy suspended earlier than ehci/ohci
> (usb2-phy will be auto suspended if no devices plug-in), and the
> clk-480m provided by it was disabled if no module used. As a result, the
> PM suspend process was blocked when it run into ehci/ohci module.

ah, so the ehci controller needs that 480m clock as well? Do you happen to 
have example patches for the ehci/ohci side already? I'd like to peak at what 
you mean with "some PM suspend process related" things.

Depending on what is actually needed, you could also pull the usbphy out of 
autosuspend in a pm-prepare callback of the phy driver itself ... see 
http://lxr.free-electrons.com/source/include/linux/pm.h#L86

Like 
- in the .prepare callback make sure to unsuspend the phy
  and deactivate the autosuspend
- ehci/ohci will poweroff the phy in it s suspend callback (already does that)
- suspend -> resume
- ehci/ohci will poweron the phy
- in the phy's .complete callback you can reactivate the autosuspend timer

Because it looks more like you actually need the phy and not the clock alone.
So it would be nicer to use mechanisms already in place instead of creating 
new dependencies.


> Hence, we are planing to refer clk_usbphyX_480m_src into each ehci/ohci
> driver. Maybe you will challenge why not refer clk_usbphy_480m directly?
> because there are two ehci/ohci connected in the different usb2phy, and
> only one clk_usbphy_480m clock was selected in clock tree.

Nope, no argument from me as I fully understand that each phy provides its own 
480m clock :-) .


Heiko
