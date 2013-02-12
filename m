From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 12 Feb 2013 15:35:11 -0700
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130212223511.GB31555@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 05:28:58PM +0100, Thomas Petazzoni wrote:
> +++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
[..]
> +pcie-controller {
> +	compatible = "marvell,armada-370-xp-pcie";
> +	status = "disabled";
> +
> +	#address-cells = <3>;
> +	#size-cells = <2>;
> +
> +	bus-range = <0x00 0xff>;
> +
> +	ranges = <0x00000800 0 0xd0040000 0xd0040000 0 0x00002000   /* port 0.0 registers */
> +	          0x00004800 0 0xd0042000 0xd0042000 0 0x00002000   /* port 2.0 registers */
> +	          0x00001000 0 0xd0044000 0xd0044000 0 0x00002000   /* port 0.1 registers */
> +	          0x00001800 0 0xd0048000 0xd0048000 0 0x00002000   /* port 0.2 registers */
> +	          0x00002000 0 0xd004C000 0xd004C000 0 0x00002000   /* port 0.3 registers */
> +		  0x00002800 0 0xd0080000 0xd0080000 0 0x00002000   /* port 1.0 registers */
> +	          0x00005000 0 0xd0082000 0xd0082000 0 0x00002000   /* port 3.0 registers */
> +		  0x00003000 0 0xd0084000 0xd0084000 0 0x00002000   /* port 1.1 registers */
> +		  0x00003800 0 0xd0088000 0xd0088000 0 0x00002000   /* port 1.2 registers */
> +		  0x00004000 0 0xd008C000 0xd008C000 0 0x00002000   /* port 1.3 registers */
> +		  0x81000000 0 0	  0xc0000000 0 0x00100000   /* downstream I/O */
> +		  0x82000000 0 0	  0xc1000000 0 0x08000000>; /* non-prefetchable memory */
> +
> +	#interrupt-cells = <1>;
> +	interrupt-map-mask = <0xf800 0 0 1>;
> +	interrupt-map = <0x0800 0 0 1 &mpic 58
> +		         0x1000 0 0 1 &mpic 59
> +			 0x1800 0 0 1 &mpic 60
> +			 0x2000 0 0 1 &mpic 61
> +			 0x2800 0 0 1 &mpic 62
> +		         0x3000 0 0 1 &mpic 63
> +			 0x3800 0 0 1 &mpic 64
> +			 0x4000 0 0 1 &mpic 65
> +			 0x4800 0 0 1 &mpic 99
> +			 0x5000 0 0 1 &mpic 103>;

This is out of date now?

> +	pcie at 0,0 {
> +		device_type = "pciex";
> +		reg = <0x0800 0 0xd0040000 0 0x2000>;

It would be great to get this sorted as per my prior comments.. Maybe
like this is easy?

pcie-controller {
 compatible = "marvell,armada-370-xp-pcie";

 // Index by marvell,pcie-port ?
 regs = <0xd0040000 0x00002000
         0xd0080000 0x00002000>;

 ranges = <0x81000000 0 0  0xc0000000  0 0x00010000   /* downstream I/O */
           0x82000000 0 0  0xc1000000  0 0x08000000>; /* non-prefetchable memory */

 pcie at 0,0 {
      device_type = "pci";
      reg = <0x0800 0 0 0>; // 00:01.0  (????)
      marvell,pcie-port = <0>;
 };
}

It is abusive to map the device internal per-port registers through
'0x00000800 0 0xd0040000' and 'reg' - that is not really the intent of
the OF spec.

Jason
