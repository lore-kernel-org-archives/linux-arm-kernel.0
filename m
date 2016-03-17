From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 17 Mar 2016 16:44:50 -0500
Subject: [PATCH 1/2] arm64: dts: juno/vexpress: fix node name unit-address
 presence warnings
In-Reply-To: <1457352735-24453-1-git-send-email-sudeep.holla@arm.com>
References: <1457352735-24453-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAL_JsqJeeZ58at95gSRwOMnce_DjDsXVRYH_bMKaX=uDHtZAAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 7, 2016 at 6:12 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Commit fa38a82096a1 ("scripts/dtc: Update to upstream version
> 53bf130b1cdd") added warnings on node name unit-address presence/absence
> mismatch in device trees.
>
> This patch fixes those warning on all the juno/vexpress platforms where
> unit-address is present in node name while the reg/ranges property is
> not present.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/boot/dts/arm/foundation-v8.dtsi         |  2 +-
>  arch/arm64/boot/dts/arm/juno-base.dtsi             | 14 +++++-----
>  arch/arm64/boot/dts/arm/juno-motherboard.dtsi      | 30 +++++++++++-----------
>  arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts         |  2 +-
>  arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi   | 14 +++++-----
>  .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts      | 10 ++++----
>  6 files changed, 36 insertions(+), 36 deletions(-)
>
> Hi Rob,
>
> I am not sure if the intention of commit fa38a82096a1 is to fix even
> existing warnings or not. I saw warning with today's -next branch.

Yes. I'm dropping it for 4.6 though.

> Let me know.
>
> Regards,
> Sudeep
>
> diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dtsi b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
> index 9314f3943269..ba03c934a861 100644
> --- a/arch/arm64/boot/dts/arm/foundation-v8.dtsi
> +++ b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
> @@ -89,7 +89,7 @@
>                              <0 63 4>;
>         };
>
> -       smb {
> +       smb at 0,08000000 {

Drop the comma and leading zeros. Comma is for distinct fields like
bus,dev,func on PCI.

This is the next warning I'm working on...

>                 compatible = "arm,vexpress,v2m-p1", "simple-bus";
>                 arm,v2m-memory-map = "rs1";
>                 #address-cells = <2>; /* SMB chipselect number and offset */
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index 4b6172b0f2cb..3841e82fa6f8 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -105,13 +105,13 @@
>                 clocks {
>                         compatible = "arm,scpi-clocks";
>
> -                       scpi_dvfs: scpi_clocks at 0 {
> +                       scpi_dvfs: scpi-clocks-0 {
>                                 compatible = "arm,scpi-dvfs-clocks";
>                                 #clock-cells = <1>;
>                                 clock-indices = <0>, <1>, <2>;
>                                 clock-output-names = "atlclk", "aplclk","gpuclk";
>                         };
> -                       scpi_clk: scpi_clocks at 3 {
> +                       scpi_clk: scpi-clocks-1 {
>                                 compatible = "arm,scpi-variable-clocks";
>                                 #clock-cells = <1>;
>                                 clock-indices = <3>;
> @@ -154,7 +154,7 @@
>                 clock-names = "pxlclk";
>
>                 port {
> -                       hdlcd1_output: endpoint at 0 {
> +                       hdlcd1_output: endpoint0 {

Just "endpoint" or add the reg property if there is another endpoint.

>                                 remote-endpoint = <&tda998x_1_input>;
>                         };
>                 };
> @@ -168,7 +168,7 @@
>                 clock-names = "pxlclk";
>
>                 port {
> -                       hdlcd0_output: endpoint at 0 {
> +                       hdlcd0_output: endpoint0 {
>                                 remote-endpoint = <&tda998x_0_input>;
>                         };
>                 };
> @@ -196,7 +196,7 @@
>                         compatible = "nxp,tda998x";
>                         reg = <0x70>;
>                         port {
> -                               tda998x_0_input: endpoint at 0 {
> +                               tda998x_0_input: endpoint0 {
>                                         remote-endpoint = <&hdlcd0_output>;
>                                 };
>                         };
> @@ -206,7 +206,7 @@
>                         compatible = "nxp,tda998x";
>                         reg = <0x71>;
>                         port {
> -                               tda998x_1_input: endpoint at 0 {
> +                               tda998x_1_input: endpoint0 {
>                                         remote-endpoint = <&hdlcd1_output>;
>                                 };
>                         };
> @@ -243,7 +243,7 @@
>                       <0x00000008 0x80000000 0x1 0x80000000>;
>         };
>
> -       smb {
> +       smb at 0,08000000 {
>                 compatible = "simple-bus";
>                 #address-cells = <2>;
>                 #size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> index 413f1b9ebcd4..3d4af126df6e 100644
> --- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> @@ -46,7 +46,7 @@
>                         arm,vexpress,site = <0>;
>                         arm,v2m-memory-map = "rs1";
>
> -                       mb_fixed_3v3: fixedregulator at 0 {
> +                       mb_fixed_3v3: fixedregulator0 {

fixed-regulator-0 perhaps.

>                                 compatible = "regulator-fixed";
>                                 regulator-name = "MCC_SB_3V3";
>                                 regulator-min-microvolt = <3300000>;
> @@ -59,42 +59,42 @@
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
>
> -                               button at 1 {
> +                               button1 {
>                                         debounce_interval = <50>;
>                                         wakeup-source;
>                                         linux,code = <116>;
>                                         label = "POWER";
>                                         gpios = <&iofpga_gpio0 0 0x4>;
>                                 };
> -                               button at 2 {
> +                               button2 {
>                                         debounce_interval = <50>;
>                                         wakeup-source;
>                                         linux,code = <102>;
>                                         label = "HOME";
>                                         gpios = <&iofpga_gpio0 1 0x4>;
>                                 };
> -                               button at 3 {
> +                               button3 {
>                                         debounce_interval = <50>;
>                                         wakeup-source;
>                                         linux,code = <152>;
>                                         label = "RLOCK";
>                                         gpios = <&iofpga_gpio0 2 0x4>;
>                                 };
> -                               button at 4 {
> +                               button4 {
>                                         debounce_interval = <50>;
>                                         wakeup-source;
>                                         linux,code = <115>;
>                                         label = "VOL+";
>                                         gpios = <&iofpga_gpio0 3 0x4>;
>                                 };
> -                               button at 5 {
> +                               button5 {
>                                         debounce_interval = <50>;
>                                         wakeup-source;
>                                         linux,code = <114>;
>                                         label = "VOL-";
>                                         gpios = <&iofpga_gpio0 4 0x4>;
>                                 };
> -                               button at 6 {
> +                               button6 {
>                                         debounce_interval = <50>;
>                                         wakeup-source;
>                                         linux,code = <99>;
> @@ -159,7 +159,7 @@
>                                         compatible = "syscon", "simple-mfd";
>                                         reg = <0x010000 0x1000>;
>
> -                                       led at 08.0 {
> +                                       led0 {

In hindsight, we probably should have done "reg = <0x8 0>" for
register and bit offsets.

Is "0" the best description of this led (i.e. is there some h/w defined name)?

>                                                 compatible = "register-bit-led";
>                                                 offset = <0x08>;
>                                                 mask = <0x01>;
