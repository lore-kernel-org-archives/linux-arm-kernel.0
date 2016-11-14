From: atull@opensource.altera.com (atull)
Date: Sun, 13 Nov 2016 22:02:00 -0600
Subject: [PATCH fpga 8/9] fpga socfpga: Use the scatterlist interface
In-Reply-To: <20161114001854.GA27248@obsidianresearch.com>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-9-git-send-email-jgunthorpe@obsidianresearch.com>
 <alpine.DEB.2.10.1611131712210.2735@atull-VirtualBox>
 <20161114001854.GA27248@obsidianresearch.com>
Message-ID: <alpine.DEB.2.10.1611132149140.2908@atull-VirtualBox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Nov 2016, Jason Gunthorpe wrote:

> On Sun, Nov 13, 2016 at 05:19:34PM -0600, atull wrote:
> 
> > Currently or soon we have 3 drivers that don't really use the sg
> > interface natively.  So this workaround ends up in each of them?
> 
> Thinking of the SG list as a workaround is not really right - the SG
> list is a way to pass memory stored in non-contiguous pages around,
> and the miter is a way to access them from the CPU.

No, I ment the other way.  The changes to socfpga.c are a workaround
to the sg-centric interface.  And other drivers will need the same
workaround.  But below I see you understand...

> 
> socfpga *does* use sg natively because it is happy to process the data
> from the CPU page-at-time. It just doesn't use DMA.
> 
> > That's a lot of duplicated code.  Why can't this code be in the
> > fpga-mgr.c core for drivers that aren't using sg (to minimizing
> > duplication).
> 
> Sure, if it is a common pattern it is a good idea to lift it.
> 
> I'd add a newop 'write_fragment' and a driver must define write_sg
> write_fragment, if write_fragment is used then the core supplies
> that loop.

Sure, but isn't that just the old op? :)
There may also be common code that you added to configure_init
that should go in the core unless it's fpga-specific.

> 
> Is there a tree with these new drivers someplace?

The arria10 driver is on linux-next master branch.  There are two
others on the mailing list now.  linux-next also contains other
changes to the FPGA mgr API that will affect your patches in minor
ways, so you should rebase you patches.

> 
> > I will test this when I get time, may not be this week.  I just
> > moved to a new building and lab and am in a course all week and
> > so forth.
> 
> Sure, I don't expect any problems, Zynq uses the same loop and it
> seems fine.
> 
> Jason
> 
