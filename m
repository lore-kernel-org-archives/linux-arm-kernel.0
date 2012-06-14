From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 14 Jun 2012 10:10:55 +0000
Subject: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E998C80@DBDE01.ent.ti.com>
References: <cover.1339419244.git.afzal@ti.com>
 <c4bd7d71e9950c09f9712077160b6231f566d8f3.1339419244.git.afzal@ti.com>
 <4FD63DBF.9000200@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997D9E@DBDE01.ent.ti.com>
 <4FD77E35.3050703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998767@DBDE01.ent.ti.com>
 <20120613113217.GK12766@atomide.com> <20120613115445.GM12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998C80@DBDE01.ent.ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E999849@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wed, Jun 13, 2012 at 17:28:33, Mohammed, Afzal wrote:
> On Wed, Jun 13, 2012 at 17:24:45, Tony Lindgren wrote:
> 
> > > If there's a chance it causing file system corruption, we should
> > > test it carefully on the boards before applying. If that's done,
> > > then there's probably no need for warnings. It's safer to disable
> > > NAND for untested boards if there's a chance of breaking the timings.
> > 
> > Actually this patch breaks at least DMA on tusb6010 on n8x0. That's
> > a MUSB hardware in a wrapper connected to GPMC that's very picky with
> > the timings.
> > 
> > Got any hints what should be done with the cycle2cycle stuff for
> > tusb6010?
> 
> Not as of now, let me try to find out.

Probably with the below patch [1], we can get values set by bootloader &
calculate back value to entered in Kernel, of course that may not work
if tusb6010 works with different gpmc i/p frequency.

Meanwhile, let me try to get datasheet & find proper values.
 
Regards
Afzal

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index eec011a..bc75e6c 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -336,11 +336,15 @@ int gpmc_cs_calc_divider(int cs, unsigned int sync_clk)
        return div;
 }

+static void gpmc_print_cs_timings(int cs);
+
 int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 {
        int div;
        u32 l;

+       gpmc_print_cs_timings(cs);
+
        div = gpmc_cs_calc_divider(cs, t->sync_clk);
        if (div < 0)
                return -1;
