From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 21 Sep 2009 10:41:45 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20090921084155.GB27357@n2100.arm.linux.org.uk>
References: <1250501311.9858.24.camel@pc1117.cambridge.arm.com>
	<20090817140422.GA10764@n2100.arm.linux.org.uk>
	<1250529916.11185.80.camel@pc1117.cambridge.arm.com>
	<20090919224022.GA738@n2100.arm.linux.org.uk>
	<1253435940.498.15.camel@pc1117.cambridge.arm.com>
	<20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
	<20090921084155.GB27357@n2100.arm.linux.org.uk>
Message-ID: <20090921094145.GA32152@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Sep 21, 2009 at 09:31:09AM +0100, Jamie Lokier wrote:
> > I'm not able to tell from this thread, and I don't have the hardware
> > to test either:
> > 
> > I have some userspace ARM code which modifies instructions and data
> > used by those instructions in a few pages, using mprotect() to make
> > them writable, modify, and make them PROT_READ|PROT_EXEC again.
> > 
> > There is no execution of the modified code _during_ the modification,
> > only afterwards.
> 
> We've had a syscall to handle the cache issues to do with self
> modifying code - __ARM_NR_cacheflush.  See the comments associated
> with 'cacheflush' in arch/arm/kernel/traps.c about how to use it.
> This is the situation which the syscall was designed to address back
> in the 1990s.

Understood already.  Other archs have a similar call.  My question was
multiple questions, specifically in response to this thread:

  - Whether sys_cacheflush is necessary when doing mprotect RW->RX
    after writing new code, or does the mprotect imply it (I presume
    _mmap_ always does);

  - If a kernel bug has been uncovered which makes sys_cacheflush
    insufficient for that in some obscure case under discussion with
    COW pages;

  - Whether it is necessary if only the data words in a code+data
    page are modified (similar to ELF PLT updates), in principle, and

  - If the above answer is no, with only the data words written, the
    bug under discussion, is sys_cacheflush necessary to work with
    unfixed kernels?

Thanks,
-- Jamie
