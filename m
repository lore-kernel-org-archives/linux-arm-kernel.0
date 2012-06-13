From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jun 2012 21:33:28 +0000
Subject: [PATCH v8 01/13] ARM: Add per-platform SMP/CPU-hotplug operations
In-Reply-To: <1339504256-11266-2-git-send-email-marc.zyngier@arm.com>
References: <1339504256-11266-1-git-send-email-marc.zyngier@arm.com>
 <1339504256-11266-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <201206132133.28758.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 June 2012, Marc Zyngier wrote:
> @@ -35,6 +36,9 @@ struct machine_desc {
>  	unsigned char		reserve_lp1 :1;	/* never has lp1	*/
>  	unsigned char		reserve_lp2 :1;	/* never has lp2	*/
>  	char			restart_mode;	/* default restart mode	*/
> +#ifdef CONFIG_SMP
> +	struct smp_ops		*smp_ops;	/* SMP operations	*/
> +#endif
>  	void			(*fixup)(struct tag *, char **,
>  					 struct meminfo *);
>  	void			(*reserve)(void);/* reserve mem blocks	*/
> @@ -50,6 +54,12 @@ struct machine_desc {
>  	void			(*restart)(char, const char *);
>  };
>  
> +#ifdef CONFIG_SMP
> +#define smp_ops(s)		.smp_ops = (&s),
> +#else
> +#define smp_ops(s)		/* empty */
> +#endif
> +

I think we should just leave these in unconditionally as before. The price
is one pointer per machine_desc, but the advantage is that we don't have
to use an ugly macro.

If people think the savings are worth doing the macro for, can we
at least kill the "," and the "&" in it, to make it more regular syntax?

> +struct smp_ops {
> +	struct smp_init_ops		init_ops;
> +	struct smp_secondary_ops	secondary_ops;
> +	struct smp_hotplug_ops		hotplug_ops;
> +};

Ok, I don't really mind this split so much, although it still feels
like it's making the structure more complicated than it should.

> +#ifdef CONFIG_SMP
> +#define smp_init_ops(prefix)		.init_ops = {			\
> +		.smp_init_cpus		= prefix##_smp_init_cpus,	\
> +		.smp_prepare_cpus	= prefix##_smp_prepare_cpus,	\
> +	},
> +
> +#define smp_secondary_ops(prefix)	.secondary_ops = {		\
> +		.smp_secondary_init	= prefix##_secondary_init,	\
> +		.smp_boot_secondary	= prefix##_boot_secondary,	\
> +	},
> +
> +extern void smp_ops_register(struct smp_ops *);
> +
> +#else
> +#define smp_init_ops(prefix)		.init_ops = {},
> +#define smp_secondary_ops(prefix)	.secondary_ops = {},
> +#define smp_ops_register(a)		do {} while(0)
> +#endif
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +#define smp_hotplug_ops(prefix)		.hotplug_ops = {	\
> +		.cpu_kill	= prefix##_cpu_kill,		\
> +		.cpu_die	= prefix##_cpu_die,		\
> +		.cpu_disable	= prefix##_cpu_disable,		\
> +	},
> +#else
> +#define smp_hotplug_ops(prefix)		.hotplug_ops = {},
> +#endif

But these macros are just horrible. The string concatenation makes it impossible
to grep for where the function pointers are actually used. Just open-code
the initialization, it's really not too much to ask to write something like

struct smp_ops vexpress_smp_ops = {
	.init_ops = {
		.smp_init_cpus		= vexpress_smp_init_cpus,
		.smp_prepare_cpus	= vexpress_smp_prepare_cpus,
	},
	.secondary_ops = {
		.smp_secondary_init	= vexpress_secondary_init,
		.smp_boot_secondary	= vexpress_boot_secondary,
	},
#ifdef CONFIG_HOTPLUG_CPU
	.hotplug_ops = {
		.cpu_kill		= vexpress_cpu_kill,
		.cpu_die		= vexpress_cpu_die,
		.cpu_disable		= vexpress_cpu_disable,
	},
#endif
};

Anyone can read this, and it's not all that much to write either. Whereas the macro
version requires everybody who wants to modify that code to understand all the
macros you introduced.

	Arnd
