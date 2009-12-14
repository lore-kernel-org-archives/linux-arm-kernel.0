From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 14 Dec 2009 15:14:39 -0500 (EST)
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <cabda6420912140948t23c07676tb5f44eb4febbc584@mail.gmail.com>
References: <20091207114218.GA19348@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071027480.31174@xanadu.home>
	<20091207170546.GB26821@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071219100.31174@xanadu.home>
	<20091207175608.GE26821@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A9347E2630EEC2@IL-MB01.marvell.com>
	<20091213120033.GA10698@n2100.arm.linux.org.uk>
	<20091213120615.GB10698@n2100.arm.linux.org.uk>
	<cabda6420912140513k40a998b7k8cf56c35cc535cfb@mail.gmail.com>
	<309002C0DA137042828828FC53D7A9347E2630F364@IL-MB01.marvell.com>
	<cabda6420912140948t23c07676tb5f44eb4febbc584@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.0912141503360.23173@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Dec 2009, christian pellegrin wrote:

> On Mon, Dec 14, 2009 at 3:46 PM, Ronen Shitrit <rshitrit@marvell.com> wrote:
> 
> > "
> >
> > I think your patch doesn't cover the PIO mode...
> >
> 
> Has someone a suggestion on how to write a test-case for this?

I don't think there is any peripheral that runs in PIO mode on 
Kirkwood... except the NAND flash.

> I tried various forms of mixing read/write syscalls (or a mmap wit 
> MAP_PRIVATE) and access via two mmap with MAP_SHARED aliasing the same 
> address (I checked that adjust_pte was called by them) but didn't get 
> any problem. I have to admit that I really don't understand how PIO in 
> kernel mode can refer to mappings that are aliased (and so market 
> uncacheable) made by user-space programs. Thank you for your patience.

PIO transfer will store data in the kernel direct mapped memory which is 
always cached.  Normally the cache coherency with user space is handled 
by flush_dcache_page(), but that deals only with L1 and data can move to 
L2 where it will be invisible to the uncached user space shared 
mappings.

I don't know off hand how PIO on a page that is already mapped and 
shared in user space may be produced though.


Nicolas
