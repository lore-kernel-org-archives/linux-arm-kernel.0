From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 3 Mar 2011 22:45:25 +0100
Subject: [PATCH 4/4] OMAP3 and 4 I2C use cpu type consistently for new
	register availability
In-Reply-To: <20110303135044.30648.27273.stgit@otae.warmcat.com>
References: <20110303134744.30648.91218.stgit@otae.warmcat.com>
	<20110303135044.30648.27273.stgit@otae.warmcat.com>
Message-ID: <4D700BF5.8090308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/3/2011 2:50 PM, Andy Green wrote:
> The driver makes the choice about which register layout to
> use based on cpu, however it then tries to use the probed
> peripheral unit version register to decide whether to access
> registers that only exist in the 4430 unit.
>
> Unfortunately, the unit with the smaller register map on the
> OMAP3530 has the same peripheral unit version number, leading
> the OMAP3530 to dereference the register map beyond the bounds
> of its array, and then to access a 'random' register offset taken
> from whatever happens to be sitting beyond the register map
> array, as reported here
>
> https://bugs.launchpad.net/linux-linaro/+bug/645324
>
> This patch makes both the choice of register map and the decision
> to use a register only present in the larger map both do so based
> on cpu type, which correctly reflects register availability.
>
> Cc: patches at linaro.org
> Reported-by: Peter Maydell<peter.maydell@linaro.org>
> Signed-off-by: Andy Green<andy.green@linaro.org>
> ---
>
>   drivers/i2c/busses/i2c-omap.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index e09c62d..c82e1bb5 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -309,7 +309,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
>   	pdata = pdev->dev.platform_data;
>
>   	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
> -	if (dev->rev>= OMAP_I2C_REV_ON_4430)
> +	if (cpu_is_omap44xx())

As explained before, you should not add any cpu_is_XXX in the driver. 
That rev field is the way to go, except that it should be populated 
using hwmod data information instead of inaccurate I2C register revision 
field.

Regards,
Benoit
