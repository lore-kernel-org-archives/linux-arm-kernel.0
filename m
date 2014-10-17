From: dianders@chromium.org (Doug Anderson)
Date: Fri, 17 Oct 2014 09:57:55 -0700
Subject: [PATCH 2/2] ARM: dts: socfpga: Add a 3.3V fixed regulator node
In-Reply-To: <1413493413-8041-3-git-send-email-dinguyen@opensource.altera.com>
References: <1413493413-8041-1-git-send-email-dinguyen@opensource.altera.com>
 <1413493413-8041-3-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <CAD=FV=V3Ewv7Ns_JD0+gd4J6p3k-N-rmFjkdYQobMgB8m7z6SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dinh,

On Thu, Oct 16, 2014 at 2:03 PM,  <dinguyen@opensource.altera.com> wrote:
> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>
> Without the 3.3V regulator node, the SDMMC driver will give these warnings:
>
> dw_mmc ff704000.dwmmc0: No vmmc regulator found
> dw_mmc ff704000.dwmmc0: No vqmmc regulator found
>
> This patch adds the regulator node, and points the SD/MMC to the regulator.
>
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
>  arch/arm/boot/dts/socfpga_arria5.dtsi         | 11 ++++++++++-
>  arch/arm/boot/dts/socfpga_arria5_socdk.dts    |  5 +++++
>  arch/arm/boot/dts/socfpga_cyclone5.dtsi       |  9 +++++++++
>  arch/arm/boot/dts/socfpga_cyclone5_socdk.dts  |  2 ++
>  arch/arm/boot/dts/socfpga_cyclone5_sockit.dts |  5 +++++
>  5 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
> index 03e8268..8093781 100644
> --- a/arch/arm/boot/dts/socfpga_arria5.dtsi
> +++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
> @@ -29,7 +29,7 @@
>                         };
>                 };
>
> -               dwmmc0 at ff704000 {
> +               mmc0: dwmmc0 at ff704000 {
>                         num-slots = <1>;
>                         broken-cd;
>                         bus-width = <4>;
> @@ -41,4 +41,13 @@
>                         cpu1-start-addr = <0xffd080c4>;
>                 };
>         };
> +
> +       regulator_3_3v_hps: fixed_3_3v_hps_regulator at 0 {

nit: no @0 since there is no "reg" (register) under this node.

nit: usually people don't like "_" in node names.  ...I would probably
do this but I'm not an expert:
  regulator_3_3v_hps: hps-regulator {

This regulator also looks pretty bogus to me.  Is this really a
regulator that software has no control over?  It means you can't fully
reset a card but I guess that's OK.

I'd also expect this regulator to be defined in the same dts / dtsi
file that it's used in.  Your current patch says "there's a generic
3.3V regulator on all boards of the socfpga_arria5 class even if they
don't use MMC, but the "socfpga_arria5_socdk" uses it for MMC.  Is
that really true?
