From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 May 2011 00:08:21 +0100
Subject: [PATCH 2/2] OMAP3BEAGLE: Add support for mt9p031 sensor
	(LI-5M03 module).
In-Reply-To: <1305624528-5595-3-git-send-email-javier.martin@vista-silicon.com>
References: <1305624528-5595-1-git-send-email-javier.martin@vista-silicon.com>
	<1305624528-5595-3-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <20110517230821.GA5913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2011 at 11:28:48AM +0200, Javier Martin wrote:
> +#include "devices.h"
> +#include "../../../drivers/media/video/omap3isp/isp.h"
> +#include "../../../drivers/media/video/omap3isp/ispreg.h"

This suggests that there's something very wrong with what's going on;
it suggests that you're trying to access driver internals which should
be handled via some better means.  And it looks like it's this:

> @@ -654,6 +715,62 @@ static void __init beagle_opp_init(void)
>  	return;
>  }
>  
> +extern struct platform_device omap3isp_device;
> +
> +static int beagle_cam_set_xclk(struct v4l2_subdev *subdev, int hz)
> +{
> +	struct isp_device *isp = platform_get_drvdata(&omap3isp_device);
> +	int ret;
> +
> +	ret = isp->platform_cb.set_xclk(isp, hz, MT9P031_XCLK);
> +	return 0;
> +}

That really needs fixing in a different way.
