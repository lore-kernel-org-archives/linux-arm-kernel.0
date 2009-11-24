From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Nov 2009 15:19:18 +0000
Subject: [PATCH 1/2] ARM: Implemented support for VFP PM context saving
In-Reply-To: <1259068826.13956.22.camel@pc1117.cambridge.arm.com>
References: <1259059024-23719-1-git-send-email-tero.kristo@nokia.com>
	<1259059024-23719-2-git-send-email-tero.kristo@nokia.com>
	<20091124114836.GA10510@n2100.arm.linux.org.uk>
	<1259068826.13956.22.camel@pc1117.cambridge.arm.com>
Message-ID: <20091124151918.GB14462@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2009 at 01:20:26PM +0000, Catalin Marinas wrote:
> BTW, the two patches below were mentioned to me some time ago but I
> haven't got the time to look at them:
> 
> [ARM] vfp: Fix bug in vfp_pm_suspend
> https://www.codeaurora.org/gitweb/quic/le/?p=kernel/msm.git;a=commit;h=88984c9b2d69c222ee1e2afc948ca73f597d40ff

This one is bad - it gets the current CPU by directly referencing ti->cpu.
Too bad if you have kernel preemption enabled; the value obtained that
way is effectively meaningless.  The only way to get a meaningful value
is via 'get_cpu()' and after you've done with using it, 'put_cpu()'.
That ensures you can't be preempted onto a different CPU mid-operation.

It's safe in vfp_notifier because we're called in an already atomic context.

> [ARM] vfp: Add additional vfp interfaces
> https://www.codeaurora.org/gitweb/quic/le/?p=kernel/msm.git;a=commit;h=393e4bfaaf79377d29cd6bb2228f87601aeca668

I don't like what's in this one.  Lack of explaination in the commit log
doesn't help.
