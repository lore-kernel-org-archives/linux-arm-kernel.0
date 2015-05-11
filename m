From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 May 2015 23:29:55 +0100
Subject: [PATCH 1/3] ARM: cache-l2c: Add flag to skip cache unlocking
In-Reply-To: <1431382651-15894-2-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1431382651-15894-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1431382651-15894-2-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <20150511222955.GK2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 12:17:29AM +0200, Sjoerd Simons wrote:
> The L2C cache should only be unlocked when the cache is setup to allow
> that. In the common case the l2x0 driver sets up the cache for that to
> be the case (e.g. setting L310_AUX_CTRL_NS_LOCKDOWN on L2C-310), making
> unlock safe. However when a secure firmware is in use, it may not be
> possible for the L2c to be configured that way making unlocking unsafe.
> 
> To handle that case add a flag to skip unlocking the cache for machine
> where this can't be done safely.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> ---
>  arch/arm/include/asm/outercache.h | 1 +
>  arch/arm/mm/cache-l2x0.c          | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
> index 563b92f..d07ca82 100644
> --- a/arch/arm/include/asm/outercache.h
> +++ b/arch/arm/include/asm/outercache.h
> @@ -39,6 +39,7 @@ struct outer_cache_fns {
>  	/* This is an ARM L2C thing */
>  	void (*write_sec)(unsigned long, unsigned);
>  	void (*configure)(const struct l2x0_regs *);
> +	bool skip_unlock;
>  };
>  
>  extern struct outer_cache_fns outer_cache;
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index e309c8f..fff7888 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -136,7 +136,8 @@ static void l2c_enable(void __iomem *base, u32 aux, unsigned num_lock)
>  	l2x0_saved_regs.aux_ctrl = aux;
>  	l2c_configure(base);
>  
> -	l2c_unlock(base, num_lock);
> +	if (!outer_cache.skip_unlock)
> +		l2c_unlock(base, num_lock);

I think we can do better here.  If the non-secure lockdown access bit has
been set, then proceed with the unlock:

	if (readl_relaxed(base + L2X0_AUX_CTRL) & L310_AUX_CTRL_NS_LOCKDOWN)
		l2c_unlock(base, num_lock);

I don't see any need to add a flag for this.  This also eliminates your
second patch.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
