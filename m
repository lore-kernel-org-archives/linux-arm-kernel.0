From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Nov 2015 15:04:59 +0000
Subject: [PATCH v3 3/4] arm64: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <1447888808-31571-4-git-send-email-dcashman@android.com>
References: <1447888808-31571-1-git-send-email-dcashman@android.com>
 <1447888808-31571-2-git-send-email-dcashman@android.com>
 <1447888808-31571-3-git-send-email-dcashman@android.com>
 <1447888808-31571-4-git-send-email-dcashman@android.com>
Message-ID: <20151123150459.GD4236@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 03:20:07PM -0800, Daniel Cashman wrote:
> From: dcashman <dcashman@google.com>
> 
> arm64: arch_mmap_rnd() uses STACK_RND_MASK to generate the
> random offset for the mmap base address.  This value represents a
> compromise between increased ASLR effectiveness and avoiding
> address-space fragmentation. Replace it with a Kconfig option, which
> is sensibly bounded, so that platform developers may choose where to
> place this compromise. Keep default values as new minimums.
> 
> Signed-off-by: Daniel Cashman <dcashman@google.com>
> ---
>  arch/arm64/Kconfig   | 23 +++++++++++++++++++++++
>  arch/arm64/mm/mmap.c |  6 ++++--
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 9ac16a4..be38e4c 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -51,6 +51,8 @@ config ARM64
>  	select HAVE_ARCH_JUMP_LABEL
>  	select HAVE_ARCH_KASAN if SPARSEMEM_VMEMMAP
>  	select HAVE_ARCH_KGDB
> +	select HAVE_ARCH_MMAP_RND_BITS
> +	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
>  	select HAVE_ARCH_SECCOMP_FILTER
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_BPF_JIT
> @@ -104,6 +106,27 @@ config ARCH_PHYS_ADDR_T_64BIT
>  config MMU
>  	def_bool y
>  
> +config ARCH_MMAP_RND_BITS_MIN
> +       default 15 if ARM64_64K_PAGES
> +       default 19
> +
> +config ARCH_MMAP_RND_BITS_MAX
> +       default 20 if ARM64_64K_PAGES && ARCH_VA_BITS=39
> +       default 24 if ARCH_VA_BITS=39
> +       default 23 if ARM64_64K_PAGES && ARCH_VA_BITS=42
> +       default 27 if ARCH_VA_BITS=42
> +       default 29 if ARM64_64K_PAGES && ARCH_VA_BITS=48
> +       default 33 if ARCH_VA_BITS=48
> +       default 15 if ARM64_64K_PAGES
> +       default 19
> +
> +config ARCH_MMAP_RND_COMPAT_BITS_MIN
> +       default 7 if ARM64_64K_PAGES
> +       default 11

FYI: we now support 16k pages too, so this might need updating. It would
be much nicer if this was somehow computed rather than have the results
all open-coded like this.

Will
