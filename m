From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Jan 2014 01:11:21 +0000
Subject: Regression (ARM) arch/arm/mm/init.c doesn't build without
 CONFIG_ARM_PATCH_PHYS_VIRT.
In-Reply-To: <52CB3F55.1050404@ti.com>
References: <m38uv1uuzr.fsf@t19.piap.pl> <m3ha9gx63v.fsf@t19.piap.pl>
 <20140106223906.GH27432@n2100.arm.linux.org.uk> <52CB3F55.1050404@ti.com>
Message-ID: <20140107011121.GI27432@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 06:42:13PM -0500, Santosh Shilimkar wrote:
> On Monday 06 January 2014 05:39 PM, Russell King - ARM Linux wrote:
> > On Mon, Jan 06, 2014 at 08:28:20PM +0100, Krzysztof Ha?asa wrote:
> >> Russell, Santosh,
> >>
> >> the unneeded commit causing regression is still in place. Please try to
> >> compile an ARM kernel without CONFIG_ARM_PATCH_PHYS_VIRT and with
> >> CONFIG_ZONE_DMA and see for yourself, if you don't believe me.
> >>
> >> Please be aware that this commit fixes nothing, its only function is
> >> causing the regression - so we don't lose anything by reverting it.
> >>
> >> If the attached wasn't clear, what the defective commit presently does
> >> is changing a perfectly valid code into a code referencing a variable
> >> which (without CONFIG_ARM_PATCH_PHYS_VIRT set) doesn't at all exist.
> >>
> >> With CONFIG_ARM_PATCH_PHYS_VIRT set, this commit does precisely nothing.
> > 

/--------------------------------------------------------------
| > > Right, so, with Assabet, which has CONFIG_DMA_ZONE=y and
| > > CONFIG_ARM_PATCH_PHYS_VIRT=y:
| > > 
| > > $ make O=../build/assabet arch/arm/mm/init.i
| > > 
| > > gives:
| > >   arm_dma_limit = __pv_phys_offset + arm_dma_zone_size - 1;
| > > 
| > > with or without Santosh's patch.
\--------------------------------------------------------------

> May be I missed your point but I ended up creating the patch because
> the CMA reservation was failing on Keystone since the arm_dma_limit
> wasn't right since it wasn't considering the actual __pv_phys_offset.
> 
> Isn't that an issue ?

See the above.  Your patch has _no_ effect what so ever when
CONFIG_ARM_PATCH_PHYS_VIRT=y - which you have on the Keystone, right?

If you don't believe me, ask make to produce arch/arm/mm/init.i, which
is the output from the preprocessor, comparing the resulting generated
file both with and without your patch applied.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
