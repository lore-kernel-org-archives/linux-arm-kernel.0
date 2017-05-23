From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 May 2017 13:56:28 +0200
Subject: [PATCH 7/8] arm64: dts: hi6220: Move board data from the dwmmc
 nodes to hikey dts
In-Reply-To: <1494260477-25163-8-git-send-email-ulf.hansson@linaro.org>
References: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
 <1494260477-25163-8-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAK8P3a1CZ4GOZ=rV9Dk5zTb0gheau+CCR_tUT4+_oqOhQXtghQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 8, 2017 at 6:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Move the board specific descriptions for the dwmmc nodes in the hi6220 SoC
> dtsi, into the hikey dts as it's there these belongs.
>
> While changing this, let's take the opportunity to drop the use of the
> "ti,non-removable" binding for one of the dwmmc device nodes, as it's not a
> valid binding and not used. Drop also the unnecessary use of "num-slots =
> <0x1>" for all of the dwmmc nodes, as there is no need to set this since
> when default number of slots is one.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 23 ++++++++++++++++++++++-
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi      | 19 -------------------
>  2 files changed, 22 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index 6dab03a..d4b3879 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -281,8 +281,29 @@
>
>                 /* GPIO blocks 16 thru 19 do not appear to be routed to pins */
>
> +               dwmmc_0: dwmmc0 at f723d000 {
> +                       cap-mmc-highspeed;
> +                       non-removable;
> +                       bus-width = <0x8>;
> +                       vmmc-supply = <&ldo19>;
> +               };
> +
> +               dwmmc_1: dwmmc1 at f723e000 {
> +                       card-detect-delay = <200>;
> +                       cap-sd-highspeed;
> +                       sd-uhs-sdr12;
> +                       sd-uhs-sdr25;
> +                       sd-uhs-sdr50;
> +                       vqmmc-supply = <&ldo7>;
> +                       vmmc-supply = <&ldo10>;
> +                       bus-width = <0x4>;
> +                       disable-wp;
> +                       cd-gpios = <&gpio1 0 1>;
> +               };
> +
>                 dwmmc_2: dwmmc2 at f723f000 {
> -                       ti,non-removable;
> +                       broken-cd;
> +                       bus-width = <0x4>;
>                         non-removable;
>                         /* WL_EN */

I see you are just following the style that is used for all other nodes
in this file, but it's worth pointing out that it's really silly to use both
a label and the full path in both the .dtsi file for the SoC and the
board specific .dts file.

If you already have labels for each node, they should be used.

(no need to respin the patch for that, just pointing it out to
the maintainers for future updates)

        Arnd
