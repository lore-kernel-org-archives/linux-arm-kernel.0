From: naobsd@gmail.com (Naoki FUKAUMI)
Date: Mon, 19 Jan 2015 10:16:50 +0900
Subject: [PATCH v3 2/3] ARM: dts: rockchip: add dts for Firefly
 Firefly-RK3288 boards
In-Reply-To: <8724226.Kbpk2bALNd@phil>
References: <1421464140-29903-1-git-send-email-naobsd@gmail.com>
 <1421464140-29903-3-git-send-email-naobsd@gmail.com>
 <8724226.Kbpk2bALNd@phil>
Message-ID: <CAFnsNoSY=Zu2tZ7h7uJKHPyZ3cAW=HxDRTJc2BGvSrNwM5N3gQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 19, 2015 at 8:36 AM, Heiko St?bner <heiko@sntech.de> wrote:
>> +     ext_gmac: external-gmac-clock {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <125000000>;
>> +             clock-output-names = "phy_clkout125";
>
> This should be named "ext_gmac". See the rockchip,rk3288-cru.txt binding
> document.

I'll revert this to use "ext_gmac".

>> +&gmac {
>> +     assigned-clocks = <&cru SCLK_MAC>;
>> +     assigned-clock-parents = <&ext_gmac>;
>> +     clock_in_out = "input";
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&rgmii_pins>, <&phy_rst>, <&phy_pmeb>, <&phy_int>;
>> +     phy_regulator = "vcc_lan";
>
> This is wrong in the dwmac-rk implementation at the moment which Romain Perier
> was/is trying to rectify. I.e. there is an established devicetree api for
> handling regulators, thus the approach the current net-code takes is just
> wrong and thus this will need to change after.

I see.

>> +     hym8563: hym8563 at 51 {
>> +             compatible = "haoyu,hym8563";
>> +             reg = <0x51>;
>> +             #clock-cells = <0>;
>> +             clock-frequency = <32768>;
>> +             clock-output-names = "rtc_clkout";
>
> this should be named "xin32k" . See radxarock.dts (as a rk3188 based similar
> example) and the rk3288 clock controller devicetree binding.

I'll revert this to use "xin32k".

> This is due to the fact that this is also the input for the suspend clock and
> the core clock code expects the specific naming according to the soc
> documentation.

can I assume clock named "xin32k" is always enabled?
no need to describe consumer explicitly?

>> +&sdio0 {
>> +     broken-cd;
>> +     bus-width = <4>;
>> +     clocks = <&hym8563>;
>> +     clock-names = "lpo";
>
> why are you _overriding_ the clocks of the sdio controller?

sorry, I was just wrong. I'll remove clocks and clock-names from here.

>> +&spi2 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&spi2_clk>, <&spi2_cs0>;
>
> you're enabling only the clk and chipselect, what about the data signals?

no idea, I just follow schematic. if it's really unusable on mainline,
I'll disable(remove) spi2.

>> +&tsadc {
>> +     clocks = <&hym8563>;
>> +     clock-names = "clkin_32k";
>
> The tsadc driver only recognizes the clocks "tsadc", "apb_pclk" so I'm not
> sure what you're doing with the clkin_32k name here? Also you're again
> overwriting the existing property.

I was wrong here too. I'll remove clocks and clock-names from here.
and if it makes tsadc non-working, I'll remove tsadc too for now.

Regards,
