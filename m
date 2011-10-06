From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Oct 2011 23:35:45 +0100
Subject: [PATCH] ARM: OMAP3: hwmod: fix variant registration and remove
	SmartReflex from common list
In-Reply-To: <alpine.DEB.2.00.1110061433540.4611@utopia.booyaka.com>
References: <alpine.DEB.2.00.1110061433540.4611@utopia.booyaka.com>
Message-ID: <20111006223545.GB27281@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06, 2011 at 02:39:28PM -0600, Paul Walmsley wrote:
> @@ -3240,7 +3240,7 @@ int __init omap3xxx_hwmod_init(void)
>  
>  	/* Register hwmods common to all OMAP3 */
>  	r = omap_hwmod_register(omap3xxx_hwmods);
> -	if (!r)
> +	if (IS_ERR_VALUE(r))
>  		return r;
>  
>  	rev = omap_rev();
> @@ -3265,7 +3265,7 @@ int __init omap3xxx_hwmod_init(void)
>  	};
>  
>  	r = omap_hwmod_register(h);
> -	if (!r)
> +	if (IS_ERR_VALUE(r))
>  		return r;

What _really_ is the return value meaning of omap_hwmod_register() ?

If it's zero for success, negative for error codes, then don't be
clever and try to use IS_ERR_VALUE() for that - just use a standard
< 0 test instead.

You only need to use IS_ERR_VALUE() for stuff that may return negative
errno values _and_ which may return valid addresses which may be
misinterpreted as negative numbers.
