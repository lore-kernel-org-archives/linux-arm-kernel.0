From: vkuznets@redhat.com (Vitaly Kuznetsov)
Date: Fri, 06 Nov 2015 14:19:08 +0100
Subject: [PATCH v11 5/5] xen/arm: account for stolen ticks
In-Reply-To: <563C91FD.7060703@citrix.com> (David Vrabel's message of "Fri, 6
 Nov 2015 11:41:49 +0000")
References: <alpine.DEB.2.02.1511051502270.13541@kaball.uk.xensource.com>
 <1446737696-9749-5-git-send-email-stefano.stabellini@eu.citrix.com>
 <20151105165743.GG32247@leverpostej>
 <alpine.DEB.2.02.1511061126500.13541@kaball.uk.xensource.com>
 <563C91FD.7060703@citrix.com>
Message-ID: <87io5fp8oj.fsf@vitty.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Vrabel <david.vrabel@citrix.com> writes:

> On 06/11/15 11:39, Stefano Stabellini wrote:
>> On Thu, 5 Nov 2015, Mark Rutland wrote:
>>>>  static void xen_percpu_init(void)
>>>>  {
>>>>  	struct vcpu_register_vcpu_info info;
>>>> @@ -104,6 +120,8 @@ static void xen_percpu_init(void)
>>>>  	BUG_ON(err);
>>>>  	per_cpu(xen_vcpu, cpu) = vcpup;
>>>>  
>>>> +	xen_setup_runstate_info(cpu);
>>>
>>> Does the runstate memory area get unregsitered when a kernel tears
>>> things down, or is kexec somehow inhibited for xen guests?
>>>
>>> i couldn't spot either happening, but I may have missed it.
>> 
>> I don't think that the runstate memory area needs to be unregistered for
>> kexec, but I am not very knowledgeble on kexec and Xen, CC'ing Vitaly
>> and David.
>
> There's a whole pile of other state needing to be reset for kexec (event
> channels and grant tables for example).  The guest needs to soft reset
> itself (available in Xen 4.6) before kexec'ing another kernel.

Unfortunately, it's 4.7. Soft reset patch series was merged after 4.6
freeze so it is only available in current master git branch.

>
> This soft reset would also including cleaning up this shared memory region.
>
> David

-- 
  Vitaly
