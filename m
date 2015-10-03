From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Sat, 03 Oct 2015 14:57:46 +0200
Subject: [PATCH v4 20/26] ARM: pxa: magician: Add support for MAX1587A
 Vcore regulator
In-Reply-To: <5609B377.3020404@tul.cz>
References: <cover.1443472089.git.petr.cvek@tul.cz> <5609B377.3020404@tul.cz>
Message-ID: <1443877066.4186.38.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 28.09.2015, 23:39 +0200 schrieb Petr Cvek:
> HTC Magician contains a MAX1587A voltage regulator for a Vcore
> supply.
> The Vcore regulation is required for a CPU speed switching. This
> patch adds
> declaration for the max1586 driver.
> 
> Notice:
> 
> - MAX1587A version does not support the V6 (USIM) output.
> - A boost resistor was directly measured for a board_id 0x3a.
> 
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> ---
>  arch/arm/mach-pxa/magician.c | 52
> ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach
> -pxa/magician.c
> index d844b9c..490d79f 100644
> --- a/arch/arm/mach-pxa/magician.c
> +++ b/arch/arm/mach-pxa/magician.c
> @@ -52,6 +52,8 @@
>  #include <linux/platform_data/camera-pxa.h>
>  #include <media/soc_camera.h>
>  
> +#include <linux/regulator/max1586.h>
> +
>  #include "devices.h"
>  #include "generic.h"
>  
> @@ -787,6 +789,52 @@ static struct platform_device vads7846_device =
> {
>  };
>  
>  /*
> + * Vcore regulator MAX1587A
> + */
> +
> +static struct regulator_consumer_supply
> magician_max1587a_consumers[] = {
> +	REGULATOR_SUPPLY("vcc_core", NULL),
> +};
> +
> +static struct regulator_init_data magician_max1587a_v3_info = {
> +	.constraints = {
> +		.name		= "vcc_core range",
> +		.min_uV		= 700000,
> +		.max_uV		= 1500000,

Wouldn't that be 1475000 for MAX1587A without the R24 resistor?

regards
Philipp
