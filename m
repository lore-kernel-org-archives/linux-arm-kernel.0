From: mikpe@it.uu.se (Mikael Pettersson)
Date: Fri, 3 Feb 2012 15:41:20 +0100
Subject: [PATCH 1/1] arm: vfp: Raising SIGFPE on invalid floating point
 operation
In-Reply-To: <20120203140621.GK889@n2100.arm.linux.org.uk>
References: <1328258184-23082-1-git-send-email-consul.kautuk@gmail.com>
 <20267.57822.537801.969721@pilspetsen.it.uu.se>
 <20120203140621.GK889@n2100.arm.linux.org.uk>
Message-ID: <20267.61968.579756.647011@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux writes:
 > On Fri, Feb 03, 2012 at 02:32:14PM +0100, Mikael Pettersson wrote:
 > > No, a SIGFPE delivered at the wrong point in time with the wrong
 > > context in its sigframe is MUCH worse than not getting a SIGFPE
 > > at all.  (And likewise for all other trap signals, SEGV, ILL, etc.)
 > 
 > If your FP is pipelined, then you won't get a SIGFPE for a div0 situation
 > as soon as the instruction appears in the program.  Think about what's
 > happening.
 > 
 > 1. The FP hardware may be occupied with a computation.
 > 2. The program issues the divide instruction, the FP hardware accepts
 >    this.  Meanwhile, the integer part of the core continues processing
 >    instructions.
 > 3. The FP hardware completes its computation, and gets to execute the
 >    divide instruction.
 > 4. The FP hardware discovers a divide-by-zero situation, and flags it
 >    in its status register.
 > 
 > At this point, there's no way for the FP hardware to flag that situation
 > to the integer core (there's no interrupt.)  The failure gets flagged
 > when the program executes the next FP instruction, and is raised by the
 > FP hardware refusing to accept that instruction with an exception status.

It's OK to deliver on the next FP insn, that's a fairly common design
and not too difficult to handle (at least not for what I've used it for,
namely to use FP exns instead of explicit NaN/Inf checks in the runtime
of the Erlang VM, and to turn the FP exns into language-level exceptions).

My reaction was against delivering at some random point in the future
where possibly incorrect decisions have already been made, and where
the state is arbitrarily different from the one at the exn origin.

However, having read Dave Martin's response I now think the problem is
a buggy application or libc, and not something the kernel should care
about.
