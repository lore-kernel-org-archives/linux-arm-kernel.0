From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 16 Feb 2010 09:15:25 +0000
Subject: 11MPCore SCU performance counters in perf
In-Reply-To: <000101caabd4$c0e526a0$42af73e0$@deacon@arm.com>
References: <000101caabd4$c0e526a0$42af73e0$@deacon@arm.com>
Message-ID: <20100216091525.GB5475@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Fri, Feb 12, 2010 at 11:15:58AM -0000, Will Deacon wrote:
> Hi Jamie,
> 
> With the perf stuff now applied by Russell, I've had a go at porting the
> oprofile backend to use perf. It's working well for v6 and v7 PMUs, but to
> maintain full oprofile compatability, I need to add the following new
> features to perf:
> 
> 1.) Support for xscale1/xscale2 PMUs 2.) Support for the 11MPCore SCU
> 
> I've done (1), but I still need to test it on some hardware. As for (2), I'm
> not sure how to proceed. The oprofile SCU driver [op_model_mpcore.c] appears
> only to support one board [the Realview EB11MP] and uses the board specific
> macro __io_address to get at the SCU. Furthermore, because oprofile expects
> to associate events with a particular core, the SCU counters are divided up
> between the cores. I think this has the potential to make profiling results
> quite misleading because some events [e.g. `A read transfer is sent to the
> external memory.'] are not tied to a core, but oprofile will be forced to
> choose one to report it on.
> 
> Looking at the oprofile userspace sources, the SCU events don't appear to be
> supported. The 11MPCore is the only ARM core to expose the SCU performance
> counters in this way and basically, I don't think it's worth supporting in
> the kernel...
> 
> ...however, we will almost certainly want support for `uncore' counters in
> the future [that is, counters not associated with a particular CPU]. I guess
> the question is: do I hack SCU support into perf and establish a method for
> supporting uncore counters at the same time, or shall I drop the SCU because
> of the reasons above and leave the uncore problem for another day?
Are the events particularly useful? I'd be inclined not to support them unless
someone really needs them. The caveats that you mention are quite important
and they really could be quite misleading. If the oprofile userspace doesn't
support the SCU events then I don't see that we've lost anything...

Jamie
