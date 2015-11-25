From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 24 Nov 2015 16:40:01 -0800
Subject: [PATCH v3 1/4] mm: mmap: Add new /proc tunable for mmap_base ASLR.
In-Reply-To: <1447888808-31571-2-git-send-email-dcashman@android.com>
References: <1447888808-31571-1-git-send-email-dcashman@android.com>
 <1447888808-31571-2-git-send-email-dcashman@android.com>
Message-ID: <20151124164001.71844bcfb4d7a500cd25d9c6@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Nov 2015 15:20:05 -0800 Daniel Cashman <dcashman@android.com> wrote:

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

Is there any harm in permitting the attacker to read these values?

And is there any benefit in permitting non-attackers to read them?

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
>
> ...
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

These could be __read_mostly.

If one believes in such things.  One effect of __read_mostly is to
clump the write-often stuff into the same cachelines and I've never
been convinced that one outweighs the other...
