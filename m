From: horms@verge.net.au (Simon Horman)
Date: Sat, 25 May 2013 10:03:09 +0900
Subject: [PATCH] ARM: mach-shmobile: r8a7790: add SATA support
In-Reply-To: <519F72F8.1000204@cogentembedded.com>
References: <1369361184-20862-1-git-send-email-horms+renesas@verge.net.au>
 <519F72F8.1000204@cogentembedded.com>
Message-ID: <20130525010309.GG4476@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 06:02:32PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 24-05-2013 6:06, Simon Horman wrote:
> 
> >Add SATA clock for r8a7790 SoC (for both device tree and usual cases).
> 
>     I don't see where you are adding clock for device tree case.
> 
> >Register SATA controller as a "late" platform device on r8a7790 SoC.
> 
>     Does R8A7790 have these "early" and "late" lists? I guess not.
> 
> >Based on "ARM: mach-shmobile: r8a7779: add SATA support" by
> >Vladimir Barinov.
> 
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >---
> >  arch/arm/mach-shmobile/clock-r8a7790.c |  4 ++++
> >  arch/arm/mach-shmobile/setup-r8a7790.c | 21 +++++++++++++++++++++
> >  2 files changed, 25 insertions(+)
> 
> >diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
> >index b393592..3619a52 100644
> >--- a/arch/arm/mach-shmobile/clock-r8a7790.c
> >+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
> [...]
> >@@ -249,6 +252,7 @@ static struct clk_lookup lookups[] = {
> >  	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP202]),
> >  	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP721]),
> >  	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP720]),
> >+	CLKDEV_DEV_ID("sata_rcar.1", &mstp_clks[MSTP814]),
> >  };
> >
> >  #define R8A7790_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
> >diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
> >index ed7ee24..5a2a073 100644
> >--- a/arch/arm/mach-shmobile/setup-r8a7790.c
> >+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
> [...]
> >@@ -118,6 +119,25 @@ static inline void r8a7790_register_scif(int idx)
> >  				      sizeof(struct plat_sci_port));
> >  }
> >
> >+static __init void r8a7790_register_sata1(void)
> 
>    What's with SATA0?
> 
> >+{
> >+
> >+	struct resource res[] = {
> 
>    Non-static variable with an intializer? Won't this be a waste of
> code? Wouldn't it be better to have it static __initdata?

Sure, if you prefer that.

> 
> >+		DEFINE_RES_MEM_NAMED(0xee300000, 0x200000, "rcar-sata"),
> 
>     2 megabytes? Won't it be a waste of memory?

2 megabytes is specified in the data sheet.
Do you think it is reasonable to use a smaller value?

> 
> >+		DEFINE_RES_IRQ(gic_iid(106)),
> >+	};
> >+
> >+	struct platform_device_info pdevinfo = {
> 
>    Same comment about non-static initialized structure...
> 
> >+		.name = "sata_rcar",
> >+		.id = 1,
> >+		.res = res,
> >+		.num_res = ARRAY_SIZE(res),
> >+		.dma_mask = DMA_BIT_MASK(32),
> >+	};
> >+
> >+	platform_device_register_full(&pdevinfo);
> >+}
> >+
> 
> WBR, Sergei
> 
