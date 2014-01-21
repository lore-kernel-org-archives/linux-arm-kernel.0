From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Jan 2014 09:03:43 +0100
Subject: [PATCH v2 1/2] dmaengine: add Qualcomm BAM dma driver
In-Reply-To: <20140120225245.GA3530@qualcomm.com>
References: <1389380874-22753-1-git-send-email-agross@codeaurora.org>
 <201401172349.28229.arnd@arndb.de> <20140120225245.GA3530@qualcomm.com>
Message-ID: <5548936.L46nLkuVIz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 January 2014 16:52:45 Andy Gross wrote:

> > > +#ifdef CONFIG_OF
> > > +static const struct of_device_id bam_of_match[] = {
> > > +	{ .compatible = "qcom,bam-v1.4.0", },
> > > +	{ .compatible = "qcom,bam-v1.4.1", },
> > > +	{}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, bam_of_match);
> > > +#endif
> > 
> > Also, you can remove the #ifdef here and the of_match_ptr() below.
> > 
> 
> If this is removed, then I'll have to add the OF dependency in the Kconfig,
> correct?

I believe it will still compile without the CONFIG_OF dependency, but
having the dependency still makes sense as it's impossible to use the
driver without CONFIG_OF.

The best dependency line is probably

	depends on (ARCH_MSM && OF) || COMPILE_TEST"

If you expect the same driver to be used on non-MSM platforms from
qualcomm, e.g. some networking or server equipment, you can also just
drop the ARCH_MSM dependency.

	Arnd
