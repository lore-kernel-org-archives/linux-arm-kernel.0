From: vkuznets@redhat.com (Vitaly Kuznetsov)
Date: Fri, 06 Nov 2015 14:25:40 +0100
Subject: [PATCH v11 5/5] xen/arm: account for stolen ticks
In-Reply-To: <20151106115916.GA23038@leverpostej> (Mark Rutland's message of
 "Fri, 6 Nov 2015 11:59:16 +0000")
References: <alpine.DEB.2.02.1511051502270.13541@kaball.uk.xensource.com>
 <1446737696-9749-5-git-send-email-stefano.stabellini@eu.citrix.com>
 <20151105165743.GG32247@leverpostej>
 <alpine.DEB.2.02.1511061126500.13541@kaball.uk.xensource.com>
 <563C91FD.7060703@citrix.com> <20151106115916.GA23038@leverpostej>
Message-ID: <87egg3p8dn.fsf@vitty.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland <mark.rutland@arm.com> writes:

> On Fri, Nov 06, 2015 at 11:41:49AM +0000, David Vrabel wrote:
>> On 06/11/15 11:39, Stefano Stabellini wrote:
>> > On Thu, 5 Nov 2015, Mark Rutland wrote:
>> >>>  static void xen_percpu_init(void)
>> >>>  {
>> >>>  	struct vcpu_register_vcpu_info info;
>> >>> @@ -104,6 +120,8 @@ static void xen_percpu_init(void)
>> >>>  	BUG_ON(err);
>> >>>  	per_cpu(xen_vcpu, cpu) = vcpup;
>> >>>  
>> >>> +	xen_setup_runstate_info(cpu);
>> >>
>> >> Does the runstate memory area get unregsitered when a kernel tears
>> >> things down, or is kexec somehow inhibited for xen guests?
>> >>
>> >> i couldn't spot either happening, but I may have missed it.
>> > 
>> > I don't think that the runstate memory area needs to be unregistered for
>> > kexec, but I am not very knowledgeble on kexec and Xen, CC'ing Vitaly
>> > and David.
>> 
>> There's a whole pile of other state needing to be reset for kexec (event
>> channels and grant tables for example).  The guest needs to soft reset
>> itself (available in Xen 4.6) before kexec'ing another kernel.
>> 
>> This soft reset would also including cleaning up this shared memory region.
>
> Ok. So we don't currently have the code kernel-side, but it looks like
> it would be relatively simple to add (having just spotted [1])

already merged in 4.3 and several stable trees.

> , and everything should be ready on the Xen side.`
>

Yes, but for x86 only. arch_domain_soft_reset() is -ENOSYS for ARM
now. It should be relatively easy to implement, one should unmap
shared_info page and do some GIC cleanup (if it's needed at all). I'd be
happy to help if someone's interested but unfortunately I don't have ARM
hardware to test at this moment...

> Thanks,
> Mark.
>
> [1] https://lkml.org/lkml/2015/9/25/152

-- 
  Vitaly
