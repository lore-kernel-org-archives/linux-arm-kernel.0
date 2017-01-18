From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jan 2017 23:12:06 +0000
Subject: [PATCH 06/10] soc/qbman: Add ARM equivalent for
 flush_dcache_range()
In-Reply-To: <1484779180-1344-7-git-send-email-roy.pledge@nxp.com>
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
 <1484779180-1344-7-git-send-email-roy.pledge@nxp.com>
Message-ID: <20170118231206.GT27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 05:39:36PM -0500, Roy Pledge wrote:
> From: Claudiu Manoil <claudiu.manoil@nxp.com>
> 
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> ---
>  drivers/soc/fsl/qbman/qman_ccsr.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
> index 43feaa9..67ae073 100644
> --- a/drivers/soc/fsl/qbman/qman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/qman_ccsr.c
> @@ -446,8 +446,14 @@ static int zero_priv_mem(struct device *dev, struct device_node *node,
>  		return -ENOMEM;
>  
>  	memset(tmpp, 0, sz);
> +#ifdef CONFIG_PPC
>  	flush_dcache_range((unsigned long)tmpp,
>  			   (unsigned long)tmpp + sz);
> +#elif defined(CONFIG_ARM)
> +	__cpuc_flush_dcache_area(tmpp, sz);

Please do not fiddle about under the covers, there be dragons there.

It looks to me like you're trying to use __cpuc_flush_dcache_area()
on an area that's been ioremap()'d, which is a waste of CPU cycles.
ioremap()'d areas are mapped as "device" memory type, which means
the region isn't even cached.  So I don't think this is necessary.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
