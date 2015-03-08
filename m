From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 8 Mar 2015 11:12:40 +0800
Subject: [linux-sunxi] [PATCH 6/7] ARM: dts: sun7i: Add OOB irq support to
 boards with broadcom sdio wifi
In-Reply-To: <1425754884-7875-6-git-send-email-hdegoede@redhat.com>
References: <1425754884-7875-1-git-send-email-hdegoede@redhat.com>
 <1425754884-7875-6-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v642i_Yg9PAg=iMyVgzm0gNwe6v7wmziYJTZcjoDBAFmcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 8, 2015 at 3:01 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 11 +++++++++++
>  arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts  | 11 +++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> index 0c219a4..8111b0c 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -167,12 +167,23 @@
>  };
>
>  &mmc3 {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
>         pinctrl-names = "default";
>         pinctrl-0 = <&mmc3_pins_a>;
>         vmmc-supply = <&reg_vmmc3>;
>         bus-width = <4>;
>         non-removable;
>         status = "okay";
> +
> +       brcmf: bcrmf at 1 {
> +               reg = <1>;
> +               compatible = "brcm,bcm4329-fmac";
> +               interrupt-parent = <&pio>;
> +               interrupts = <10 8>; /* PH10 / EINT10 */
> +               interrupt-names = "host-wake";
> +       };

I gave this a spin on my Cubietruck. (I was running cap-sdio-irq before.)

Ran a few ping tests with a simple
"sudo ping -i 0.1 -I wlan0 -s 65500 192.168.1.1"
After a few runs I got

sunxi-mmc 1c12000.mmc: smc 1 err, cmd 53, RD SBE !!
sunxi-mmc 1c12000.mmc: data error, sending stop command
brcmfmac: brcmf_sdio_readframes: RXHEADER FAILED: -110
brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame, send NAK
brcmfmac: brcmf_sdiod_regrw_helper: failed to write data F1 at 0x0a040, err: -5
brcmfmac: brcmf_sdio_hdparse: seq 226: sequence number error, expect 227
sunxi-mmc 1c12000.mmc: smc 1 err, cmd 53, RD DTO !!
sunxi-mmc 1c12000.mmc: data error, sending stop command
sunxi-mmc 1c12000.mmc: smc 1 err, cmd 53, RD DTO !!
sunxi-mmc 1c12000.mmc: data error, sending stop command
sunxi-mmc 1c12000.mmc: smc 1 err, cmd 53, RD DTO !!
sunxi-mmc 1c12000.mmc: data error, sending stop command
brcmfmac: brcmf_sdiod_regrw_helper: failed to read data F1 at 0x0a020, err: -110
brcmfmac: brcmf_sdio_dpc: failed backplane access over SDIO, halting operation
sunxi-mmc 1c12000.mmc: smc 1 err, cmd 53, RD DTO !!
sunxi-mmc 1c12000.mmc: data error, sending stop command
sunxi-mmc 1c12000.mmc: smc 1 err, cmd 53, RD DTO !!
sunxi-mmc 1c12000.mmc: data error, sending stop command
sunxi-mmc 1c12000.mmc: smc 1 err, cmd 53, RD DTO !!
sunxi-mmc 1c12000.mmc: data error, sending stop command

The chip is pretty much dead afterwards.

With cap-sdio-irq it doesn't happen so soon, but it does.
Without either, the response time is bad with packet losses,
but at least it doesn't die.

Is this the problem Arend (CC-ed) was looking into?

Regards
ChenYu

>  };
>
>  &mmc3_pins_a {
> diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
> index baee563..4a8defd 100644
> --- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
> @@ -164,12 +164,23 @@
>  };
>
>  &mmc3 {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
>         pinctrl-names = "default";
>         pinctrl-0 = <&mmc3_pins_a>;
>         vmmc-supply = <&reg_vmmc3>;
>         bus-width = <4>;
>         non-removable;
>         status = "okay";
> +
> +       brcmf: bcrmf at 1 {
> +               reg = <1>;
> +               compatible = "brcm,bcm4329-fmac";
> +               interrupt-parent = <&pio>;
> +               interrupts = <10 8>; /* PH10 / EINT10 */
> +               interrupt-names = "host-wake";
> +       };
>  };
>
>  &mmc3_pins_a {
> --
> 2.3.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
