From: igall@marvell.com (Igal Liberman)
Date: Mon, 8 May 2017 08:46:08 +0000
Subject: [PATCH v3 2/3] crypto: inside-secure: add SafeXcel EIP197 crypto
 engine driver
In-Reply-To: <c018afb6-202c-6e89-d990-c2259dc07f6e@arm.com>
References: <20170424075407.19730-1-antoine.tenart@free-electrons.com>
 <20170424075407.19730-3-antoine.tenart@free-electrons.com>
 <8ff65d6a5e5e4d388d3c5a384e4f5fd6@IL-EXCH01.marvell.com>
 <20170424085731.wbg53t5lcler4mng@kwain>
 <c018afb6-202c-6e89-d990-c2259dc07f6e@arm.com>
Message-ID: <a5e25c4a7e294ec2bea11803a79d0a77@IL-EXCH01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin

> -----Original Message-----
> From: linux-crypto-owner at vger.kernel.org [mailto:linux-crypto-
> owner at vger.kernel.org] On Behalf Of Robin Murphy
> Sent: Wednesday, May 03, 2017 20:15
> To: Antoine Tenart; Igal Liberman
> Cc: herbert at gondor.apana.org.au; davem at davemloft.net;
> jason at lakedaemon.net; andrew at lunn.ch; gregory.clement at free-
> electrons.com; sebastian.hesselbarth at gmail.com; linux-
> crypto at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> thomas.petazzoni at free-electrons.com; boris.brezillon at free-electrons.com;
> Ofer Heifetz; Nadav Haklai
> Subject: Re: [PATCH v3 2/3] crypto: inside-secure: add SafeXcel EIP197
> crypto engine driver
> 
> On 24/04/17 09:57, Antoine Tenart wrote:
> > Hi Igal,
> >
> > On Mon, Apr 24, 2017 at 08:50:32AM +0000, Igal Liberman wrote:
> >> [...]
> >>
> >>> +	priv->clk = of_clk_get(dev->of_node, 0);
> >>> +	if (!IS_ERR(priv->clk)) {
> >>> +		ret = clk_prepare_enable(priv->clk);
> >>> +		if (ret) {
> >>> +			dev_err(dev, "unable to enable clk (%d)\n", ret);
> >>> +			return ret;
> >>> +		}
> >>> +	} else {
> >>> +		/* The clock isn't mandatory */
> >>> +		if (PTR_ERR(priv->clk) == -EPROBE_DEFER)
> >>> +			return -EPROBE_DEFER;
> >>> +	}
> >>> +
> >>> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> >>
> >> The correct address width of the engine in Marvell SoCs is 40bit.
> 
> Is that what the IP block itself is internally limited to, or just how many bits
> happen to be wired up externally in the particular Marvell integrations?
> 

The IP supports up to 64bit address width (depends on the revision).
The 40bit limitation is related to Marvell integration.

> > Oops. I'll update.
> 
> If the device itself can handle full 64-bit addresses, then the driver should
> reflect that regardless of the integration - describing integration limitations is
> the job of the firmware, e.g. with DT "dma-ranges", assuming they actually
> matter (typically if the whole SoC interconnect and physical memory map is
> the same width then having an even wider DMA mask doesn't make any
> difference - 64 bits still just means "everything").
> 
> If it's the case that the IP is configurable and could be synthesised with
> various internal address widths, then that might warrant a DT property to
> identify the particular configuration if it's not readable from some ID
> register, although it may be reasonable in practice to simply assume the
> chosen configuration to be sane (i.e. not smaller than the rest of the system)
> and that the driver can set the maximal DMA mask as above.
> 
> Robin.
> 
> >
> > Thanks!
> > Antoine
> >
