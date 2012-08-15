From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 15 Aug 2012 18:05:55 +0100
Subject: [PATCH 0/3] New algorithm for ASID allocation and rollover
In-Reply-To: <1345049642-29704-1-git-send-email-will.deacon@arm.com>
References: <1345049642-29704-1-git-send-email-will.deacon@arm.com>
Message-ID: <502BD6F3.9080909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/08/12 17:53, Will Deacon wrote:
> Hello,
> 
> Following some investigation into preempt-rt Linux, it became apparent
> that ASID rollover can happen fairly regularly under certain heavy
> scheduling workloads. Each time this happens, we broadcast an interrupt
> to the secondary CPUs so that we can reset the global ASID numberspace
> without assigning duplicate ASIDs to different tasks or accidentally
> assigning different ASIDs to threads of the same process.
> 
> This leads to a large number of expensive IPIs between cores:
> 
>            CPU0       CPU1
> IPI0:          0          0  Timer broadcast interrupts
> IPI1:      23165     115888  Rescheduling interrupts
> IPI2:          0          0  Function call interrupts
> IPI3:       6619       1123  Single function call interrupts <---- IPIs
> IPI4:          0          0  CPU stop interrupts
> 
> Digging deeper, this also leads to an extremely varied waittime on the
> cpu_asid_lock. Granted this is only contended for <1% of the time, but
> the waittime varies between 0.5 and 734 us!
> 
> After some discussion, it became apparent that tracking the ASIDs
> currently active on the cores in the system means that, on rollover, we
> can automatically reserve those that are in use without having to stop
> the world.
> 
> This patch series develops that idea so that:
> 
>   - We can support cores without hardware broadcasting of TLB maintenance
>     operations without resorting to IPIs.

This particular bit should benefit even more to virtual machines, as it
avoids trapping back to the host to handle a write to the (emulated) GIC
distributor, and the corresponding interrupt injection on the target vcpus.

I'll give it a spin on KVM.

	M.
-- 
Jazz is not dead. It just smells funny...
