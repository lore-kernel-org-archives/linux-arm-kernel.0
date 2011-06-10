From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 10 Jun 2011 16:39:02 -0600
Subject: [PATCH v4 4/4] dt: add amba device creation to platform bus scan
In-Reply-To: <1307738923-7564-5-git-send-email-robherring2@gmail.com>
References: <1307738923-7564-1-git-send-email-robherring2@gmail.com>
	<1307738923-7564-5-git-send-email-robherring2@gmail.com>
Message-ID: <20110610223902.GF28994@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 03:48:43PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Add support to the platform bus scanning to call custom device creation
> function for amba devices.
> 
> Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: arnd at arndb.de
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  drivers/of/platform.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 8d0f477..1712f22 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -21,6 +21,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/amba/bus.h>
>  
>  static int of_dev_node_match(struct device *dev, void *data)
>  {
> @@ -234,6 +235,11 @@ static int of_platform_bus_create(struct device_node *bus,
>  		return 0;
>  	}
>  
> +	if (of_device_is_compatible(bus, "arm,amba-device")) {
> +		of_amba_device_create(bus, parent);
> +		return 0;
> +	}
> +	

Yeah, this is the right thing to do.  I'll pick it up.

>  	dev = of_platform_device_create(bus, NULL, parent);
>  	if (!dev || !of_match_node(matches, bus))
>  		return 0;
> -- 
> 1.7.4.1
> 
