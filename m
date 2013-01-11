From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 11 Jan 2013 19:48:19 +0100
Subject: [PATCH 14/14] ARM: tegra: trimslice: Initialize PCIe from DT
In-Reply-To: <50EF5537.6080602@wwwdotorg.org>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-15-git-send-email-thierry.reding@avionic-design.de>
 <50EF5537.6080602@wwwdotorg.org>
Message-ID: <20130111184819.GA18717@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 04:56:39PM -0700, Stephen Warren wrote:
> On 01/09/2013 01:43 PM, Thierry Reding wrote:
> > With the device tree support in place, probe the PCIe controller from
> > the device tree and remove the corresponding workaround in the board
> > file.
> 
> Thierry, there are a couple things missing from this patch; I include a
> fixup for you to squash in, but also see beyond that for a problem.
> 
> >  arch/arm/boot/dts/tegra20-trimslice.dts |   26 +++++++++++++++++++++-----
> >  1 file changed, 21 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
> > index ebb4c17..41fc45b 100644
> > --- a/arch/arm/boot/dts/tegra20-trimslice.dts
> > +++ b/arch/arm/boot/dts/tegra20-trimslice.dts
> > @@ -303,12 +303,10 @@
> >  
> >  	pcie-controller {
> >  		status = "okay";
> > +		pex-clk-supply = <&pci_clk_reg>;
> > +		vdd-supply = <&pci_vdd_reg>;
> >  
> > -		pci at 0 {
> > -			status = "okay";
> > -		};
> > -
> > -		pci at 1 {
> > +		pci at 1,0 {
> >  			status = "okay";
> >  		};
> >  	};
> > @@ -366,6 +364,24 @@
> >  			regulator-max-microvolt = <1800000>;
> >  			regulator-always-on;
> >  		};
> > +
> > +		pci_clk_reg: regulator at 2 {
> > +			compatible = "regulator-fixed";
> > +			reg = <2>;
> > +			regulator-name = "pci_clk";
> > +			regulator-min-microvolt = <3300000>;
> > +			regulator-max-microvolt = <3300000>;
> > +			regulator-always-on;
> > +		};
> > +
> > +		pci_vdd_reg: regulator at 3 {
> > +			compatible = "regulator-fixed";
> > +			reg = <3>;
> > +			regulator-name = "pci_vdd";
> > +			regulator-min-microvolt = <1050000>;
> > +			regulator-max-microvolt = <1050000>;
> > +			regulator-always-on;
> > +		};
> >  	};
> >  
> >  	sound {
> > -- 
> > 1.7.10.4
> 
> However, PCIe still doesn't work on TrimSlice; the device enumeration
> fails. The log is below:
> 
> > [    0.790425] tegra-pcie 80003000.pcie-controller: link 0 down, retrying
> > [    0.801351] tegra-pcie 80003000.pcie-controller: PCI host bridge to bus 0000:00
> > [    0.808945] pci_bus 0000:00: root bus resource [io  0x82000000-0x8200ffff]
> > [    0.816109] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xafffffff]
> > [    0.823303] pci_bus 0000:00: root bus resource [mem 0xb0000000-0xbfffffff pref]
> > [    0.830893] pci_bus 0000:00: root bus resource [bus 00-ff]
> > [    0.836728] pci 0000:00:01.0: [10de:0bf0] type 01 class 0x060000
> > [    0.843097] pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> > [    0.850047] PCI: bus0: Fast back to back transfers disabled
> > [    0.855853] pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > [    0.864308] tegra-pcie 80003000.pcie-controller: AXI response decoding error, signature: 10010001
> > [    0.873489] tegra-pcie 80003000.pcie-controller:   FPCI address: fe10010000
> 
> ^^^ For some reason, the config register access fails.
> 
> > [    0.880760] PCI: bus1: Fast back to back transfers enabled
> > [    0.886482] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> > [    0.893381] pci 0000:00:01.0: PCI bridge to [bus 01]
> > [    0.898577] PCI: enabling device 0000:00:01.0 (0140 -> 0143)
> > [    0.904535] pci 0000:00:01.0: nv_msi_ht_cap_quirk didn't locate host bridge
> 
> With plain next-20130109, the device enumeration succeeds.

That's very strange. I haven't seen that on my setup. Looks like I need
to dig out the TrimSlice again and debug this. It'll take me a while and
there are plenty of other requested changes already, so if I find a fix
I can roll it into the next version.

Thanks for testing,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130111/ab94f169/attachment-0001.sig>
