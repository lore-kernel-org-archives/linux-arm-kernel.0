From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Jan 2011 18:42:58 +0000
Subject: ARM: relocation out of range (when loading a module)
In-Reply-To: <alpine.LFD.2.00.1101121314470.25498@xanadu.home>
References: <4D2B4CE4.9080309@ahsoftware.de>
	<alpine.LFD.2.00.1101101722470.9794@xanadu.home>
	<4D2BFA08.5030104@ahsoftware.de>
	<AANLkTinR7ih2ZMRMbXmSvoh-rS3LVv+UCvd0rRH_ESzf@mail.gmail.com>
	<20110111155930.GH11039@n2100.arm.linux.org.uk>
	<4D2D1942.4050905@ahsoftware.de>
	<AANLkTimAFp7ORrJLw2d8-i5pK0MZGTyAN5kmRR37ky1v@mail.gmail.com>
	<alpine.LFD.2.00.1101121314470.25498@xanadu.home>
Message-ID: <20110112184258.GH11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 01:28:23PM -0500, Nicolas Pitre wrote:
> If we really needed to do such thing, that would be even better to 
> simply have the kernel create those indirect veneers dynamically.  And 
> in fact, Russell had that working and he posted the corresponding patch 
> many years ago, but the module placement was made so that the indirect 
> branches were unnecessary.

Actually, it's something we used to do in 2.2 days when modules were
prepared and linked in userspace before being uploaded into kernel
space.  This allowed the module to be inteligently linked - so the
indirect branches were created only when they were necessary.

When the new kernel-based module linker happened, this presented a
chicken and egg problem with that approach, which give us a choice:
either place the module within range of the kernel text and guarantee
that the kernel text is reachable, or _always_ indirect every module
branch through a jump table even if it was reachable from where the
module was placed.

The decision was made to go with the former, so the latter never got
implemented.

Then came along the embedded initrd/initramfs idea which rather buggered
the scheme when large initramfs are embedded into the image.

As the overall feeling at the time was "don't use large initrds" it's
something I've never really cared about - and I'm still of the opinion
that 16MB of compressed initrd/initramfs is rather silly.
