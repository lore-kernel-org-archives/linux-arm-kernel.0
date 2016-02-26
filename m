From: abrestic@google.com (Andrew Bresticker)
Date: Fri, 26 Feb 2016 10:04:22 -0800
Subject: [PATCH V3] ARM64: tegra: Add support for Google Pixel C
In-Reply-To: <1455020809-17531-1-git-send-email-jonathanh@nvidia.com>
References: <1454949199-27050-1-git-send-email-jonathanh@nvidia.com>
 <1455020809-17531-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <CAL1qeaEYTnm-MYYE+bGCHJ72Hb3t3cZ-7uo1Sbny9XB-3pqRfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jon,

On Tue, Feb 9, 2016 at 4:26 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
> Add initial device-tree support for Google Pixel C (a.k.a. Smaug) based
> upon Tegra210 SoC with 3 GiB of LPDDR4 RAM.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
Tested-by: Andrew Bresticker <abrestic@chromium.org>

> ---
>
> Changes v2 -> v3:
> - Added PSCI information to enable all 4 CPUs on boot
>
> Changes v1 -> v2:
> - Removed console boot parameter and added stdout-path
> - Added 32k clock for PMC
>
>  arch/arm64/boot/dts/nvidia/Makefile           |  1 +
>  arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 83 +++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
>
> diff --git a/arch/arm64/boot/dts/nvidia/Makefile b/arch/arm64/boot/dts/nvidia/Makefile
> index a7e865da1005..0f7cdf3e05c1 100644
> --- a/arch/arm64/boot/dts/nvidia/Makefile
> +++ b/arch/arm64/boot/dts/nvidia/Makefile
> @@ -2,6 +2,7 @@ dtb-$(CONFIG_ARCH_TEGRA_132_SOC) += tegra132-norrin.dtb
>  dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2371-0000.dtb
>  dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2371-2180.dtb
>  dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2571.dtb
> +dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-smaug.dtb
>
>  always         := $(dtb-y)
>  clean-files    := *.dtb
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> new file mode 100644
> index 000000000000..750e85c45135
> --- /dev/null
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> @@ -0,0 +1,83 @@
> +/dts-v1/;
> +
> +#include "tegra210.dtsi"
> +
> +/ {
> +       model = "Google Pixel C";
> +       compatible = "google,smaug-rev8", "google,smaug-rev7",
> +                    "google,smaug-rev6", "google,smaug-rev5",
> +                    "google,smaug-rev4", "google,smaug-rev3",
> +                    "google,smaug-rev1", "google,smaug", "nvidia,tegra210";
> +
> +       aliases {
> +               serial0 = &uarta;
> +       };
> +
> +       chosen {
> +               bootargs = "earlycon";
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0x0 0x80000000 0x0 0xc0000000>;
> +       };
> +
> +       serial at 0,70006000 {
> +               status = "okay";
> +       };
> +
> +       pmc at 0,7000e400 {
> +               nvidia,invert-interrupt;
> +               nvidia,suspend-mode = <0>;
> +               nvidia,cpu-pwr-good-time = <0>;
> +               nvidia,cpu-pwr-off-time = <0>;
> +               nvidia,core-pwr-good-time = <12000 6000>;
> +               nvidia,core-pwr-off-time = <39053>;
> +               nvidia,core-power-req-active-high;
> +               nvidia,sys-clock-req-active-high;
> +               status = "okay";
> +       };
> +
> +       sdhci at 0,700b0600 {
> +               bus-width = <8>;
> +               non-removable;
> +               status = "okay";
> +       };
> +
> +       clocks {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               clk32k_in: clock at 0 {
> +                       compatible = "fixed-clock";
> +                       reg = <0>;
> +                       #clock-cells = <0>;
> +                       clock-frequency = <32768>;
> +               };
> +       };
> +
> +       cpus {
> +               cpu at 0 {
> +                       enable-method = "psci";
> +               };
> +
> +               cpu at 1 {
> +                       enable-method = "psci";
> +               };
> +
> +               cpu at 2 {
> +                       enable-method = "psci";
> +               };
> +
> +               cpu at 3 {
> +                       enable-method = "psci";
> +               };
> +       };
> +
> +       psci {
> +               compatible = "arm,psci-1.0";
> +               method = "smc";
> +       };
> +};
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
