From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 6 Nov 2015 11:59:16 +0000
Subject: [PATCH v11 5/5] xen/arm: account for stolen ticks
In-Reply-To: <563C91FD.7060703@citrix.com>
References: <alpine.DEB.2.02.1511051502270.13541@kaball.uk.xensource.com>
 <1446737696-9749-5-git-send-email-stefano.stabellini@eu.citrix.com>
 <20151105165743.GG32247@leverpostej>
 <alpine.DEB.2.02.1511061126500.13541@kaball.uk.xensource.com>
 <563C91FD.7060703@citrix.com>
Message-ID: <20151106115916.GA23038@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 11:41:49AM +0000, David Vrabel wrote:
> On 06/11/15 11:39, Stefano Stabellini wrote:
> > On Thu, 5 Nov 2015, Mark Rutland wrote:
> >>>  static void xen_percpu_init(void)
> >>>  {
> >>>  	struct vcpu_register_vcpu_info info;
> >>> @@ -104,6 +120,8 @@ static void xen_percpu_init(void)
> >>>  	BUG_ON(err);
> >>>  	per_cpu(xen_vcpu, cpu) = vcpup;
> >>>  
> >>> +	xen_setup_runstate_info(cpu);
> >>
> >> Does the runstate memory area get unregsitered when a kernel tears
> >> things down, or is kexec somehow inhibited for xen guests?
> >>
> >> i couldn't spot either happening, but I may have missed it.
> > 
> > I don't think that the runstate memory area needs to be unregistered for
> > kexec, but I am not very knowledgeble on kexec and Xen, CC'ing Vitaly
> > and David.
> 
> There's a whole pile of other state needing to be reset for kexec (event
> channels and grant tables for example).  The guest needs to soft reset
> itself (available in Xen 4.6) before kexec'ing another kernel.
> 
> This soft reset would also including cleaning up this shared memory region.

Ok. So we don't currently have the code kernel-side, but it looks like
it would be relatively simple to add (having just spotted [1]), and
everything should be ready on the Xen side.`

Thanks,
Mark.

[1] https://lkml.org/lkml/2015/9/25/152
