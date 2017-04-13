From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 13 Apr 2017 08:32:35 +0100
Subject: A question about vtimer interrupt when guest_exit
In-Reply-To: <B99C36949BCC8541A564076B659DD970671E7965@nkgeml514-mbs.china.huawei.com>
References: <B99C36949BCC8541A564076B659DD970671E7965@nkgeml514-mbs.china.huawei.com>
Message-ID: <1ae65d92-d69a-5420-7b40-4e3f67984a4d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/04/17 07:14, Wangxuefeng (E) wrote:
>  
> 
> Hi Marc,
> 
> I have a question about the vtimer ppi report when guest exit.
> 
>  
> 
> 1.       The flow: vtimer PPI assert->guest_exit->disable the
> vtimer->msr daifclear, #0x2
> 
>  
> 
> 2.       When disable the vtimer, the nCNTVIRQ will be cleared, then the
> clear request will be sent to GICD, GICD send clear request to GICC then
> clear the irq to CPU. So the clear request indeed be sent to CPU need
> some cycles(for example: N cycles),  
> 
> while the cpu execute from ?disable vtimer?  to ?clear the mask of irq?
> need M cycles, how the software make sure the interrupt won?t be taken
> by CPU before it indeed get the clear request?  Or the ARM architecture
> make sure M<N.

The architecture doesn't guarantee anything like that. If your GIC is
too slow to retire the pending interrupt by the time we unmask
interrupts at the CPU level, you'll get a (harmless) warning that we've
taken a spurious timer interrupt. This isn't a big deal, just the
indication that the HW is a bit imbalanced (fast CPU, slow GIC).

We may revise the way we handle the timer interrupt@some point,
taking the interrupt and keeping it active while injected into the guest.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
