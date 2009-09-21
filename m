From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Sep 2009 11:08:53 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20090921094145.GA32152@shareable.org>
References: <1250501311.9858.24.camel@pc1117.cambridge.arm.com>
	<20090817140422.GA10764@n2100.arm.linux.org.uk>
	<1250529916.11185.80.camel@pc1117.cambridge.arm.com>
	<20090919224022.GA738@n2100.arm.linux.org.uk>
	<1253435940.498.15.camel@pc1117.cambridge.arm.com>
	<20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
	<20090921084155.GB27357@n2100.arm.linux.org.uk>
	<20090921094145.GA32152@shareable.org>
Message-ID: <1253527733.1541.40.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-09-21 at 10:41 +0100, Jamie Lokier wrote:
>   - Whether sys_cacheflush is necessary when doing mprotect RW->RX
>     after writing new code, or does the mprotect imply it (I presume
>     _mmap_ always does);

mmap() doesn't do this as it doesn't map the pages itself. The pages are
mapped later during fault processing and it's the
flush_dcache_page/update_mmu_cache combination that takes care of the
D-cache cleaning and I-cache invalidation.

IMHO, mprotect(RX) should do the flushing but let's see Russell's
opinion (that's what my patch proposes).

>   - If a kernel bug has been uncovered which makes sys_cacheflush
>     insufficient for that in some obscure case under discussion with
>     COW pages;

sys_cacheflush isn't insufficient with write-allocate caches, it's only
that the dynamic linker doesn't use it (since it's only writing data but
in a text page).

>   - Whether it is necessary if only the data words in a code+data
>     page are modified (similar to ELF PLT updates), in principle, and

IMHO, no.

>   - If the above answer is no, with only the data words written, the
>     bug under discussion, is sys_cacheflush necessary to work with
>     unfixed kernels?

sys_cacheflush would work around the problem but distributions,
including Debian and Ubuntu, are affected and the dynamic linker would
need to be fixed (for such filesystems it's easier to push a kernel fix
than a toolchain one).

-- 
Catalin
