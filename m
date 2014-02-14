From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 14 Feb 2014 14:50:37 +0100
Subject: How to select between different display timings? (was: [PATCH 7/8]
 ARM: dts: tx28: restructure and update DTS file)
In-Reply-To: <1375966287-6784-8-git-send-email-LW@KARO-electronics.de>
References: <1375966287-6784-1-git-send-email-LW@KARO-electronics.de>
 <1375966287-6784-8-git-send-email-LW@KARO-electronics.de>
Message-ID: <52FE1F2D.4010102@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar and Shawn,

On 08.08.2013 14:51, Lothar Wa?mann wrote:
> - add Copyright header
> - use label references for better readability
> - sort the entries alphabetically
> - add some aliases used by U-Boot to edit the DT data
>
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>   arch/arm/boot/dts/imx28-tx28.dts |  693 +++++++++++++++++++++++++++++++++-----
>   1 files changed, 611 insertions(+), 82 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
> index 37be532..866af60 100644
> --- a/arch/arm/boot/dts/imx28-tx28.dts
> +++ b/arch/arm/boot/dts/imx28-tx28.dts
...
> +&lcdif {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&lcdif_24bit_pins_a &lcdif_sync_pins_a &lcdif_ctrl_pins_a>;
> +       lcd-supply = <&reg_lcd>;
> +       display = <&display>;
> +       status = "okay";
> +
> +       display: display at 0 {
> +               bits-per-pixel = <32>;
> +               bus-width = <24>;
> +
> +               display-timings {
> +                       native-mode = <&timing5>;
> +                       timing0: timing0 {
> +                               panel-name = "VGA";
> +                               clock-frequency = <25175000>;
> +                               hactive = <640>;
> +                               vactive = <480>;
> +                               hback-porch = <48>;
> +                               hsync-len = <96>;
> +                               hfront-porch = <16>;
> +                               vback-porch = <33>;
> +                               vsync-len = <2>;
> +                               vfront-porch = <10>;
> +                               hsync-active = <0>;
> +                               vsync-active = <0>;
> +                               de-active = <1>;
> +                               pixelclk-active = <1>;
> +                       };
> +
> +                       timing1: timing1 {
> +                               panel-name = "ETV570";
> +                               clock-frequency = <25175000>;
> +                               hactive = <640>;
> +                               vactive = <480>;
> +                               hback-porch = <114>;
> +                               hsync-len = <30>;
> +                               hfront-porch = <16>;
> +                               vback-porch = <32>;
> +                               vsync-len = <3>;
> +                               vfront-porch = <10>;
> +                               hsync-active = <0>;
> +                               vsync-active = <0>;
> +                               de-active = <1>;
> +                               pixelclk-active = <1>;
> +                       };
> +
> +                       timing2: timing2 {
> +                               panel-name = "ET0350";
> +                               clock-frequency = <6500000>;
> +                               hactive = <320>;
> +                               vactive = <240>;
> +                               hback-porch = <34>;
> +                               hsync-len = <34>;
> +                               hfront-porch = <20>;
> +                               vback-porch = <15>;
> +                               vsync-len = <3>;
> +                               vfront-porch = <4>;
> +                               hsync-active = <0>;
> +                               vsync-active = <0>;
> +                               de-active = <1>;
> +                               pixelclk-active = <1>;
> +                       };
> +
> +                       timing3: timing3 {
> +                               panel-name = "ET0430";
> +                               clock-frequency = <9000000>;
> +                               hactive = <480>;
> +                               vactive = <272>;
> +                               hback-porch = <2>;
> +                               hsync-len = <41>;
> +                               hfront-porch = <2>;
> +                               vback-porch = <2>;
> +                               vsync-len = <10>;
> +                               vfront-porch = <2>;
> +                               hsync-active = <0>;
> +                               vsync-active = <0>;
> +                               de-active = <1>;
> +                               pixelclk-active = <1>;
> +                       };
> +
> +                       timing4: timing4 {
> +                               panel-name = "ET0500", "ET0700";
> +                               clock-frequency = <33260000>;
> +                               hactive = <800>;
> +                               vactive = <480>;
> +                               hback-porch = <88>;
> +                               hsync-len = <128>;
> +                               hfront-porch = <40>;
> +                               vback-porch = <33>;
> +                               vsync-len = <2>;
> +                               vfront-porch = <10>;
> +                               hsync-active = <0>;
> +                               vsync-active = <0>;
> +                               de-active = <1>;
> +                               pixelclk-active = <1>;
> +                       };
> +
> +                       timing5: timing5 {
> +                               panel-name = "ETQ570";
> +                               clock-frequency = <6400000>;
> +                               hactive = <320>;
> +                               vactive = <240>;
> +                               hback-porch = <38>;
> +                               hsync-len = <30>;
> +                               hfront-porch = <30>;
> +                               vback-porch = <16>;
> +                               vsync-len = <3>;
> +                               vfront-porch = <4>;
> +                               hsync-active = <0>;
> +                               vsync-active = <0>;
> +                               de-active = <1>;
> +                               pixelclk-active = <1>;
> +                       };
> +               };
> +       };
> +};

Being no graphics expert, looking at above device tree change, I'd like 
to understand how this can be used to switch between different display 
timings?

In the kernel, I've found the code which selects the default/native-mode 
(of_display_timing.c). But, as here, if there is a native/default mode, 
there are alternative modes. I haven't understood how and who to select 
these other modes? In this case, how could the alternative modes 
timing0/1/2/3/4 be selected in the kernel?

Do you have any pointers regarding this?

Many thanks and best regards

Dirk
