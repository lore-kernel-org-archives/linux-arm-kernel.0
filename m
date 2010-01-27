From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Jan 2010 17:57:32 -0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <201001271840.47714.jpihet@mvista.com>
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
	<201001261847.44774.jpihet@mvista.com>
	<000701ca9f75$dbe071f0$93a155d0$@deacon@arm.com>
	<201001271840.47714.jpihet@mvista.com>
Message-ID: <000801ca9f7a$338d5f90$9aa81eb0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

Jean Pihet wrote:

> > However, if the IRQs are
> > defined, but for some reason we fail to request them, then the
> > armpmu_reserve_hardware function will fail.
> That is the expected behaviour, isn't it?
> Why is the PMU request failing? That is worth investigating. I never had that
> problem on the Cortex-A8. Is it caused because of the multicore?

Don't worry, requesting the IRQs did not fail. I was simply speculating about
the behaviour if it *does* fail. Then armpmu_reserve_hardware will return an
error, which will prevent the event being added. Instead, we could print a
warning, but continue without IRQs in the same manner as though they had not
been defined in pmu.c.
 
> > Actually, the return
> > value appears to be uninitialised if you don't have any IRQs defined.
> If the PMU request fails the IRQ should not be requested, so I think it is ok.
> Is that correct?

What I mean is, if pmu_irqs->num_irqs < 1, then we return err without ever
setting it. In fact, we might even end up freeing IRQs which we haven't
requested which could cause all sorts of problems.

> >
> > Anyway, apart from that, it appeared to work fine.
> Good!
> 
> Thanks for testing!
> Jean
> 
> > Tested-by: Will Deacon <will.deacon@arm.com>

That's alright, but it's conditional on sorting out the above! :)

Cheers,

Will
