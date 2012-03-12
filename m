From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 12 Mar 2012 15:17:05 +0100
Subject: [PATCH 11/11] ARM: tegra: pcie: Add device tree support
In-Reply-To: <20120312120610.GA14020@sirena.org.uk>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-12-git-send-email-thierry.reding@avionic-design.de>
 <4F59253D.7070100@wwwdotorg.org>
 <20120312120610.GA14020@sirena.org.uk>
Message-ID: <20120312141705.GA16395@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown wrote:
> On Thu, Mar 08, 2012 at 02:31:41PM -0700, Stephen Warren wrote:
> > On 03/08/2012 07:51 AM, Thierry Reding wrote:
> 
> > > +- vdd-supply: power supply for controller (1.05V)
> 
> > Should those *-supply properties really be optional? I got the
> > impression talking to Mark in a different thread that all regulators
> > should exist, although their implementation may be via a fixed
> > regulator, with no GPIO, as determined by the board design.
> 
> Depends on the electronics, if the device can function without a supply
> then it is OK for it to be optional.  This is moderately unusual but not
> unknown.  It's obviously also OK to omit the supply if the system
> doesn't use software regulators at all, though a kernel with regulator
> support enabled would need to use dummy regulators to stub things out.

The PCIe controller actually needs those supplies and won't work without
them. However on TrimSlice both of these supplies seem to be hardwired and
always on. At least that's what I deduce from the code because there is no
code that enables either the 1.05V or the pex-clk supplies.

My understanding of the fixed regulator was that it was meant to be used for
fixed voltage supplies that can still be enabled or disabled (for example as
supplied by a GPIO) but not regulators that are fix in the sense that they
cannot be enabled or disabled at all but are always on.

Then again, the fixed regulator binding says that the gpio property is
optional, so perhaps doing something like the following will work:

	pex_clk_reg: fixedregulator at 0 {
		compatible = "regulator-fixed";
		regulator-name = "PCIE CLK";
		regulator-min-microvolt = <3300000>;
		regulator-max-microvolt = <3300000>;
		regulator-always-on;
	};

	pcie_reg: fixedregulator at 1 {
		compatible = "regulator-fixed";
		regulator-name = "PCIE VDD";
		regulator-min-microvolt = <1050000>;
		regulator-max-microvolt = <1050000>;
		regulator-always-on;
	};

Is that how it is supposed to work?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120312/4da42232/attachment-0001.sig>
