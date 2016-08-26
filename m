From: oss@buserror.net (Scott Wood)
Date: Fri, 26 Aug 2016 17:57:14 -0500
Subject: [PATCH 10/10] dt-bindings: sec: Update bindings for LS1012A
In-Reply-To: <1472207269-18499-10-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1472207269-18499-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <1472207269-18499-10-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <1472252234.13245.28.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-08-26 at 15:57 +0530, Bhaskar Upadhaya wrote:
> Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
> ---
> ?.../devicetree/bindings/crypto/fsl-sec5.txt????????| 153
> +++++++++++++++++++++
> ?1 file changed, 153 insertions(+)
> ?create mode 100644 Documentation/devicetree/bindings/crypto/fsl-sec5.txt

Again, the subject should explain what you're adding, not why. ?You're adding
a sec5 binding, not an LS1012A binding.

Why aren't the crypto maintainers/list CCed?

Why do we need a separate binding document for each SEC version? ?What is
different from the sec4 binding or the sec6 binding? ?Especially given that
the example claims compatibility with sec4?

> diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec5.txt
> b/Documentation/devicetree/bindings/crypto/fsl-sec5.txt
> new file mode 100644
> index 0000000..7bcaa6f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/fsl-sec5.txt
> @@ -0,0 +1,153 @@
> +SEC 5 is Freescale's Cryptographic Accelerator and Assurance Module (CAAM).
> +Currently Freescale arm chip LS1012A is embedded with SEC 5.
> +SEC 5 device tree binding include:
> +???-SEC 5 Node
> +???-Job Ring Node
> +???-Full Example
> +
> +=====================================================================
> +SEC 5 Node
> +
> +Description
> +
> +????Node defines the base address of the SEC 5 block.
> +????This block specifies the address range of all global
> +????configuration registers for the SEC 5 block.
> +????For example, In LS1012A, we could see three SEC 5 node.
> +
> +PROPERTIES
> +
> +???- compatible
> +??????Usage: required
> +??????Value type: <string>
> +??????Definition: Must include "fsl,sec-v5.4".

There was no v5.x prior to v5.4?

> +???- fsl,sec-era
> +??????Usage: optional
> +??????Value type: <u32>
> +??????Definition: A standard property. Define the 'ERA' of the SEC
> +??????????device.

This is not "a standard property".

> +???- reg
> +??????Usage: required
> +??????Value type: <prop-encoded-array>
> +??????Definition: A standard property.??Specifies the physical
> +??????????address and length of the SEC 5 configuration registers.

Whether this property expresses the raw physical address depends on the ranges
of the parent node. ?Just say that there's one reg resource which is the SEC
configuration registers.

> +
> +???- ranges
> +???????Usage: required
> +???????Value type: <prop-encoded-array>
> +???????Definition: A standard property.??Specifies the physical address
> +???????????range of the SEC 5.0 register space (-SNVS not included).??A
> +???????????triplet that includes the child address, parent address, &
> +???????????length.

Likewise with the talk about "physical address". ?It's also not required that
it contain such a triplet -- it could theoretically be an empty ranges
property, or there could be multiple translations. ?Bindings shouldn't try to
(poorly) repeat the definition of standard properties. ?They should specify
information that is specific to this binding.

The only thing worth mentioning here about ranges is if the driver will expect
a particular translation independently of whether a child reg is using it.

> +===================================================================
> +Full Example
> +
> +Since some chips may contain more than one SEC, the dtsi contains
> +only the node contents, not the node itself.??A chip using the SEC
> +should include the dtsi inside each SEC node.??Example:

Bindings generally describe what the OS expects to see, not the details of the
dtsi structure.

> +
> +In fsl-ls1012a.dtsi:
> +
> +	compatible = "fsl,sec-v5.4";
> +	fsl,sec-era = <8>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	sec_jr0: jr at 10000 {
> +		compatible = "fsl,sec-v5.4-job-ring",
> +			"fsl,sec-v5.0-job-ring",
> +			"fsl,sec-v4.0-job-ring";
> +			reg = <0x10000 0x10000>;
> +			interrupts = <0 71 0x4>;
> +	};
> +	sec_jr1: jr at 20000 {
> +		compatible = "fsl,sec-v5.4-job-ring",
> +			"fsl,sec-v5.0-job-ring",
> +			"fsl,sec-v4.0-job-ring";
> +			reg = <0x20000 0x10000>;
> +			interrupts = <0 72 0x4>;
> +	};
> +	sec_jr2: jr at 30000 {
> +		compatible = "fsl,sec-v5.4-job-ring",
> +			"fsl,sec-v5.0-job-ring",
> +			"fsl,sec-v4.0-job-ring";
> +			reg = <0x30000 0x10000>;
> +			interrupts = <0 73 0x4>;
> +	};
> +	sec_jr3: jr at 40000 {
> +		compatible = "fsl,sec-v5.4-job-ring",
> +			"fsl,sec-v5.0-job-ring",
> +			"fsl,sec-v4.0-job-ring";
> +			reg = <0x40000 0x10000>;
> +			interrupts = <0 74 0x4>;
> +	};

This is terrible whitespace.

-Scott
