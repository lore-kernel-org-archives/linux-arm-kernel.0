From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 23 Mar 2013 10:41:56 +0000
Subject: [PATCH 1/6] of/pci: Provide support for parsing PCI DT ranges
 property
In-Reply-To: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
References: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
Message-ID: <20130323104156.GL4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 23, 2013 at 01:04:53PM +0900, Jingoo Han wrote:
> -		switch ((pci_space >> 24) & 0x3) {
> -		case 1:		/* PCI IO space */
> +		if (iter.flags & IORESOURCE_IO) {

Please look at how IORESOURCE_* stuff is defined:
#define IORESOURCE_TYPE_BITS    0x00001f00      /* Resource type */
#define IORESOURCE_IO           0x00000100      /* PCI/ISA I/O ports */
#define IORESOURCE_MEM          0x00000200
#define IORESOURCE_REG          0x00000300      /* Register offsets */
#define IORESOURCE_IRQ          0x00000400
#define IORESOURCE_DMA          0x00000800
#define IORESOURCE_BUS          0x00001000

Notice that it's not an array of bits.

So this should be:
		if ((iter.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO) {

> +			iter.cpu_addr = iter.pci_addr;
> +		} else if (iter.flags & IORESOURCE_MEM) {

And this should be:
		} else if ((iter.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_MEM) {

> +		if (iter.flags & IORESOURCE_IO) {

Same here.

> +		} else if (iter.flags & IORESOURCE_MEM) {

And again here.

> -		switch ((pci_space >> 24) & 0x3) {
> -		case 1:		/* PCI IO space */
> +		if (iter.flags & IORESOURCE_IO) {

ditto.

> +			iter.cpu_addr = iter.pci_addr;
> +		} else if (flags & IORESOURCE_MEM) {

ditto.
