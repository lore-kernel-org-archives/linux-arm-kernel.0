From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 May 2011 15:52:51 +0100
Subject: [PATCH] ARM: Do not allow unaligned accesses when
	CONFIG_ALIGNMENT_TRAP
In-Reply-To: <yw1xzkmdpjnm.fsf@unicorn.mansr.com>
References: <20110523111648.10474.78396.stgit@e102109-lin.cambridge.arm.com>
	<20110523132124.GI17672@n2100.arm.linux.org.uk>
	<1306158690.7196.15.camel@e102109-lin.cambridge.arm.com>
	<yw1xzkmdpjnm.fsf@unicorn.mansr.com>
Message-ID: <20110523145251.GB14131@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2011 at 03:37:49PM +0100, M?ns Rullg?rd wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> 
> > On Mon, 2011-05-23 at 14:21 +0100, Russell King - ARM Linux wrote:
> >> On Mon, May 23, 2011 at 12:16:48PM +0100, Catalin Marinas wrote:
> >> > Newer versions of gcc generate unaligned accesses by default, causing
> >> > kernel panics when CONFIG_ALIGNMENT_TRAP is enabled. This patch adds the
> >> > -mno-unaligned-access option to gcc.
> >> 
> >> This description doesn't make sense.  If we have alignment traps enabled,
> >> then we _expect_ to fix up unaligned loads and stores.
> >> 
> >> Therefore there should be no panic if CONFIG_ALIGNMENT_TRAP is enabled.
> >> 
> >> So what's the _actual_ problem that this is trying to address?  What's
> >> the panic/oops look like?  And that information should be in the commit
> >> description _anyway_.
> >
> > OK, not clear from my commit log. See below for details (I'll add them
> > to the log):
> >
> > http://www.codesourcery.com/archives/arm-gnu/msg04202.html
> >
> > Basically the fault happens before we call alignment_init(). There are
> > other ways to fix this issue (like initialising the alignment handler
> > earlier).
> 
> The reset value of SCTLR.A is 0 on ARMv7.  Something must be setting it
> to 1 early, before the alignment trap handler is initialised.  This
> something is what needs to be changed.

Yes it is, and it is being set by the common CPU-independent initialization
code.  For ARMv6 and above, it is then cleared when the trap handler is
in place.  That is so we don't miss any misaligned traps which may cause
silent errors if the A bit isn't set for ARMv5 and below.

The resolutions to this is to either introduce yet more crappy ifdefs into
head.S or move crappy the A-bit ifdefs into every proc-*.S file for CPUs
pre-dating ARMv6 - of which there is a _lot_ of them.  Neither of these
options looks anywhere near appealing.
