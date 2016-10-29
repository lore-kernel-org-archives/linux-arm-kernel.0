From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Fri, 28 Oct 2016 17:09:26 -0700
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <20161028220546.GA19693@obsidianresearch.com>
References: <c0e99b6e-ae72-5c64-34c1-91865d0e00b5@suse.com>
 <20161027143937.GC6818@obsidianresearch.com>
 <8bed213a-96e3-1891-a46a-234253a2561e@suse.com>
 <20161028154740.GC10441@obsidianresearch.com>
 <5ea0e77e-11c5-b4f7-00a9-9c5425ffac5a@suse.com>
 <20161028165555.GA17998@obsidianresearch.com>
 <20161028182308.GB18325@live.com>
 <20161028202619.GA29625@obsidianresearch.com>
 <20161028210015.GA19901@live.com>
 <20161028220546.GA19693@obsidianresearch.com>
Message-ID: <20161029000926.GA30169@live.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Fri, Oct 28, 2016 at 04:05:46PM -0600, Jason Gunthorpe wrote:
> On Fri, Oct 28, 2016 at 02:00:15PM -0700, Moritz Fischer wrote:
> 
> > > What did you do to get a working bitfile? Are you using one of the
> > > Vivado automatic flows that 'handles' this for you? I am not.
> > 
> > https://github.com/EttusResearch/fpgadev/blob/master/usrp3/tools/scripts/viv_utils.tcl#L165
> 
> Hm 404

Whooopsie ... that was the internal link. Try that one:

https://github.com/EttusResearch/fpga/blob/master/usrp3/tools/scripts/viv_utils.tcl#L165

It's not a single command but rather a sequence of steps we take to
create an image that works (using write_cfgmem instead of write_binfile)

> 
> > Is what our build process does (we set the byte_swap_bin parameter to
> > 1). You're right in that write_bitstream will give you a non-swapped
> > version.
> 
> ?? byte_swap_bin is not documented in UG835
> 
> > If we reevaluate now that we wanna support swapping we should do this at
> > a framework level. Maybe a preprocess callback or a FPGA_MGR_SWAP flag.
> > I'll need to think about this :-)
> 
> I'm perfectly fine with the driver only working with a single canonical
> bitfile format. That seems completly reasonable, and I prefer an
> efficient programming sequence for performance.
> 
> Further, eventually this framework is going to have to be fixed to be
> able to DMA out of the page cache and in that world there is no
> sensible option to process the data before sending it on to the
> hardware.
> 
> > > So from my perspective, this driver is incompatible with the output of
> > > the Xilinx tools. I don't really care, we always post-process the
> > > output of write_bitfile, and I am happy to provide a canonized
> > > bitstream, but the driver needs to do more to help people get this
> > > right.
> > 
> > Ok, so I'm fine with adding the checks and a warning if you don't find
> > the sync word. We could add documentation describing which format we
> > expect.
> 
> Maybe you could send a patch to update the comments for the driver, or
> add a documentation file how to produce an acceptable format using
> Xilinx tools..

Yeah will do. I don't know if the generation flow outlined above is perfect,
we just pad our images and I haven't run into issues so far.

> So, the question still remains, should the driver require the header
> be stripped (eg the sync word is the first 4 bytes), or should it
> search the first bit for an aligned sync word?

So currently we don't require it to be stripped, changing it so it does
require stripping would break people's setups that already use the
current implementation.
That being said, I don't like the idea of the driver having to search
either...

Michal, S?ren you guys have a preference / input?

> Either requirement is acceptable to the hardware. My patch does the
> former, I suspect you need the later?

For my usecases I could deal with either way, looking at backwards
compat the latter one would be preferential I supose ...

Cheers,

Moritz
