From: will.deacon@arm.com (Will Deacon)
Date: Fri, 7 Dec 2012 19:02:44 +0000
Subject: [PATCH] ARM: ftrace: Ensure code modifications are synchronised
 across all cpus
In-Reply-To: <1354905805.17101.86.camel@gandalf.local.home>
References: <1354872138.3176.15.camel@computer5.home>
 <1354888985.17101.41.camel@gandalf.local.home>
 <1354892111.13000.50.camel@linaro1.home>
 <1354894134.17101.44.camel@gandalf.local.home>
 <20121207162346.GW14363@n2100.arm.linux.org.uk>
 <1354898200.17101.50.camel@gandalf.local.home>
 <20121207164530.GX14363@n2100.arm.linux.org.uk>
 <1354900436.17101.58.camel@gandalf.local.home>
 <20121207181309.GY14363@n2100.arm.linux.org.uk>
 <1354905805.17101.86.camel@gandalf.local.home>
Message-ID: <20121207190244.GB29618@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Fri, Dec 07, 2012 at 06:43:25PM +0000, Steven Rostedt wrote:
> On Fri, 2012-12-07 at 18:13 +0000, Russell King - ARM Linux wrote:
> > Even changing it to a breakpoint is potentially problematical.  So we'd
> > need to ensure that no other CPU was executing the code while we modify
> > it.
> 
> This is not the same as x86, I guess because x86 has a one byte
> breakpoint. Thus, it is stated in the x86 architecture (I believe,
> Peter, you can correct me if I'm wrong), that the only "safe" thing that
> can modify code, is a software breakpoint.
> 
> Are you saying that thumb does not guarantee even software breakpoints
> from being added atomically? Doesn't that kill the purpose of a
> breakpoint?

For ARMv7, there are small subsets of instructions for ARM and Thumb which
are guaranteed to be atomic wrt concurrent modification and execution of
the instruction stream between different processors:

Thumb:	The 16-bit encodings of the B, NOP, BKPT, and SVC instructions.
ARM:	The B, BL, NOP, BKPT, SVC, HVC, and SMC instructions.

but before your eyes light up at the presence of the BKPT instruction in
that list; we don't actually use that in Linux and instead leave it for
external (i.e. JTAG) debuggers so that they can operate without getting
tangled up with spurious traps from the OS. Linux actually picks its own
undefined instructions, which are obviously not included in the lists above.

Also note that the 16-bit limitation for Thumb instructions above can
actually be used to modify *half* of a BL instruction but, to keep things
exciting, the PC-relative immediate is split across the two halves. However,
you could in theory mess around with bottom 10 bits or so, depending on the
exact encoding...

Obviously this doesn't preclude the need for cache maintenance on both D and
I side, but the atomicity guarantees are as I've described above.

Will
