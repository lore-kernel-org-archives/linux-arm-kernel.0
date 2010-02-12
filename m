From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Feb 2010 11:15:58 -0000
Subject: 11MPCore SCU performance counters in perf
Message-ID: <000101caabd4$c0e526a0$42af73e0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

With the perf stuff now applied by Russell, I've had a go at porting the
oprofile backend to use perf. It's working well for v6 and v7 PMUs, but to
maintain full oprofile compatability, I need to add the following new features
to perf:

1.) Support for xscale1/xscale2 PMUs
2.) Support for the 11MPCore SCU

I've done (1), but I still need to test it on some hardware. As for (2), I'm not
sure how to proceed. The oprofile SCU driver [op_model_mpcore.c] appears only to
support one board [the Realview EB11MP] and uses the board specific macro
__io_address to get at the SCU. Furthermore, because oprofile expects to
associate events with a particular core, the SCU counters are divided up between
the cores. I think this has the potential to make profiling results quite
misleading because some events [e.g. `A read transfer is sent to the external
memory.'] are not tied to a core, but oprofile will be forced to choose one to
report it on.

Looking at the oprofile userspace sources, the SCU events don't appear to be
supported. The 11MPCore is the only ARM core to expose the SCU performance
counters in this way and basically, I don't think it's worth supporting in the
kernel...

...however, we will almost certainly want support for `uncore' counters in the
future [that is, counters not associated with a particular CPU]. I guess the
question is: do I hack SCU support into perf and establish a method for
supporting uncore counters at the same time, or shall I drop the SCU because of
the reasons above and leave the uncore problem for another day?

Please let me know what you think,

Will
