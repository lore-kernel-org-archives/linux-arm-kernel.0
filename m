From: paul.liu@linaro.org (Ying-Chun Liu (PaulLiu))
Date: Wed, 18 Jan 2012 02:45:14 +0800
Subject: [PATCH] mx53_loco: add DA9053 PMIC support
In-Reply-To: <87fwffmk2p.fsf@lebrac.rtp-net.org>
References: <1326733853-13956-1-git-send-email-paul.liu@linaro.org>	<1326733853-13956-2-git-send-email-paul.liu@linaro.org>
 <87fwffmk2p.fsf@lebrac.rtp-net.org>
Message-ID: <4F15C1BA.6090308@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks all.

I'm preparing another new upload to fix all the problems.

(2012?01?17? 05:08), Arnaud Patard (Rtp) wrote:
> "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org> writes:
> 
> Hi,
> 
>> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>

>> +
>> +#define MX53_LOCO_DA9052_IRQ			(6*32 + 11)	/* GPIO7_11 */
> 
> you're aware that there's a IMX_GPIO_NR() macro for defining gpio,
> right ? Moreover, why not putting it with other #defines for gpio in the
> top of the file ?

Thanks. My fault. I'll change to use this macro.

> 
>> diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
>> index fd9efb0..9fb56eb 100644
>> --- a/arch/arm/plat-mxc/include/mach/irqs.h
>> +++ b/arch/arm/plat-mxc/include/mach/irqs.h
>> @@ -53,7 +53,15 @@
>>  #endif
>>  /* REVISIT: Add IPU irqs on IMX51 */
>>  
>> -#define NR_IRQS			(MXC_IPU_IRQ_START + MX3_IPU_IRQS)
>> +#define MXC_PMIC_IRQ_START	(MXC_IPU_IRQ_START + MX3_IPU_IRQS)
>> +
>> +#ifdef CONFIG_MACH_MX53_LOCO
>> +#define MXC_PMIC_IRQS 32
>> +#else
>> +#define MXC_PMIC_IRQS 0
>> +#endif
> 
> So, each board using a pmic needing some irqs will need to add a
> #ifdef/#define combo ? Can it be made more generic ? How will it work
> with a kernel compiled for several machines, say loco and an other using
> a pmic using more than 32 irqs ?
> 

Sorry. Any possible suggestions?

I'm thinking about using CONFIG_SPARSE_IRQ
and then we can use .nr_irqs in MACHINE_START block so I can acquire
more irqs there.
But I don't know if this is another intrusive way.

Many Thanks,
Paul
