From: david.vrabel@citrix.com (David Vrabel)
Date: Tue, 6 May 2014 16:54:29 +0100
Subject: [Xen-devel] [PATCH] Xen: hibernation is x86-only at the moment
In-Reply-To: <alpine.DEB.2.02.1405061402520.14596@kaball.uk.xensource.com>
References: <5165529.jneGVBC5b5@wuerfel> <5360C1A7.8060401@citrix.com>
 <alpine.DEB.2.02.1405061402520.14596@kaball.uk.xensource.com>
Message-ID: <536905B5.6040900@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/14 14:35, Stefano Stabellini wrote:
> On Wed, 30 Apr 2014, David Vrabel wrote:
>> On 29/04/14 21:00, Arnd Bergmann wrote:
>>> In commit 603fb42a66499ab "ARM: 8011/1: ARM hibernation / suspend-to-disk",
>>> currently in linux-next, the ARM architecture gains support for
>>> hibernation (suspend-to-disk). Xen supports this in principle, but only
>>> has an architecture specific hypercall defined on x86, which leads
>>> to a build error when both hibernation and Xen support are enabled:
>>>
>>> drivers/xen/manage.c:105:2: error: implicit declaration of function 'HYPERVISOR_suspend' [-Werror=implicit-function-declaration]
>>>   si->cancelled = HYPERVISOR_suspend(si->arg);
>>>
>>> It is probably a good idea to define this hypercall on ARM as well
>>> and provide an implementation in the host, but until that is done,
>>> this patch helps disable the broken code in the Xen guest by making
>>> it depend on CONFIG_X86.
> 
> Thanks Arnd.
> 
> 
>> Since this isn't a regression in 3.15-rcX can you provide the
>> appropriate hypercall on ARM.  This does not require that there is an
>> implementation on Xen.
>>
>> When the Xen implementation exists it will be easier to use if the
>> support already exists in Linux.
> 
> 
> The sched_on hypercall is already implemented on ARM.
> However SCHEDOP_shutdown, defined as it is now, is unusable on ARM:
> 
> /*
>  * Halt execution of this domain (all VCPUs) and notify the system controller.
>  * @arg == pointer to sched_shutdown_t structure.
>  *
>  * If the sched_shutdown_t reason is SHUTDOWN_suspend then this
>  * hypercall takes an additional extra argument which should be the
>  * MFN of the guest's start_info_t.
>  *
>  * In addition, which reason is SHUTDOWN_suspend this hypercall
>  * returns 1 if suspend was cancelled or the domain was merely
>  * checkpointed, and 0 if it is resuming in a new domain.
>  */
> #define SCHEDOP_shutdown    2
> 
> 
> We don't have a start_info, and even if we had, we wouldn't know the
> MFN.
> I think we should make it available on ARM only if we change the
> interface making the third argument x86 only.  Of course that would
> impact the linux side implementation too.

We do not want a different number of arguments to this hypercall.  Just
pass 0 for the MFN.  This hypercall docs should be updated to say this.

This doesn't seem any different to x86 HVM where the start_info_mfn
parameter is also not relevant.

	if (xen_hvm_domain()) {
		si.arg = 0UL;
		si.pre = NULL;
		si.post = &xen_hvm_post_suspend;
	} else {
		si.arg = virt_to_mfn(xen_start_info);
		si.pre = &xen_pre_suspend;
		si.post = &xen_post_suspend;
	}

Changing this to be !xen_pv_domain() would then do the right thing for arm.

David
