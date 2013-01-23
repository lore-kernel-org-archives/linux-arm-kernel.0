From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Jan 2013 14:50:07 +0000
Subject: ARM: hw_breakpoint mismatch breakpoint behaves unexpectedly like
 a match breakpoint on ARM_DEBUG_ARCH_V7_ECP14
In-Reply-To: <CAPfQmK+mwx39J5yWiLCTWbiFL=yL-rw=XZXRkOwGU_byQsDyQA@mail.gmail.com>
References: <CAPfQmKJaYf6M4iHKuNcHgYZi5R8M7fXdXta34Q=1C0cHKimkyQ@mail.gmail.com>
 <20130122093102.GC12295@mudshark.cambridge.arm.com>
 <CAPfQmK+mwx39J5yWiLCTWbiFL=yL-rw=XZXRkOwGU_byQsDyQA@mail.gmail.com>
Message-ID: <20130123145007.GB26811@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 05:11:11PM +0000, Valentin Pistol wrote:
> > The ptrace interface doesn't support mismatch breakpoints, and ignores those
> > bits in the user request, hence why you see a normal breakpoint being
> > created. Note that mismatch breakpoints are used internally for stepping
> > over breakpoints set by perf.
> >
> > If you wanted to add single-step using mismatch breakpoints, I think we'd be
> > better off re-introducing the SINGLESTEP ptrace request for ARM to use
> > hw_breakpoints.
> 
> I noticed your old Feb 2011 post on SINGLESTEP being removed:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/041408.html
> 
> So it was managing its own breakpoints and instruction decoding (like
> gdb would) but didn't take advantage of either mismatch support or
> hw_breakpoints?

Correct. The code also didn't handle newer instructions especially well,
with issues on SMP too. Given that the request is only supposed to be
implemented for architectures with hardware single-step, it made sense to
remove the code.

> Such support seems really useful and yet much more simple if mismatch
> is supported.
> I definitely would like to use the ptrace and hw-breakpoints interface
> instead of avoiding and writing it from scratch, as it takes care of a
> lot of details, for instance SMP and context switches, uninstalling
> and installing the breakpoints as required.

Ok.

> I'm wondering how pervasive the required changes are to support
> SINGLESTEP with mismatch breakpoints.
> If you think it's a good idea I'm very willing to try and add-in such support.
> Please let me know if there's some obvious issues about going forward
> with this that you may be aware of.

Given that ARMv8 has hardware single-step, I'd be inclined to implement
that instead so that we don't have to overload the SINGLESTEP request later
on. Alternatively, you could implement something like PTRACE_HBPSTEP but I
think you will run into some problems:

	1. Alignment restrictions. Stepping something like a 32-bit Thumb
	   instruction on a halfword boundary will need *two* breakpoints to
	   be added and handled appropriately.

	2. Interaction with mismatch breakpoints being used internally by
	   the kernel. You might be ok here, but you want to check the code
	   which uses mismatch breakpoints to step over breakpoints and
	   watchpoints.

Will
