From: thierry.reding@gmail.com (Thierry Reding)
Date: Sat, 28 Jun 2014 01:44:21 +0200
Subject: [RFC 2/4] ARM: tegra: Add legacy interrupt controller nodes
In-Reply-To: <53ADDAEF.2070805@wwwdotorg.org>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
 <1403888329-24755-2-git-send-email-thierry.reding@gmail.com>
 <53ADDAEF.2070805@wwwdotorg.org>
Message-ID: <20140627234420.GC26184@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 02:58:23PM -0600, Stephen Warren wrote:
> On 06/27/2014 10:58 AM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > Add device tree nodes for the legacy interrupt controller so that the
> > driver can get the register ranges from device tree rather than hard-
> > coding them.
> 
> > diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> 
> > +	interrupt-controller at 60004000 {
> > +		compatible = "nvidia,tegra20-ictlr";
> > +		reg = <0x60004000 0x40   /* primary controller */
> > +		       0x60004100 0x40   /* secondary controller */
> > +		       0x60004200 0x40   /* tertiary controller */
> > +		       0x60004300 0x40   /* quaternary controller */
> > +		       0x60004400 0x40>; /* quinary controller */
> > +	};
> 
> The quinary controller doesn't exist on Tegra20.

Right, I've dropped it.

> > diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> 
> > +	interrupt-controller at 60004000 {
> > +		compatible = "nvidia,tegra20-ictlr";
> 
> At the least, each SoC should have an SoC-specific compatible value in
> addition to the base Tegra20 value in case we need to differentiate them
> in the future.
> 
> I'd be tempted to only include the SoC-specific value and omit the
> Tegra20-specific value so we don't have to care whether they're really
> 100% backwards-compatible, but it's probably safe to say they're all
> Tegra20 compatible (or all Tegra30 compatible given the 4-vs-5
> controllers difference).

I've looked at the register specification files and I can't see any
differences between Tegra20, Tegra30, Tegra114 and Tegra124. Except
for the absence of a quinary controller on Tegra20.

I think I'll go with this:

	tegra114.dtsi: compatible = "nvidia,tegra114-ictlr", "nvidia,tegra30-ictlr";
	tegra124.dtsi: compatible = "nvidia,tegra124-ictlr", "nvidia,tegra30-ictlr";
	tegra20.dtsi: compatible = "nvidia,tegra20-ictlr";
	tegra30.dtsi: compatible = "nvidia,tegra30-ictlr";

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140628/242118ea/attachment.sig>
