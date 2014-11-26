From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Nov 2014 09:48:52 +0100
Subject: [PATCH v2] arm: Support for the PXN CPU feature on ARMv7
In-Reply-To: <1416981921-19643-1-git-send-email-js07.lee@gmail.com>
References: <1416981921-19643-1-git-send-email-js07.lee@gmail.com>
Message-ID: <6108655.KIqtjFdn4U@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 November 2014 15:05:21 Jungseung Lee wrote:
> +#if __LINUX_ARM_ARCH__ >= 6 && !defined(CONFIG_ARM_LPAE)
> +static inline bool cpu_has_classic_pxn(void)
> +{
> +       static unsigned int vmsa = ~0UL;
> +
> +       if (cpu_architecture() != CPU_ARCH_ARMv7)
> +               return false;
> +       if (vmsa == 4)
> +               return true;
> +
> +       vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
> +       return vmsa == 4;
> +}
> +#else
> +static inline bool cpu_has_classic_pxn(void)
> +{
> +       return false;
> +}
> +#endif
> +
> 

As mentioned before, please turn the #ifdef into an "if (IS_ENABLED(...))" check.

The 'if (vmsa == 4)' check above looks like it came from an earlier version
and is always false, so just drop that.

	Arnd
