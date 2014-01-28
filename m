From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 28 Jan 2014 17:46:44 +0000
Subject: [Xen-devel] [PATCH] arm/xen: Initialize event channels earlier
In-Reply-To: <52E7EA78.5020305@linaro.org>
References: <1390920842-21886-1-git-send-email-julien.grall@linaro.org>
 <alpine.DEB.2.02.1401281651400.4373@kaball.uk.xensource.com>
 <52E7EA78.5020305@linaro.org>
Message-ID: <alpine.DEB.2.02.1401281742080.4373@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Jan 2014, Julien Grall wrote:
> >> +static int xen_cpu_notification(struct notifier_block *self,
> >> +				unsigned long action,
> >> +				void *hcpu)
> >> +{
> >> +	int cpu = (long)hcpu;
> >> +
> >> +	switch (action) {
> >> +	case CPU_UP_PREPARE:
> >> +		xen_percpu_init(cpu);
> >> +		break;
> >> +	case CPU_STARTING:
> >> +		xen_interrupt_init();
> >> +		break;
> > 
> > Is CPU_STARTING guaranteed to be called on the new cpu only?
> 
> Yes.
> 
> > If so, why not call both xen_percpu_init and xen_interrupt_init on
> > CPU_STARTING?
> 
> Just in case that xen_vcpu is used somewhere else by a cpu notifier
> callback CPU_STARTING. We don't know which callback is called first.

Could you please elaborate a bit more on the problem you are trying to
describe?


> > As it stands I think you introduced a subtle change (that might be OK
> > but I think is unintentional): xen_percpu_init might not be called from
> > the same cpu as its target anymore.
> 
> No, xen_percpu_init and xen_interrupt_init are called on the boot cpu at
> the end of xen_guest_init.
 
Is CPU_UP_PREPARE guaranteed to be called on the target cpu? I think
not, therefore you would be executing xen_percpu_init for cpu1 on cpu0.
