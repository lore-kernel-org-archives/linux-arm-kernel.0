From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 18 Mar 2015 11:39:19 +0100
Subject: [PATCH v6] ARM: dts: Add HS400 support for exynos5420 and
 exynos5800
In-Reply-To: <1426648118-20790-1-git-send-email-alim.akhtar@samsung.com>
References: <1426648118-20790-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <CABxcv=mbfPS92a19NAF85zRPvzyriHqdRzHzXOBACoQG_Kn_iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alim,

On Wed, Mar 18, 2015 at 4:08 AM, Alim Akhtar <alim.akhtar@samsung.com> wrote:
> From: Seungwon Jeon <tgih.jun@samsung.com>
>
> HS400 timing values are added for SMDK5420, exynos5420-peach-pit
> and exynos5800-peach-pi boards.
> This also adds RCLK GPIO line, this gpio should be in pull-down
> state.
> This also enables HS400 on peach-pi and this updates the clock frequency
> to 800MHz to be set as input clock to controller.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> [Alim: addressed review comments]
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
> Changes in V6:
>         Rebased on kukjin's for-next branch[0]
>         (commit: 77105c8 Merge branch 'v4.0-samsung-fixes-2' into for-next)
>
> [0]: git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>
>  arch/arm/boot/dts/exynos5420-peach-pit.dts | 4 +++-
>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi  | 7 +++++++
>  arch/arm/boot/dts/exynos5420-smdk5420.dts  | 4 +++-
>  arch/arm/boot/dts/exynos5800-peach-pi.dts  | 7 +++++--
>  4 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index d0ee55f..e158861 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -695,8 +695,10 @@
>         samsung,dw-mshc-ciu-div = <3>;
>         samsung,dw-mshc-sdr-timing = <0 4>;
>         samsung,dw-mshc-ddr-timing = <0 2>;
> +       samsung,dw-mshc-hs400-timing = <0 2>;
> +       samsung,read-strobe-delay = <90>;
>         pinctrl-names = "default";
> -       pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
> +       pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;

Why are you removing the sd0_bus1 pinctrl here? Same comment for the
other boards.

This will cause a regression if the XMMCnDATA[0] pad was not mux'ed as
SD_n_DATA[0] by the bootloader.

Best regards,
Javier
