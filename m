From: tony@atomide.com (Tony Lindgren)
Date: Thu, 18 Mar 2010 20:24:48 -0700
Subject: [PATCH] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
	check for it on V6
In-Reply-To: <20100319013521.GP2900@atomide.com>
References: <20100317175731.GE2900@atomide.com>
	<1268849278.19565.28.camel@e102109-lin.cambridge.arm.com>
	<20100317191114.GH2900@atomide.com>
	<1268910826.15334.32.camel@e102109-lin.cambridge.arm.com>
	<20100318170021.GN2900@atomide.com>
	<20100319013521.GP2900@atomide.com>
Message-ID: <20100319032448.GQ2900@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100318 18:31]:
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -269,6 +269,24 @@ static void __init cacheid_init(void)
>  extern struct proc_info_list *lookup_processor_type(unsigned int);
>  extern struct machine_desc *lookup_machine_type(unsigned int);
>  
> +#ifdef CONFIG_CPU_V6
> +static void __init feat_v6_fixup(void)
> +{
> +	int id = read_cpuid_id();
> +
> +	if (id & 0x000f0000 != 0x00070000)
> +		return;
> +
> +	/* HWCAP_TLS is available only on V6 r1p0 and later */
> +	if (((id >> 20) & 3) == 0)
> +		elf_hwcap &= ~HWCAP_TLS;
> +}

This test probably needs to only look at ARM1136, and ignore others
such as ARM1176. Will take a look tomorrow.

Tony
