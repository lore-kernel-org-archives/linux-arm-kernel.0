From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2011 22:23:53 +0200
Subject: [RFC PATCH 2/3] ARM: SoC: Add per SoC SMP and CPU hotplug
	operations
In-Reply-To: <1315501212-1820-3-git-send-email-marc.zyngier@arm.com>
References: <1315501212-1820-1-git-send-email-marc.zyngier@arm.com>
	<1315501212-1820-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <1594529.EmMGjcLOoi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 September 2011 18:00:11 Marc Zyngier wrote:
> +struct arm_soc_smp_ops {
> +       void (*smp_init_cpus)(void);
> +       void (*smp_prepare_cpus)(unsigned int max_cpus);
> +       void (*smp_secondary_init)(unsigned int cpu);
> +       int  (*smp_boot_secondary)(unsigned int cpu, struct task_struct *idle);
> +#ifdef CONFIG_HOTPLUG_CPU
> +       int  (*cpu_kill)(unsigned int cpu);
> +       void (*cpu_die)(unsigned int cpu);
> +       int  (*cpu_disable)(unsigned int cpu);
> +#endif
> +};
> +
>  struct arm_soc_desc {
>         const char              *name;
> +#ifdef CONFIG_SMP
> +       struct arm_soc_smp_ops  smp_ops;
> +#endif
>  };

If you make this two data structures, I would actually recommend using a
pointer to the arm_soc_smp_ops instead of embedding it in arm_soc_desc.

This will make it possible to put the arm_soc_smp_ops into the plat_smp.c file
and get rid of a few more #ifdefs.

It may also be a good idea to have global pointers and for arm_soc_desc and
arm_soc_smp_ops instead of pointing to them from the board file. I can see
reasons both ways, and that should probably be driven by code efficiency
concerns.

	Arnd
