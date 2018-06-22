From: vkoul@kernel.org (Vinod)
Date: Fri, 22 Jun 2018 10:14:17 +0530
Subject: [PATCH 2/2] hwrng: msm: add ACPI support
In-Reply-To: <869e9828-5e34-49db-4387-629dcc4b09b0@codeaurora.org>
References: <1529594276-12210-1-git-send-email-timur@codeaurora.org>
 <1529594276-12210-2-git-send-email-timur@codeaurora.org>
 <20180622042322.GF27187@vkoul-mobl>
 <869e9828-5e34-49db-4387-629dcc4b09b0@codeaurora.org>
Message-ID: <20180622044417.GI27187@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21-06-18, 23:26, Timur Tabi wrote:
> On 6/21/18 11:23 PM, Vinod wrote:
> > On 21-06-18, 10:17, Timur Tabi wrote:
> > > Add support for probing on ACPI systems, with ACPI HID QCOM8160.
> > > 
> > > On ACPI systems, clocks are always enabled, the PRNG should
> > > already be enabled, and the register region is read-only.
> > > The driver only verifies that the hardware is already
> > > enabled never tries to disable or configure it.
> > 
> > so if you are using v2 hardware, are you pointing to High Level OS EE or
> > some other..?
> 
> I'm not sure what you mean.
> 
> > >  +	/*
> > > +	 * ACPI systems have v2 hardware. The clocks are always enabled,
> > > +	 * the PRNG register space is read-only, and the PRNG should
> > > +	 * already be enabled.
> > > +	 */
> > > +	if (has_acpi_companion(&pdev->dev)) {
> > > +		u32 val;
> > > +
> > > +		val = readl(rng->base + PRNG_CONFIG);
> > 
> > v2 EEs dont seem to have CONFIG register, so not sure about this one
> 
> I can post the register set, but this works on my silicon.  The first device
> has all the registers.  Then there are about 12-13 other devices with their
> own 64K register regions, and those don't have a config register.

The one on MSM8996 have 4K register space for each region and first two
regions are not accessible to the SW. They are part of security ring and
hence the CONFIG register is not accessible. If i try to access then it
borks!

Are you sure you are supposed to use the TZ there, I would presume the
lower level firmware would use that?

> I don't know why you would choose to support a one of the secondary register
> sets when you can use the primary.

Access denied is the reason :D

So this make me think you should do 2 level support for ACPI, one ACPI
support and one V2 support where we dont touch CONFIG register. That way
both regions will work

-- 
~Vinod
