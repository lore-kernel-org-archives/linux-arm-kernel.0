From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 31 Oct 2016 10:23:27 -0600
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <20161029000926.GA30169@live.com>
References: <20161027143937.GC6818@obsidianresearch.com>
 <8bed213a-96e3-1891-a46a-234253a2561e@suse.com>
 <20161028154740.GC10441@obsidianresearch.com>
 <5ea0e77e-11c5-b4f7-00a9-9c5425ffac5a@suse.com>
 <20161028165555.GA17998@obsidianresearch.com>
 <20161028182308.GB18325@live.com>
 <20161028202619.GA29625@obsidianresearch.com>
 <20161028210015.GA19901@live.com>
 <20161028220546.GA19693@obsidianresearch.com>
 <20161029000926.GA30169@live.com>
Message-ID: <20161031162327.GA28817@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 05:09:26PM -0700, Moritz Fischer wrote:
> It's not a single command but rather a sequence of steps we take to
> create an image that works (using write_cfgmem instead of write_binfile)

Ah, and it relies on newer Vivado features too.. Never had a use for
write_cfgmem before, and wouldn't have thought it did this.

I always do these transform externally and we tack our own header onto
the bitfile as well..

> > So, the question still remains, should the driver require the header
> > be stripped (eg the sync word is the first 4 bytes), or should it
> > search the first bit for an aligned sync word?
> 
> So currently we don't require it to be stripped, changing it so it does
> require stripping would break people's setups that already use the
> current implementation.

Considering there is a way to produce an acceptable bitfile via
write_cfgmem I think we should stick with that and allow the header to
be present, otherwise all users need yet another tool.

I'll send another patch when I get back from the plumbers conference.

> > Either requirement is acceptable to the hardware. My patch does the
> > former, I suspect you need the later?
> 
> For my usecases I could deal with either way, looking at backwards
> compat the latter one would be preferential I supose ...

Well, there are no in-kernel users, and no uapi, so it isn't such a
big deal. I'm actually surprised this got merged without users ..

Jason
