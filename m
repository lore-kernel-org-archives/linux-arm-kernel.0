From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 30 Nov 2015 11:23:23 -0800
Subject: [PATCH 1/7] ARM: dts: qcom: msm8974-honami: Define pinctrl state
 for blsp_uart2
In-Reply-To: <1445403470-17434-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1445403470-17434-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <CAMAWPa9fHWY3diCfZG2s0ZaNqza+SnK+4QZzkAwW8xb9zjOqHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 9:57 PM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:
> Make sure the blsp1_uart2 pins are in the correct state for the uart.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

kernelci.org has been detecting boot failures on my z1 since
next-20151120[1] and I finally got around to bisecting, which pointed
to this patch which is in next in the for of commit 14cd83b824aa ARM:
dts: qcom: msm8974-honami: Define pinctrl state for blsp_uart2

That commit doesn't revert cleanly on top of next-20151130, but
manually removing the stuff added in this patch, next-20151130 boots
fine on the z1.

Kevin

[1] http://kernelci.org/boot/qcom-msm8974-sony-xperia-honami/job/next/kernel/next-20151127/defconfig/multi_v7_defconfig/lab/lab-khilman/?_id=5658061359b5140196b5fd2f

> ---
>  .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
> index 016f9ad9392a..6f7e4ef4ccf7 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
> @@ -23,6 +23,29 @@
>  &soc {
>         serial at f991e000 {
>                 status = "ok";
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&blsp1_uart2_pin_a>;
> +       };
> +
> +       pinctrl at fd510000 {
> +               blsp1_uart2_pin_a: blsp1-uart2-pin-active {
> +                       rx {
> +                               pins = "gpio5";
> +                               function = "blsp_uart2";
> +
> +                               drive-strength = <2>;
> +                               bias-pull-up;
> +                       };
> +
> +                       tx {
> +                               pins = "gpio4";
> +                               function = "blsp_uart2";
> +
> +                               drive-strength = <4>;
> +                               bias-disable;
> +                       };
> +               };
>         };
>  };
>
> --
> 2.4.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
