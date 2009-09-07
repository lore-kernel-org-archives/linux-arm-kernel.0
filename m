From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 07 Sep 2009 22:40:01 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <19109.17240.533530.549263@pilspetsen.it.uu.se>
References: <4A7AEEB6.5060903@googlemail.com>
	<1250184014.14019.40.camel@pc1117.cambridge.arm.com>
	<1250501311.9858.24.camel@pc1117.cambridge.arm.com>
	<20090817140422.GA10764@n2100.arm.linux.org.uk>
	<1251548848.5030.11.camel@pc1117.cambridge.arm.com>
	<1251707405.7930.7.camel@pc1117.cambridge.arm.com>
	<1252337372.23780.73.camel@pc1117.cambridge.arm.com>
	<19109.17240.533530.549263@pilspetsen.it.uu.se>
Message-ID: <1252359601.10891.9.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-09-07 at 19:31 +0200, Mikael Pettersson wrote:
> Catalin Marinas writes:
>  > Any opinion on whether the ARM kernel should support dynamic shared
>  > objects where not all objects are position-independent? IOW, whether
>  > text relocations are allowed to be resolved at run-time rather than
>  > compile (static link) time for the dynamic shared objects? AFAICT, there
>  > isn't anything in the ARM EABI which would prevent this, so a kernel
>  > patch may be needed.
> 
> I didn't follow the start of this thread, but what exactly
> do you mean by "kernel support" for runtime relocations in
> shared objects? As far as I can tell, all that would happen
> is that some non-pic .so is mapped somewhere, the user-space
> linker runs and fixes relocations (directly or lazily), writes
> to COW pages, causing the kernel to copy them to new page frames.
> 
> In my book that's just "normal" actions for mmaps and pagefaults.
> 
> Is the problem that the kernel has buggy cache maintenance when
> COW-ing text pages on this arch?

Yes (IMHO), pretty much. Two situations here - (a) COW-ing RW pages with
mprotect(RX) afterwards and (b) COW-wing RWX pages. The latter isn't
usually found in current filesystems, so we can ignore it of now. As for
the former, we don't want to clean the cache at every COW of RW pages
(on VIPT/PIPT hardware), so the best place is during mprotect(RX).

Alternatively (*not* my preferred solution), we tell the toolchain
people that such thing as COW text pages isn't supported, so I suspect
other architectures can cope fine with this.

-- 
Catalin
