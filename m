From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 Feb 2017 17:56:50 +0100
Subject: [PATCH 0/5] Fix regression introduced by set_irq_flags() removal
In-Reply-To: <alpine.DEB.2.11.1512081153410.3595@nanos>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20151020140427.GE3953@io.lakedaemon.net>
 <20151020160828.497fcc80@free-electrons.com>
 <alpine.DEB.2.11.1510202121590.8159@nanos>
 <20151111092638.587a53a4@free-electrons.com>
 <alpine.DEB.2.11.1511131509180.3987@nanos>
 <20151204120329.30a52cf4@free-electrons.com>
 <alpine.DEB.2.11.1512051823140.3595@nanos>
 <alpine.DEB.2.11.1512061018450.3595@nanos>
 <20151208095835.582dc34b@free-electrons.com>
 <alpine.DEB.2.11.1512081153410.3595@nanos>
Message-ID: <20170224175650.72115d4d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Tue, 8 Dec 2015 11:54:11 +0100 (CET), Thomas Gleixner wrote:
> On Tue, 8 Dec 2015, Thomas Petazzoni wrote:
> > When a device driver uses a normal (non per-CPU) interrupt, then it
> > doesn't have to take care of disabling the interrupt on suspend and
> > re-enabling the interrupt on resume at the interrupt controller level.
> > This is all transparently handled by the irqchip driver.
> > 
> > Why should the handling of per-CPU interrupts be different and require
> > explicit handling from each device driver rather than being
> > transparently handled by the irqchip driver ?  
> 
> Fair enough. Did not think about the boot cpu part.

I am reviving this *very* old thread, as I wanted to push the remaining
patches. But it seems like the issue no longer exists.

Summary of the story:

 - Between 4.2 and 4.3-rc, commit d17cab4451df1 broke suspend/resume on
   Armada XP. The issue was that the IRQ_NOAUTOEN was no longer
   cleared, and therefore irqd_irq_disabled() no longer indicated that
   our per-CPU interrupts were enabled, and consequently our local
   timer per-CPU interrupt was not re-enabled upon resume.

 - After some discussion, we merged a very simple workaround for 4.3,
   which consists in clearing IRQ_NOAUTOEN:

    irq_clear_status_flags(virq, IRQ_NOAUTOEN);

   But the idea was to do a better implementation later on, which my
   patch series at the same time was trying.

 - Now, fast forward to 4.10, if I remove the:

    irq_clear_status_flags(virq, IRQ_NOAUTOEN);

   then I can no longer reproduce the original issue from 4.3-rc, which
   clearing IRQ_NOAUTOEN was fixing. My system resumes fine.

Has there been some changes in this area that could explain that
irqd_irq_disable() now indicates that my per-CPU interrupt is enabled,
while it didn't say so back in 4.3-rc ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
