From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Tue, 19 Dec 2017 16:59:54 +0530
Subject: [PATCH] ARM: NOMMU: Setup VBAR/Hivecs for secondaries cores
In-Reply-To: <1513679029-5915-1-git-send-email-vladimir.murzin@arm.com>
References: <1513679029-5915-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20171219112954.GA14910@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 19, 2017 at 10:23:49AM +0000, Vladimir Murzin wrote:
> With switch to dynamic exception base address setting, VBAR/Hivecs
> set only for boot CPU, but secondaries stay unaware of that. That
> might lead to weird effects when trying up to bring up secondaries.
> 
> Fixes: ad475117d201 ("ARM: 8649/2: nommu: remove Hivecs configuration is asm")

Sorry, it was my incompetence not seeing the secondary CPU's case.

Was the issue observed on Cortex-R ?, and was it occuring with
CONFIG_CPU_HIGH_VECTOR enabled or disabled ?

Instead of,

> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h

> +#ifndef CONFIG_MMU
> +extern unsigned long setup_vectors_base(void);
> +#else
> +static inline unsigned long setup_vectors_base(void)
> +{
> +	return 0;
> +}
> +#endif

> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c

> +	setup_vectors_base();

how about,

        if (!IS_ENABLED(CONFIG_MMU))
                setup_vectors_base();

That would avoid #ifdef's. Also as w/ MMU, vector base is not setup
(always Hivecs), this would make clear that setup_vectors_base() is
non-existent on MMU on.

Thanks for the fix.

afzal
