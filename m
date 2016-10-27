From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 27 Oct 2016 08:32:03 -0600
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <bdae79f1-dfed-d735-cb49-9ce8aa0b6e4f@xilinx.com>
References: <20161026225413.GA6220@obsidianresearch.com>
 <bdae79f1-dfed-d735-cb49-9ce8aa0b6e4f@xilinx.com>
Message-ID: <20161027143203.GA6818@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 09:42:03AM +0200, Michal Simek wrote:

> I am not quite sure about this and I didn't try it on real hw.
> But minimum bitstream size 52+B and more likely much more than this.

Oh probably, I didn't try to guess what the minimum size is, that
check is just to prevent reading past the end of the buffer.

> This is taken from u-boot source code and this is full BIN header.
> The code above is checking only the last word.

There can be garbage before the sync word.  The hardware ignores
everything till it gets the sync word.  Prior versions of the driver
with the autodetection would discard the garbage.

Since the autodetection was ripped out I didn't want to search since
the intent seems to be for user space to provide a full bitstream,
which should start at the sync word, but that is another option.

>        0x000000bb, /* Sync word */
>        0x11220044, /* Sync word */
>        DUMMY_WORD,
>        DUMMY_WORD,
>        0xaa995566, /* Sync word */

This is the bus width detection pattern, I understood the Zync DevC
interface was wired to 32 bits and did not respond to this.

Jason
