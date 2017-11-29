From: jagan@amarulasolutions.com (Jagan Teki)
Date: Wed, 29 Nov 2017 19:23:56 +0530
Subject: [PATCH 2/2] arm64: dts: orange-pi-zero-plus2: enable AP6212a
 WiFi/BT combo
In-Reply-To: <20171103195855.15283-3-geomatsi@gmail.com>
References: <20171103195855.15283-1-geomatsi@gmail.com>
 <20171103195855.15283-3-geomatsi@gmail.com>
Message-ID: <CAMty3ZAiDvAG-P-c0J7vKaDyRWQ2CQobLA_xycRva5B20W6SOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 4, 2017 at 1:28 AM, Sergey Matyukevich <geomatsi@gmail.com> wrote:
> Enable AP6212a WiFi/BT combo chip on orange-pi-zero-plus2 board:
> - WiFi SDIO interface is connected to MMC1
> - WiFi REG_ON pin connected to gpio PA9: attach to mmc-pwrseq
> - WiFi HOST_WAKE pin connected to gpio PL7
> - BT is connected to UART1
>
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> ---
>  .../allwinner/sun50i-h5-orangepi-zero-plus2.dts    | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> index a42fd79a62a3..d415b7b67cce 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> @@ -64,6 +64,13 @@
>                 regulator-min-microvolt = <3300000>;
>                 regulator-max-microvolt = <3300000>;
>         };
> +
> +       wifi_pwrseq: wifi_pwrseq {
> +               compatible = "mmc-pwrseq-simple";
> +               pinctrl-names = "default";
> +               reset-gpios = <&pio 0 9 GPIO_ACTIVE_LOW>; /* PA9 */
> +               post-power-on-delay-ms = <200>;
> +       };
>  };
>
>  &mmc0 {
> @@ -75,6 +82,25 @@
>         status = "okay";
>  };
>
> +&mmc1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc1_pins_a>;
> +       vmmc-supply = <&reg_vcc3v3>;
> +       vqmmc-supply = <&reg_vcc3v3>;
> +       mmc-pwrseq = <&wifi_pwrseq>;
> +       bus-width = <4>;
> +       non-removable;
> +       status = "okay";
> +
> +       brcmf: wifi at 1 {
> +               reg = <1>;
> +               compatible = "brcm,bcm4329-fmac";
> +               interrupt-parent = <&r_pio>;
> +               interrupts = <0 7 IRQ_TYPE_LEVEL_LOW>;  /* PL7 */
> +               interrupt-names = "host-wake";
> +       };
> +};

Did you observe this issue, I'm using firmware from buildroot and
couldn't find any *.txt from brcm/ I believe we need ass text file for
firmware details, did you tried the same from BR?

Log:
[    1.872235] mmc1: new high speed SDIO card at address 0001
[    1.880919] brcmfmac: brcmf_fw_map_chip_to_name: using
brcm/brcmfmac43430-sdio.bin for chip 0x00a9a6(43430) rev 0x000001
[    1.908802] EXT4-fs (mmcblk0p1): re-mounted. Opts: data=ordered
[    1.927199] brcmfmac mmc1:0001:1: Direct firmware load for
brcm/brcmfmac43430-sdio.txt failed with error -2
[    2.963478] brcmfmac: brcmf_sdio_htclk: HT Avail timeout (1000000):
clkctl 0x50
[    3.971888] brcmfmac: brcmf_sdio_htclk: HT Avail timeout (1000000):
clkctl 0x50

thanks!
-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
