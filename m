From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 21 Feb 2014 10:31:05 -0700
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <20140221180508.7ed6cfaf@skate>
References: <20140221003227.GF19893@obsidianresearch.com>
 <20140221093444.35870a73@skate> <5307152D.3020804@keymile.com>
 <20140221101218.45766e8a@skate> <53071970.1040400@keymile.com>
 <20140221103936.56b3d9f8@skate> <53074584.5010202@keymile.com>
 <20140221144708.48559045@skate>
 <20140221163902.GB4706@obsidianresearch.com>
 <20140221180508.7ed6cfaf@skate>
Message-ID: <20140221173105.GA17611@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 06:05:08PM +0100, Thomas Petazzoni wrote:
 
> Now I have another question: our mvebu_pcie_align_resource() function
> makes sure that the base address of the BAR is aligned on its size,
> because it is a requirement of MBus windows. However, if you later
> split the BAR into multiple windows, will this continue to work out?

No, you must align to (1 << log2_round_down(size)) - that will always
be the largest mbus window created and thus the highest starting
alignment requirement.

I looked for a bit to see if I could find why the core is rounding up
to 196MB and it wasn't clear to me either.

Gerlando, if you instrument the code in setup-bus.c, particularly
pbus_size_mem, you will probably find out.

Jason
