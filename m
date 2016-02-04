From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 4 Feb 2016 09:32:03 +0000
Subject: [PATCH] irqchip-gicv3: wait for ack from redistributer after
 read_iar
In-Reply-To: <1454528588-32721-1-git-send-email-tchalamarla@caviumnetworks.com>
References: <1454528588-32721-1-git-send-email-tchalamarla@caviumnetworks.com>
Message-ID: <56B31A93.5050608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tirumalesh,

On 03/02/16 19:43, tchalamarla at caviumnetworks.com wrote:
> From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
> 
> Systems with high number of cores and sufficiently loaded,
> there exists a small window where it is possible for re-distributor
> to illegally merge two LPI and cuases missing interrupts.

s/cuases/causes/

It has nothing to do with the number of cores or the load, but
everything to do with the latency between the CPU interface and the
redistributor, and how quickly the redistributor gets notified that the
interrupt is not pending anymore.

> 
> Solution is, wait for ack from the redistributor after read_iar.
> A "dsb sy" after IAR read ensures there is no illegal merge windows.

You don't "wait for the ack". You actually *push* the ack (as in
Interrupt Acknowledgement Register) towards the redistributor.

The fact that the DSB generates an ACK message from the redistributor is
an HW implementation detail is not universally relevant. Please stay at
the architecture level, and avoid implementation details.

> 
> giv3 spec version 32 also warns this, see section 4.4.13

What is the point of pointing to an engineering specification that is
unavailable to almost anyone (hint: it has the word "Confidential" on
each and every page)?

A much better reference would be a quote from the publicly available GIC
Architecture Specification (ARM IHI 0069B). Something like:

4.1.1 Physical CPU Interface:
"The effects of reading ICC_IAR0_EL1 and ICC_IAR1_EL1 on the state of a
returned INTID are not guaranteed to be visible until after the
execution of a DSB."

> 
> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
> ---
>  arch/arm64/include/asm/arch_gicv3.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
> index 2731d3b..8ec88e5 100644
> --- a/arch/arm64/include/asm/arch_gicv3.h
> +++ b/arch/arm64/include/asm/arch_gicv3.h
> @@ -103,6 +103,7 @@ static inline u64 gic_read_iar_common(void)
>  	u64 irqstat;
>  
>  	asm volatile("mrs_s %0, " __stringify(ICC_IAR1_EL1) : "=r" (irqstat));
> +	dsb(sy);
>  	return irqstat;
>  }
>  
> 

Other than that, I'm fine with this. Please repost with an amended
commit message and subject.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
