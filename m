From: atull@opensource.altera.com (atull)
Date: Tue, 15 Nov 2016 09:47:05 -0600
Subject: [PATCH fpga 8/9] fpga socfpga: Use the scatterlist interface
In-Reply-To: <20161115043537.GA23253@obsidianresearch.com>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-9-git-send-email-jgunthorpe@obsidianresearch.com>
 <alpine.DEB.2.10.1611131712210.2735@atull-VirtualBox>
 <20161114001854.GA27248@obsidianresearch.com>
 <alpine.DEB.2.10.1611132149140.2908@atull-VirtualBox>
 <20161115043537.GA23253@obsidianresearch.com>
Message-ID: <alpine.DEB.2.20.1611150940270.3634@atull-VirtualBox2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Nov 2016, Jason Gunthorpe wrote:

> On Sun, Nov 13, 2016 at 10:02:00PM -0600, atull wrote:
> > > I'd add a newop 'write_fragment' and a driver must define write_sg
> > > write_fragment, if write_fragment is used then the core supplies
> > > that loop.
> > 
> > Sure, but isn't that just the old op? :)
> 
> I'm fine with that too, but it is semantically different since write
> is called multiple times in this new world.. All the drivers seem fine
> with that today so it is probably OK ..

Not different.

>From 'fpga-mgr.txt':
  The programming sequence is:
   1. .write_init
   2. .write (may be called once or multiple times)
   3. .write_complete

The old write was be separate from write_init and write_complete
because I figured that in the future someone may be streaming in
the bitstream and not have the whole bitstream in memory.  So
that is keeping with the original intention that it could be
called multiple times.  The current API doesn't do that but the
fpga manager ops are intended to support that from the start.

Alan

> 
> > There may also be common code that you added to configure_init
> > that should go in the core unless it's fpga-specific.
> 
> Sure, the alignment test is easy enough to pull out..
> 
> Jason
> 
