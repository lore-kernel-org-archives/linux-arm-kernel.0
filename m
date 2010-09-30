From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Sep 2010 21:48:57 +0100
Subject: [PATCH 2/4] arm: dis-allow hotplug on MSM
In-Reply-To: <1285879245.14953.29.camel@c-dwalke-linux.qualcomm.com>
References: <1284062289-10914-3-git-send-email-dwalker@codeaurora.org>
	<20100930071919.GA6434@ucw.cz>
	<1285865137.14953.4.camel@c-dwalke-linux.qualcomm.com>
	<1285870183.14953.7.camel@c-dwalke-linux.qualcomm.com>
	<20100930195237.GA2174@elf.ucw.cz>
	<1285876546.14953.10.camel@c-dwalke-linux.qualcomm.com>
	<20100930200246.GB2174@elf.ucw.cz>
	<1285877287.14953.13.camel@c-dwalke-linux.qualcomm.com>
	<20100930201749.GA11660@n2100.arm.linux.org.uk>
	<1285879245.14953.29.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100930204857.GB11660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 30, 2010 at 01:40:45PM -0700, Daniel Walker wrote:
> On Thu, 2010-09-30 at 21:17 +0100, Russell King - ARM Linux wrote:
> > If you make them spin, you'll eat power until the system powers them off.
> > As things currently stand though, we don't have enough code out of the
> > init sections to allow a SMP restart from power-off.  So, S2RAM isn't
> > going to work on secondary processors at the moment _anyway_.
> 
> When you say "SMP restart" do you mean resume?

Yes.

> If I did make them spin wouldn't suspend and resume work at that point?

Normally with S2RAM, CPU state is saved, and the CPU is powered down.
That's how it seems to work on all the ARM UP platforms, and I don't
see any reason why someone implementing suspend would want to leave
the CPUs powered during S2RAM - they'd gobble power.

> > Current CPU hotplug implementations are based around taking CPUs offline
> > without powering them off for run-time power saving only.
> 
> What I was thinking with the stubs is to fake the offlining. So it's not
> power efficient , but suspend still works.

The question you need to research is: does putting the system into
suspend mode result in power being lost to the CPUs?

If the answer is yes, then as things currently stand you'll lose the
secondary CPUs when you try to resume the system as the code necessary
to bring them back online will have been discarded.

If the answer is no, suspend won't be useful because the other CPUs will
be spinning, thereby consuming more power than an idle system would be.

I think you'll find though that suspend mode will result in power being
lost to all CPUs.
