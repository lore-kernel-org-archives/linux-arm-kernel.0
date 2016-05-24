From: dianders@chromium.org (Doug Anderson)
Date: Mon, 23 May 2016 21:51:19 -0700
Subject: [PATCH 2/4] phy: rockchip-emmc: configure frequency range and
 drive impedance
In-Reply-To: <CAD=FV=UwocUy_bOUrJZB47taHWdV1KGkvi5CyZf74Y8cvGgVmw@mail.gmail.com>
References: <1463092986-61777-1-git-send-email-briannorris@chromium.org>
 <1463092986-61777-2-git-send-email-briannorris@chromium.org>
 <3695875b-09c3-cd80-3062-55d985e51f70@rock-chips.com>
 <CAD=FV=UwocUy_bOUrJZB47taHWdV1KGkvi5CyZf74Y8cvGgVmw@mail.gmail.com>
Message-ID: <CAD=FV=VYPs22rGX9Latecb0EWFA0kOCFmoSQ83wPecrFkL0m7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 13, 2016 at 11:46 AM, Doug Anderson <dianders@chromium.org> wrote:
>> Per the commit msg, signal may vary from board to board, so I guess
>> 50ohm may not always be the best selection?
>
> Starting out with something sane like 50 ohms seems like it makes
> sense for now.  It's OK to start with a default for now to get things
> basically working and then add device tree support once we have a
> second user.
>
>
> When we're ready to make this more generic, IMHO we might consider
> having the PHY implement the pinctrl API and officially be a pin
> controller and we use those bindings.  We are controlling pins so
> using the pinctrl API seems like it might make sense?
>
> I _think_ that perhaps what we're specifying here is actually slew
> rate, but feel free to correct me if I'm wrong.  It looks as if "drive
> strength" is supposed to be specified in terms of mA and the docs I
> find show that we're actually controlling how fast the pins will
> toggle.
>
> I'm not 100% certain I know how the pinctrl bindings apply in this
> case (maybe Heiko has ideas, or maybe we should send a proposal to
> Linus W?), but from the bindings they look like they offer some
> flexibility.
>
> Maybe this would look like below (or maybe you need some extra sub-nodes)
>
>        sdhci: sdhci at fe330000 {
>                compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
>                reg = <0x0 0xfe330000 0x0 0x10000>;
>                interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>                clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
>                clock-names = "clk_xin", "clk_ahb";
>                assigned-clocks = <&cru SCLK_EMMC>;
>                assigned-clock-rates = <200000000>;
>                phys = <&emmc_phy>;
>                phy-names = "phy_arasan";
>                pinctrl-names = "default";
>                pinctrl-0 = <&pcfg_emmc_slew_rate_x1_00>;
>                status = "disabled";
>        };
>
>                emmc_phy: phy at f780 {
>                        compatible = "rockchip,rk3399-emmc-phy";
>                        reg = <0xf780 0x20>;
>                        #phy-cells = <0>;
>                        status = "disabled";
>
>                        pcfg_emmc_slew_rate_x1_00: pcfg-emmc-slew-rate-x1-00 {
>                                slew-rate = <100>;
>                        };
>                        pcfg_emmc_slew_rate_x1_50: pcfg-emmc-slew-rate-x1-50 {
>                                slew-rate = <150>;
>                        };
>                        pcfg_emmc_slew_rate_x0_75: pcfg-emmc-slew-rate-x0-75 {
>                                slew-rate = <75>;
>                        };
>                        pcfg_emmc_slew_rate_x0_50: pcfg-emmc-slew-rate-x0-50 {
>                                slew-rate = <50>;
>                        };
>                        pcfg_emmc_slew_rate_x1_20: pcfg-emmc-slew-rate-x1-20 {
>                                slew-rate = <120>;
>                        };
>                        pcfg_emmc_slew_rate_x1_20: pcfg-emmc-slew-rate-x1-20 {
>                                slew-rate = <120>;
>                        };
>            };
>
> The nice thing about using the pinctrl API is that:
>
> * It allows us to _also_ control pullups / pulldowns.  We probably
> want to control those also since some boards may use external pullups
> and others may want to use the internal ones.
>
> * If SDHCI needs to dynamically adjust things (like turning on pulls,
> adjusting drive strengths, etc) it can do it in a sane API.

Note that I still believe that we could land the 50 Ohm first (AKA
land the patch Brian posted), but I'm also convinced that my pinctrl
proposal above is not a good idea for the way to move forward, at
least in terms of the "driver strength" part.  Specifically it seems
like the 50 Ohm / 33 Ohm / 66 Ohm / 100 Ohm / 40 Ohm is a concept from
eMMC 5.0 and probably doesn't fit to pinctrl.

I also _think_ it needs to be matched against what's available from
the card (card->drive_strength) and the card needs to be told about
it, but I could be wrong about that.



-Doug
