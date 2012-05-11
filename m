From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 11 May 2012 10:33:03 +0800
Subject: [alsa-devel] [PATCH 5/6] ASoC: mxs: add device tree support
 for mxs-sgtl5000
In-Reply-To: <20120510122001.GM17875@S2101-09.ap.freescale.net>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
 <1336639333-11561-6-git-send-email-shawn.guo@linaro.org>
 <20120510111646.GL6622@shlinux2.ap.freescale.net>
 <20120510122001.GM17875@S2101-09.ap.freescale.net>
Message-ID: <20120511023302.GN6622@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 08:20:04PM +0800, Shawn Guo wrote:
> On Thu, May 10, 2012 at 07:16:46PM +0800, Dong Aisheng wrote:
> > > +static int __devinit mxs_sgtl5000_probe_dt(struct platform_device *pdev)
> > > +{
> > > +	struct device_node *np = pdev->dev.of_node;
> > > +	struct device_node *saif_np[2], *codec_np;
> > > +	struct platform_device *saif_pdev[2];
> > > +	int i, ret = 0;
> > > +
> > > +	if (!np)
> > > +		return 1; /* no device tree */
> > > +
> > > +	saif_np[0] = of_parse_phandle(np, "saif-controllers", 0);
> > > +	saif_np[1] = of_parse_phandle(np, "saif-controllers", 1);
> > > +	codec_np = of_parse_phandle(np, "audio-codec", 0);
> > > +	if (!saif_np[0] || !saif_np[1] || !codec_np) {
> > > +		dev_err(&pdev->dev, "phandle missing or invalid\n");
> > > +		return -EINVAL;
> > > +	}
> > ...
> > 
> > > +
> > > +	saif_pdev[0] = of_find_device_by_node(saif_np[0]);
> > > +	saif_pdev[1] = of_find_device_by_node(saif_np[1]);
> > > +	if (!saif_pdev[0] || !saif_pdev[1]) {
> > > +		dev_err(&pdev->dev, "failed to find saif platform device\n");
> > > +		ret = -EINVAL;
> > > +		goto out;
> > > +	}
> > Do we really need this checking?
> > 
> Hmm, why not?  We need to ensure that the phandles are correctly
> represented in device tree.
> 
Hmm, even we need to do sanity check, i guess this could be done in
core since the core will take these nodes as parameter.
However, after checking the core a bit, i guess the core has already
done this:

/* no, then find CPU DAI from registered DAIs*/
list_for_each_entry(cpu_dai, &dai_list, list) {
	if (dai_link->cpu_dai_of_node) {
		if (cpu_dai->dev->of_node != dai_link->cpu_dai_of_node)
			continue;
	} else {
		if (strcmp(cpu_dai->name, dai_link->cpu_dai_name))
			continue;
	}

	rtd->cpu_dai = cpu_dai;
	goto find_codec;
}

It looks if the phandles are not correctly represented, the dai binding
will fail, right?

Regards
Dong Aisheng
