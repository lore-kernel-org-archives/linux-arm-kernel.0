From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 22 Dec 2015 16:07:29 +0000
Subject: [PATCH RESEND v4] arm: remove !CPU_V6 and !GENERIC_ATOMIC64
 build dependencies for XEN
In-Reply-To: <20151222155713.GN8644@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.02.1512221404060.3096@kaball.uk.xensource.com>
 <20151222144605.GJ8644@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1512221535470.3096@kaball.uk.xensource.com>
 <20151222155713.GN8644@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.02.1512221603000.3096@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Dec 2015, Russell King - ARM Linux wrote:
> On Tue, Dec 22, 2015 at 03:45:19PM +0000, Stefano Stabellini wrote:
> > The code builds, but of course it could not actually run on CPU_V6. But
> > the use case for me is building drivers/xen/grant-table.c, which can
> > only run on CPU_V7 anyway, so it is not a problem.
> 
> What I'm concerned about in this case is if you try to use instructions
> which are not supported by the CPU, even in assembly, the assembler
> will barf.
> 
> So, if we're building an ARMv6 + ARMv7 kernel, and you try to use
> LDREXB in generic code, even though you may intend it to only be
> executed on ARMv7, the assembler will error out.
> 
> We used to be able to work around that by passing -Wa,-march=armv7
> to the compiler for specific files, which would then tell the assembler
> to accept ARMv7 instructions, but modern GCC output .arch pseudo-ops
> which override the command line.  So now the only way to do it is to
> override the assemblers selected archtecture using .arch pseudo-ops
> in the assembly code.
> 
> So, what I'm saying is that dropping the !ARMv6 dependency is not as
> simple as it would seem, and I'm nervous about including any such
> patches this close to Christmas and the merge window.
 
Sure, that's understandable.

Merge window aside, do you think that for the future it might be better
to change approach and write a Xen specific implementation of
sync_cmpxchg?  Like this older patch tried to do

http://marc.info/?l=linux-arm-kernel&m=138436406724990&w=2

?
