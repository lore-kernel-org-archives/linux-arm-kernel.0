From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Sep 2011 11:28:11 +0100
Subject: [PATCH] arm/dt: Add SoC detection macros
In-Reply-To: <1315555339-12685-1-git-send-email-amartin@nvidia.com>
References: <1315555339-12685-1-git-send-email-amartin@nvidia.com>
Message-ID: <20110917102811.GC16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2011 at 01:02:19AM -0700, Allen Martin wrote:
> +#ifdef CONFIG_ARCH_TEGRA_2x_SOC
> +# ifdef SOC_NAME
> +#  undef MULTI_SOC
> +#  define MULTI_SOC
> +# else
> +#   define SOC_NAME tegra2
> +# endif
> +#endif
> +#ifdef CONFIG_ARCH_TEGRA_3x_SOC
> +# ifdef SOC_NAME
> +#  undef MULTI_SOC
> +#  define MULTI_SOC
> +# else
> +#   define SOC_NAME tegra3
> +# endif
> +#endif
> +
> +#define soc_is_tegra2()			0
> +#define soc_is_tegra3()			0
> +
> +#if defined(MULTI_SOC)
> +# if defined(CONFIG_ARCH_TEGRA_2x_SOC)
> +#  undef soc_is_tegra2
> +#  define soc_is_tegra2()		is_tegra2()
> +# endif
> +# if defined(CONFIG_ARCH_TEGRA_3x_SOC)
> +#  undef soc_is_tegra3
> +#  define soc_is_tegra3()		is_tegra3()
> +# endif
> +#else /* non-multi, only one architecture is on */
> +# if defined(CONFIG_ARCH_TEGRA_2x_SOC)
> +#  undef soc_is_tegra2
> +#  define soc_is_tegra2()		1
> +# elif defined(CONFIG_ARCH_TEGRA_3x_SOC)
> +#  undef soc_is_tegra3
> +#  define soc_is_tegra3()		1
> +# endif
> +#endif

This is not the way to do this, especially for a file in asm/*.h.  Look
at the way machine_is_xxx() is dealt with in include/generated/mach-types.h.

#define MULTI_SOC			0
#undef SOC_SELECTED

#ifdef CONFIG_ARCH_TEGRA_2x_SOC
# ifdef SOC_SELECTED
#  undef MULTI_SOC
#  define MULTI_SOC			1
# else
#  define SOC_SELECTED
# endif
# define soc_is_tegra2()		(!MULTI_SOC || is_tegra2())
#else
# define soc_is_tegra2()		0
#endif

#ifdef CONFIG_ARCH_TEGRA_3x_SOC
# ifdef SOC_SELECTED
#  undef MULTI_SOC
#  define MULTI_SOC			1
# else
#  define SOC_SELECTED
# endif
# define soc_is_tegra3()		(!MULTI_SOC || is_tegra3())
#else
# define soc_is_tegra3()		0
#endif

#undef SOC_SELECTED

The above is nicely extensible - if other SoCs need to extend this they
just need to add another outer ifdef..endif section to the file.

> +
> +enum soc_version {
> +	SOC_UNKNOWN = 0,
> +	TEGRA_T20,
> +	TEGRA_T30,

I'd suggest prefixing these with SOC_ to avoid any namespace problems.

> +};
> +
> +void soc_init_version(void);
> +enum soc_version soc_get_version(void);
> +
> +static inline int is_tegra2(void)
> +{
> +	return soc_get_version() == TEGRA_T20;
> +}
> +
> +static inline int is_tegra3(void)
> +{
> +	return soc_get_version() == TEGRA_T30;
> +}

If we require all SoCs to provide a value in soc_version, then we can use
exactly the same method as mach-types.h uses - and while at this, please
get rid of soc_get_version().  It's far cheaper to access the variable
directly rather than indirect through a function, just like we do with
__machine_arch_type.  Mark it __read_mostly too.

One last point to raise here is - and it's quite a fundamental one - do we
really want this?  If we're making decisions based on the SoC type, that
suggests to me that the hardware description in DT is incomplete, and
we're hiding stuff in the kernel behind the SoC type.  That doesn't sound
particularly appealing given the point of DT is to encode the hardware
specific information outside the kernel code.
