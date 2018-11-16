From: dianders@chromium.org (Doug Anderson)
Date: Thu, 15 Nov 2018 21:03:24 -0800
Subject: [PATCH] arm64: dts: rockchip: rk3399: Add xin32k clk
In-Reply-To: <20181116004247.172977-1-dbasehore@chromium.org>
References: <20181116004247.172977-1-dbasehore@chromium.org>
Message-ID: <CAD=FV=VjN3J66wv2LGhQYD+-_W1q+KCzvo3V_1F9ktAb-T-i4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 15, 2018 at 4:42 PM Derek Basehore <dbasehore@chromium.org> wrote:
>
> This adds the xin32k clock to the RK3399 CPU. Even though it's not
> directly used, muxes will end up traversing the entire clk tree on
> calls to determine_rate if it doesn't exist.
>
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 99e7f65c1779..6a32293982d0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -191,6 +191,13 @@
>                 #clock-cells = <0>;
>         };
>
> +       xin32k: xin32k {

nit: xin32k is the name of the clock that rk3399 consumes.  It seems a
little weird to name this node with that name.  Can you call this:

ap_rtc_clk: ap-rtc-clk

...after the gru schematic?  You wouldn't change the
clock-output-names, just the node name / label.


> +               compatible = "fixed-clock";
> +               clock-frequency = <32000>;

I checked the datasheet for the 32K clock and it shows that this is a
32768 Hz clock, not a 32000 Hz one.  I also checked the rk808 clock
driver (which is supposed to be compatible with rk3399) and it
produces a 32768 clock.
