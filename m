From: james.morse@arm.com (James Morse)
Date: Fri, 6 Apr 2018 11:02:56 +0100
Subject: [PATCH 1/5] arm64: entry: isb in el1_irq
In-Reply-To: <20180405171800.5648-2-ynorov@caviumnetworks.com>
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
 <20180405171800.5648-2-ynorov@caviumnetworks.com>
Message-ID: <5036b99a-9faa-c220-27dd-e0d73f8b3fc7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yury,

On 05/04/18 18:17, Yury Norov wrote:
> Kernel text patching framework relies on IPI to ensure that other
> SMP cores observe the change. Target core calls isb() in IPI handler

(Odd, if its just to synchronize the CPU, taking the IPI should be enough).


> path, but not at the beginning of el1_irq entry. There's a chance
> that modified instruction will appear prior isb(), and so will not be
> observed.
> 
> This patch inserts isb early at el1_irq entry to avoid that chance.


> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index ec2ee720e33e..9c06b4b80060 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -593,6 +593,7 @@ ENDPROC(el1_sync)
>  
>  	.align	6
>  el1_irq:
> +	isb					// pairs with aarch64_insn_patch_text
>  	kernel_entry 1
>  	enable_da_f
>  #ifdef CONFIG_TRACE_IRQFLAGS
> 

An ISB at the beginning of the vectors? This is odd, taking an IRQ to get in
here would be a context-synchronization-event too, so the ISB is superfluous.

The ARM-ARM  has a list of 'Context-Synchronization event's (Glossary on page
6480 of DDI0487B.b), paraphrasing:
* ISB
* Taking an exception
* ERET
* (...loads of debug stuff...)


Thanks,

James
