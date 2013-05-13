From: horms@verge.net.au (Simon Horman)
Date: Mon, 13 May 2013 09:43:14 +0900
Subject: [PATCH 1/2] ARM: shmobile: r8a7790: add Ether support
In-Reply-To: <518CCB6A.2060303@cogentembedded.com>
References: <1368173119-27345-1-git-send-email-horms+renesas@verge.net.au>
 <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
 <518CCB6A.2060303@cogentembedded.com>
Message-ID: <20130513004314.GD22911@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 10, 2013 at 02:26:50PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 10-05-2013 12:05, Simon Horman wrote:
> 
> >Add Ether clock and platform device for R8A7779 SoC; add a function to
> >register this device with board-specific platform data.
> 
> >Based on a similar change for the r8a7779 by Sergei Shtylyov.
> 
> >Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> >---
> 
> >This patch has a run-time dependency on "sh_eth: add support for r8a7790 SoC".
> >---
> >  arch/arm/mach-shmobile/clock-r8a7790.c        |  6 +++++-
> >  arch/arm/mach-shmobile/include/mach/r8a7790.h |  3 +++
> >  arch/arm/mach-shmobile/setup-r8a7790.c        | 15 +++++++++++++++
> >  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> >diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
> >index bedd20c..2c3123e 100644
> >--- a/arch/arm/mach-shmobile/clock-r8a7790.c
> >+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
> [...]
> >@@ -178,9 +179,11 @@ static struct clk div6_clks[DIV6_NR] = {
> >  };
> >
> >  /* MSTP */
> >-enum { MSTP721, MSTP720,
> >+enum { MSTP813, MSTP812,
> 
>    I think these two should be on a line of their own...
> 
> >MSTP721, MSTP720,
> >  	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP_NR };
> >  static struct clk mstp_clks[MSTP_NR] = {
> >+	[MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
> >+	[MSTP812] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 12, 0), /* EtherAVB */
> >  	[MSTP721] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 21, 0), /* SCIF0 */
> >  	[MSTP720] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 20, 0), /* SCIF1 */
> >  	[MSTP216] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 16, 0), /* SCIFB2 */
> [...]
> >diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
> >index 2e919e6..95b8f7e 100644
> >--- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
> >+++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
> >@@ -1,9 +1,12 @@
> >  #ifndef __ASM_R8A7790_H__
> >  #define __ASM_R8A7790_H__
> >
> >+#include <linux/sh_eth.h>
> >+
> >  void r8a7790_add_standard_devices(void);
> >  void r8a7790_clock_init(void);
> >  void r8a7790_pinmux_init(void);
> >  void r8a7790_timer_init(void);
> >+void r8a7790_add_ether_device(struct sh_eth_plat_data *pdata);
> 
>    Perhaps better place is right after r8a7790_add_standard_devices()...

Is the implication that the struct sh_eth_plat_data can be defined
in setup-r8a7790.c? Or do you for see adding a struct sh_eth_plat_data
parameter to r8a7790_add_standard_devices() ?

> >  #endif /* __ASM_R8A7790_H__ */
> >diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
> >index eeef5f6..8ed0d7b 100644
> >--- a/arch/arm/mach-shmobile/setup-r8a7790.c
> >+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
> >@@ -30,6 +30,21 @@
> >  #include <mach/r8a7790.h>
> >  #include <asm/mach/arch.h>
> >
> >+
> >+/* Ether */
> >+static struct resource ether_resources[] = {
> 
>    You missed the '__initdata' annotation.

Thanks, I will fix that.

> 
> >+	DEFINE_RES_MEM(0xee700000, 0x400),
> >+	DEFINE_RES_IRQ(gic_spi(162)), /* IRQ0 */
> >+};
