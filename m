From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Mar 2011 23:14:32 +0000
Subject: [PATCH 6/6] ARM: nmk: update GPIO chained IRQ handler to use
	EOI in parent chip
In-Reply-To: <alpine.LFD.2.00.1103012133530.2701@localhost6.localdomain6>
References: <1298900022-21516-1-git-send-email-will.deacon@arm.com>
	<1298900022-21516-7-git-send-email-will.deacon@arm.com>
	<20110228140327.GA1937@n2100.arm.linux.org.uk>
	<001401cbd772$a1f93ae0$e5ebb0a0$@deacon@arm.com>
	<alpine.LFD.2.00.1102281949050.2701@localhost6.localdomain6>
	<20110228214445.GD1937@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1103011140560.2701@localhost6.localdomain6>
	<20110301201904.GA27107@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1103012133530.2701@localhost6.localdomain6>
Message-ID: <20110301231432.GG27107@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2011 at 10:29:37PM +0100, Thomas Gleixner wrote:
> Can you please take the time and explain me the difference of the
> following:

Can you please take the time to realise that sometimes the combination
between the primary and secondary interrupt controller is so tied that
this kind of thing can't happen?

Sometimes the secondary interrupt controller *must* mask the parent
interrupt because it has no masking capability of its own.

Sometimes the secondary interrupt controller *must* cause the primary
controller to ack the interrupt status *before* the secondary handler
reads the status.

You can not say "the primary controller behaves like X so we always do
X" because the action required on the primary is a combination of how
the primary behaves *and* how the secondary behaves.

Consider for example an edge triggered interrupt connected to a secondary
controller - yes, we have that combination.  When you read the secondary
status register and clear those interrupts which are pending, the
secondary controller resets to inactive its output.  If there's still
pending interrupts, it re-asserts the output causing a new edge.

If your primary 'flow' handler were to acknowledge the interrupt *after*
the demux, you'd lose interrupts.

However, if the very same primary interrupt controller is connected to
a FPGA based oring of several interrupt sources, this has to ack before
reading the status, read the status, process *all* interrupts, re-ack,
re-read the status and repeat until the status register indicates no
further interrupts are pending.

You can't deal with these two situations if you tie all the primary
flow handling outside of the secondary demux handler.  And it's
*wrong* to do so.  The behaviour required for the primary controller
inherently depends on the secondary controller.

It may not be clean from a software point of view, but that's hardware
for you, and we have to make this work.  You *can't* do that by
separating the primary flow from the demux.
