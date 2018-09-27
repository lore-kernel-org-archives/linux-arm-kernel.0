From: robh@kernel.org (Rob Herring)
Date: Thu, 27 Sep 2018 14:10:00 -0500
Subject: [PATCH v3 2/5] dt-bindings: spi: add binding file for NXP
 FlexSPI controller
In-Reply-To: <1537525323-20730-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1537525323-20730-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1537525323-20730-3-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <20180927191000.GA18549@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2018 at 03:52:00PM +0530, Yogesh Gaur wrote:
> Add binding file for NXP FlexSPI controller
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
> Changes for v3:
> - None
> Changes for v2:
> - Incorporated Rob review comments.
> 
>  .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> new file mode 100644
> index 0000000..94b5203
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
> +	         - fspi_base: configuration register address space
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
> +fspi at 0: flexspi at 20c0000 {

Use standard node names.

spi at ...

> +	compatible = "nxp,lx2160a-fspi";
> +	reg = <0x0 0x20c0000 0x0 0x10000>, <0x0 0x20000000 0x0 0x10000000>;
> +	reg-names = "fspi_base", "fspi_mmap";
> +	interrupts = <0 25 0x4>; /* Level high type */
> +	clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +	clock-names = "fspi_en", "fspi";
> +
> +	flash at 0: mt35xu512aba at 0 {

You've got the label and node name reversed. Drop the '@' in the label. 
That should be reserved for node names.

> +		reg = <0>;
> +		....
> +	};
> +
> +	flash at 1: mt35xu512aba at 1 {
> +		reg = <1>;
> +		....
> +	};
> +};
> -- 
> 2.7.4
> 
