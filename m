From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 11 Jan 2013 05:34:37 +0100
Subject: [PATCH 12/14] ARM: tegra: tec: Add PCIe support
In-Reply-To: <50EF5B46.8010806@wwwdotorg.org>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-13-git-send-email-thierry.reding@avionic-design.de>
 <50EF5B46.8010806@wwwdotorg.org>
Message-ID: <20130111043437.GF28094@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 05:22:30PM -0700, Stephen Warren wrote:
> On 01/09/2013 01:43 PM, Thierry Reding wrote:
> > Enable the first PCIe root port which is connected to an FPGA on the
> > Tamonten Evaluation Carrier and add device nodes for each of the PCI
> > endpoints available in the standard configuration.
> 
> > diff --git a/arch/arm/boot/dts/tegra20-tec.dts b/arch/arm/boot/dts/tegra20-tec.dts
> 
> > +	pcie-controller {
> > +		vdd-supply = <&pci_vdd_reg>;
> > +		pex-clk-supply = <&pci_clk_reg>;
> > +		status = "okay";
> 
> Sorry this is also really picky. I'd prefer properties that exist in
> /include/d files and are overidden here to appear first, followed by new
> properties. In other words, move the status property to be first. I
> believe/hope all the other (Tegra) .dts files follow this convention.

Okay, I'll fix that.

> > +		pci at 1,0 {
> > +			bus-range = <0x01 0x0a>;
> > +			status = "okay";
> > +
> > +			pci at 0,0 {
> > +				reg = <0x010000 0 0 0 0>;
> 
> Hmm. The unit address in that node name doesn't match the address in the
> reg property, although I suppose there's nothing we can do about it
> since those formats are both defined by the standard PCI binding?

That's the standard encoding for unit addresses for PCI devices. The
first cell in the reg property encodes bus/device/function (amongst
other things) and the node name is supposed to be pci@<dev>,<fn>.

> What do the numbers "0,0" represent here; device/function? Is the same
> true for the "0,0" in the child nodes?

Yes, exactly.

> > +				bus-range = <0x02 0x0a>;
> > +
> > +				compatible = "plda,pcie";
> 
> Are there DT binding documents for all these devices; plda,pcie,
> ad,pcie, ad,pcie-test, etc.?

No. To be honest I don't quite know how to handle this. For the PLDA
things aren't so bad since it has a proper PCI ID, but the other cores
don't since they are custom IP or taken from opencores.org and made
available via PCIe. We're still in the process of obtaining our own PCI
vendor ID so that these can be properly assigned.

Also, as you have guessed, most of these are not required. I just wanted
to include them here for completeness (and maybe reference in case
somebody else, myself included, needs a working example to base other
work on).

> > +				pci at 4,0 {
> > +					reg = <0x022000 0 0 0 0>;
> > +					bus-range = <0x07 0x07>;
> > +
> > +					compatible = "ad,pcie";
> > +					device_type = "pci";
> > +
> > +					#address-cells = <3>;
> > +					#size-cells = <2>;
> > +
> > +					pci at 0,0 {
> > +						compatible = "opencores,uart";
> > +						reg = <0x070000 0 0 0 0>;
> > +					};
> > +				};
> 
> Do you need to include a node for the UART; I can see you need to for
> the SPI/I2C controllers so you can instantiate the appropriate devices
> on non-probe-able buses, but I think you can just let regular PCI device
> probing find the UART, Ethernet MAC, etc., can't you?

Yes, that's correct. Only SPI and I2C actually require these nodes. I'm
not sure if the PCI binding requires all nodes to be present or not.
Other examples I've seen (e.g. arch/x86/platform/ce4100/falconfalls.dts)
contain nodes for everything, most of which don't seem to be necessary
for things to work.

One other thing that I've seen is the usage of the more standard pci*
values for the compatible property. None of them are very descriptive
which is why I used a vendor,device type of value instead.

Going over the PCI binding again, however, it looks like there's no
requirement to make the node name pci at dev,fn and pci can be anything.
Making it uart at 0,0 and then adjusting the compatible value to be as the
binding requires could be an option. In that case I suppose even the
bindings documentation shouldn't be necessary.

That doesn't cover the nodes where non-standard properties are needed
(I2C and SPI), which do need binding documents. I wouldn't know how to
name them, though. I'm not sure going with the current convention would
be any good since it'll be hard to find the right document if you have
to look it up by matching vendor and device IDs or PCI class.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130111/ee11ef4f/attachment-0001.sig>
