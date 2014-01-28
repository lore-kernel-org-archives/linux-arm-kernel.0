From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 28 Jan 2014 18:11:57 +0000
Subject: [Xen-devel] [PATCH] arm/xen: Initialize event channels earlier
In-Reply-To: <52E7F02A.7010508@linaro.org>
References: <1390920842-21886-1-git-send-email-julien.grall@linaro.org>
 <alpine.DEB.2.02.1401281651400.4373@kaball.uk.xensource.com>
 <52E7EA78.5020305@linaro.org>
 <alpine.DEB.2.02.1401281742080.4373@kaball.uk.xensource.com>
 <52E7F02A.7010508@linaro.org>
Message-ID: <alpine.DEB.2.02.1401281809560.4373@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Jan 2014, Julien Grall wrote:
> On 01/28/2014 05:46 PM, Stefano Stabellini wrote:
> > On Tue, 28 Jan 2014, Julien Grall wrote:
> >>>> +static int xen_cpu_notification(struct notifier_block *self,
> >>>> +				unsigned long action,
> >>>> +				void *hcpu)
> >>>> +{
> >>>> +	int cpu = (long)hcpu;
> >>>> +
> >>>> +	switch (action) {
> >>>> +	case CPU_UP_PREPARE:
> >>>> +		xen_percpu_init(cpu);
> >>>> +		break;
> >>>> +	case CPU_STARTING:
> >>>> +		xen_interrupt_init();
> >>>> +		break;
> >>>
> >>> Is CPU_STARTING guaranteed to be called on the new cpu only?
> >>
> >> Yes.
> >>
> >>> If so, why not call both xen_percpu_init and xen_interrupt_init on
> >>> CPU_STARTING?
> >>
> >> Just in case that xen_vcpu is used somewhere else by a cpu notifier
> >> callback CPU_STARTING. We don't know which callback is called first.
> > 
> > Could you please elaborate a bit more on the problem you are trying to
> > describe?
> 
> We want to make sure that the vcpu is registered correctly. If not, we
> can't skip it and avoid xen to have a "dead" VCPU to schedule due to BUG_ON.
> 
> I agree that now we have a BUG_ON in the middle of xen_percpu_init, but
> it's possible to return an error. In this case Linux will skip this cpu
> and continue to boot.

I think there are no benefits in having two separate functions
(xen_percpu_init and xen_interrupt_init) called at two different points
(CPU_UP_PREPARE and CPU_STARTING).
I would simply have one. Simpler is better.


> >>> As it stands I think you introduced a subtle change (that might be OK
> >>> but I think is unintentional): xen_percpu_init might not be called from
> >>> the same cpu as its target anymore.
> >>
> >> No, xen_percpu_init and xen_interrupt_init are called on the boot cpu at
> >> the end of xen_guest_init.
> >  
> > Is CPU_UP_PREPARE guaranteed to be called on the target cpu? I think
> > not, therefore you would be executing xen_percpu_init for cpu1 on cpu0.
> >
> 
> I don't see any issue to execute xen_percpu_init for cpu1 on cpu0, all
> the code is taking directly the vcpu ID to initialize.

Me neither, I was simply pointing out that you made this change without
writing it in the commit message (therefore I assume it might be
unintended).
