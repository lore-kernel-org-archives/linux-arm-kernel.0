From: dianders@chromium.org (Doug Anderson)
Date: Thu, 21 Apr 2016 15:38:22 -0700
Subject: [PATCH] ARM64: dts: rockchip: add core dtsi file for RK3399 SoCs
In-Reply-To: <3937420.4aN2rRBlcO@diego>
References: <1461122150-9042-1-git-send-email-jay.xu@rock-chips.com>
 <1461211092-26331-1-git-send-email-jay.xu@rock-chips.com>
 <3937420.4aN2rRBlcO@diego>
Message-ID: <CAD=FV=X9S4z2WLEJ-KaaCZxfkdO4+-i2hUd3dsYJi5qXEvpVBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I didn't look as deeply as Heiko, but a few comments...


On Thu, Apr 21, 2016 at 3:02 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Hi Jay,
>
> Am Donnerstag, 21. April 2016, 11:58:12 schrieb Jianqun Xu:
>> This patch adds rk3399.dtsi for rk3399 found on Rockchip
>> RK3399 SoCs, also add rk3399-evb.dts for Rockchip RK3399
>> Evaluation Board.
>>
>> Patch is tested on RK3399 evb.
>>
>> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
>
> please split this into
> - patch adding the dtsi
> - patch adding the evb dts
> - patch adding the new  board to bindings/arm/rockchip.txt
>
> more inline below

Also don't forget to remove the controversial pmu bits for now (as
discussed earlier) so this can land while all those kinks are being
worked out.

>> +     sdhci: sdhci at fe330000 {
>> +             compatible = "arasan,sdhci-5.1";
>
> not 100% sure, but we might want a
>                 compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
>
> allowing us to get more specific, if implementation oddities surface later.

I agree with Heiko.  This sounds very sane to me, too, and matches
previous discussions.

>> +             reg = <0x0 0xfe330000 0x0 0x10000>;
>> +             interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> +             clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
>> +             clock-names = "clk_xin", "clk_ahb";
>> +             phys = <&emmc_phy>;
>> +             phy-names = "phy_arasan";
>> +             status = "disabled";
>> +     };
>> +
>> +     usb2phy: usb2phy {
>> +             compatible = "rockchip,rk3399-usb-phy";
>
> this doesn't look like it got submitted yet.
>
> Also, the newer socs (rk3399. rk3036, rk3228) seem to use a different usbphy
> block than rk3288 and before (with a big bunch of new phy-related register
> blocks I haven't looked at yet) - so this should probably get a new driver as
> well and not be crammed into the current phy driver, which is for the older
> picophy (or what it was called).
>
>
>> +             rockchip,grf = <&grf>;
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +
>> +             usb2phy0: usb2-phy0 {
>> +                     #phy-cells = <0>;
>> +                     #clock-cells = <0>;
>> +                     reg = <0xe458>;
>> +             };
>
> When we're doing a new driver, could we please get rid of these subnodes and
> instead access phys via something like
>
>         phys = <&usb2phy 0>;

>From what I recall during the submission of the previous PHY Kishon
preferred the subnodes.  I think I made a fool of myself in the last
discussion about this because I reported bugs in my downstream kernel
that didn't exist upstream, but if you want to read it you can see
here:

https://patchwork.kernel.org/patch/5474871/

I believe patch v6 used IDs like Heiko is suggesting and it turned to
subnodes in v7 based on Kishon's request.  Since PHY code and bindings
are Kishon's call, I have a feeling his opinion will trump here.

>> +
>> +             usb2phy1: usb2-phy1 {
>> +                     #phy-cells = <0>;
>> +                     #clock-cells = <0>;
>> +                     reg = <0xe468>;
>> +             };
>> +     };
>> +
>> +     usb_host0_echi: usb at fe380000 {
>
> not "echi" please :-)

Just because it took me an extra reading to understand, he means turn
"echi" to "ehci".


>> +             compatible = "generic-ehci";
>> +             reg = <0x0 0xfe380000 0x0 0x20000>;
>> +             interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>> +             clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>;
>> +             clock-names = "hclk_host0", "hclk_host0_arb";
>> +             phys = <&usb2phy0>;
>> +             phy-names = "usb2_phy0";
>> +             status = "disabled";
>> +     };
>
> [...]
>
>> +     usbdrd3_0: usb at fe800000 {
>> +             compatible = "rockchip,dwc3";
>
> is this in some tree already?

I'm really surprised that there's not some generic fallback for
"dwc3-of-simple.c".  I would have expected:
  "rockchip,rk3399-dwc3", "synopsis,dwc3";

...but that doesn't appear to be in the bindings.  Weird.

>> +     i2c1: i2c at ff110000 {
>> +             compatible = "rockchip,rk3399-i2c";
>
> David respun the rk3399 i2c-support on tuesday, so this and the others below
> are waiting on Wolfram to take a look.

I think it can work with the rk3288-i2c as a fallback, at least for
low speed stuff, right?  Should this be:

compatible = "rockchip,rk3399-i2c", "rockchip,rk3288-i2c"

Looks like that was done for rk3368.


-Doug
