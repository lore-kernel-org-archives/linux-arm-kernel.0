From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 16 Apr 2010 19:30:41 +0530
Subject: [PATCH] ARM: Fix "BUG: scheduling while atomic:
	swapper/0/0x00000002"
In-Reply-To: <33A307AF30D7BF4F811B1568FE7A9B18033BD001@EXDCVYMBSTM006.EQ1STM.local>
References: <33A307AF30D7BF4F811B1568FE7A9B18033BD001@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C4F164A5@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Sundar R IYER
> Sent: Friday, April 16, 2010 7:14 PM
> To: linux-arm-kernel at lists.infradead.org
> Subject: Re : [PATCH] ARM: Fix "BUG: scheduling while atomic: swapper/0/0x00000002"
> 
> Hi Santosh/Russell,
> 
> >Hmm, I don't think this is how we should be solving this problem.
> >x86 calls init_idle() on the idle task when it's re-used, and this
> >resets the preempt count amongst other things.  So maybe we want to
> >do this instead in the __cpu_up path:
> 
> The following patch fixes the dump messages at my end during re-onlining the offline CPU.
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 577543f..ee1d608 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -86,6 +86,9 @@ int __cpuinit __cpu_up(unsigned int cpu)
>                                                 return PTR_ERR(idle);
>                                 }
>                                 ci->idle = idle;
> +              } else {
> +                              /* fix any preempt leaks whilst going down */
> +                              init_idle(idle, cpu);
>                 }
> 
Actually I found there is while the CPU is going down. If you fix that, both paths
- going down and coming up - gets fixed.

Regards,
Santosh
