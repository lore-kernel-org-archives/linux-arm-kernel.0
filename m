From: tobetter@gmail.com (Dongjin Kim)
Date: Wed, 23 Jan 2013 03:15:23 +0900
Subject: [PATCH] ARM: dts: add mshc controller node for Exynos4x12 SoCs
In-Reply-To: <1358764755-21470-1-git-send-email-thomas.abraham@linaro.org>
References: <1358764755-21470-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CADoNuNee7xbRPJupGvUKVRB8TKq0WZMg1XYk24-ks34fbRPt1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Good to see your patch, actually I had sent similar one before but no
one care my patch. And now I feel it seems to be wrong.

But I have a couple of question if I use your patch to enable MSHC
controller work properly on Exynos4412.

What's the exact form of ".compatible" on board file?
With your patch, MSHC is not probed at all in my board. The
".compatible" has to be 'samsung,exynos5250-dw-mshc' and it works.

I also tried '.compatible = "samsung,exynos5250-dw-mshc",
"samsung,exynos4412-dw-mshc"', it probes the driver but in the
function 'dw_mci_exynos_priv_init', priv->ctrl_type always becomes
DW_MCI_TYPE_EXYNOS5250. Because there is a loop and returns each
compatible strings in alphanumeric order whatever it is ordered in the
board file.

I also tried below patch to add a compatible for Exynos4412 to
'dw_mci_exynos_match' with its specific data, and it works. What's the
right direction? If I am missing something or wrong, please correct
me. :)

Many thanks,
Dongjin.

@@ -184,6 +186,25 @@ static int dw_mci_exynos_setup_bus(struct dw_mci *host,
        return 0;
 }

+/* Exynos4412 controller specific capabilities */
+static unsigned long exynos4412_dwmmc_caps[4] = {
+       MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR |
+               MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
+       MMC_CAP_CMD23,
+       MMC_CAP_CMD23,
+       MMC_CAP_CMD23,
+};
+
+static const struct dw_mci_drv_data exynos4412_drv_data = {
+       .caps                   = exynos4412_dwmmc_caps,
+       .init                   = dw_mci_exynos_priv_init,
+       .setup_clock            = dw_mci_exynos_setup_clock,
+       .prepare_command        = dw_mci_exynos_prepare_command,
+       .set_ios                = dw_mci_exynos_set_ios,
+       .parse_dt               = dw_mci_exynos_parse_dt,
+       .setup_bus              = dw_mci_exynos_setup_bus,
+};
+
 /* Exynos5250 controller specific capabilities */
 static unsigned long exynos5250_dwmmc_caps[4] = {
        MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR |
@@ -204,6 +225,8 @@ static const struct dw_mci_drv_data exynos5250_drv_data = {
 };

 static const struct of_device_id dw_mci_exynos_match[] = {
+       { .compatible = "samsung,exynos4412-dw-mshc",
+                       .data = &exynos4412_drv_data, },
        { .compatible = "samsung,exynos5250-dw-mshc",
                        .data = &exynos5250_drv_data, },
        {},


On Mon, Jan 21, 2013 at 7:39 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> Commit cea0f256 ("ARM: dts: Add board dts file for ODROID-X") includes a node
> to describe the board level properties for mshc controller. But the mshc
> controller node was not added in the Exynos4x12 dtsi file which resulted
> in the following warning when compiling the dtb files.
>
> Warning (reg_format): "reg" property in /mshc at 12550000/slot at 0 has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> Warning (avoid_default_addr_size): Relying on default #address-cells value for /mshc at 12550000/slot at 0
> Warning (avoid_default_addr_size): Relying on default #size-cells value for /mshc at 12550000/slot at 0
>
> Fix this by adding the mshc controller node for Exynos4x12 SoCs.
>
> Cc: Dongjin Kim <tobetter@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/boot/dts/exynos4412.dtsi |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index 78ed377..96f5b66 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -32,4 +32,12 @@
>                 interrupts = <0 57 0>, <0 0 0>, <0 0 0>, <0 0 0>,
>                              <1 12 0>, <1 12 0>, <1 12 0>, <1 12 0>;
>         };
> +
> +       mshc at 12550000 {
> +               compatible = "samsung,exynos4412-dw-mshc";
> +               reg = <0x12550000 0x1000>;
> +               interrupts = <0 77 0>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +       };
>  };
> --
> 1.7.5.4
>
