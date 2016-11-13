From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Sun, 13 Nov 2016 15:13:33 -0700
Subject: [PATCH fpga 9/9] fpga: Remove support for non-sg drivers
In-Reply-To: <alpine.DEB.2.10.1611131439190.2735@atull-VirtualBox>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-10-git-send-email-jgunthorpe@obsidianresearch.com>
 <bad801c5-fe3a-665b-de67-bf69c42fb2b4@gmail.com>
 <20161110163315.GB22004@obsidianresearch.com>
 <8078ce27-5df0-c882-ffa3-d0c9316b7c54@gmail.com>
 <alpine.DEB.2.10.1611131439190.2735@atull-VirtualBox>
Message-ID: <20161113221333.GA19494@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 13, 2016 at 02:44:51PM -0600, atull wrote:

> > >> Would it not make sense to keep the top level API the same?
> > > Fundamentally no.
> 
> NACK for now.  Let's slow down here a bit.
> 
> I don't see any rush in getting rid of the contiguous
> buffer interface.

As I explained to Joshua, until all the drivers support sg the public
sg interface can not be sensibly added, so it actually is a hard
blocker to making progress.

Further, the longer things are left, the more code will depend on the
broken interface and the harder it will be to ultimately fix. This is
a good time because there are only 2 upstream drivers, and I can test
one, you can test the other :)

> At the very least, my socfpga-a10 driver is using the old
> interface and has been just applied.  And currently your
> socfpga changes are untested whereas my original driver
> has been in use and is known to work.

Well, looks like a10 uses the same write code as socfpga, so the patch
should trivially port over. Let me know if you need help.

Are you able to test the modified socfpga?

> Let's wait on that patch until we have quite a few FPGA's
> supported and can be sure that we won't miss the old
> interface.

Well, I am sure :) There is no reason to need this contiguous virtual
memory at the driver level. Our existing drivers demonstrate both how
to do DMA and PIO from the SG list, there really are no other transfer
modes supported by the kernel ...

But even if you are not sure, keeping the unused dead API around is
the exact opposite of the accepted kernel process. Read
stable-api-nonsense.txt and understand how that applies here.

The API can be revised again if a driver comes along that needs an
improvement, but given how intrinsically broken huge contiguous
allocations are, I can't forsee any situation where returning to this
interface would be a good idea.

Do you have comments on the other patches?

Jason
