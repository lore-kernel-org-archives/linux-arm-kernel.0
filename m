From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 28 Oct 2016 16:05:46 -0600
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <20161028210015.GA19901@live.com>
References: <20161026225413.GA6220@obsidianresearch.com>
 <c0e99b6e-ae72-5c64-34c1-91865d0e00b5@suse.com>
 <20161027143937.GC6818@obsidianresearch.com>
 <8bed213a-96e3-1891-a46a-234253a2561e@suse.com>
 <20161028154740.GC10441@obsidianresearch.com>
 <5ea0e77e-11c5-b4f7-00a9-9c5425ffac5a@suse.com>
 <20161028165555.GA17998@obsidianresearch.com>
 <20161028182308.GB18325@live.com>
 <20161028202619.GA29625@obsidianresearch.com>
 <20161028210015.GA19901@live.com>
Message-ID: <20161028220546.GA19693@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 02:00:15PM -0700, Moritz Fischer wrote:

> > What did you do to get a working bitfile? Are you using one of the
> > Vivado automatic flows that 'handles' this for you? I am not.
> 
> https://github.com/EttusResearch/fpgadev/blob/master/usrp3/tools/scripts/viv_utils.tcl#L165

Hm 404

> Is what our build process does (we set the byte_swap_bin parameter to
> 1). You're right in that write_bitstream will give you a non-swapped
> version.

?? byte_swap_bin is not documented in UG835

> If we reevaluate now that we wanna support swapping we should do this at
> a framework level. Maybe a preprocess callback or a FPGA_MGR_SWAP flag.
> I'll need to think about this :-)

I'm perfectly fine with the driver only working with a single canonical
bitfile format. That seems completly reasonable, and I prefer an
efficient programming sequence for performance.

Further, eventually this framework is going to have to be fixed to be
able to DMA out of the page cache and in that world there is no
sensible option to process the data before sending it on to the
hardware.

> > So from my perspective, this driver is incompatible with the output of
> > the Xilinx tools. I don't really care, we always post-process the
> > output of write_bitfile, and I am happy to provide a canonized
> > bitstream, but the driver needs to do more to help people get this
> > right.
> 
> Ok, so I'm fine with adding the checks and a warning if you don't find
> the sync word. We could add documentation describing which format we
> expect.

Maybe you could send a patch to update the comments for the driver, or
add a documentation file how to produce an acceptable format using
Xilinx tools..

> Ok. That sounds reasonable.

So, the question still remains, should the driver require the header
be stripped (eg the sync word is the first 4 bytes), or should it
search the first bit for an aligned sync word?

Either requirement is acceptable to the hardware. My patch does the
former, I suspect you need the later?

Jason
