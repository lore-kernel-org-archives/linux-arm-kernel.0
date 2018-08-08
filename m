From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 8 Aug 2018 13:34:09 +0100
Subject: [PATCH] arm64: Trap WFI executed in userspace
In-Reply-To: <9af8bb9a-7c6c-2560-5965-118dfadf8141@arm.com>
References: <20180807093326.5090-1-marc.zyngier@arm.com>
 <20180807100437.GA9097@e103592.cambridge.arm.com>
 <9af8bb9a-7c6c-2560-5965-118dfadf8141@arm.com>
Message-ID: <20180808123408.GC24736@iMac.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2018 at 11:24:34AM +0100, Marc Zyngier wrote:
> On 07/08/18 11:05, Dave Martin wrote:
> > On Tue, Aug 07, 2018 at 10:33:26AM +0100, Marc Zyngier wrote:
> >> It recently came to light that userspace can execute WFI, and that
> >> the arm64 kernel doesn trap this event. This sounds rather benign,

Nitpick: "doesn't".

> >> but the kernel should decide when it wants to wait for an interrupt,
> >> and not userspace.
> >>
> >> Let's trap WFI and treat it as a way to yield the CPU to another
> >> process.
[...]
> > I can't think of a legitimate reason for userspace to execute WFI
> > however.  Userspace doesn't have interrupts under Linux, so it makes
> > no sense to wait for one.
> > 
> > Have we seen anybody using WFI in userspace?  It may be cleaner to
> > map this to SIGILL rather than be permissive and regret it later.
> 
> I couldn't find any user, and I'm happy to just send userspace to hell
> in that case. But it could also been said that since it was never
> prevented, it is a de-facto ABI.

I wouldn't really go as far as SIGILL on WFI. I think the patch is fine
as it is. In case Will plans to merge it:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
