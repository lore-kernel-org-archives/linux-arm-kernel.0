From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 15 Aug 2014 11:46:06 +0100
Subject: [PATCH 1/6] Documentation: DT: Add bindings for FSL NS16550A UART
In-Reply-To: <1408096156-29772-2-git-send-email-bhupesh.sharma@freescale.com>
References: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
 <1408096156-29772-2-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <20140815104606.GB15621@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 15, 2014 at 10:49:10AM +0100, Bhupesh Sharma wrote:
> This patch addss the device-tree documentation for Freescale's
> NS16550 UART (also called DUART).
> 
> There is a specific errata fix required in FSL NS16550 UART
> which ensures that an random interrupt storm is not observed when
> a break is provided as an input to the UART.

Should this not go in
Documentation/devicetree/bindings/serial/of-serial.txt as with other
NS16550A variations?

The only code for handling this string seems to live in
arch/powerpc/kernel/legacy_serial.c. Is there a patch factoring that out
into common code? Or is the erratum not applicable to the revision used
in your ARMv8 SoC?

Thanks,
Mark.

> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> ---
>  .../devicetree/bindings/serial/fsl-ns16550.txt     |   24 ++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/fsl-ns16550.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-ns16550.txt b/Documentation/devicetree/bindings/serial/fsl-ns16550.txt
> new file mode 100644
> index 0000000..9926e10
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/fsl-ns16550.txt
> @@ -0,0 +1,24 @@
> +* Freescale DUART is very similar to the PC16552D (and to a
> +  pair of NS16550A), albeit with some nonstandard behavior such as
> +  erratum A-004737 (relating to incorrect BRK handling).
> +
> +- compatible: "fsl,ns16550"
> +
> +  Represents a single port that is compatible with the DUART found
> +  on many Freescale chips (examples include mpc8349, mpc8548,
> +  mpc8641d, p4080 and ls2085a).
> +
> +- reg: The base address of the UART register bank.
> +
> +- interrupts: A single interrupt specifier.
> +
> +- clock-frequency = Input clock to the baud rate divider.
> +
> +Example:
> +	serial1: serial at 21c4600 {
> +		compatible = "fsl,ns16550", "ns16550a";
> +		reg = <0x0 0x21c4600 0x0 0x100>;
> +		clock-frequency = <0>;
> +		interrupts = <0 32 0x1>;
> +	};
> +
> -- 
> 1.7.9.5
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
