From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 21 Sep 2009 09:31:09 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <4AB6B0AB.8040307@arm.com>
References: <4A7AEEB6.5060903@googlemail.com>
	<1250184014.14019.40.camel@pc1117.cambridge.arm.com>
	<1250501311.9858.24.camel@pc1117.cambridge.arm.com>
	<20090817140422.GA10764@n2100.arm.linux.org.uk>
	<1250529916.11185.80.camel@pc1117.cambridge.arm.com>
	<20090919224022.GA738@n2100.arm.linux.org.uk>
	<1253435940.498.15.camel@pc1117.cambridge.arm.com>
	<20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com>
Message-ID: <20090921083109.GC20006@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm not able to tell from this thread, and I don't have the hardware
to test either:

I have some userspace ARM code which modifies instructions and data
used by those instructions in a few pages, using mprotect() to make
them writable, modify, and make them PROT_READ|PROT_EXEC again.

There is no execution of the modified code _during_ the modification,
only afterwards.

I expect the behaviour is the same as that toolchain which modifies
instructions in the ELF PLT.  (Which, by the way, an ARM FDPIC-ELF
for no-MMU I've been working on also does).

Would the crash problems being discussed affect that sort of code in
general on released ARM kernels?  Do I need an I-cache flush in
userspace after the mprotect - is that required, and will that always
be enough?  Will it still be required when the fix is in?

My question is about some simple code patching at application startup.
But, generalising to a JIT code generator, does it complicate matters
if code is being executed from a page _at the same time_ as another
thread (perhaps on another CPU) is writing to another part of the
_same page_ - writing code, and it's associated local data, to be
executed shortly after it's written while continuing to execute the
earlier code?

Thanks!
-- Jamie
