From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Mar 2010 13:53:03 -0000
Subject: [Kgdb-bugreport] [PATCH] ARM: change definition of cpu_relax()
	for ARM11MPCore
In-Reply-To: <4B9859C6.1020000@windriver.com>
References: <1268150768-6597-1-git-send-email-will.deacon@arm.com>	<20100309162202.GB17251@n2100.arm.linux.org.uk>	<000f01cabfa6$76951ac0$63bf5040$@deacon@arm.com>	<20100309164926.GC17251@n2100.arm.linux.org.uk>	<001001cabfb2$4a75d2c0$df617840$@deacon@arm.com>
	<4B9817CF.2050807@windriver.com> <4B9859C6.1020000@windriver.com>
Message-ID: <001701cac122$2bf75a00$83e60e00$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Maybe we should initial the atomic_t variable before we using such as
> atomic_inc/dec() directly.
> 
> Dongdong.
> 
> 
> --- a/kernel/kgdb.c
> +++ b/kernel/kgdb.c
> @@ -227,6 +227,17 @@ kgdb_post_primary_code(struct pt_regs *regs, int
> e_vector, int err_code)
>          return;
>   }
> 
> +static void kgdb_initial_atomic_var()
> +{
> +       int i;
> +       for (i = NR_CPUS-1; i >= 0; i--) {
> +               atomic_set(&passive_cpu_wait[i], 0);
> +               atomic_set(&cpu_in_kgdb[i], 0);
> +       }
> +
> +       atomic_set(&kgdb_setting_breakpoint, 0);
> +}
> +

Given that passive_cpu_wait and cpu_in_kgdb are static, I think those guys
are alright as-is. kgdb_setting_breakpoint should probably be reset though.

Will
