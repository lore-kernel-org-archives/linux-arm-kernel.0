From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 12 Jan 2011 13:28:23 -0500 (EST)
Subject: ARM: relocation out of range (when loading a module)
In-Reply-To: <AANLkTimAFp7ORrJLw2d8-i5pK0MZGTyAN5kmRR37ky1v@mail.gmail.com>
References: <4D2B4CE4.9080309@ahsoftware.de>
	<alpine.LFD.2.00.1101101722470.9794@xanadu.home>
	<4D2BFA08.5030104@ahsoftware.de>
	<AANLkTinR7ih2ZMRMbXmSvoh-rS3LVv+UCvd0rRH_ESzf@mail.gmail.com>
	<20110111155930.GH11039@n2100.arm.linux.org.uk>
	<4D2D1942.4050905@ahsoftware.de>
	<AANLkTimAFp7ORrJLw2d8-i5pK0MZGTyAN5kmRR37ky1v@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1101121314470.25498@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jan 2011, Dave Martin wrote:

> In general, do we expect always to be able to avoid the situation
> where branches in the kernel may need to cover too large a range ...
> and is there any strategy for working aroung it?

Normally we try to keep the code close together.  And at least for the 
.text section, the linker is able to insert indirect branch veneers when 
the range is too large.  But in the case of modules, it's the in-kernel 
code that perform the final symbol relocation.

> If we have problems branching from the modules area into vmlinux, we
> could possibly build modules with -fPIC : this would remove the
> restriction on branch range, though there would also be some
> performance impact for the modules...

If we really needed to do such thing, that would be even better to 
simply have the kernel create those indirect veneers dynamically.  And 
in fact, Russell had that working and he posted the corresponding patch 
many years ago, but the module placement was made so that the indirect 
branches were unnecessary.

Even now, it's probably a better idea to rework the section layout and 
preserve the ability to perform direct branches into the kernel from 
modules as much as possible.


Nicolas
