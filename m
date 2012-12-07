From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 07 Dec 2012 15:01:42 -0500
Subject: [PATCH] ARM: ftrace: Ensure code modifications are synchronised
 across all cpus
In-Reply-To: <20121207190244.GB29618@mudshark.cambridge.arm.com>
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
 <20121207190244.GB29618@mudshark.cambridge.arm.com>
Message-ID: <1354910502.17101.89.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-12-07 at 19:02 +0000, Will Deacon wrote:

> For ARMv7, there are small subsets of instructions for ARM and Thumb which
> are guaranteed to be atomic wrt concurrent modification and execution of
> the instruction stream between different processors:
> 
> Thumb:	The 16-bit encodings of the B, NOP, BKPT, and SVC instructions.
> ARM:	The B, BL, NOP, BKPT, SVC, HVC, and SMC instructions.
> 
> but before your eyes light up at the presence of the BKPT instruction in
> that list; we don't actually use that in Linux and instead leave it for
> external (i.e. JTAG) debuggers so that they can operate without getting
> tangled up with spurious traps from the OS. Linux actually picks its own
> undefined instructions, which are obviously not included in the lists above.

My eyes actually lit up with the B instruction :-)  As Jon showed, we
could use a 16bit jump instead. Add the B to jump over the other half of
the call (to all places that you want to modify). Send a sync to all
CPUs to flush their caches. Modify the other half of the call, send
another sync, and then modify the first half.

> 
> Also note that the 16-bit limitation for Thumb instructions above can
> actually be used to modify *half* of a BL instruction but, to keep things
> exciting, the PC-relative immediate is split across the two halves. However,
> you could in theory mess around with bottom 10 bits or so, depending on the
> exact encoding...
> 
> Obviously this doesn't preclude the need for cache maintenance on both D and
> I side, but the atomicity guarantees are as I've described above.

Right. Thanks for the update.

-- Steve
