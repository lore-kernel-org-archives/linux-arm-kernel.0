From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jun 2014 23:37:49 +0100
Subject: [PATCH 9/9] ARM: kernel: add outer cache support for cacheinfo
 implementation
In-Reply-To: <1403717444-23559-10-git-send-email-sudeep.holla@arm.com>
References: <1403717444-23559-1-git-send-email-sudeep.holla@arm.com>
 <1403717444-23559-10-git-send-email-sudeep.holla@arm.com>
Message-ID: <20140625223748.GM32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 06:30:44PM +0100, Sudeep Holla wrote:
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index efc5cab..30ca151 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -105,6 +105,15 @@ static inline void l2c_unlock(void __iomem *base, unsigned num)
>  	}
>  }
>  
> +static void l2x0_getinfo(struct outer_cache_info *info)
> +{
> +	if (!info)
> +		return;

Pointless NULL test.  If someone passes NULL to this function (which
you never do in this file) then we want to know about it because _that_
is a kernel bug - it is invalid to pass NULL.  Hence the kernel should
oops.

Please, don't go around adding stupid NULL tests for conditions which
should _never_ happen, instead, rely on the kernel to oops if these
invalid conditions occur.  That's why we produce a backtrace from such
events, to allow invalid conditions to be debugged and fixed.

Having stuff silently ignore in this way does not detect these bugs so
they go by unnoticed.

Take a moment to read some of the fs/ or kernel/ code, and you'll find
a lack of NULL checks in there.  That's what gives that code performance,
because it's not spending its time doing loads of useless NULL checks.

> @@ -894,6 +903,7 @@ static void __init __l2c_init(const struct l2c_init_data *data,
>  		data->enable(l2x0_base, aux, data->num_lock);
>  
>  	outer_cache = fns;
> +	outer_cache.get_info = l2x0_getinfo;

NAK.  Think about it.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
