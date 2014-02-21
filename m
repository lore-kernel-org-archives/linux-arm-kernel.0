From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 21 Feb 2014 09:39:02 -0700
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <20140221144708.48559045@skate>
References: <20140220173518.GA19893@obsidianresearch.com>
 <20140220212914.29ddc031@skate>
 <20140221003227.GF19893@obsidianresearch.com>
 <20140221093444.35870a73@skate> <5307152D.3020804@keymile.com>
 <20140221101218.45766e8a@skate> <53071970.1040400@keymile.com>
 <20140221103936.56b3d9f8@skate> <53074584.5010202@keymile.com>
 <20140221144708.48559045@skate>
Message-ID: <20140221163902.GB4706@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 02:47:08PM +0100, Thomas Petazzoni wrote:
>  *) I don't know if the algorithm to split the BAR into multiple
>     windows is going to be trivial.

physaddr_t base,size;

while (size != 0) {
   physaddr_t window_size = 1 << log2_round_down(size);
   create_window(base,window_size);
   base += window_size;
   size -= window_size;
}

At the very worst log2_round_down is approxmiately

unsigned int log2_round_down(unsigned int val)
{
	unsigned int res = 0;
	while ((1<<res) <= val)
		res++;
	return res - 1;
}

Minimum PCI required alignment for windows is 1MB so it will always
work out into some number of mbus windows..

Jason
