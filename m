From: robh@kernel.org (Rob Herring)
Date: Mon, 3 Sep 2018 20:33:25 -0500
Subject: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexSPI
 driver
In-Reply-To: <1535711404-29528-5-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1535711404-29528-5-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <5b8e8a7b.1c69fb81.f713b.79ea@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 04:00:01PM +0530, Yogesh Gaur wrote:
> Add binding file for NXP FlexSPI driver.

Bindings are for h/w, not drivers.

> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
>  .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> new file mode 100644
> index 0000000..9f07116
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> @@ -0,0 +1,42 @@
> +* NXP Flex Serial Peripheral Interface (FSPI)
> +
> +Required properties:
> +  - compatible : Should be "nxp,lx2160a-fspi"
> +  - reg :        First contains the register location and length,
> +                 Second contains the memory mapping address and length
> +  - reg-names :  Should contain the resource reg names:
> +                 - fspi_base: iconfiguration register address space
> +                 - fspi_mmap: memory mapped address space
> +  - interrupts : Should contain the interrupt for the device
> +
> +Optional properties:
> +  - big-endian : See common-properties.txt.
> +
> +Required SPI slave node properties:
> +  - reg :        There are two buses (A and B) with two chip selects each.
> +                 This encodes to which bus and CS the flash is connected:
> +                 - <0>: Bus A, CS 0
> +                 - <1>: Bus A, CS 1
> +                 - <2>: Bus B, CS 0
> +                 - <3>: Bus B, CS 1
> +
> +Example showing the usage of two SPI NOR slave devices on bus A:
> +
> +fspi0: flexspi at 20c0000 {

spi at ...

> +	compatible = "nxp,lx2160a-fspi";
> +	reg = <0x0 0x20c0000 0x0 0x10000>, <0x0 0x20000000 0x0 0x10000000>;
> +	reg-names = "fspi_base", "fspi_mmap";
> +	interrupts = <0 25 0x4>; /* Level high type */
> +	clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +	clock-names = "fspi_en", "fspi";
> +
> +	flash0: mt35xu512aba at 0 {

flash at 0

> +		reg = <0>;
> +		....
> +	};
> +
> +	flash1: mt35xu512aba at 1 {

flash at 1

Make sure to fix the dts patch too.

> +		reg = <1>;
> +		....
> +	};
> +};
> -- 
> 2.7.4
> 
