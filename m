From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 18 May 2011 18:48:37 +0530
Subject: [PATCH 2/9] davinci: sram: ioremap the davinci_soc_info
	specified sram regions
In-Reply-To: <80c0c2ff5a39baf6140c08460c2691b178c038c0.1305668470.git.bengardiner@nanometrics.ca>
References: <B85A65D85D7EB246BE421B3FB0FBB593024CF13ED4@dbde02.ent.ti.com>
	<cover.1305668470.git.bengardiner@nanometrics.ca>
	<80c0c2ff5a39baf6140c08460c2691b178c038c0.1305668470.git.bengardiner@nanometrics.ca>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CFDCA6C@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On Wed, May 18, 2011 at 03:11:58, Ben Gardiner wrote:

> diff --git a/arch/arm/mach-davinci/sram.c b/arch/arm/mach-davinci/sram.c
> index 219d4c5..96026df 100644
> --- a/arch/arm/mach-davinci/sram.c
> +++ b/arch/arm/mach-davinci/sram.c
> @@ -8,6 +8,7 @@
>   * the Free Software Foundation; either version 2 of the License, or
>   * (at your option) any later version.
>   */
> +#include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <asm/pv-pool.h>
> @@ -26,16 +27,23 @@ EXPORT_SYMBOL_GPL(davinci_pv_pool);
>   */
>  static int __init sram_init(void)
>  {
> +	void *addr;
>  	unsigned len = davinci_soc_info.sram_len;
>  	int status = 0;
>  
>  	if (len) {
>  		len = min_t(unsigned, len, SRAM_SIZE);
> -		davinci_pv_pool = pv_pool_create((void *)SRAM_VIRT,
> +		addr = ioremap(davinci_soc_info.sram_phys, len);
> +		if (!addr)
> +			return -EIO;

-ENOMEM here (for the next time you post). See Sergei's
mail on error codes below. Useful stuff.

https://patchwork.kernel.org/patch/47365/

Thanks,
Sekhar
