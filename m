From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 14 Jun 2012 12:42:24 +0200
Subject: [PATCH] i2c: let the core register devices from devicetree
In-Reply-To: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20120614124224.58a9e823@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Wed, 13 Jun 2012 23:12:10 +0200, Wolfram Sang wrote:
> Currently, every driver has to do it on its own, but it should be done
> in the core, like we already do with board_info structs.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
> 
> Based on v3.5-rc2. Only build tested, I don't have a OF based device
> around at the moment.
> (...)
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index a6ad32b..4791833 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -39,6 +39,7 @@
>  #include <linux/irqflags.h>
>  #include <linux/rwsem.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/of_i2c.h>
>  #include <asm/uaccess.h>
>  
>  #include "i2c-core.h"
> @@ -880,6 +881,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>  #endif
>  
>  	/* create pre-declared device nodes */
> +	of_i2c_register_devices(adap);
> +
>  	if (adap->nr < __i2c_first_dynamic_bus_num)
>  		i2c_scan_static_board_info(adap);
>  

This was proposed in the past, and rejected because of dependency
issues. I don't think the situation changed. of_i2c needs i2c-core for
i2c_new_device(), and with the change above, i2c-core needs of_i2c for
of_i2c_register_devices(). If either is built as a module, it will fail.

This might be the reason why of_spi ended up being merged into
drivers/spi according to Grant? I have no objection to the same being
done for of_i2c if it makes everybody happy, as long as it does not
create additional dependencies (i.e. I2C should not depend on OF.)

-- 
Jean Delvare
