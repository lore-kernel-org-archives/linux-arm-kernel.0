From: robh@kernel.org (Rob Herring)
Date: Sun, 22 Nov 2015 14:49:35 -0600
Subject: [PATCH v2 1/5] devicetree: bindings: Document qcom board
 compatible format
In-Reply-To: <1448062280-15406-2-git-send-email-sboyd@codeaurora.org>
References: <1448062280-15406-1-git-send-email-sboyd@codeaurora.org>
 <1448062280-15406-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20151122204935.GA465@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 03:31:16PM -0800, Stephen Boyd wrote:
> Some qcom based bootloaders identify the dtb blob based on a set
> of device properties like SoC, platform, PMIC, and revisions of
> those components. In downstream kernels, these values are added
> to the different component dtsi files (i.e. pmic dtsi file, SoC
> dtsi file, board dtsi file, etc.) via qcom specific DT
> properties. The dtb files are parsed by a program called dtbTool
> that picks out these properties and creates a table of contents
> binary blob with the property information and some offsets into
> the concatenation of all the dtbs (termed a QCDT image).
> 
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

Much more reasonable now. I do find the '/' in it a bit strange though.

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/arm/qcom.txt | 51 ++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/qcom.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.txt b/Documentation/devicetree/bindings/arm/qcom.txt
> new file mode 100644
> index 000000000000..3e24518c6678
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/qcom.txt
> @@ -0,0 +1,51 @@
> +QCOM device tree bindings
> +-------------------------
> +
> +Some qcom based bootloaders identify the dtb blob based on a set of
> +device properties like SoC and platform and revisions of those components.
> +To support this scheme, we encode this information into the board compatible
> +string.
> +
> +Each board must specify a top-level board compatible string with the following
> +format:
> +
> +	compatible = "qcom,<SoC>[-<soc_version>][-<foundry_id>]-<board>[/<subtype>][-<board_version>]"
> +
> +The 'SoC' and 'board' elements are required. All other elements are optional.
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
> +The 'board' element must be one of the following strings:
> +
> +	cdp
> +	liquid
> +	dragonboard
> +	mtp
> +	sbc
> +
> +The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
> +where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
> +as v1. If all versions of the 'board_version' elements match, then a
> +wildcard '*' should be used, e.g. 'v*'.
> +
> +The 'foundry_id' and 'subtype' elements are one or more digits from 0 to 9.
> +
> +Examples:
> +
> +	"qcom,msm8916-v1-cdp-pm8916-v2.1"
> +
> +A CDP board with an msm8916 SoC, version 1 paired with a pm8916 PMIC of version
> +2.1.
> +
> +	"qcom,apq8074-v2.0-2-dragonboard/1-v0.1"
> +
> +A dragonboard board v0.1 of subtype 1 with an apq8074 SoC version 2, made in
> +foundry 2.
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
