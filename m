From: dianders@chromium.org (Doug Anderson)
Date: Mon, 9 Nov 2015 13:08:43 -0800
Subject: [PATCH v2 7/8] ARM: dts: rockchip: assign usbphy480m_src to the
 new usbphy pll on veyron
In-Reply-To: <1446998681-26436-8-git-send-email-heiko@sntech.de>
References: <1446998681-26436-1-git-send-email-heiko@sntech.de>
 <1446998681-26436-8-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=WAmx1y-Euf5-FfdcawxbduKERR-==opWT9VtnwEjmycw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Sun, Nov 8, 2015 at 8:04 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> Veyron devices try to always set the source for usbphy480m to the usbphy0
> that is the phy connected to the otg controller, because the firmware-
> default is usbphy1, the ehci-controller connected to the internal camera
> that might get turned off way easier to save power.
>
> In the mainline kernel we currently don't use the usbphy480m_src at all,
> as it mainly powers the uart0 source that is connected to the bluetooth
> component of the wifi/bt combo.
>
> So move that assignment over to the new real pll clock inside the usbphy.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/boot/dts/rk3288-veyron.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
> index d4263ed..c8329b5 100644
> --- a/arch/arm/boot/dts/rk3288-veyron.dtsi
> +++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
> @@ -410,7 +410,7 @@
>         status = "okay";
>
>         assigned-clocks = <&cru SCLK_USBPHY480M_SRC>;
> -       assigned-clock-parents = <&cru SCLK_OTGPHY0>;
> +       assigned-clock-parents = <&usbphy0>;
>         dr_mode = "host";
>  };

This is right, hence:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...you will slightly break bisectability with this series though,
right?  In the previous patch in this series you changed the clocks in
the mux away from the fake ones to be the real ones.  If you have
either that patch without this one or this patch without that one then
clock parents won't get assigned properly...

I seem to remember that one of the USB phy clocks was kinds jittery (I
want to say it was the EHCI one) and that was causing problems talking
to the BT UART at 3Mbps.  I kinda doubt we have anyone running BT on
upstream over that UART (only used on veyron devices with Broadcom
WiFi), so maybe this is OK.  ...but if you had any other ideas for how
to avoid breaking bisect that would be nice.

If nothing else, if we're going to break bisect then the two commits
should reference each other and say that you need both and that with
only one you might see a different clock selected...

-Doug
