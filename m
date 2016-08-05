From: frank.wang@rock-chips.com (Frank Wang)
Date: Fri, 5 Aug 2016 16:34:42 +0800
Subject: [PATCH v3 2/7] clk: rockchip: rk3399: export 480M_SRC clock id
 for usbphy0/usbphy1
In-Reply-To: <1918977.W0kRfKbZsD@diego>
References: <1470122401-31934-1-git-send-email-zhengxing@rock-chips.com>
 <1470122401-31934-3-git-send-email-zhengxing@rock-chips.com>
 <1918977.W0kRfKbZsD@diego>
Message-ID: <cba79ba6-7f41-5398-389c-7fd3fe5e0089@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 2016/8/5 3:10, Heiko St?bner wrote:
> Hi Xing,
>
> Am Dienstag, 2. August 2016, 15:19:56 schrieb Xing Zheng:
>> Export these source clocks for usbphy.
>>
>> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> can you please provide a rationale why you need manual control over that
> intermediate clock?

Well, From below graph, you can see that 'clk_usbphyX_480m' is generated 
from usb2phy, and 'clk_usbphy_480m' which select from 
clk_usbphyX_480m_src via a gate (G13[12])  provided 480M clock to other 
modules.

   xin24m
       |__ clk_usb2phy0_ref
       |                 |__ clk_usbphy0_480m
       |                                   |__clk_usbphy0_480m_src
       | |__clk_usbphy_480m
       |         |__ ... ...
       |__ clk_usb2phy1_ref
                          |__ clk_usbphy1_480m
                                          |__clk_usbphy1_480m_src

> The two usbphys seem to use the  clk_usb2phyX_ref clocks, generate the 480m
> clocks, but do not seem to need the clk_usbphyX_480m_src gates.

Yeah, they used to be. However, the story went something like this,

Some PM suspend process related ehci/ohci controller are base on 480m 
clocks, unfortunately, usb2-phy suspended earlier than ehci/ohci 
(usb2-phy will be auto suspended if no devices plug-in), and the 
clk-480m provided by it was disabled if no module used. As a result, the 
PM suspend process was blocked when it run into ehci/ohci module.

Hence, we are planing to refer clk_usbphyX_480m_src into each ehci/ohci 
driver. Maybe you will challenge why not refer clk_usbphy_480m directly? 
because there are two ehci/ohci connected in the different usb2phy, and 
only one clk_usbphy_480m clock was selected in clock tree.

BR.
Frank

> The clk_usbphyX_480m_src clocks on the other hand only lead to the
> clk_usbphy_480m mux, so I'd like some explanation on what you want to achieve
> here :-)
>
>
> Thanks
> Heiko
>
