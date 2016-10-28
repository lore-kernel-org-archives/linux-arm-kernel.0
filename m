From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 28 Oct 2016 14:26:19 -0600
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <20161028182308.GB18325@live.com>
References: <20161026225413.GA6220@obsidianresearch.com>
 <c0e99b6e-ae72-5c64-34c1-91865d0e00b5@suse.com>
 <20161027143937.GC6818@obsidianresearch.com>
 <8bed213a-96e3-1891-a46a-234253a2561e@suse.com>
 <20161028154740.GC10441@obsidianresearch.com>
 <5ea0e77e-11c5-b4f7-00a9-9c5425ffac5a@suse.com>
 <20161028165555.GA17998@obsidianresearch.com>
 <20161028182308.GB18325@live.com>
Message-ID: <20161028202619.GA29625@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 11:23:08AM -0700, Moritz Fischer wrote:

> I'm fine with checking for boundary cases where the bitstreams are
> obviously too small or wrong size, I'm not convinced that checking using
> internal knowledge about the bistream format inside the kernel is the
> right place.

To be clear, the sync word is documented in the Xilinx public docs, it
is mandatory. I don't think there is anything wrong with doing basic
validation on the structure of the bitstream before sending it.

> > The problem with the way it is now is how hard it is to figure out
> > what the right bitstream format should be. Clear instructions to
> > canonize by droping the header before the sync word and byteswap so
> > the sync word is in the given order is much clearer..
> 
> I don't know about you, but for my designs I can just use what drops out
> of my Vivado build.

Are you sure? With a 4.8 kernel?

 # (in vivado 2016.3) write_bitstream -bin_file foo
 $ hexdump -C foo.bin
 00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
 *
 00000020  00 00 00 bb 11 22 00 44  ff ff ff ff ff ff ff ff  |.....".D........|
 00000030  aa 99 55 66 20 00 00 00  30 02 20 01 00 00 00 00  |..Uf ...0. .....|

So that isn't going to work, it needs byte swapping

 $ hexdump -C foo.bit
 000000a0  bb 11 22 00 44 ff ff ff  ff ff ff ff ff aa 99 55  |..".D..........U|
 000000b0  66 20 00 00 00 30 02 20  01 00 00 00 00 30 02 00  |f ...0. .....0..|

This also is not going to work, it needs byteswapping and the sync word
has to be 4 byte aligned.

What did you do to get a working bitfile? Are you using one of the
Vivado automatic flows that 'handles' this for you? I am not.

Remember, 4.8 now has the patch to remove the autodetection that used
to correct both of the above two problems..

So from my perspective, this driver is incompatible with the output of
the Xilinx tools. I don't really care, we always post-process the
output of write_bitfile, and I am happy to provide a canonized
bitstream, but the driver needs to do more to help people get this
right.

> Are you unhappy with the way we document which format to use, or
> that we don't slice off the beginning (that gets ignored by hardware?).

Well, I'm unhappy I spent an hour wondering why things didn't work
with no information on what the expected format was now for this
driver. For a bit I wondered if there was a driver bug as this stuff
all worked for me with the original xdevcfg driver.

Some of the problems were bugs on my part (which would have been found
much faster with validation), but at the end of the day this is
horribly unfriendly. You get a timeout and a 'Failed' message, thats
it.

I think all common bitstream formatting errors would be detected by
simply validating the sync word.

Jason
