From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Aug 2015 22:38:54 -0600
Subject: [PATCH 1/7] drm/vc4: Add devicetree bindings for VC4.
In-Reply-To: <1439427380-2436-2-git-send-email-eric@anholt.net>
References: <1439427380-2436-1-git-send-email-eric@anholt.net>
 <1439427380-2436-2-git-send-email-eric@anholt.net>
Message-ID: <55CEC25E.7070303@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2015 06:56 PM, Eric Anholt wrote:
> Signed-off-by: Eric Anholt <eric@anholt.net>

This one definitely needs a patch description, since someone might not
know what a VC4 is, and "git log" won't show the text from the binding
doc itself. I'd suggest adding the initial paragraph of the binding doc
as the patch description, or more.

> diff --git a/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt b/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt

> +Required properties for VC4:
> +- compatible:	Should be "brcm,vc4"
> +- crtcs:	List of references to pixelvalve scanout engines

s/references to/phandles of/ would be more typical DT language.

> +- hvss:		List of references to HVS video scalers
> +- encoders:	List of references to output encoders (HDMI, SDTV)

Would it make sense to make all those nodes child node of the vc4
object. That way, there's no need to have these lists of objects; they
can be automatically built up as the DT is enumerated. I know that e.g.
the NVIDIA Tegra host1x binding works this way, and I think it may have
been inspired by other similar cases.

Of course, this is only appropriate if the HW modules really are
logically children of the VC4 HW module. Perhaps they aren't. If they
aren't though, I wonder what this "vc4" module actually represents in HW?

> +Required properties for HDMI
> +- compatible:	Should be "brcm,vc4-hdmi"
> +- reg:		Physical base address and length of the two register ranges
> +		  ("HDMI" and "HD")

I'd add "in that order" right before ")".

> +Example:
> +/ {
> +	soc {

Minor nit: Examples often don't include any nodes "above" the nodes
whose bindings are being documented.
