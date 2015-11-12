From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 12 Nov 2015 11:44:08 -0800
Subject: [PATCH 1/3] devicetree: bindings: Document qcom board compatible
 format
In-Reply-To: <20151112164948.GA24938@rob-hp-laptop>
References: <1445894712-14350-1-git-send-email-sboyd@codeaurora.org>
 <1445894712-14350-2-git-send-email-sboyd@codeaurora.org>
 <20151112164948.GA24938@rob-hp-laptop>
Message-ID: <20151112194408.GC15032@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12, Rob Herring wrote:
> On Mon, Oct 26, 2015 at 02:25:10PM -0700, Stephen Boyd wrote:
> > Some qcom based bootloaders identify the dtb blob based on a set
> > of device properties like SoC, platform, PMIC, and revisions of
> > those components. In downstream kernels, these values are added
> > to the different component dtsi files (i.e. pmic dtsi file, SoC
> > dtsi file, board dtsi file, etc.) via qcom specific DT
> > properties. The dtb files are parsed by a program called dtbTool
> > that picks out these properties and creates a table of contents
> > binary blob with the property information and some offsets into
> > the concatenation of all the dtbs (termed a QCDT image).
> 
> Got a pointer to what these properties look like?

Do you mean the blob header format? You can see that described
in a text document next to the C file for dtbtool[1].

> 
> > The suggestion is to do this via the board compatible string
> > instead, because these qcom specific properties are never used by
> > the kernel. Add a document describing the format of the
> > compatible string that encodes all this information that's
> > currently encoded in the qcom,{msm-id,board-id,pmic-id}
> > properties in downstream devicetrees. Future bootloaders may be
> > updated to look at the compatible field instead of looking for
> > the table of contents image. For non-updateable bootloaders, a
> > new dtbTool program will parse the compatible string and generate
> > a QCDT image from it.
> > 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  Documentation/devicetree/bindings/arm/qcom.txt | 86 ++++++++++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/qcom.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/qcom.txt b/Documentation/devicetree/bindings/arm/qcom.txt
> > new file mode 100644
> > index 000000000000..ed084367182d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/qcom.txt
> > @@ -0,0 +1,86 @@
> > +QCOM device tree bindings
> > +-------------------------
> > +
> > +Some qcom based bootloaders identify the dtb blob based on a set of
> > +device properties like SoC, platform, PMIC, and revisions of those components.
> > +To support this scheme, we encode this information into the board compatible
> > +string.
> 
> Why does all this need to be a single property?

Because the different vendor properties were rejected by arm-soc
maintainers and the board compatible string was suggested as the
place to put such information.

> 
> > +Each board must specify a top-level board compatible string with the following
> > +format:
> > +
> > +	compatible = "qcom,<SoC>(-<soc_version>)(-<foundry_id>)-<plat_type>(/<subtype>)(-<plat_version>)(-<mb>MB)(-<panel>-panel)(-boot-<boot>)(-<pmic>(-v<pmic_version>)){0-4}"
> > +
> > +where elements in parentheses "()" are optional and elements in brackets "<>"
> 
> [] brackets are more generally used for optional params.

Ok. I can make that change.

> 
> > +are names of elements. Meaning only the 'SoC' and 'plat_type' elements are
> > +required.
> > +
> > +The 'SoC' element must be one of the following strings:
> > +
> > +	apq8016
> > +	apq8074
> > +	apq8084
> > +	apq8096
> > +	msm8916
> > +	msm8974
> > +	msm8996
> > +
> > +The 'plat_type' element must be one of the following strings:
> > +
> > +	cdp
> > +	liquid
> > +	dragonboard
> > +	mtp sbc
> 
> Platform is pretty overloaded meaning. Perhaps board_type would be more 
> clear.

Ok.

> 
> > +
> > +The 'soc_version', 'plat_version' and 'pmic_version' elements take the form of
> > +v<Major>.<Minor> where the minor number may be omitted when it's zero, i.e.
> > +v1.0 is the same as v1. If all versions of the 'plat_version' element's match,
> > +then a wildcard '*' should be used, e.g. 'v*'.
> > +
> > +The 'foundry_id', 'subtype', and 'mb' elements are one or more digits from 0
> > +to 9.
> 
> Can you define what these are exactly. I gather mb is RAM size.

Not really, foundry_id is a number and so is subtype.

> 
> > +
> > +The 'panel' element must be one of the following strings:
> > +
> > +	720p
> > +	fWVGA
> > +	hd
> > +	qHD
> 
> How is this used?

I believe this was added so that we could have different dtbs for
devices that have different panels on them. I'm not sure this is
still used though. It could be legacy.

> 
> 
> > +The 'boot' element must be one of the following strings:
> > +
> > +	emmc_sdc1
> > +	ufs
> > +
> > +The 'pmic' element must be one of the following strings:
> > +
> > +	pm8841
> > +	pm8019
> > +	pm8110
> > +	pma8084
> > +	pmi8962
> > +	pmd9635
> > +	pm8994
> > +	pmi8994
> > +	pm8916
> > +	pm8004
> > +	pm8909
> > +
> > +The 'pmic' element is specified in order of ascending USID. The PMIC in USID0
> > +goes first, and then USID2, USID4, and finally USID6. Up to four PMICs may be
> > +specified and no holes in the USID number space are allowed.
> 
> What is USID?

USID is Unique Slave IDentifier. It's an SPMI concept.

> 
> > +
> > +Examples:
> > +
> > +	"qcom,msm8916-v1-cdp-pm8916-v2.1"
> > +
> > +A CDP board with an msm8916 SoC, version 1 paired with a pm8916 PMIC of version
> > +2.1.
> > +
> > +	"qcom,apq8074-v2.0-2-dragonboard/1-v0.1-512MB-panel-qHD-boot-emmc_sdc1-pm8941-v0.2-pm8909-v2.2-pma8084-v3-pm8110-v1"
> 
> Which example is more common?
> 

The former. I tried to make up the worst case example so we could
see how large the string may become.

[1] https://www.codeaurora.org/cgit/quic/la/device/qcom/common/tree/dtbtool/dtbtool.txt?h=LA.BF64.1.2.1.c1_rb1.30

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
