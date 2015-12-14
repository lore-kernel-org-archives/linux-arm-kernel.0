From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Dec 2015 11:19:49 +0000
Subject: [PATCH v6 3/4] arm64: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <1449856338-30984-4-git-send-email-dcashman@android.com>
References: <1449856338-30984-1-git-send-email-dcashman@android.com>
 <1449856338-30984-2-git-send-email-dcashman@android.com>
 <1449856338-30984-3-git-send-email-dcashman@android.com>
 <1449856338-30984-4-git-send-email-dcashman@android.com>
Message-ID: <20151214111949.GD6992@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Fri, Dec 11, 2015 at 09:52:17AM -0800, Daniel Cashman wrote:
> From: dcashman <dcashman@google.com>
> 
> arm64: arch_mmap_rnd() uses STACK_RND_MASK to generate the
> random offset for the mmap base address.  This value represents a
> compromise between increased ASLR effectiveness and avoiding
> address-space fragmentation. Replace it with a Kconfig option, which
> is sensibly bounded, so that platform developers may choose where to
> place this compromise. Keep default values as new minimums.
> 
> Signed-off-by: Daniel Cashman <dcashman@android.com>
> ---
>  arch/arm64/Kconfig   | 33 +++++++++++++++++++++++++++++++++
>  arch/arm64/mm/mmap.c |  8 ++++++--
>  2 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 871f217..0cc9c24 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -51,6 +51,8 @@ config ARM64
>  	select HAVE_ARCH_JUMP_LABEL
>  	select HAVE_ARCH_KASAN if SPARSEMEM_VMEMMAP && !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
>  	select HAVE_ARCH_KGDB
> +	select HAVE_ARCH_MMAP_RND_BITS
> +	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
>  	select HAVE_ARCH_SECCOMP_FILTER
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_BPF_JIT
> @@ -104,6 +106,37 @@ config ARCH_PHYS_ADDR_T_64BIT
>  config MMU
>  	def_bool y
>  
> +config ARCH_MMAP_RND_BITS_MIN
> +       default 14 if ARM64_64K_PAGES
> +       default 16 if ARM64_16K_PAGES
> +       default 18
> +
> +# max bits determined by the following formula:
> +#  VA_BITS - PAGE_SHIFT - 3

Now that we have this comment, I think we can drop the unsupported
combinations from the list below. That means we just end up with:

> +config ARCH_MMAP_RND_BITS_MAX
> +       default 19 if ARM64_VA_BITS=36
> +       default 24 if ARM64_VA_BITS=39
> +       default 27 if ARM64_VA_BITS=42
> +       default 30 if ARM64_VA_BITS=47
> +       default 29 if ARM64_VA_BITS=48 && ARM64_64K_PAGES
> +       default 31 if ARM64_VA_BITS=48 && ARM64_16K_PAGES
> +       default 33 if ARM64_VA_BITS=48

With that:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
