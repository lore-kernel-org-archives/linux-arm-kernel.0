From: james.morse@arm.com (James Morse)
Date: Thu, 03 Aug 2017 16:25:19 +0100
Subject: [PATCH v3 0/5] ARM64: disable irq between breakpoint and step
 exception
In-Reply-To: <883651ba-2178-b5cf-7f6c-bfb2f6999a01@redhat.com>
References: <cover.1501496603.git.panand@redhat.com>
 <597F65BD.3070200@arm.com> <e78a8e67-48ab-421c-c316-3b55821f0eec@redhat.com>
 <59820835.1020301@arm.com> <883651ba-2178-b5cf-7f6c-bfb2f6999a01@redhat.com>
Message-ID: <5983405F.4010002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On 02/08/17 19:46, Pratyush Anand wrote:
> In my understanding problems are:
> (1) Single stepping of unwanted instruction (ie. instruction  next to enable_dbg
> from el1_irq)
> (2) We do not have memory at the end of el1_irq, so that we can set watchpoint
> exception generating instruction for single stepping.

Yes, for (2) the PSTATE.SS bit is saved in SPSR.SS when we take the irq, but it
isn't restored because we ERET from the irq handler with PSTATE.D clear.


> I think, we can find a way to take care for (2), but not sure how (1) can be
> taken care, without the approach I am taking.

We can fix (1) by making 'enable_dbg' inherit the debug state of the interrupted
EL1, unless the SPSR.SS bit is set, in which case we interrupted a
single-stepped instruction and shouldn't re-enable debug because we know must
MDSCR_EL1.SS be set.

This way a synchronous data-abort from a single-stepped instruction with
interrupts unmasked can unmask interrupts in el1_sync but keep debug disabled.
This should give us the least surprises if we call core-code.

I've posted a series that (in addition to your perf/watchpoint patches) fixes
all the issues I saw with your example. Can you test it fixes the
single-step:interrupt interaction on your platform?


Thanks,

James
