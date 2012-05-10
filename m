From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 20:20:04 +0800
Subject: [alsa-devel] [PATCH 5/6] ASoC: mxs: add device tree support for
 mxs-sgtl5000
In-Reply-To: <20120510111646.GL6622@shlinux2.ap.freescale.net>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
 <1336639333-11561-6-git-send-email-shawn.guo@linaro.org>
 <20120510111646.GL6622@shlinux2.ap.freescale.net>
Message-ID: <20120510122001.GM17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 07:16:46PM +0800, Dong Aisheng wrote:
> > +static int __devinit mxs_sgtl5000_probe_dt(struct platform_device *pdev)
> > +{
> > +	struct device_node *np = pdev->dev.of_node;
> > +	struct device_node *saif_np[2], *codec_np;
> > +	struct platform_device *saif_pdev[2];
> > +	int i, ret = 0;
> > +
> > +	if (!np)
> > +		return 1; /* no device tree */
> > +
> > +	saif_np[0] = of_parse_phandle(np, "saif-controllers", 0);
> > +	saif_np[1] = of_parse_phandle(np, "saif-controllers", 1);
> > +	codec_np = of_parse_phandle(np, "audio-codec", 0);
> > +	if (!saif_np[0] || !saif_np[1] || !codec_np) {
> > +		dev_err(&pdev->dev, "phandle missing or invalid\n");
> > +		return -EINVAL;
> > +	}
> ...
> 
> > +
> > +	saif_pdev[0] = of_find_device_by_node(saif_np[0]);
> > +	saif_pdev[1] = of_find_device_by_node(saif_np[1]);
> > +	if (!saif_pdev[0] || !saif_pdev[1]) {
> > +		dev_err(&pdev->dev, "failed to find saif platform device\n");
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> Do we really need this checking?
> 
Hmm, why not?  We need to ensure that the phandles are correctly
represented in device tree.

> > +	card->dev = &pdev->dev;
> Repeat assignment?
> 
Good catch, again.  It's a rebasing error.  Thanks.

Regards,
Shawn
