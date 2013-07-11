From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Jul 2013 16:32:20 +0200
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <51DD9A8C.10608@keymile.com>
References: <51DD88A4.1030506@keymile.com> <20130710185706.72b124a4@skate>
 <51DD9A8C.10608@keymile.com>
Message-ID: <20130711163220.2b3adf38@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gerlando Falauto,

On Wed, 10 Jul 2013 19:31:56 +0200, Gerlando Falauto wrote:

> Yes, though we had to trick it a little bit to get both the internal 
> switch and this PCIe device working:
> 
> - this PCIe device requires to map 256M of memory as opposed to just 128
> - we need a virtual PCIe device to connect to the internal switch, which 
> must be mapped at 0xf4000000 (normally used for the NAND which must then 
> move to 0xff000000)

Aah, if you need 256 MB, then you need to adjust the ranges, because
by default there is only 128 MB for PCIe memory. So, you would need
something like:

So, within the pcie-controller node, you should do something like:

			ranges = <0x82000000 0 0x00040000 0x00040000 0 0x00002000   /* Port 0.0 registers */
				  0x82000000 0 0xe0000000 0xe0000000 0 0x10000000   /* non-prefetchable memory */
			          0x81000000 0 0          0xf0000000 0 0x00100000>; /* downstream I/O */

and in the ranges property at the ocp { } level, you should do something like:


		ranges = <0x00000000 0xf1000000 0x0100000
		          0xe0000000 0xe0000000 0x10100000 /* PCIE */
		          0xf4000000 0xf4000000 0x0000400
		          0xf5000000 0xf5000000 0x0000400>;

Basically, before the change the configuration was:

 * 128 MB of PCIe memory at 0xe0000000
 * 1 MB of PCIe I/O at 0xe8000000

After the change, you have:

 * 256 MB of PCIe memory at 0xe0000000
 * 1 MB of PCIe I/O at 0xf0000000

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
