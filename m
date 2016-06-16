From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 16 Jun 2016 10:54:08 +0200
Subject: [v2 PATCH 1/4] Documentation: bindings: add dt doc for Rockchip
 USB Type-C PHY
In-Reply-To: <CAAFQd5BY23zdKCxUnLDz6TT+6ro3qnQPP+bH-uu3KDCzdO50nw@mail.gmail.com>
References: <1465810789-22303-1-git-send-email-zyw@rock-chips.com>
 <5761F34F.8040202@rock-chips.com>
 <CAAFQd5BY23zdKCxUnLDz6TT+6ro3qnQPP+bH-uu3KDCzdO50nw@mail.gmail.com>
Message-ID: <6012957.TOtSrmnyF4@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 16. Juni 2016, 16:49:42 schrieb Tomasz Figa:
> On Thu, Jun 16, 2016 at 9:31 AM, Chris Zhong <zyw@rock-chips.com> wrote:
> > Hi Heiko
> > 
> > On 06/16/2016 06:11 AM, Heiko Stuebner wrote:
> >> Am Montag, 13. Juni 2016, 17:39:46 schrieb Chris Zhong:
> >>> This patch adds a binding that describes the Rockchip USB Type-C PHY
> >>> for rk3399
> >>> 
> >>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> >>> 
> >>> ---
> >>> 
> >>> Changes in v2:
> >>> - add some registers description
> >>> 
> >>> Changes in v1:
> >>> - add extcon node description
> >>> - move the registers in phy driver
> >>> - remove the suffix of reset
> >>> 
> >>>   .../devicetree/bindings/phy/phy-rockchip-typec.txt | 77
> >>> 
> >>> ++++++++++++++++++++++ 1 file changed, 77 insertions(+)
> >>> 
> >>>   create mode 100644
> >>> 
> >>> Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> >>> 
> >>> diff --git
> >>> a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> >>> b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt new file
> >>> mode 100644
> >>> index 0000000..430920c
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> >>> @@ -0,0 +1,77 @@
> >>> +* ROCKCHIP type-c PHY
> >>> +---------------------
> >>> +
> >>> +Required properties:
> >>> + - compatible : should be "rockchip,rk3399-typec-phy0" or
> >>> +                        "rockchip,rk3399-typec-phy1"
> >>> + - reg: Address and length of the usb phy control register set
> >>> + - rockchip,grf : phandle to the syscon managing the "general
> >>> +   register files"
> >>> + - clocks : phandle + clock specifier for the phy clocks
> >>> + - clock-names : string, clock name, must be "tcpdcore", "tcpdphy_ref";
> >>> + - resets : a list of phandle + reset specifier pairs
> >>> + - reset-names : string reset name, must be:
> >>> +                "tcphy", "tcphy_pipe", "uphy_tcphy"
> >>> + - #phy-cells : Must be 0.  See ./phy-bindings.txt for details.
> >>> + - extcon : extcon specifier for the Power Delivery
> >>> +
> >>> +Note, there are 2 type-c phys for RK3399, and they are almost
> >>> identical,
> >>> except +these registers(description below), every register node contains
> >>> 3 sections: +offset, enable bit, write mask bit.
> >>> + - rockchip,typec_conn_dir : the register of type-c connector
> >>> direction,
> >>> +   for type-c phy0, it must be <0xe580 0 16>;
> >>> +   for type-c phy1, it must be <0xe58c 0 16>;
> >> 
> >> I think I said this already, but these register-lists would be much
> >> happier
> >> being defined inside the driver - see how Frank managed this on his
> >> usb2phy
> >> please.
> >> 
> >> Heiko
> > 
> > Yes, I move them into driver in v1 patch, but Rob Herring and Guenter
> > Roeck
> > recommend to put them back to dts.
> > These phy0 and phy1 are exactly the same, except these grf registers.
> 
> I think having the registers in dts isn't a bad idea. It might be
> actually even useful to bring up this PHY on new SoCs, if they happen
> to have the same PHY, just different plumbing.
> 
> But I suppose we don't need two separate compatible strings for phy0
> and phy1 anymore as Rob pointed, just one "rockchip,rk3399-typec-phy".

That is true - so I guess I'm also ok with going that way.

Though with the GRF-based interfaces being as volatile as they are between soc 
types, I just fear that this might not hold up on future socs.
For example the usb2phy is used on rk3036, rk3228, rk3366, rk3368, rk3399 and 
the GRF-side differs a lot - even with some features not even supported.

> After the above is fixed and underscores in property names are
> replaced with dashes, feel free to add my Reviewed-by.

I guess the clock and reset-names could also use dashes instead of 
underscores.
