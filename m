From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 4 Jun 2013 10:43:59 +0200
Subject: [PATCH 06/10] mmc: dw_mmc-pltfm: add Rockchip variant
In-Reply-To: <51AD67CF.60300@samsung.com>
References: <201306030055.15413.heiko@sntech.de>
 <201306030059.03783.heiko@sntech.de> <51AD67CF.60300@samsung.com>
Message-ID: <201306041044.00128.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 4. Juni 2013, 06:06:39 schrieb Jaehoon Chung:
> On 06/03/2013 07:59 AM, Heiko St?bner wrote:
> > Cortex-A9 SoCs from Rockchip use a slightly modified variant of dw_mmc
> > controllers that seems to require the SDMMC_CMD_USE_HOLD_REG bit to
> > always be set.
> > 
> > There also seem to be no other modifications (additional register etc)
> > present, so to keep the footprint low, add this small variant to the
> > pltfm driver.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  drivers/mmc/host/dw_mmc-pltfm.c |   48
> >  +++++++++++++++++++++++++++----------- 1 files changed, 34
> >  insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/dw_mmc-pltfm.c
> > b/drivers/mmc/host/dw_mmc-pltfm.c index 0048da8..7d041b5 100644
> > --- a/drivers/mmc/host/dw_mmc-pltfm.c
> > +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> > @@ -24,6 +24,16 @@
> > 
> >  #include "dw_mmc.h"
> > 
> > +
> > +static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32
> > *cmdr)
> 
> How about using "dw_mci_pltfm_prepare_command()"?
> Maybe HOLD_REG could be used at other SoC.

The problem I had when thinking about it is that every implementation using 
the HOLD_REG stuff does it differently ... on the Exynos variant it depends on 
the CLKSEL register value and on the SOCFPGA variant on other clock values.

It's only on the Rockchip variant that it seems to needed all the time.

So, doing it with a "dw_mci_pltfm_prepare_command()" would need a flag to 
signal that the implementation needs the HOLD_REG all the time, but we won't 
know yet if other implementations will have other constraints on its use - 
like only i special cases or such.

So personally I would keep it as it is for now, until more platforms using the 
HOLD_REG come along to see some sort of pattern of its use?
