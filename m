From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 13 Jun 2016 08:46:08 +0200
Subject: [PATCH 6/7] ARM: dts: imx53-tx53: Switch using
 simple-audio-card for audio support
In-Reply-To: <1465621345-12597-6-git-send-email-shc_work@mail.ru>
References: <1465621345-12597-1-git-send-email-shc_work@mail.ru>
 <1465621345-12597-6-git-send-email-shc_work@mail.ru>
Message-ID: <20160613084608.17e33ad3@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, 11 Jun 2016 08:02:24 +0300 Alexander Shiyan wrote:
> The sound support can be handled by "simple-audio-card" instead of
> use a private driver.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx53-tx53-x03x.dts |  1 +
>  arch/arm/boot/dts/imx53-tx53-x13x.dts |  1 +
>  arch/arm/boot/dts/imx53-tx53.dtsi     | 57 ++++++++++++++++++++++++++---------
>  3 files changed, 45 insertions(+), 14 deletions(-)
> 
[...]
> @@ -142,6 +156,26 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_ssi1>;
>  	status = "okay";
> +
> +	audmux_ssi0 {
> +		fsl,audmux-port = <MX51_AUDMUX_PORT2_SSI0>;
>
This fails to compile because MX51_AUDMUX_PORT2_SSI0 is not defined!
It should be MX51_AUDMUX_PORT1_SSI0.

+			(IMX_AUDMUX_V2_PTCR_TFSDIR |
+			IMX_AUDMUX_V2_PTCR_TFSEL(MX51_AUDMUX_PORT4) |
+			IMX_AUDMUX_V2_PTCR_TCLKDIR |
+			IMX_AUDMUX_V2_PTCR_TCSEL(MX51_AUDMUX_PORT4) |
+			IMX_AUDMUX_V2_PTCR_SYN)
+			IMX_AUDMUX_V2_PDCR_RXDSEL(MX51_AUDMUX_PORT4)
>
These should be MX51_AUDMUX_PORT5 rather than MX51_AUDMUX_PORT4.
(This applies to the other .dts files in your patchset excluiding
mx51-babbage.dts).

> @@ -502,14 +536,9 @@
>  };
>  
>  &ssi1 {
> -	codec-handle = <&sgtl5000>;
>  	status = "okay";
>  };
>  
> -&ssi2 {
> -	status = "disabled";
> -};
> -
This may be redundant because it is the default, but I prefer to keep
it here, to make it easier for the end user to enable it and to
document, that the SSI2 interface is actually usable on the TX53
modules.


Lothar Wa?mann
