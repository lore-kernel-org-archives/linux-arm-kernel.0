From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 9 Aug 2018 13:34:57 +0100
Subject: [PATCH] arm64: Trap WFI executed in userspace
In-Reply-To: <20180808123408.GC24736@iMac.local>
References: <20180807093326.5090-1-marc.zyngier@arm.com>
 <20180807100437.GA9097@e103592.cambridge.arm.com>
 <9af8bb9a-7c6c-2560-5965-118dfadf8141@arm.com>
 <20180808123408.GC24736@iMac.local>
Message-ID: <20180809123457.GN9097@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2018 at 01:34:09PM +0100, Catalin Marinas wrote:
> On Tue, Aug 07, 2018 at 11:24:34AM +0100, Marc Zyngier wrote:
> > On 07/08/18 11:05, Dave Martin wrote:
> > > On Tue, Aug 07, 2018 at 10:33:26AM +0100, Marc Zyngier wrote:
> > >> It recently came to light that userspace can execute WFI, and that
> > >> the arm64 kernel doesn trap this event. This sounds rather benign,
> 
> Nitpick: "doesn't".
> 
> > >> but the kernel should decide when it wants to wait for an interrupt,
> > >> and not userspace.
> > >>
> > >> Let's trap WFI and treat it as a way to yield the CPU to another
> > >> process.
> [...]
> > > I can't think of a legitimate reason for userspace to execute WFI
> > > however.  Userspace doesn't have interrupts under Linux, so it makes
> > > no sense to wait for one.
> > > 
> > > Have we seen anybody using WFI in userspace?  It may be cleaner to
> > > map this to SIGILL rather than be permissive and regret it later.
> > 
> > I couldn't find any user, and I'm happy to just send userspace to hell
> > in that case. But it could also been said that since it was never
> > prevented, it is a de-facto ABI.
> 
> I wouldn't really go as far as SIGILL on WFI. I think the patch is fine
> as it is. In case Will plans to merge it:

For practical purposes I agree, because we can't control the binary
blobs out there: I just wanted to bang the drum because we are creating
semantics here and there is not an obvious correct answer to what they
should be.

I'd still like to see rationale for why this should map to schedule()
(which userspace currently has no direct way to trigger) as opposed to
sched_yield() or something like that.

[...]

Cheers
---Dave
