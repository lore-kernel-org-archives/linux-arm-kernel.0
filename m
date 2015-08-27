From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 27 Aug 2015 07:45:39 +0100
Subject: [PATCH 2/4] remoteproc: Supply controller driver for ST's Remote
 Processors
In-Reply-To: <55DDF252.2010901@mentor.com>
References: <1440594483-29601-1-git-send-email-lee.jones@linaro.org>
 <1440594483-29601-3-git-send-email-lee.jones@linaro.org>
 <55DDF252.2010901@mentor.com>
Message-ID: <20150827064539.GD19409@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Aug 2015, Nathan Lynch wrote:

> On 08/26/2015 08:08 AM, Lee Jones wrote:
> > --- /dev/null
> > +++ b/drivers/remoteproc/st_remoteproc.c
> > @@ -0,0 +1,300 @@
> > +/*
> > + * ST's Remote Processor Control Driver
> > + *
> > + * Copyright (C) 2015 STMicroelectronics - All Rights Reserved
> > + *
> > + * Author: Ludovic Barre <ludovic.barre@st.com>
> 
> When submitting code you didn't write, I'd say it's better practice to
> clearly indicate its provenance in the commit message.  E.g. something
> like "Driver based on code authored by Ludovic Barre for ST".  And
> obtain signoffs etc if possible.
> 
> 
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License.
> 
> Please review the wording here.  It's unclear whether this is intended
> to be v2-only or v2 or later.
> 
> 
> > +static int st_rproc_stop(struct rproc *rproc)
> > +{
> > +	struct st_rproc *st_rproc = rproc->priv;
> > +	int err = 0;
> > +
> > +	if (st_rproc->config->sw_reset) {
> > +		err = reset_control_assert(st_rproc->sw_reset);
> > +		if (err)
> > +			dev_warn(&rproc->dev, "Failed to assert S/W Reset\n");
> > +	}
> > +
> > +	if (st_rproc->config->pwr_reset) {
> > +		err = reset_control_assert(st_rproc->pwr_reset);
> > +		if (err)
> > +			dev_warn(&rproc->dev, "Failed to assert Power Reset\n");
> > +	}
> > +
> > +	clk_disable(st_rproc->clk);
> > +
> > +	return 0;
> > +}
> 
> Seems like st_rproc_stop should propagate errors back to its caller
> instead of always returning 0.

Good points, will fix.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
