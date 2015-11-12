From: robh@kernel.org (Rob Herring)
Date: Thu, 12 Nov 2015 10:49:48 -0600
Subject: [PATCH 1/3] devicetree: bindings: Document qcom board compatible
 format
In-Reply-To: <1445894712-14350-2-git-send-email-sboyd@codeaurora.org>
References: <1445894712-14350-1-git-send-email-sboyd@codeaurora.org>
 <1445894712-14350-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20151112164948.GA24938@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 02:25:10PM -0700, Stephen Boyd wrote:
> Some qcom based bootloaders identify the dtb blob based on a set
> of device properties like SoC, platform, PMIC, and revisions of
> those components. In downstream kernels, these values are added
> to the different component dtsi files (i.e. pmic dtsi file, SoC
> dtsi file, board dtsi file, etc.) via qcom specific DT
> properties. The dtb files are parsed by a program called dtbTool
> that picks out these properties and creates a table of contents
> binary blob with the property information and some offsets into
> the concatenation of all the dtbs (termed a QCDT image).

Got a pointer to what these properties look like?

> The suggestion is to do this via the board compatible string
> instead, because these qcom specific properties are never used by
> the kernel. Add a document describing the format of the
> compatible string that encodes all this information that's
> currently encoded in the qcom,{msm-id,board-id,pmic-id}
> properties in downstream devicetrees. Future bootloaders may be
> updated to look at the compatible field instead of looking for
> the table of contents image. For non-updateable bootloaders, a
> new dtbTool program will parse the compatible string and generate
> a QCDT image from it.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.txt | 86 ++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/qcom.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.txt b/Documentation/devicetree/bindings/arm/qcom.txt
> new file mode 100644
> index 000000000000..ed084367182d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/qcom.txt
> @@ -0,0 +1,86 @@
> +QCOM device tree bindings
> +-------------------------
> +
> +Some qcom based bootloaders identify the dtb blob based on a set of
> +device properties like SoC, platform, PMIC, and revisions of those components.
> +To support this scheme, we encode this information into the board compatible
> +string.

Why does all this need to be a single property?

> +Each board must specify a top-level board compatible string with the following
> +format:
> +
> +	compatible = "qcom,<SoC>(-<soc_version>)(-<foundry_id>)-<plat_type>(/<subtype>)(-<plat_version>)(-<mb>MB)(-<panel>-panel)(-boot-<boot>)(-<pmic>(-v<pmic_version>)){0-4}"
> +
> +where elements in parentheses "()" are optional and elements in brackets "<>"

[] brackets are more generally used for optional params.

> +are names of elements. Meaning only the 'SoC' and 'plat_type' elements are
> +required.
> +
> +The 'SoC' element must be one of the following strings:
> +
> +	apq8016
> +	apq8074
> +	apq8084
> +	apq8096
> +	msm8916
> +	msm8974
> +	msm8996
> +
> +The 'plat_type' element must be one of the following strings:
> +
> +	cdp
> +	liquid
> +	dragonboard
> +	mtp sbc

Platform is pretty overloaded meaning. Perhaps board_type would be more 
clear.

> +
> +The 'soc_version', 'plat_version' and 'pmic_version' elements take the form of
> +v<Major>.<Minor> where the minor number may be omitted when it's zero, i.e.
> +v1.0 is the same as v1. If all versions of the 'plat_version' element's match,
> +then a wildcard '*' should be used, e.g. 'v*'.
> +
> +The 'foundry_id', 'subtype', and 'mb' elements are one or more digits from 0
> +to 9.

Can you define what these are exactly. I gather mb is RAM size.

> +
> +The 'panel' element must be one of the following strings:
> +
> +	720p
> +	fWVGA
> +	hd
> +	qHD

How is this used?


> +The 'boot' element must be one of the following strings:
> +
> +	emmc_sdc1
> +	ufs
> +
> +The 'pmic' element must be one of the following strings:
> +
> +	pm8841
> +	pm8019
> +	pm8110
> +	pma8084
> +	pmi8962
> +	pmd9635
> +	pm8994
> +	pmi8994
> +	pm8916
> +	pm8004
> +	pm8909
> +
> +The 'pmic' element is specified in order of ascending USID. The PMIC in USID0
> +goes first, and then USID2, USID4, and finally USID6. Up to four PMICs may be
> +specified and no holes in the USID number space are allowed.

What is USID?

> +
> +Examples:
> +
> +	"qcom,msm8916-v1-cdp-pm8916-v2.1"
> +
> +A CDP board with an msm8916 SoC, version 1 paired with a pm8916 PMIC of version
> +2.1.
> +
> +	"qcom,apq8074-v2.0-2-dragonboard/1-v0.1-512MB-panel-qHD-boot-emmc_sdc1-pm8941-v0.2-pm8909-v2.2-pma8084-v3-pm8110-v1"

Which example is more common?

> +
> +A dragonboard board v0.1 of subtype 1 with an apq8074 SoC version 2, made in
> +foundry 2 with 512MB of memory and a qHD panel booting from emmc_sdc1, paired
> +with a pm8941 PMIC version 0.2 at USID0, pm8909 PMIC version 2.2 at USID2,
> +pma8084 version 3 at USID4 and a pm8110 version 1 at USID6.
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
