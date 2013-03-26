From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 26 Mar 2013 21:16:54 +0100
Subject: [PATCHv6 10/17] arm: mvebu: add PCIe Device Tree informations
 for Armada 370
In-Reply-To: <20130326163421.GA30255@obsidianresearch.com>
References: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364314719-1049-11-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130326163421.GA30255@obsidianresearch.com>
Message-ID: <20130326201654.GA7109@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 10:34:21AM -0600, Jason Gunthorpe wrote:
[...]
> This basically looks fine to me, however, I think it is valuable if
> you and Thierry could use the same method to pass per-port registers. I
> expect others are going to reference these bindings for future work,
> and one standard method is more clear than two.
> 
> Thierry: Did you settle on using assigned-addresses? Can you share the
> final binding for your driver?

Yes, I have the final bindings ready and I was waiting for Andrew's new
version of the ranges parsing patch before sending the next (and
hopefully final) version of the series. He posted that patch now so I
should have something ready soon. For now here's what I currently use
for DT:

	pcie-controller {
		compatible = "nvidia,tegra20-pcie";
		device_type = "pci";
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

		ranges = <0x82000000 0 0x80000000 0x80000000 0 0x00001000   /* port 0 registers */
			  0x82000000 0 0x80001000 0x80001000 0 0x00001000   /* port 1 registers */
			  0x81000000 0 0          0x82000000 0 0x00010000   /* downstream I/O */
			  0x82000000 0 0xa0000000 0xa0000000 0 0x10000000   /* non-prefetchable memory */
			  0xc2000000 0 0xb0000000 0xb0000000 0 0x10000000>; /* prefetchable memory */

		clocks = <&tegra_car 70>, <&tegra_car 72>, <&tegra_car 74>,
			 <&tegra_car 118>;
		clock-names = "pex", "afi", "pcie_xclk", "pll_e";
		status = "disabled";

		pci at 1,0 {
			device_type = "pci";
			assigned-addresses = <0x82000800 0 0x80000000 0 0x1000>;
			reg = <0x000800 0 0 0 0>;
			status = "disabled";

			#address-cells = <3>;
			#size-cells = <2>;

			nvidia,num-lanes = <2>;
		};

		pci at 2,0 {
			device_type = "pci";
			assigned-addresses = <0x82001000 0 0x80001000 0 0x1000>;
			reg = <0x001000 0 0 0 0>;
			status = "disabled";

			#address-cells = <3>;
			#size-cells = <2>;

			nvidia,num-lanes = <2>;
		};
	};

I think that has everything that we discussed previously.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130326/ca9f45b0/attachment.sig>
