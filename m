From: sstabellini@kernel.org (Stefano Stabellini)
Date: Thu, 8 Sep 2016 11:12:13 -0700 (PDT)
Subject: [PATCH] arm/xen: fix SMP guests boot
In-Reply-To: <1473328108-30658-1-git-send-email-vkuznets@redhat.com>
References: <1473328108-30658-1-git-send-email-vkuznets@redhat.com>
Message-ID: <alpine.DEB.2.10.1609081111070.2359@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Sep 2016, Vitaly Kuznetsov wrote:
> Commit 88e957d6e47f ("xen: introduce xen_vcpu_id mapping") broke SMP ARM
> guests on Xen. When FIFO-based event channels are in use (this is the
> default), evtchn_fifo_alloc_control_block() is called on CPU_UP_PREPARE
> event and this happens before we set up xen_vcpu_id mapping in
> xen_starting_cpu. Temporary fix the issue by setting direct Linux CPU id
> <-> Xen vCPU id mapping for all possible CPUs at boot. We don't currently
> support kexec/kdump on Xen/ARM so these ids always match.
> 
> In future, we have several ways to solve the issue, e.g.:
> - Eliminate all hypercalls from CPU_UP_PREPARE, do them from the starting
> CPU. This can probably be done for both x86 and ARM and, if done, will
> allow us to get Xen's idea of vCPU id from CPUID/MPIDR on the starting CPU
> directly, no messing with ACPI/device tree required.
> - Save vCPU id information from ACPI/device tree on ARM and use it to
> initialize xen_vcpu_id mapping. This is the same trick we currently do on
> x86.
> 
> Reported-by: Julien Grall <julien.grall@arm.com>
> Tested-by: Wei Chen <Wei.Chen@arm.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> It would be nice if this patch could still make it to 4.8 as all SMP
> ARM/Xen guests are currently broken.

Yes


>  arch/arm/xen/enlighten.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 3d2cef6..f193414 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -170,9 +170,6 @@ static int xen_starting_cpu(unsigned int cpu)
>  	pr_info("Xen: initializing cpu%d\n", cpu);
>  	vcpup = per_cpu_ptr(xen_vcpu_info, cpu);
>  
> -	/* Direct vCPU id mapping for ARM guests. */
> -	per_cpu(xen_vcpu_id, cpu) = cpu;
> -
>  	info.mfn = virt_to_gfn(vcpup);
>  	info.offset = xen_offset_in_page(vcpup);
>  
> @@ -330,6 +327,7 @@ static int __init xen_guest_init(void)
>  {
>  	struct xen_add_to_physmap xatp;
>  	struct shared_info *shared_info_page = NULL;
> +	int cpu;
>  
>  	if (!xen_domain())
>  		return 0;
> @@ -380,7 +378,8 @@ static int __init xen_guest_init(void)
>  		return -ENOMEM;
>  
>  	/* Direct vCPU id mapping for ARM guests. */
> -	per_cpu(xen_vcpu_id, 0) = 0;
> +	for_each_possible_cpu(cpu)
> +		per_cpu(xen_vcpu_id, cpu) = cpu;
>  
>  	xen_auto_xlat_grant_frames.count = gnttab_max_grant_frames();
>  	if (xen_xlate_map_ballooned_pages(&xen_auto_xlat_grant_frames.pfn,
> -- 
> 2.7.4
> 
