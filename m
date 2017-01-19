From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Jan 2017 10:56:46 +0000
Subject: [PATCH 1/2] security: Change name of CONFIG_DEBUG_RODATA
In-Reply-To: <1484789346-21012-2-git-send-email-labbott@redhat.com>
References: <1484789346-21012-1-git-send-email-labbott@redhat.com>
 <1484789346-21012-2-git-send-email-labbott@redhat.com>
Message-ID: <20170119105646.GA11176@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Wed, Jan 18, 2017 at 05:29:05PM -0800, Laura Abbott wrote:
> 
> Despite the word 'debug' in CONFIG_DEBUG_RODATA, this kernel option
> provides key security features that are to be expected on a modern
> system. Change the name to CONFIG_HARDENED_PAGE_MAPPINGS which more
> accurately describes what this option is intended to do.

This generally sounds good. Thanks for attacking this!

On the bikeshedding front, *maybe* it would be nice to mention
permissions in the name, something like STRICT_KERNEL_RWX. That might
also prevent the reading of 'hardened' as 'optional overhead'.

That said, the proposed name is fine by me -- I'm happy so long as
'DEBUG' goes.

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1117421..06fed56 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -11,6 +11,7 @@ config ARM64
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_GIGANTIC_PAGE
> +	select ARCH_HAS_HARDENED_MAPPINGS
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_SG_CHAIN
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> @@ -123,9 +124,6 @@ config ARCH_PHYS_ADDR_T_64BIT
>  config MMU
>  	def_bool y
>  
> -config DEBUG_RODATA
> -	def_bool y
> -

> diff --git a/security/Kconfig b/security/Kconfig
> index 118f454..ad6ce82 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -158,6 +158,22 @@ config HARDENED_USERCOPY_PAGESPAN
>  	  been removed. This config is intended to be used only while
>  	  trying to find such users.
>  
> +config ARCH_HAS_HARDENED_MAPPINGS
> +	def_bool n
> +
> +config HARDENED_PAGE_MAPPINGS
> +	bool "Mark kernel mappings with stricter permissions (RO/W^X)"
> +	default y
> +	depends on ARCH_HAS_HARDENED_MAPPINGS
> +	help
> +          If this is set, kernel text and rodata memory will be made read-only,
> +	  and non-text memory will be made non-executable. This provides
> +	  protection against certain security attacks (e.g. executing the heap
> +	  or modifying text).
> +
> +	  Unless your system has known restrictions or performance issues, it
> +	  is recommended to say Y here.

It's somewhat unfortunate that this means the feature is no longer
mandatory on arm64 (and s390+x86). We have a boot-time switch to turn
the protections off, so I was hoping we could make this mandatory on all
architectures with support.

It would be good to see if we could make this mandatory for arm and
parisc, or if it really needs to be optional for either of those.

Thanks,
Mark.
