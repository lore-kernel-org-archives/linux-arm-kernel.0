From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Nov 2009 19:32:57 +0000
Subject: [REGRESSION] 2eca40a8 breaks StrongARM compilation
In-Reply-To: <20091111192315.GA29757@rainbow>
References: <20091111192315.GA29757@rainbow>
Message-ID: <20091111193257.GA14775@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2009 at 10:23:15PM +0300, Dmitry Artamonow wrote:
> Commit 2eca40a8 which went into 2.6.32-rc6 breaks compilation
> for ipaq h3600 and probably other SA1100 machines when CONFIG_CPU_FREQ
> is unset:

I'm aware, I have a very large patch which fixes SA1100, but there's
other ARM machine classes which are similarly broken.

We've been around this loop before, where a change like this was
introduced and reverted.  The kernel community seems set to constantly
repeat the same old mistakes time and time again.

> +#ifdef CONFIG_CPU_FREQ
>  	pcd = get_pcd(var->pixclock, cpufreq_get(0));
> +#else
> +	pcd = get_pcd(var->pixclock, 206400);
> +#endif

This is just not acceptable, and could lead to LCD panel damage due
to wrong timings - not all platforms boot at 206.4MHz.  Given that
it's far better that the kernel be obviously broken than silently
wrong while causing hardware damage.
