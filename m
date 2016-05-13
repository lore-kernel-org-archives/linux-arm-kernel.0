From: dianders@chromium.org (Doug Anderson)
Date: Fri, 13 May 2016 11:46:33 -0700
Subject: [PATCH 2/4] phy: rockchip-emmc: configure frequency range and
 drive impedance
In-Reply-To: <3695875b-09c3-cd80-3062-55d985e51f70@rock-chips.com>
References: <1463092986-61777-1-git-send-email-briannorris@chromium.org>
 <1463092986-61777-2-git-send-email-briannorris@chromium.org>
 <3695875b-09c3-cd80-3062-55d985e51f70@rock-chips.com>
Message-ID: <CAD=FV=UwocUy_bOUrJZB47taHWdV1KGkvi5CyZf74Y8cvGgVmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Thu, May 12, 2016 at 6:02 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Hi Brian,
>
>
> On 2016/5/13 6:43, Brian Norris wrote:
>>
>> From: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> Signal integrity analysis has suggested we set these values. Do this in
>> power_on(), so that they get reconfigured after suspend/resume.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>> ---
>>  drivers/phy/phy-rockchip-emmc.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/phy/phy-rockchip-emmc.c
>> b/drivers/phy/phy-rockchip-emmc.c
>> index 48cbe691a889..5641dede32f6 100644
>> --- a/drivers/phy/phy-rockchip-emmc.c
>> +++ b/drivers/phy/phy-rockchip-emmc.c
>> @@ -56,6 +56,19 @@
>>  #define PHYCTRL_DLLRDY_SHIFT   0x5
>>  #define PHYCTRL_DLLRDY_DONE    0x1
>>  #define PHYCTRL_DLLRDY_GOING   0x0
>> +#define PHYCTRL_FREQSEL_200M   0x0
>> +#define PHYCTRL_FREQSEL_50M    0x1
>> +#define PHYCTRL_FREQSEL_100M   0x2
>> +#define PHYCTRL_FREQSEL_150M   0x3
>> +#define PHYCTRL_FREQSEL_MASK   0x3
>> +#define PHYCTRL_FREQSEL_SHIFT  0xc
>> +#define PHYCTRL_DR_MASK                0x7
>> +#define PHYCTRL_DR_SHIFT       0x4
>> +#define PHYCTRL_DR_50OHM       0x0
>> +#define PHYCTRL_DR_33OHM       0x1
>> +#define PHYCTRL_DR_66OHM       0x2
>> +#define PHYCTRL_DR_100OHM      0x3
>> +#define PHYCTRL_DR_40OHM       0x4
>>
>>  struct rockchip_emmc_phy {
>>         unsigned int    reg_offset;
>> @@ -154,6 +167,20 @@ static int rockchip_emmc_phy_power_on(struct phy
>> *phy)
>>         struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
>>         int ret = 0;
>>
>> +       /* DLL operation: 170 to 200 MHz */
>
>
> What is 170 here? Should we expose them to dt instead of hardcoding
> them?

This was probably my fault.  I did some searching and found
<https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf>.
It appears to be docs for a similar (but not identical) PHY.  We were
looking at it to try to get more clarity on some bits that were hard
to understand in the docs we had.

In that doc there appear to be 3 bits for selecting the DLL operation
and they have ranges defined.  In Rockchip's PHY there are only 2
bits.  Thus things don't map totally properly.

Anyway, comment should probably be removed.


I _think_ that this just needs to match the input clock rate of the
eMMC, right?  So presumably the PHY should get a reference to the same
clock that was given to the controller clock.  It can check the clock
at probe time and then register a notifier to keep the in sync (if we
expect the clock to change).

IMHO adding all of that complexity seems like it could wait for a
followup patch.  For now we can assume 200 MHz I think?


> Per the commit msg, signal may vary from board to board, so I guess
> 50ohm may not always be the best selection?

Starting out with something sane like 50 ohms seems like it makes
sense for now.  It's OK to start with a default for now to get things
basically working and then add device tree support once we have a
second user.


When we're ready to make this more generic, IMHO we might consider
having the PHY implement the pinctrl API and officially be a pin
controller and we use those bindings.  We are controlling pins so
using the pinctrl API seems like it might make sense?

I _think_ that perhaps what we're specifying here is actually slew
rate, but feel free to correct me if I'm wrong.  It looks as if "drive
strength" is supposed to be specified in terms of mA and the docs I
find show that we're actually controlling how fast the pins will
toggle.

I'm not 100% certain I know how the pinctrl bindings apply in this
case (maybe Heiko has ideas, or maybe we should send a proposal to
Linus W?), but from the bindings they look like they offer some
flexibility.

Maybe this would look like below (or maybe you need some extra sub-nodes)

       sdhci: sdhci at fe330000 {
               compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
               reg = <0x0 0xfe330000 0x0 0x10000>;
               interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
               clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
               clock-names = "clk_xin", "clk_ahb";
               assigned-clocks = <&cru SCLK_EMMC>;
               assigned-clock-rates = <200000000>;
               phys = <&emmc_phy>;
               phy-names = "phy_arasan";
               pinctrl-names = "default";
               pinctrl-0 = <&pcfg_emmc_slew_rate_x1_00>;
               status = "disabled";
       };

               emmc_phy: phy at f780 {
                       compatible = "rockchip,rk3399-emmc-phy";
                       reg = <0xf780 0x20>;
                       #phy-cells = <0>;
                       status = "disabled";

                       pcfg_emmc_slew_rate_x1_00: pcfg-emmc-slew-rate-x1-00 {
                               slew-rate = <100>;
                       };
                       pcfg_emmc_slew_rate_x1_50: pcfg-emmc-slew-rate-x1-50 {
                               slew-rate = <150>;
                       };
                       pcfg_emmc_slew_rate_x0_75: pcfg-emmc-slew-rate-x0-75 {
                               slew-rate = <75>;
                       };
                       pcfg_emmc_slew_rate_x0_50: pcfg-emmc-slew-rate-x0-50 {
                               slew-rate = <50>;
                       };
                       pcfg_emmc_slew_rate_x1_20: pcfg-emmc-slew-rate-x1-20 {
                               slew-rate = <120>;
                       };
                       pcfg_emmc_slew_rate_x1_20: pcfg-emmc-slew-rate-x1-20 {
                               slew-rate = <120>;
                       };
           };

The nice thing about using the pinctrl API is that:

* It allows us to _also_ control pullups / pulldowns.  We probably
want to control those also since some boards may use external pullups
and others may want to use the internal ones.

* If SDHCI needs to dynamically adjust things (like turning on pulls,
adjusting drive strengths, etc) it can do it in a sane API.



> Another thing I need to elaborate more here is that emmc phy only
> supports 50/100/150/200Mhz. Presumably people love to use the highest
> speed mode with its upper limiting frequency, but in case of some
> special requirement or bad board design, they want to add max-frequency
> in dts for emmc controller. In this case PHYCTRL_FREQSEL_XXXM should
> meet the actual max-frequency, take 100M for example, otherwise
> emmc_phy's  tuning block will use 200M to do some calculation but it
> certainly should be 100M. This leads emmc_phy to choose the wrong
> phase. Finally maybe you will see triggering re-tune easily or some
> worse case of even tuning failure when probing card.

Sounds like this should be handled as per above: make sure that the
PHY has access to the clock and can check it's rate.

---

So overall:

* Should re-spin and remove the comment about 170 MHz.

* I think this could land as-is other than the comment.

* Long term someone (hopefully at Rockchip) should think about making
the driver auto-adjust using the clock API.

* Long term someone (hopefully at Rockchip) should think about trying
to use the pinctrl API to allow adjusting drive strengths and pullups.


-Doug
