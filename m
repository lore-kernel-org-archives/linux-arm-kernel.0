From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Feb 2014 18:05:08 +0100
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <20140221163902.GB4706@obsidianresearch.com>
References: <20140220173518.GA19893@obsidianresearch.com>
 <20140220212914.29ddc031@skate>
 <20140221003227.GF19893@obsidianresearch.com>
 <20140221093444.35870a73@skate> <5307152D.3020804@keymile.com>
 <20140221101218.45766e8a@skate> <53071970.1040400@keymile.com>
 <20140221103936.56b3d9f8@skate> <53074584.5010202@keymile.com>
 <20140221144708.48559045@skate>
 <20140221163902.GB4706@obsidianresearch.com>
Message-ID: <20140221180508.7ed6cfaf@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Fri, 21 Feb 2014 09:39:02 -0700, Jason Gunthorpe wrote:
> On Fri, Feb 21, 2014 at 02:47:08PM +0100, Thomas Petazzoni wrote:
> >  *) I don't know if the algorithm to split the BAR into multiple
> >     windows is going to be trivial.
> 
> physaddr_t base,size;
> 
> while (size != 0) {
>    physaddr_t window_size = 1 << log2_round_down(size);
>    create_window(base,window_size);
>    base += window_size;
>    size -= window_size;
> }
> 
> At the very worst log2_round_down is approxmiately
> 
> unsigned int log2_round_down(unsigned int val)
> {
> 	unsigned int res = 0;
> 	while ((1<<res) <= val)
> 		res++;
> 	return res - 1;
> }
> 
> Minimum PCI required alignment for windows is 1MB so it will always
> work out into some number of mbus windows..

Interesting! Thanks!

Now I have another question: our mvebu_pcie_align_resource() function
makes sure that the base address of the BAR is aligned on its size,
because it is a requirement of MBus windows. However, if you later
split the BAR into multiple windows, will this continue to work out?

Let's take an example: a 96 MB BAR. If it gets put at 0xe0000000, then
no problem: we create one 64 MB window at 0xe0000000 and a 32 MB window
at 0xe4000000. Both base addresses are aligned on the size of the
window.

However, if the 96 MB BAR gets put at 0xea000000 (which is aligned on a
96 MB boundary, as required by our mvebu_pcie_align_resource). We
create one 64 MB window at 0xea000000, and one 32 MB window at
0xee000000. Unfortunately, while 0xea000000 is aligned on a 96 MB
boundary, it is not aligned on a 64 MB boundary, so the 64 MB window we
have created is wrong.

Which also makes me think that our mvebu_pcie_align_resource()
function uses round_up(start, size), which most likely doesn't work with
non power-of-two sizes.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
