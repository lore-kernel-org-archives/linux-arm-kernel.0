From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 30 Oct 2012 04:05:11 +0000 (UTC)
Subject: [PATCHv2 12/12] ARM: OMAP4: hwmod data: do not enable or reset
 the McPDM during kernel init
In-Reply-To: <4FD5C04F.2040509@ti.com>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004626.20034.42995.stgit@dusk> <4FD5C04F.2040509@ti.com>
Message-ID: <alpine.DEB.2.00.1210300403170.12697@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 11 Jun 2012, Cousson, Benoit wrote:

> On 6/11/2012 2:46 AM, Paul Walmsley wrote:
>
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > index 3613054..86fc513 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > @@ -2091,6 +2091,18 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod = {
> >   	.name		= "mcpdm",
> >   	.class		= &omap44xx_mcpdm_hwmod_class,
> >   	.clkdm_name	= "abe_clkdm",
> > +	/*
> > +	 * It's suspected that the McPDM requires an off-chip main
> > +	 * functional clock, controlled via I2C.
> 
> Nit: Is it not suspected, it is a fact. The clock tree clearly indicate that
> the mcpdm fclk is generated from the pad_clks.
> The IP is a custom link for the Audio IC control / data. using the Audio IC as
> a source clock is standard. Since that IP is done only for that purpose, there
> is no optional clock path from the PRCM like it is the case for the McASP /
> McBSP.
> 
> >  This IP block is
> > +	 * currently reset very early during boot, before I2C is
> > +	 * available, so it doesn't seem that we have any choice in
> > +	 * the kernel other than to avoid resetting it.  XXX This is
> > +	 * really a hardware issue workaround: every IP block should
> > +	 * be able to source its main functional clock from either
> > +	 * on-chip or off-chip sources.  McPDM seems to be the only
> > +	 * current exception.
> 
> I do not think this is the right place to put some complaint about the HW :-).
> I guess we should just describe the facts.
> 
> > +	 */
> > +	.flags		= HWMOD_EXT_OPT_MAIN_CLK,

I've updated this one to take your comments into account for 3.7-rc fixes.  
But...

> Could you please update the hints for this IP in the autogen scripts?
> I added a comment attribute to add a custom comment on top of the flags entry.
> The latest branch is "omap5430_for_3.6".

... could you please take care of updating the autogen side?  Updated 
patch is below.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Mon, 29 Oct 2012 22:02:14 -0600
Subject: [PATCH] ARM: OMAP4: hwmod data: do not enable or reset the McPDM
 during kernel init
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Resolve this kernel boot message:

omap_hwmod: mcpdm: cannot be enabled for reset (3)

The McPDM on OMAP4 can only receive its functional clock from an
off-chip source.  This source is not guaranteed to be present on the
board, and when present, it is controlled by I2C.  This would
introduce a board dependency to the early hwmod code which it was not
designed to handle.  Also, neither the driver for this off-chip clock
provider nor the I2C code is available early in boot when the hwmod
code is attempting to enable and reset IP blocks.  This effectively
makes it impossible to enable and reset this device during hwmod init.

At its core, this patch is a workaround for an OMAP hardware problem.
It should be possible to configure the OMAP to provide any IP block's
functional clock from an on-chip source.  (This is true for almost
every IP block on the chip.  As far as I know, McPDM is the only
exception.)  If the kernel cannot reset and configure IP blocks, it
cannot guarantee a sane SoC state.  Relying on an optional off-chip
clock also creates a board dependency which is beyond the scope of the
early hwmod code.

This patch works around the issue by marking the McPDM hwmod record
with the HWMOD_EXT_OPT_MAIN_CLK flag.  This prevents the hwmod
code from touching the device early during boot.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: P?ter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 652d028..7bddfa5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2125,6 +2125,14 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod = {
 	.name		= "mcpdm",
 	.class		= &omap44xx_mcpdm_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
+	/*
+	 * It's suspected that the McPDM requires an off-chip main
+	 * functional clock, controlled via I2C.  This IP block is
+	 * currently reset very early during boot, before I2C is
+	 * available, so it doesn't seem that we have any choice in
+	 * the kernel other than to avoid resetting it.
+	 */
+	.flags		= HWMOD_EXT_OPT_MAIN_CLK,
 	.mpu_irqs	= omap44xx_mcpdm_irqs,
 	.sdma_reqs	= omap44xx_mcpdm_sdma_reqs,
 	.main_clk	= "mcpdm_fck",
-- 
1.7.10.4
