From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Thu, 2 Dec 2010 11:42:04 +0530
Subject: [PATCH v6] OMAP2+: PM: omap device: API's for handling
	mstandby mode
In-Reply-To: <4CF6AD2C.4020907@nokia.com>
References: <1291229228-4438-1-git-send-email-manjugk@ti.com>
	<4CF6AD2C.4020907@nokia.com>
Message-ID: <20101202061139.GA5645@GLPP-machine>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Adrian Hunter <adrian.hunter@nokia.com> [2010-12-01 22:16:44 +0200]:

> On 01/12/10 20:47, ext G, Manjunath Kondaiah wrote:
> >Certain errata in OMAP2+ processors will require forcing
> >master standby to "no standby" mode before completing on going
> >operation. Without this, the results will be unpredictable.
> >
> >Since current implementation of PM run time framework does not support
> >changing sysconfig settings during middle of the on going operation,
> >these API's will support the same. One API will force the device's
> >sysconfig mstandby mode settings to "no standby" and other API will
> >release "no standby" mode and sets it to "smart standby" or "no
> >standby? depending on HWMOD_SWSUP_MSTANDBY value.
> >
> >These API's should be used by device drivers only incase of
> >erratum applicable to their modules if there is no other methods
> >to resolve.
> >
> >These API's are required for multiple DMA errata which require
> >putting DMA controller in no mstandby mode before stopping dma.
> >
> >The applicable errata:
> >1. Erratum ID: i557(Applicable for omap36xx all ES versions)
> >The channel hangs when the Pause bit (DMA4_CDPi [7] ) is cleared
> >through config port while in Standby.
> >
> >2. Erratum ID: i541
> >sDMA FIFO draining does not finish. Applicable to all omap2+ except
> >omap4.
> >
> >3. Erratum ID:i88
> >The sDMA to be put in no mstandby mode before disabling the channel
> >after completing the data transfer operation.
> >Applicable only for OMAP3430 ES1.0
> >
> >Also fixes typo HWMOD_SWSUP_MSTDBY to HWMOD_SWSUP_MSTANDBY in
> >omap_hwmod.h
> >
> >Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
> >Cc: Kevin Hilman<khilman@deeprootsystems.com>
> >Cc: Paul Walmsley<paul@pwsan.com>
> >Cc: linux-arm-kernel at lists.infradead.org
> >
> >---
> >Change summary:
> >v3: Review comments incorporated for:
> >https://patchwork.kernel.org/patch/282212/
> >v4: added mutex changes
> >v5: typo fixes for errata and erratum
> >v6: fixed oh increment bug and also mutex(missing in v5)
> >
> >  arch/arm/mach-omap2/omap_hwmod.c              |   47 +++++++++++++++++++-
> >  arch/arm/plat-omap/include/plat/omap_device.h |    2 +
> >  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    4 +-
> >  arch/arm/plat-omap/omap_device.c              |   60 +++++++++++++++++++++++++
> >  4 files changed, 111 insertions(+), 2 deletions(-)
> >
> 
> Does not seem to handle overlapping requests to set/clear
> midle mode.

We can have use count so that we can avoid register access during
middle of operation if mstandby mode is already changed to "no standby"
mode.

> 
> Also, there is a mutex but don't these functions get called
> sometimes in interrupt context?

I feel we should leave this to caller of these API's. The caller should 
make sure that, he disables interrupts if it is used in interrupt context.

-Manjunath
