From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 12 Mar 2013 21:38:19 +0100
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130312155749.GA1820@obsidianresearch.com>
References: <20130309013152.GA3883@obsidianresearch.com>
 <513C117D.6080800@firmworks.com>
 <20130310065539.GA14704@obsidianresearch.com>
 <513D6F9C.9000100@firmworks.com>
 <20130311181554.GA10992@obsidianresearch.com>
 <513E519B.6010503@firmworks.com>
 <20130311232516.GA13873@obsidianresearch.com>
 <513E6AFE.3090304@firmworks.com>
 <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
 <20130312155749.GA1820@obsidianresearch.com>
Message-ID: <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 09:57:49AM -0600, Jason Gunthorpe wrote:
> On Tue, Mar 12, 2013 at 08:08:52AM +0100, Thierry Reding wrote:
> 
> > So to recapitulate, we agree that configuration space can be translated
> > through the "ranges" property. That means the only missing link is a new
> > function to translate not only "assigned-addresses" but also the "reg"
> > property for PCI devices. Is that it?
> 
> No, the first conclusion is that placing a config space in ranges is
> against the language in the current spec (see section 12).
> 
> The second conclusion is that there is probably a way forward to
> update the spec in a backwards compatible way to model ECAM, but would
> require more analysis.
> 
> Finally, there was no objections to the approach in Thomas's patch,
> other than the note to fix the '@1,0' and the extra device_type="pci"

That's not what I deduced from Mitch's comments. He said explicitly that
he liked the idea to represent mapped configuration space using the
ranges property. Mitch, correct me if I misinterpret what you said.

I've also verified that things actually do work with the binding that I
proposed for Tegra, even if I add device_type = "pci" to the root port
nodes. The reason is that the OF core looks up the type of the *parent*
node to find a matching bus. This happens to be the pcie-controller node
which is not a PCI device and therefore the address translation works
properly.

So let me quote the latest binding that I'm using:

	pcie-controller {
		compatible = "nvidia,tegra20-pcie";
		reg = <0x80003000 0x00000800   /* PADS registers */
		       0x80003800 0x00000200   /* AFI registers */
		       0x90000000 0x10000000>; /* configuration space */
		reg-names = "pads", "afi", "cs";
		interrupts = <0 98 0x04   /* controller interrupt */
		              0 99 0x04>; /* MSI interrupt */
		interrupt-names = "intr", "msi";

		bus-range = <0x00 0xff>;
		#address-cells = <3>;
		#size-cells = <2>;

		ranges = <0x00000800 0 0 0x80000000 0 0x00001000   /* port 0 configuration space */
			  0x00001000 0 0 0x80001000 0 0x00001000   /* port 1 configuration space */
			  0x81000000 0 0 0x82000000 0 0x00010000   /* downstream I/O */
			  0x82000000 0 0 0xa0000000 0 0x10000000   /* non-prefetchable memory */
			  0xc2000000 0 0 0xb0000000 0 0x10000000>; /* prefetchable memory */

		clocks = <&tegra_car 70>, <&tegra_car 72>, <&tegra_car 74>,
			 <&tegra_car 118>;
		clock-names = "pex", "afi", "pcie_xclk", "pll_e";
		status = "disabled";

		pci at 1,0 {
			device_type = "pci";
			reg = <0x000800 0 0 0 0x1000>;
			status = "disabled";

			#address-cells = <3>;
			#size-cells = <2>;

			nvidia,num-lanes = <2>;
		};

		pci at 2,0 {
			device_type = "pci";
			reg = <0x001000 0 0 0 0x1000>;
			status = "disabled";

			#address-cells = <3>;
			#size-cells = <2>;

			nvidia,num-lanes = <2>;
		};
	};

I can't find anything wrong in the above. As far as I can tell, there's
nothing in it that's in conflict with the specification.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130312/c5981d10/attachment.sig>
