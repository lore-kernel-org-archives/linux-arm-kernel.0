From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 31 Jan 2012 00:27:57 -0700 (MST)
Subject: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to
 pwrdm_clear_all_prev_pwrst()
In-Reply-To: <CAMQu2gyACq7RFyfnyNddDg7xRbHTTqsgXwMq6Ng4WfLxaatvAw@mail.gmail.com>
References: <20120130093931.11027.31048.stgit@dusk>
 <20120130094312.11027.31050.stgit@dusk> <878vkopw2o.fsf@ti.com>
 <CAMQu2gxyY50Bno_R2v1x98-ND47CrVpZBq+wA3POXz2+7E7eEw@mail.gmail.com>
 <alpine.DEB.2.00.1201302359320.10061@utopia.booyaka.com>
 <CAMQu2gyACq7RFyfnyNddDg7xRbHTTqsgXwMq6Ng4WfLxaatvAw@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1201310024510.10061@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 31 Jan 2012, Shilimkar, Santosh wrote:

> On Tue, Jan 31, 2012 at 12:45 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Tue, 31 Jan 2012, Shilimkar, Santosh wrote:
> >
> >> In this code the need is to clear only CPU and MPUPD, and hence they are
> >> explicitly cleared since the pre/post transition calls can be moved to PM_DEBUG
> >> in production kernels.
> >>
> >> But as you stated in current mainline kernel they are superfluous since the
> >> pre/post calls are not under PM debug. So I am ok either way
> >
> > We're using the PM counters for the context restore skip optimization now
> > in pwrdm_get_context_loss_count(), so they've suddenly become needed even
> > when PM_DEBUG=n. ?But those counters are only needed when there are
> > devices in the CPU* powerdomains to track that can lose logic context. ?I
> > don't think that's the case on OMAP4, but you would probably know better
> > than I.
> >
> Good point so the pre/post calls are must then. We should kill those extra calls
> form OMAP4 code then.

I wonder if we should track how many hwmods are present in a powerdomain?  
We could check that counter to determine if we could skip the access.

> > Another aspect is that previous powerstate accesses for the CPU*
> > powerdomains would theoretically go to the MPU local PRM rather than the
> > system PRCM. ?So they may actually return quickly. ?Haven't tested this.
> >
> You are correct. They do.

Cool.

> > The MPUSS powerdomain might be another case, though. ?There are a bunch of
> > devices in there: the local timers, APB debug devices, etc. ?We probably
> > have to worry about restoring context for some of those at some point.
> >
> MPUSS PD is at the global PRCM level but that one doesn't take time either.
> You need few more cycles to reach there.
> IIRC, other power domains use to take time because of the wait_transition
> calls we had. Mostly it was because of the BUGs you fixed. When get some
> time I will profile these calls and see if we still have that issue.

That would be interesting.  I was guessing that the previous powerstate 
registers in the global PRCM might be located in some clockdomain that was 
clocked at sys_clk or the 32KiHZ clock.  But if it's really just due to 
the wait_transition(), that might be something we can optimize...


- Paul
