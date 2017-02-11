From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Sat, 11 Feb 2017 04:53:16 +0200
Subject: [linux-sunxi] [PATCH] Add Master Sample Data Mode for SPI
In-Reply-To: <20170210220247.8478-1-viniciusfre@gmail.com>
References: <20170210220247.8478-1-viniciusfre@gmail.com>
Message-ID: <20170211045316.12d939ae@i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Feb 2017 19:02:47 -0300
Vinicius Maciel <viniciusfre@gmail.com> wrote:

> In order to work appropriately, the max11043 ADC chip and probably
> others, needs SPI master samples the data at the correct edge. From
> max11043 datasheet: "The data at DIN is latched on the rising edge
> of SCLK". Same to DOUT.
> 
> This patch add Master Sample Data Mode bit in normal sample mode.
> 
> Signed-off-by: Vinicius Maciel <viniciusfre@gmail.com>
> ---
>  drivers/spi/spi-sun4i.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index c5cd635c28f3..6325be2ce8d9 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -44,6 +44,7 @@
>  #define SUN4I_CTL_CS_MANUAL			BIT(16)
>  #define SUN4I_CTL_CS_LEVEL			BIT(17)
>  #define SUN4I_CTL_TP				BIT(18)
> +#define SUN4I_CTL_SDM				BIT(20)
>  
>  #define SUN4I_INT_CTL_REG		0x0c
>  #define SUN4I_INT_CTL_RF_F34			BIT(4)
> @@ -407,7 +408,8 @@ static int sun4i_spi_runtime_resume(struct device *dev)
>  	}
>  
>  	sun4i_spi_write(sspi, SUN4I_CTL_REG,
> -			SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP);
> +			SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP |
> +			SUN4I_CTL_SDM);
>  
>  	return 0;
>  

Thanks! That's a good catch. This particular bit is actually set in the
reset default register value, according to the Allwinner A20 manual.
But on Allwinner A10 and Allwinner A13 it is documented as unused and
can't be changed (it remains zero even if we try to modify it).

So looks like only A20 is affected, because the kernel currently sets a
non-standard mode, deviating from both Allwinner's default and normal
SPI behaviour.

You still need to update the summary line to add all the necessary
sunxi and spi specific prefixes (see similar commits). Also a similar
fix most likely needs to be applied to the spi-sun6i.c file too (due
to the copy-paste curse and code duplication), but I'm not sure if it
needs to be a part of this patch or a separate one.

Reviewed-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>

-- 
Best regards,
Siarhei Siamashka
