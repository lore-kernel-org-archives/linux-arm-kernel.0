From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 18 Jan 2010 19:43:55 +0100
Subject: Elusive crash in SMC91X/PXA network code?
In-Reply-To: <alpine.DEB.1.10.1001181825560.22774@venus.araneidae.co.uk>
References: <alpine.DEB.1.10.1001181825560.22774@venus.araneidae.co.uk>
Message-ID: <20100118184355.GD8970@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2010 at 06:27:19PM +0000, Michael Abbott wrote:
> I have a crash, that manifests itself in a variety of ways, all of them 
> leading to a kernel panic or oops, typically in smc_interrupt or in the 
> associated network handling code.  Unfortunately the crash is quite 
> elusive, and seems to depend on a hardware specific and out of tree driver 
> (which I am busily cutting down to a minimum).
> 
> I would be hugely grateful if anybody could cast any light on this at all, 
> or suggest any approach to debug this.
> 
> Firstly the basics.  The target system is an XCEP board: this has an 
> embedded PXA255 processor and works with a target specific FPGA and 
> driver; the core XCEP architecture is now in the mainstream kernel as of 
> v2.6.32.  The network device for this board is an SMC 91C111.
> 
> The bug in question is most reliably forced by transferring a very large 
> file over NFS while the embedded driver is performing DMA transfers (from 
> FPGA to XCEP RAM); it is also possible to force the crash by sending 
> enough UDP packets to the device; I've had no success in forcing the crash 
> with any other form of network load.  It can take anything from a few 
> seconds to many minutes of such stress for the crash to occur.

If other network load doesn't provoke the bug, I'd say you can rule out
the network driver. To me that smells like a typical memory corruption
that could be anywhere in your kernel, including and most probably in
third-party drivers.

> The crash can be reproduced on 2.6.27, 2.6.30 and 2.6.32, but 
> interestingly enough not on 2.6.20 -- this does tempt thoughts of an 
> elusive regression in the SMC driver or elsewhere.  Unfortunately the 
> architecture step from .20 to .27 is large enough to make a regression 
> test really rather painful, particularly as local patches will need to be 
> migrated along with the bisect, but clearly that's an option I'll need to 
> consider.
> 
> Disabling DMA support on the SMC device (producing a performance penalty 
> of only 10%, that device has tiny network buffers) makes the crash much 
> more elusive ... but it does crash eventually, maybe overnight.

I'd bet it would crash sooner or later anyway, even with no network
traffic included. The network driver code is just a hot code path, which
is enough of a reason to explain that the kernel likely crashes in
there.

I don't believe the SMC network driver is broken in such a bad way for a
long time, but I've never been using that one, so I can't say for sure.

HTH,
Daniel
