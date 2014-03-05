From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Mar 2014 10:12:55 +0000
Subject: [PATCH 2/2] ixp4xx_eth: Setup coherent_dma_mask
In-Reply-To: <m38uspas21.fsf@t19.piap.pl>
References: <20140305085311.07b3922a@marrow.netinsight.se>
 <20140305085549.3eb22236@marrow.netinsight.se> <m3d2i1atmq.fsf@t19.piap.pl>
 <20140305094330.GU21483@n2100.arm.linux.org.uk> <m38uspas21.fsf@t19.piap.pl>
Message-ID: <20140305101255.GW21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 10:55:02AM +0100, Krzysztof Ha?asa wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> >> > +	err = dma_set_coherent_mask(&dev->dev, DMA_BIT_MASK(32));
> >> > +	if (err < 0)
> >> > +		goto err_free;
> >> > +
> >> 
> >> Both David and the DMA API say 32 bits must be the default. OTOH there
> >> is other code like this in the kernel, guess IXP4xx is not alone with
> >> such constrains.
> >
> > If you have drivers missing this call, that's part of the problem:
> >
> > | For correct operation, you must interrogate the kernel in your device
> > | probe routine to see if the DMA controller on the machine can properly
> > | support the DMA addressing limitation your device has.
> 
> Well, we already know it can. Actually, the DMA controller is a part of
> the CPU + RAM controller chip :-)
> 
> But I guess with this new wording it's something the drivers can use.

What I quoted is not "new wording" apart from the addition of the interface
which sets both masks.  This has been documented as a requirement since
before there was a dma_* API (the pci_dma_* API predated that, and also
had this requirement.)

It's something that has long been ignored on ARM because "oh we can do it
in the platform code" - not anymore, not with DT.  This short-cut has
finally bitten, and we now must conform.

So, in the interests of everything working as it should, it's something
that needs to be fixed irrespective of anything else: all our drivers
which perform DMA should make the appropriate DMA mask calls.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
