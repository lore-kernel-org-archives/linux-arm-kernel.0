From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Sep 2010 21:17:49 +0100
Subject: [PATCH 2/4] arm: dis-allow hotplug on MSM
In-Reply-To: <1285877287.14953.13.camel@c-dwalke-linux.qualcomm.com>
References: <1284062289-10914-1-git-send-email-dwalker@codeaurora.org>
	<1284062289-10914-3-git-send-email-dwalker@codeaurora.org>
	<20100930071919.GA6434@ucw.cz>
	<1285865137.14953.4.camel@c-dwalke-linux.qualcomm.com>
	<1285870183.14953.7.camel@c-dwalke-linux.qualcomm.com>
	<20100930195237.GA2174@elf.ucw.cz>
	<1285876546.14953.10.camel@c-dwalke-linux.qualcomm.com>
	<20100930200246.GB2174@elf.ucw.cz>
	<1285877287.14953.13.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100930201749.GA11660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 30, 2010 at 01:08:07PM -0700, Daniel Walker wrote:
> That's actually what I had original, Russell offered this as an
> alternative. Now that I think about the stubs tho, I'm not sure it's
> that bad an idea. All the stubs would do is not put the core into a
> lower powermode, but would allow suspend. It wouldn't be very
> efficient , but suspend would work.

If you just provide empty stubs, esp. for platform_cpu_die(), then an
attempt to take a CPU offline will result in it immediately restarting
back into the kernel - which will probably result in an oops as the
kernel won't be expecting the CPU to come back.

If you make them spin, you'll eat power until the system powers them off.
As things currently stand though, we don't have enough code out of the
init sections to allow a SMP restart from power-off.  So, S2RAM isn't
going to work on secondary processors at the moment _anyway_.

Current CPU hotplug implementations are based around taking CPUs offline
without powering them off for run-time power saving only.

I have been working on a set of patches recently to reorganize the
various head.S code to allow SMP restart from a CPU power-down, which
is almost ready.
