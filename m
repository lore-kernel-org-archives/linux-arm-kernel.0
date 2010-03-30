From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 30 Mar 2010 12:33:45 +0100
Subject: [PATCH] ARM: Implement copy_to_user_page() for noMMU
In-Reply-To: <1269941500.17138.38.camel@e102109-lin.cambridge.arm.com>
References: <20100329132457.1967.3394.stgit@e102109-lin.cambridge.arm.com>
	<20100330013132.GA15598@shareable.org>
	<20100330072919.GA14500@n2100.arm.linux.org.uk>
	<1269941500.17138.38.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100330113345.GB27463@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> On Tue, 2010-03-30 at 08:29 +0100, Russell King - ARM Linux wrote:
> > On Tue, Mar 30, 2010 at 02:31:32AM +0100, Jamie Lokier wrote:
> > > Other variations such as writing when a mapping is !VM_EXEC and later
> > > mapping or mprotecting the same shmem VM_EXEC, but it's even more
> > > forbidden semantically to write to a read-only mapping (and just as
> > > unchecked on nommu), and conversion of writable to VM_EXEC ought to
> > > flush i-cache at mprotect time.
> > 
> > If NX isn't implemented, then arm_elf_read_implies_exec() must return 1
> > for the CPU - so that any region that is marked readable will have
> > VM_EXEC set.
> 
> If we run uClinux on ARMv6 hardware, we get the above function returning
> 0. Should we make this function conditional on CONFIG_MMU?

Good catch.  I suspect no-MMU implies read-implies-exec, because it
does... unless there is some exciting MPU setting against it.

If no-MMU implies read-implies-exec, there is no need to check VM_EXEC
in this no-MMU code, is there? ;-)

Actually I'm inclined to unconditionally flush i-cache on ptrace write
just because (a) ptrace write is not performance critical, and (b)
invalid target program behaviour (forgetting to set PROT_EXEC) should
not cause GDB setting a breakpoint to fail in such a subtle way.

-- Jamie
