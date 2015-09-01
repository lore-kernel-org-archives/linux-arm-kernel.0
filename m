From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 1 Sep 2015 08:55:38 +0100
Subject: [PATCH v2 3/4] remoteproc: Supply controller driver for ST's
 Remote Processors
In-Reply-To: <55E08B34.9080102@mentor.com>
References: <1440757911-9120-1-git-send-email-lee.jones@linaro.org>
 <1440757911-9120-4-git-send-email-lee.jones@linaro.org>
 <55E08B34.9080102@mentor.com>
Message-ID: <20150901075538.GJ4796@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Aug 2015, Nathan Lynch wrote:

> On 08/28/2015 05:31 AM, Lee Jones wrote:
> > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > index 28c711f..72e97d7 100644
> > --- a/drivers/remoteproc/Kconfig
> > +++ b/drivers/remoteproc/Kconfig
> > @@ -77,4 +77,13 @@ config DA8XX_REMOTEPROC
> >  	  It's safe to say n here if you're not interested in multimedia
> >  	  offloading.
> >  
> > +config ST_REMOTEPROC
> > +	tristate "ST remoteproc support"
> > +	depends on ARCH_STI
> > +	select REMOTEPROC
> > +	help
> > +	  Say y here to support ST's adjunct processors via the remote
> > +	  processor framework.
> > +	  This can be either built-in or a loadable module.
> > +
> 
> The code uses reset_control_* APIs, so this should depend on
> RESET_CONTROLLER, no?

There's no need to explicitly depend on RESET_CONTROLLER.

With !RESET_CONTROLLER the user is WARN()ed about using the reset_*
API.

> > +/*
> > + * ST's Remote Processor Control Driver
> > + *
> > + * Copyright (C) 2015 STMicroelectronics - All Rights Reserved
> > + *
> > + * Author: Ludovic Barre <ludovic.barre@st.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2, or (at your option)
> > + * any later version.
> > + */
> 
> OK, but:
> 
> > +MODULE_LICENSE("GPL v2");
> 
> These are not in agreement.  You want "GPL" for MODULE_LICENSE if you
> intend v2 or later.

Right, good spot.

I will clarify this with ST and make the necessary changes.

> > +static int st_rproc_stop(struct rproc *rproc)
> > +{
> > +	struct st_rproc *st_rproc = rproc->priv;
> > +	int ret, err = 0;
> > +
> > +	if (st_rproc->config->sw_reset) {
> > +		ret = reset_control_assert(st_rproc->sw_reset);
> > +		if (ret)
> > +			dev_err(&rproc->dev, "Failed to assert S/W Reset\n");
> > +	}
> > +
> > +	if (st_rproc->config->pwr_reset) {
> > +		err = reset_control_assert(st_rproc->pwr_reset);
> > +		if (err)
> > +			dev_err(&rproc->dev, "Failed to assert Power Reset\n");
> > +	}
> > +
> > +	clk_disable(st_rproc->clk);
> > +
> > +	return ret ?: err;
> > +}
> 
> Sorry, but I think this is a stylistically inadequate response to my
> earlier comments.  At least name the status variables sw_ret and pwr_ret
> or something.  And it looks like ret could be used uninitialized.
> 
> Also, do you want to unconditionally call clk_disable even if you've
> encountered errors?

Again this is something I need to clarify.  However, it doesn't strike
me as incorrect to gate the IP's clock just because the reset lines
haven't been successfully asserted.

Will check with the guys who know this IP and make suggested changes.

> > +static int st_rproc_start(struct rproc *rproc)
> > +{
> > +	struct st_rproc *st_rproc = rproc->priv;
> > +	int err;
> > +
> > +	regmap_update_bits(st_rproc->boot_base, st_rproc->boot_offset,
> > +			   st_rproc->config->bootaddr_mask, rproc->bootaddr);
> > +
> > +	err = clk_enable(st_rproc->clk);
> > +	if (err) {
> > +		dev_err(&rproc->dev, "Failed to enable clock\n");
> > +		return err;
> > +	}
> > +
> > +	if (st_rproc->config->sw_reset) {
> > +		err = reset_control_deassert(st_rproc->sw_reset);
> > +		if (err) {
> > +			dev_err(&rproc->dev, "Failed to deassert S/W Reset\n");
> > +			return err;
> > +		}
> > +	}
> > +
> > +	if (st_rproc->config->pwr_reset) {
> > +		err = reset_control_deassert(st_rproc->pwr_reset);
> > +		if (err) {
> > +			dev_err(&rproc->dev, "Failed to deassert Power Reset\n");
> > +			return err;
> > +		}
> > +	}
> > +
> > +	dev_info(&rproc->dev, "Started from 0x%x\n", rproc->bootaddr);
> > +
> > +	return 0;
> > +}
> 
> Does this want to unwind any of its operations if it encounters a failure?

Sounds sensible.  Will adapt.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
