From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 12 Jun 2012 07:48:11 +0200
Subject: [PATCH v2 09/10] ARM: tegra: harmony: Initialize PCIe from DT
In-Reply-To: <4FD6661A.1060407@wwwdotorg.org>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-10-git-send-email-thierry.reding@avionic-design.de>
 <4FD6661A.1060407@wwwdotorg.org>
Message-ID: <20120612054811.GB4040@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> On 06/11/2012 09:05 AM, Thierry Reding wrote:
> > With the device tree support in place, probe the PCIe controller from
> > the device tree and remove the corresponding workaround in the board
> > file.
> 
> > diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
> 
> > +	pci_vdd_reg: fixedregulator at 0 {
> 
> I think that'd usually just be "regulator at 0".
> 
> If you need the "@0" part to differentiate between multiple regulators,
> the node needs a reg property too:
> 
> 	reg = <0 0>;
> 
> although then I wonder about putting the regulator under the root node,
> since the address wouldn't really make sense...

Perhaps we should add a new "regulators" node under the root node to collect
this kind of regulators that don't fit anywhere else. Looking at the code,
something like this should work:

	/ {
		...

		regulators {
			compatible = "simple-bus";
			#address-cells = <1>;
			#size-cells = <0>;

			pci_vdd_reg: regulator at 0 {
				reg = <0>;
			};
		};
	};

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120612/4b13eac2/attachment.sig>
