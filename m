From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 22 Mar 2013 07:28:54 +0100
Subject: [PATCH 5/5] arm: dts: Convert mvebu device tree files to 64 bits
In-Reply-To: <20130321205545.GA8358@obsidianresearch.com>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <1363883179-1361-6-git-send-email-gregory.clement@free-electrons.com>
 <20130321201533.GN21478@lunn.ch> <20130321212236.1015295d@skate>
 <20130321205545.GA8358@obsidianresearch.com>
Message-ID: <20130322062854.GS21478@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

So, lets see if i have all this right.

IO space needs to stay where it is, somewhere in the top 1GB, because
it is limited to the 32bit address space.

We must have some SDRAM in the bottom of the 40bit address range in
order that DMA works. Bounce buffers are used for anything which is
outside of the bottom 32bits.

SDRAM can only be split on ranks. I assume this is also a synonym for
chip select? 

Ideally we want the boot loader to setup the split, since it is not
very easy to move stuff around in a running system. Alternatively, the
boot loader could setup the lowest rank/chip select and leave the
others disabled. That gives enough that Linux can boot and decide
where it wants to put the rest, without the problem of having to remap
the SDRAM its currently running from.

It might be possible, in theory, to copy code into the SRAM and run
from SRAM while moving the SDRAM around. But i get the feeling its not
very easy.

If there is 4GB in the system, it is probably going to be split with
2GB low and 2GB high. This is probably the most important use case,
since throwing away 1/4 of your SDRAM is much worse than 1/8, or 1/16.

If there is 8GB in the system, it is probably going to be split with
2GB low and 6GB high, assuming it has 4 ranks of 2GB. What might be
considered is 4/4 split, with 1GB discarded, if that gives better
overall performance. If it happens to be 2x 4GB you have no choice but
to discard 1GB.

With 16GB, there is no choice other than 4GB/12GB with 1GB discarded.

Is that all correct?

Thanks
	Andrew
