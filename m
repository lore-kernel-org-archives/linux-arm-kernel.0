From: atull@opensource.altera.com (atull)
Date: Wed, 16 Nov 2016 09:45:23 -0600
Subject: [PATCH fpga 8/9] fpga socfpga: Use the scatterlist interface
In-Reply-To: <20161116052033.GA6044@obsidianresearch.com>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-9-git-send-email-jgunthorpe@obsidianresearch.com>
 <alpine.DEB.2.10.1611131712210.2735@atull-VirtualBox>
 <20161114001854.GA27248@obsidianresearch.com>
 <alpine.DEB.2.10.1611132149140.2908@atull-VirtualBox>
 <20161115043537.GA23253@obsidianresearch.com>
 <alpine.DEB.2.20.1611150940270.3634@atull-VirtualBox2>
 <20161116052033.GA6044@obsidianresearch.com>
Message-ID: <alpine.DEB.2.20.1611160939140.3364@atull-VirtualBox2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Nov 2016, Jason Gunthorpe wrote:

> On Tue, Nov 15, 2016 at 09:47:05AM -0600, atull wrote:
> > Not different.
> > 
> > From 'fpga-mgr.txt':
> >   The programming sequence is:
> >    1. .write_init
> >    2. .write (may be called once or multiple times)
> >    3. .write_complete
> > 
> > The old write was be separate from write_init and write_complete
> > because I figured that in the future someone may be streaming in
> > the bitstream and not have the whole bitstream in memory.
> 
> What is the point of this if write_init gets a copy of the buffer -
> what is that supposed to be?

Sometimes write_init needs to look at the header of the image.
You can see that in the socfpga-a10.c (on linux-next/master)

> 
> If you see things this way why are you opposed to patch 9? I'll change
> things around to call write multiple times and force the sg list into
> write_init, which seems like what you intended anyhow..

Not against it (and I do need to spend some more time looking
at this stuff, this is coming at a busy time).  My point there
was that there was code that needed to go into the core so that
the ICE40 and the cyclone spi driver that are on the mailing
list won't have to have the same workaround that you were
adding to the socfpga.c driver.

Alan

> 
> Jason
> 
