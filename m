From: mpe@ellerman.id.au (Michael Ellerman)
Date: Wed, 25 Nov 2015 15:40:00 +1100
Subject: [PATCH v3 1/4] mm: mmap: Add new /proc tunable for mmap_base ASLR.
In-Reply-To: <1447888808-31571-2-git-send-email-dcashman@android.com>
References: <1447888808-31571-1-git-send-email-dcashman@android.com>
 <1447888808-31571-2-git-send-email-dcashman@android.com>
Message-ID: <1448426400.3762.11.camel@ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-11-18 at 15:20 -0800, Daniel Cashman wrote:

> From: dcashman <dcashman@google.com>
> 
> ASLR currently only uses 8 bits to generate the random offset for the
> mmap base address on 32 bit architectures. This value was chosen to
> prevent a poorly chosen value from dividing the address space in such
> a way as to prevent large allocations. This may not be an issue on all
> platforms. Allow the specification of a minimum number of bits so that
> platforms desiring greater ASLR protection may determine where to place
> the trade-off.

...

> diff --git a/arch/Kconfig b/arch/Kconfig
> index 4e949e5..141823f 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -511,6 +511,70 @@ config ARCH_HAS_ELF_RANDOMIZE
>  	  - arch_mmap_rnd()
>  	  - arch_randomize_brk()
>  
> +config HAVE_ARCH_MMAP_RND_BITS
> +	bool
> +	help
> +	  An arch should select this symbol if it supports setting a variable
> +	  number of bits for use in establishing the base address for mmap
> +	  allocations and provides values for both:
> +	  - ARCH_MMAP_RND_BITS_MIN
> +	  - ARCH_MMAP_RND_BITS_MAX
> +
> +config ARCH_MMAP_RND_BITS_MIN
> +	int
> +
> +config ARCH_MMAP_RND_BITS_MAX
> +	int
> +
> +config ARCH_MMAP_RND_BITS_DEFAULT
> +	int
> +
> +config ARCH_MMAP_RND_BITS
> +	int "Number of bits to use for ASLR of mmap base address" if EXPERT
> +	range ARCH_MMAP_RND_BITS_MIN ARCH_MMAP_RND_BITS_MAX
> +	default ARCH_MMAP_RND_BITS_DEFAULT if ARCH_MMAP_RND_BITS_DEFAULT

Here you support a default which is separate from the minimum.

> +	default ARCH_MMAP_RND_BITS_MIN
> +	depends on HAVE_ARCH_MMAP_RND_BITS

...
> +
> +config ARCH_MMAP_RND_COMPAT_BITS
> +	int "Number of bits to use for ASLR of mmap base address for compatible applications" if EXPERT
> +	range ARCH_MMAP_RND_COMPAT_BITS_MIN ARCH_MMAP_RND_COMPAT_BITS_MAX
> +	default ARCH_MMAP_RND_COMPAT_BITS_MIN

But here you don't.

Just forgot?

I'd like to have a default which is separate from the minimum. That way we can
have a default which is reasonably large, but allow it to be lowered easily if
anything breaks.

cheers
