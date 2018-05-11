From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 11 May 2018 07:31:45 -0500
Subject: [PATCH] arm64: dts: stratix10: Add QSPI support for Stratix10
In-Reply-To: <1525985204-11525-1-git-send-email-thor.thayer@linux.intel.com>
References: <1525985204-11525-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <CAL_JsqKN0TxFoGjoeXuOb1tJ4GhhC1yHRud3g6-DvZOH_Ago5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2018 at 3:46 PM,  <thor.thayer@linux.intel.com> wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
>
> Add qspi_clock
>    The qspi_clk frequency is updated by U-Boot before starting Linux.
> Add QSPI interface node.
> Add QSPI flash memory child node.
>    Setup the QSPI memory in 2 partitions.
>
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 22 +++++++++++++++
>  .../boot/dts/altera/socfpga_stratix10_socdk.dts    | 31 ++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> index e6b059378dc0..ed47dfce3ba6 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> @@ -119,6 +119,12 @@
>                                 #clock-cells = <0>;
>                                 compatible = "fixed-clock";
>                         };
> +
> +                       qspi_clk: qspi_clk {

s/_/-/

> +                               #clock-cells = <0>;
> +                               compatible = "fixed-clock";
> +                               clock-frequency = <200000000>;
> +                       };
>                 };
>
>                 gmac0: ethernet at ff800000 {
> @@ -466,5 +472,21 @@
>                                 interrupts = <16 4>, <48 4>;
>                         };
>                 };
> +
> +               qspi: spi at ff8d2000 {
> +                       compatible = "cdns,qspi-nor";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0xff8d2000 0x100>,
> +                             <0xff900000 0x100000>;
> +                       interrupts = <0 3 4>;
> +                       cdns,fifo-depth = <128>;
> +                       cdns,fifo-width = <4>;
> +                       cdns,trigger-address = <0x00000000>;
> +                       clocks = <&qspi_clk>;
> +                       bus-num = <1>;
> +
> +                       status = "disabled";
> +               };
>         };
>  };
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> index f9b1ef12db48..60251462067a 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> @@ -147,3 +147,34 @@
>                 reg = <0x68>;
>         };
>  };
> +
> +&qspi {
> +       flash0: n25q00 at 0 {

flash at 0

> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "n25q00aa";
> +               reg = <0>;
> +               spi-max-frequency = <50000000>;
> +
> +               m25p,fast-read;
> +               cdns,page-size = <256>;
> +               cdns,block-size = <16>;
> +               cdns,read-delay = <1>;
> +               cdns,tshsl-ns = <50>;
> +               cdns,tsd2d-ns = <50>;
> +               cdns,tchsh-ns = <4>;
> +               cdns,tslch-ns = <4>;
> +
> +               partition at qspi-boot {

use a 'partitions' node to contain all the partitions.

> +                       label = "Boot and fpga data";
> +                       /* 64MB for boot and FPGA data */
> +                       reg = <0x0 0x4000000>;
> +               };
> +
> +               partition at qspi-rootfs {
> +                       label = "Root Filesystem - JFFS2";
> +                       /* 64MB for Linux jffs2 */
> +                       reg = <0x4000000 0x4000000>;
> +               };
> +       };
> +};
> --
> 2.7.4
>
