From: dan@debian.org (Daniel Jacobowitz)
Date: Wed, 3 Feb 2010 09:56:09 -0500
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100203144320.GH22275@n2100.arm.linux.org.uk>
References: <20100203005038.GA16356@caradoc.them.org>
	<1265197942.1970.34.camel@pc1117.cambridge.arm.com>
	<20100203132824.GA27048@n2100.arm.linux.org.uk>
	<20100203134822.GA27441@caradoc.them.org>
	<20100203144320.GH22275@n2100.arm.linux.org.uk>
Message-ID: <20100203145609.GA31800@caradoc.them.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2010 at 02:43:20PM +0000, Russell King - ARM Linux wrote:
> You should be aware that there has been a move to rid the kernel of
> software-based breakpointing implementations through 'utrace' which
> I've been more or less ignoring because of that (because it means
> that we lose the ability to set any breakpoints.)

You've lost me.  I know that utrace has a ptrace emulation mode, and
memory read/write via ptrace is the only support GDB needs to set and
remove software breakpoints.  The kind of breakpoint support I'm
talking about here is just for generating the SIGTRAP instead of
SIGILL on particular instructions, as you know.  What is it that
utrace removes?  The breakpoint-based PTRACE_SINGLESTEP?

I think we've talked about PTRACE_SINGLESTEP in the past; GDB doesn't
currently use it, because of some of the tricky multi-threading issues
you mentioned a few messages back.  The only way to resolve them is to
have the execution control engine (which is in GDB) have explicit
knowledge of where breakpoints are inserted, so GDB inserts and
removes its own breakpoints.

There's some signal handler corner cases that I'd like to return to
someday, but I've never found the time :-( It's going to take some
serious thought to avoid race conditions in this hybrid model where
GDB does some of the single-step control.

> Just to be clear, I'm not objecting to your patch (which I think is
> fine) - I'm just trying to make sure that the same ground isn't being
> covered in multiple ways by different people.

Thanks.  It's 5912/1.

-- 
Daniel Jacobowitz
CodeSourcery
