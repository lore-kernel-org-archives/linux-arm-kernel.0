From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 19 Dec 2017 14:44:01 +0000
Subject: [PATCH] ARM: NOMMU: Setup VBAR/Hivecs for secondaries cores
In-Reply-To: <20171219112954.GA14910@afzalpc>
References: <1513679029-5915-1-git-send-email-vladimir.murzin@arm.com>
 <20171219112954.GA14910@afzalpc>
Message-ID: <4e80e47a-d7b4-c09c-fe88-a7dff6522038@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 19/12/17 11:29, afzal mohammed wrote:
> Hi,
> 
> On Tue, Dec 19, 2017 at 10:23:49AM +0000, Vladimir Murzin wrote:
>> With switch to dynamic exception base address setting, VBAR/Hivecs
>> set only for boot CPU, but secondaries stay unaware of that. That
>> might lead to weird effects when trying up to bring up secondaries.
>>
>> Fixes: ad475117d201 ("ARM: 8649/2: nommu: remove Hivecs configuration is asm")
> 
> Sorry, it was my incompetence not seeing the secondary CPU's case.
> 
> Was the issue observed on Cortex-R ?, and was it occuring with
> CONFIG_CPU_HIGH_VECTOR enabled or disabled ?

I caught it when was trying to setup VBAR and after code inspection I
noticed that setting of Hivecs were changed as well.

> 
> Instead of,
> 
>> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> 
>> +#ifndef CONFIG_MMU
>> +extern unsigned long setup_vectors_base(void);
>> +#else
>> +static inline unsigned long setup_vectors_base(void)
>> +{
>> +	return 0;
>> +}
>> +#endif
> 
>> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> 
>> +	setup_vectors_base();
> 
> how about,
> 
>         if (!IS_ENABLED(CONFIG_MMU))
>                 setup_vectors_base();
> 
> That would avoid #ifdef's. Also as w/ MMU, vector base is not setup
> (always Hivecs), this would make clear that setup_vectors_base() is
> non-existent on MMU on.

Works for me, but I went with plain #ifndef.

Vladimir

> 
> Thanks for the fix.
> 
> afzal
> 
