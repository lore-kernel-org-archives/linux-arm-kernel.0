From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 13 Mar 2012 19:29:09 +0530
Subject: [PATCH 2/2] ARM: omap: hwmod: Make omap_hwmod_softreset wait
 for reset status
In-Reply-To: <1331646928-31119-3-git-send-email-rnayak@ti.com>
References: <1331646928-31119-1-git-send-email-rnayak@ti.com>
 <1331646928-31119-3-git-send-email-rnayak@ti.com>
Message-ID: <4F5F52AD.6090009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 March 2012 07:25 PM, Rajendra Nayak wrote:
> omap_hwmod_softreset() does not seem to wait for reset status
> after doing a softreset. Make it use _ocp_softreset() instead
> which does this correctly.
>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> Cc: Benoit Cousson<b-cousson@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> Cc: Anand Gadiyar<gadiyar@ti.com>
> Cc: Shubhrajyoti D<shubhrajyoti@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |   14 +++-----------
>   1 files changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index ae56939..9b49440 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1907,20 +1907,12 @@ void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs)
>    */
>   int omap_hwmod_softreset(struct omap_hwmod *oh)
>   {
> -	u32 v;
> -	int ret;
> -
> -	if (!oh || !(oh->_sysc_cache))
> +	if (!oh)
>   		return -EINVAL;
>
> -	v = oh->_sysc_cache;
> -	ret = _set_softreset(oh,&v);
> -	if (ret)
> -		goto error;
> -	_write_sysconfig(v, oh);
> +	_ocp_softreset(oh);
>
> -error:
> -	return ret;
> +	return 0;

Just realized, this should be 'return _ocp_softreset(oh);'
instead. will fix and repost.

>   }
>
>   /**
