From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 12 Sep 2016 11:49:32 +0100
Subject: [PATCH v5 2/3] mfd: add support for Allwinner SoCs ADC
In-Reply-To: <20160912100719.GJ9449@lukather>
References: <1473344917-1524-1-git-send-email-quentin.schulz@free-electrons.com>
 <1473344917-1524-3-git-send-email-quentin.schulz@free-electrons.com>
 <20160912091829.GB1873@dell>
 <93bd339b-85ab-d0fc-5e80-e2aca290c0d7@free-electrons.com>
 <20160912095923.GD1873@dell> <20160912100719.GJ9449@lukather>
Message-ID: <20160912104932.GF1873@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Sep 2016, Maxime Ripard wrote:

> On Mon, Sep 12, 2016 at 10:59:23AM +0100, Lee Jones wrote:
> > > >> +static const struct of_device_id sun4i_gpadc_mfd_of_match[] = {
> > > >> +	{
> > > >> +		.compatible = "allwinner,sun4i-a10-ts",
> > > >> +		.data = &sun4i_gpadc_mfd_cells,
> > > >> +	}, {
> > > >> +		.compatible = "allwinner,sun5i-a13-ts",
> > > >> +		.data = &sun5i_gpadc_mfd_cells,
> > > >> +	}, {
> > > >> +		.compatible = "allwinner,sun6i-a31-ts",
> > > >> +		.data = &sun6i_gpadc_mfd_cells,
> > > >> +	}, { /* sentinel */ }
> > > >> +};
> > > > 
> > > > Don't mix OF and MFD functionality.
> > > > 
> > > > Why don't you create a node for "iio_hwmon" and have
> > > > platform_of_populate() do your bidding?
> > > > 
> > > 
> > > We are using a stable binding which we cannot modify. This means, the DT
> > > in its current state can only be modified to add features, which is not
> > > the case of this driver (it is a rewriting of an existing driver which
> > > uses the rtp node).
> > 
> > Then use .data = <defined model ID> and set up a switch() in .probe().
> 
> Uh? Why? It just adds a non-standard indirection, while using
> of_match_device is very standard, and used extensively in Linux.

You still use of_match_device() to obtain the ID.

The "don't mix DT with the MFD API" is there to prevent some of the
nasty hacks I've seen previously.  This particular example doesn't
seem so bad, but it's a gateway to ridiculous hackery!

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
