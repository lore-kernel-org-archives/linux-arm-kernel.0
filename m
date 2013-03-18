From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Mar 2013 21:40:23 +0000
Subject: [PATCH v2 1/2] ARM: vexpress: Enable regulator framework when
 MMCI is in use
In-Reply-To: <20130318185458.GK4977@n2100.arm.linux.org.uk>
References: <20130315181614.GY4977@n2100.arm.linux.org.uk>
 <1363630617.3054.19.camel@hornet>
 <20130318185458.GK4977@n2100.arm.linux.org.uk>
Message-ID: <201303182140.23623.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 March 2013, Russell King - ARM Linux wrote:
> On Mon, Mar 18, 2013 at 06:16:57PM +0000, Pawel Moll wrote:
> > 
> > Reverting it will not change anything as the driver had the same
> > dependency before, just using :
> 
> Umm.  If CONFIG_REGULATOR is not set with the patch reverted, the
> regulator support is not used at all, and the ocrmask comes from
> the platform data.

I think the point is that case of DT booting, the platform data has
a zero ocrmask, because Versatile Express has no auxdata to set
a platform_data pointer for the mmci device, and the default allocated
mmci device driver does not initialize the ocrmask unless the
regulator API is used.

This took me a while to figure out, the point being that this is not
actually a regression, it never worked as far as I can tell.

I don't think that selecting the regulator API is a good idea, for
the reasons that you mentioned, and I still wouldn't take the
patch. In theory we could do a workaround by adding a DT property
to the mmci node that describes the fixed voltage supplied to the
card if there are no regulators, but then again we already describe
the voltage using the regulator binding and I would not want to
duplicate that information.

What I think we should have though is a better diagnostic here:
If neither the platform data nor the DT contain a valid description
of the voltage supplied to the card, the probe should fail saying
that the information is missing, not that the card is incompatible.

	Arnd
