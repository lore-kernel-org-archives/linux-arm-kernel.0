From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 30 Aug 2016 12:21:13 +0100
Subject: [PATCH] generic: Add the exception case checking routine for ppi
 interrupt
In-Reply-To: <57C568F8.20802@arm.com>
References: <1472530639-21616-1-git-send-email-majun258@huawei.com>
 <57C548D0.3090700@arm.com> <57C5617B.6080801@huawei.com>
 <57C568F8.20802@arm.com>
Message-ID: <20160830112113.GE1223@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 12:07:36PM +0100, Marc Zyngier wrote:
> +Mark
> On 30/08/16 11:35, majun (F) wrote:
> > ? 2016/8/30 16:50, Marc Zyngier ??:
> >> On 30/08/16 05:17, MaJun wrote:
> >>> From: Ma Jun <majun258@huawei.com>
> >>>
> >>> During system booting, if the interrupt which has no action registered
> >>> is triggered, it would cause system panic when try to access the
> >>> action member.
> >>
> >> And why would that interrupt be enabled? If you enable a PPI before
> >> registering a handler, you're doing something wrong.
> > 
> > Actually,the problem described above happened during the capture
> > kernel booting.
> > 
> > In my system, sometimes there is a pending physical timer
> > interrupt(30) when the first kernel panic and the status is kept
> > until the capture kernel booting.
> 
> And that's perfectly fine. The interrupt can be pending forever, as it
> shouldn't get enabled.
> 
> > So, this interrupt will be handled during capture kernel booting.
> 
> Why? Who enables it?
> 
> > Becasue we use virt timer interrupt but not physical timer interrupt
> > in capture kernel, the interrupt 30 has no action handler.
> 
> Again: who enables this interrupt? Whichever driver enables it should be
> fixed.

I'm also at a loss.

In this case, arch_timer_uses_ppi must be VIRT_PPI. So in
arch_timer_register(), we'll only request_percpu_irq the virt PPI.
arch_timer_has_nonsecure_ppi() will be false, given arch_timer_uses_ppi
is VIRT_PPI, so in arch_timer_starting_cpu() we'll only
enable_percpu_irq() the virt PPI.

We don't fiddle with arch_timer_uses_ppi after calling
arch_timer_register(). So I can't see how we could enable another IRQ in
this case.

Looking at the driver in virt/kvm/arm/arch_timer.c, we only enable what
we've succesfully requested, so it doesnt' seem like there's an issue
there.

>From a quick look at teh GIC driver, it looks like we reset PPIs
correctly, so it doesn't look like we have a "latent enable".

Thanks,
Mark.
