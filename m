From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 9 Nov 2016 08:56:51 -0700
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <609bc971-bb6d-8cd2-8e64-23c0082a6216@topic.nl>
References: <20161028202619.GA29625@obsidianresearch.com>
 <20161028210015.GA19901@live.com>
 <20161028220546.GA19693@obsidianresearch.com>
 <20161029000926.GA30169@live.com>
 <20161031162327.GA28817@obsidianresearch.com>
 <7117d821-a1b1-7c07-806a-483be99131e6@xilinx.com>
 <20161101153326.GA6193@obsidianresearch.com>
 <4e2c7e1c-7c33-a552-5b91-dbdefac58e37@xilinx.com>
 <20161108000538.GA13959@obsidianresearch.com>
 <609bc971-bb6d-8cd2-8e64-23c0082a6216@topic.nl>
Message-ID: <20161109155651.GA15076@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 03:21:52PM +0100, Mike Looijmans wrote:
> I think the basic idea behind the commit is flawed to begin with and the
> patch should be discarded completely. The same discussion was done for the
> Xilinx FPGA manager driver, which resulted in the decision that the tooling
> should create a proper file.

That hasn't changed at all, this just produces a clear and obvious
message about what is wrong instead of 'timed out'.

Remember, again, the Xilinx tools do not produce an acceptable
bitstream file by default. You need to do very strange and special
things to get something acceptable to this driver. It is a very easy
mistake to make and hard to track down if you don't already know these
details.

> This driver should either become obsolete or at least move into the
> same direction as the FPGA manager rather than away from that.

I don't understand what you are talking about here, this is a fpga mgr
driver already, and is consistent with the FPGA manger - the auto
detect stuff was removed a while ago and isn't coming back.

It is perfectly reasonable for fpga manager drivers to pre-validate
the proposed bitstream, IMHO all of the drivers should try and do
that step.

Remember, it is deeply unlikely but sending garbage to an FPGA could
damage it.

> Besides political arguments, there's a more pressing technical argument
> against this theck as well: The whole check is pointless since the hardware
> itself already verifies the validity of the stream.

The purpose of the check is not to protect the hardware. The check is
to help the user provide the correct input because the hardware
provides no feedback at all on what is wrong with the input.

And again, the out-of-tree Xilinx driver accepted files that this
driver does not, so having a clear and understandable message is going
to be very important for users.

> doesn't have any effect, the hardware will discard it. There's no reason to
> waste CPU cycles duplicating this check in software.

In the typical success case we are talking about 5 32 bit compares,
which isn't even worth considering.

Jason
