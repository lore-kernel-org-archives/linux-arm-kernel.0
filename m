From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Sep 2014 19:21:37 +0100
Subject: [PATCH] ARM: perf: Don't sleep while atomic when enabling
 per-cpu interrupts
In-Reply-To: <540F3EE5.90500@codeaurora.org>
References: <1410200814-25878-1-git-send-email-sboyd@codeaurora.org>
 <20140909113943.GG1754@arm.com> <540F3EE5.90500@codeaurora.org>
Message-ID: <20140910182137.GL1710@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 06:54:45PM +0100, Stephen Boyd wrote:
> On 09/09/14 04:39, Will Deacon wrote:
> > It's interesting that arm64 isn't affected by this problem, since we don't
> > update the active_irqs mask for PPIs there and consequently just pass the
> > irq instead of the cpu_pmu. I can't see why we actually need to update the
> > active_irqs mask for arch/arm/, so could we remove that and follow arm64's
> > lead instead? That would remove the need for a new struct definition too.
> >
> 
> I guess you're saying that we don't need the active_irqs mask in the
> percpu irq case? It looks like we still use it to determine when the
> last CPU PMU has been disabled in the non-percpu case.

Correct.

> Here's the interdiff. Is there a reason arm64 casts data to an unsigned
> int pointer when what's passed is an int pointer?

There has to be a cast to something because data is a void *.
enable_percpu_irq takes an unsigned int, so I guess that's why it was
chosen. I'm not fussed either way.

Feel free to submit the full patch with my ack:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
