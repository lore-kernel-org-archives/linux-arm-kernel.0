From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 Jun 2014 00:08:34 +0200
Subject: [PATCH 2/4] of: Add NVIDIA Tegra XUSB pad controller binding
In-Reply-To: <53909F31.4050603@wwwdotorg.org>
References: <1401894990-30092-1-git-send-email-thierry.reding@gmail.com>
 <1401894990-30092-2-git-send-email-thierry.reding@gmail.com>
 <53909F31.4050603@wwwdotorg.org>
Message-ID: <20140605220833.GA28817@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 05, 2014 at 10:47:45AM -0600, Stephen Warren wrote:
> On 06/04/2014 09:16 AM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > This patch adds the device tree binding documentation for the XUSB pad
> > controller found on NVIDIA Tegra SoCs. It exposes both pinmuxing and PHY
> > capabilities.
> 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
> 
> > +- #phy-cells: Should be 1. The specifier is the index of the PHY to reference.
> > +  Possible values are:
> > +  - 0: PCIe
> > +  - 1: SATA
> 
> Those values are defined in
> include/dt-bindings/pinctrl/pinctrl-tegra-xusb.h. I personally consider
> the <dt-bindings/> header files to be part of the binding itself, rather
> than being derived from the binding. As such, I'd suggest the following
> changes:
> 
> * Make this patch 1 not patch 2
> * Move pinctrl-tegra-xusb.h into this patch.
> * Remove the list of values above, and replace it with the text "See
> <dt-bindings/pinctrl/pinctrl-tegra-xusb.h> for the set of valid values".

I remember discussions where people explicitly said that relying on the
symbolic names in the DT bindings was a mistake because it would mean
that everyone would need to have access to a mechanism similar to what
we have in the Linux kernel (and that the header files would always need
to be shipped with the DT bindings).

> > +Example:
> > +========
> > +
> > +SoC file extract:
> > +-----------------
> > +
> > +	padctl at 0,7009f000 {
> > +		compatible = "nvidia,tegra124-xusb-padctl";
> > +		reg = <0x0 0x7009f000 0x0 0x1000>;
> > +		resets = <&tegra_car 142>;
> > +		reset-names = "padctl";
> > +
> > +		#address-cells = <0>;
> > +		#size-cells = <0>;
> 
> Why are those two properties required? Yes, this node has sub-nodes, but
> those sub-nodes don't have a reg property or unit address. The main
> Tegra pinctrl nodes don't have #address/size-cells.

I seem to remember that there was a reason but I'm pulling a blank. I'll
do some testing with those removed and verify that they are indeed not
needed.

> > +Board file extract:
> > +-------------------
> 
> > +	padctl: padctl at 0,7009f000 {
> > +		pinmux {
> > +			pinctrl-0 = <&padctl_default>;
> > +			pinctrl-names = "default";
> 
> Isn't there one extra level of nodes here. In the DT patches later in
> this series, pinctrl-0/pinctrl-names are directly inside the top-level
> padctl node.

Yes, this is left-over from an earlier version of the patch. Thanks for
catching this.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140606/09c8765f/attachment.sig>
