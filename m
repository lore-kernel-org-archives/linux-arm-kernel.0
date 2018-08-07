From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 7 Aug 2018 11:05:02 +0100
Subject: [PATCH] arm64: Trap WFI executed in userspace
In-Reply-To: <20180807093326.5090-1-marc.zyngier@arm.com>
References: <20180807093326.5090-1-marc.zyngier@arm.com>
Message-ID: <20180807100437.GA9097@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2018 at 10:33:26AM +0100, Marc Zyngier wrote:
> It recently came to light that userspace can execute WFI, and that
> the arm64 kernel doesn trap this event. This sounds rather benign,
> but the kernel should decide when it wants to wait for an interrupt,
> and not userspace.
> 
> Let's trap WFI and treat it as a way to yield the CPU to another
> process.

This doesn't amount to a justification.

If the power controller is unexpectedly left in a bad state so that
WFI will do something nasty to a cpu that may enter userspace, then we
probably have bigger problems.

So, maybe it really is pretty harmless to let userspace execute this.

I can't think of a legitimate reason for userspace to execute WFI
however.  Userspace doesn't have interrupts under Linux, so it makes
no sense to wait for one.

Have we seen anybody using WFI in userspace?  It may be cleaner to
map this to SIGILL rather than be permissive and regret it later.

[...]

Cheers
---Dave
