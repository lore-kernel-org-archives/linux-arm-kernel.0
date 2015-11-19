From: dcashman@android.com (Daniel Cashman)
Date: Wed, 18 Nov 2015 16:14:13 -0800
Subject: [PATCH v3 1/4] mm: mmap: Add new /proc tunable for mmap_base ASLR.
In-Reply-To: <1447888808-31571-2-git-send-email-dcashman@android.com>
References: <1447888808-31571-1-git-send-email-dcashman@android.com>
 <1447888808-31571-2-git-send-email-dcashman@android.com>
Message-ID: <564D1455.4070508@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2015 03:20 PM, Daniel Cashman wrote:
>  ==============================================================
>  
> +mmap_rnd_bits:
> +
> +This value can be used to select the number of bits to use to
> +determine the random offset to the base address of vma regions
> +resulting from mmap allocations on architectures which support
> +tuning address space randomization.  This value will be bounded
> +by the architecture's minimum and maximum supported values.
> +
> +This value can be changed after boot using the
> +/proc/sys/kernel/mmap_rnd_bits tunable
> +
> +==============================================================
> +
> +mmap_rnd_compat_bits:
> +
> +This value can be used to select the number of bits to use to
> +determine the random offset to the base address of vma regions
> +resulting from mmap allocations for applications run in
> +compatibility mode on architectures which support tuning address
> +space randomization.  This value will be bounded by the
> +architecture's minimum and maximum supported values.
> +
> +This value can be changed after boot using the
> +/proc/sys/kernel/mmap_rnd_compat_bits tunable
> +
> +==============================================================

As Kees pointed out in my erroneously sent (missing v3 prefix)
patch-set: the /proc/sys/kernel/ entries were not changed to reflect the
move to /proc/sys/vm/.


> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 00bad77..7d39828 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -51,6 +51,17 @@ extern int sysctl_legacy_va_layout;
>  #define sysctl_legacy_va_layout 0
>  #endif
>  
> +#ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
> +extern int mmap_rnd_bits_min;
> +extern int mmap_rnd_bits_max;
> +extern int mmap_rnd_bits;
> +#endif
> +#ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
> +extern int mmap_rnd_compat_bits_min;
> +extern int mmap_rnd_compat_bits_max;
> +extern int mmap_rnd_compat_bits;
> +#endif
> +
>  #include <asm/page.h>
>  #include <asm/pgtable.h>
>  #include <asm/processor.h>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index dc6858d..40e5de6 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1568,6 +1568,28 @@ static struct ctl_table vm_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_doulongvec_minmax,
>  	},
> +#ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
> +	{
> +		.procname	= "mmap_rnd_bits",
> +		.data		= &mmap_rnd_bits,
> +		.maxlen		= sizeof(mmap_rnd_bits),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= &mmap_rnd_bits_min,
> +		.extra2		= &mmap_rnd_bits_max,
> +	},
> +#endif
> +#ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
> +	{
> +		.procname	= "mmap_rnd_compat_bits",
> +		.data		= &mmap_rnd_compat_bits,
> +		.maxlen		= sizeof(mmap_rnd_compat_bits),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= &mmap_rnd_compat_bits_min,
> +		.extra2		= &mmap_rnd_compat_bits_max,
> +	},
> +#endif
>  	{ }
>  };
>  
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 2ce04a6..aa49841 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -58,6 +58,18 @@
>  #define arch_rebalance_pgtables(addr, len)		(addr)
>  #endif
>  
> +#ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
> +int mmap_rnd_bits_min = CONFIG_ARCH_MMAP_RND_BITS_MIN;
> +int mmap_rnd_bits_max = CONFIG_ARCH_MMAP_RND_BITS_MAX;
> +int mmap_rnd_bits = CONFIG_ARCH_MMAP_RND_BITS;
> +#endif
> +#ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
> +int mmap_rnd_compat_bits_min = CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN;
> +int mmap_rnd_compat_bits_max = CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX;
> +int mmap_rnd_compat_bits = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
> +#endif
> +

Again from Kees in my erroneously sent (missing v3 prefix) patch-set:
the min/max should be const.
