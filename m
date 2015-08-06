From: scott.shu@mediatek.com (Scott Shu)
Date: Thu, 6 Aug 2015 10:59:02 +0800
Subject: [PATCH v3 3/8] soc: Mediatek: Add SCPSYS CPU power domain driver
In-Reply-To: <20150805085034.GG18700@pengutronix.de>
References: <1438696464-59858-1-git-send-email-scott.shu@mediatek.com>
 <1438696464-59858-4-git-send-email-scott.shu@mediatek.com>
 <20150805085034.GG18700@pengutronix.de>
Message-ID: <1438829942.9435.24.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-08-05 at 10:50 +0200, Sascha Hauer wrote:
> On Tue, Aug 04, 2015 at 09:54:19PM +0800, Scott Shu wrote:
> > This adds a CPU power domain driver for the Mediatek SCPSYS unit on
> > MT6580.
> > 
> > Signed-off-by: Scott Shu <scott.shu@mediatek.com>
> > ---
> >  drivers/soc/mediatek/mtk-scpsys.c   |  250 +++++++++++++++++++++++++++++++++++
> >  include/linux/soc/mediatek/scpsys.h |    9 ++
> >  2 files changed, 259 insertions(+)
> >  create mode 100644 include/linux/soc/mediatek/scpsys.h
> > 
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > index 43a79ed..ca0f2dd 100644
> > --- a/drivers/soc/mediatek/mtk-scpsys.c
> > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > @@ -15,18 +15,30 @@
> >  #include <linux/io.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mfd/syscon.h>
> > +#include <linux/of.h>
> >  #include <linux/of_device.h>
> > +#include <linux/of_address.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_domain.h>
> >  #include <linux/regmap.h>
> >  #include <linux/soc/mediatek/infracfg.h>
> > +#include <linux/soc/mediatek/scpsys.h>
> >  #include <dt-bindings/power/mt8173-power.h>
> >  
> > +#define SPM_POWERON_CONFIG_SET		0x0000
> > +#define SPM_CA7_CPU0_PWR_CON		0x0200
> >  #define SPM_VDE_PWR_CON			0x0210
> >  #define SPM_MFG_PWR_CON			0x0214
> > +#define SPM_CA7_CPU1_PWR_CON		0x0218
> > +#define SPM_CA7_CPU2_PWR_CON		0x021c
> > +#define SPM_CA7_CPU3_PWR_CON		0x0220
> >  #define SPM_VEN_PWR_CON			0x0230
> >  #define SPM_ISP_PWR_CON			0x0238
> >  #define SPM_DIS_PWR_CON			0x023c
> > +#define SPM_CA7_CPU0_L1_PDN		0x025c
> > +#define SPM_CA7_CPU1_L1_PDN		0x0264
> > +#define SPM_CA7_CPU2_L1_PDN		0x026c
> > +#define SPM_CA7_CPU3_L1_PDN		0x0274
> >  #define SPM_VEN2_PWR_CON		0x0298
> >  #define SPM_AUDIO_PWR_CON		0x029c
> >  #define SPM_MFG_2D_PWR_CON		0x02c0
> > @@ -34,12 +46,20 @@
> >  #define SPM_USB_PWR_CON			0x02cc
> >  #define SPM_PWR_STATUS			0x060c
> >  #define SPM_PWR_STATUS_2ND		0x0610
> > +#define SPM_SLEEP_TIMER_STA		0x0720
> >  
> > +/* bit definition in SPM_CA7_CPUx_PWR_CON */
> >  #define PWR_RST_B_BIT			BIT(0)
> >  #define PWR_ISO_BIT			BIT(1)
> >  #define PWR_ON_BIT			BIT(2)
> >  #define PWR_ON_2ND_BIT			BIT(3)
> >  #define PWR_CLK_DIS_BIT			BIT(4)
> > +#define SRAM_CKISO_BIT			BIT(5)
> > +#define SRAM_ISOINT_B_BIT		BIT(6)
> > +
> > +/* bit definition in SPM_CA7_CPUx_L1_PDN */
> > +#define L1_PDN				BIT(0)
> > +#define L1_PDN_ACK			BIT(8)
> >  
> >  #define PWR_STATUS_DISP			BIT(3)
> >  #define PWR_STATUS_MFG			BIT(4)
> > @@ -52,6 +72,28 @@
> >  #define PWR_STATUS_AUDIO		BIT(24)
> >  #define PWR_STATUS_USB			BIT(25)
> >  
> > +#define MT6580_MAX_CPUS			4
> > +
> > +#ifdef CONFIG_SMP
> > +static DEFINE_SPINLOCK(spm_cpu_lock);
> > +
> > +static void __iomem *spm_cpu_base;
> > +
> > +static const u32 spm_cpu_pwr_con[MT6580_MAX_CPUS] = {
> > +	SPM_CA7_CPU0_PWR_CON,
> > +	SPM_CA7_CPU1_PWR_CON,
> > +	SPM_CA7_CPU2_PWR_CON,
> > +	SPM_CA7_CPU3_PWR_CON,
> > +};
> > +
> > +static const u32 spm_cpu_l1_pdn[MT6580_MAX_CPUS] = {
> > +	SPM_CA7_CPU0_L1_PDN,
> > +	SPM_CA7_CPU1_L1_PDN,
> > +	SPM_CA7_CPU2_L1_PDN,
> > +	SPM_CA7_CPU3_L1_PDN,
> > +};
> > +#endif
> > +
> >  enum clk_id {
> >  	MT8173_CLK_MM,
> >  	MT8173_CLK_MFG,
> > @@ -485,3 +527,211 @@ static struct platform_driver scpsys_drv = {
> >  };
> >  
> >  module_platform_driver_probe(scpsys_drv, scpsys_probe);
> > +
> > +#define SPM_REGWR_EN		BIT(0)
> > +#define SPM_PROJECT_CODE	0x0B16
> > +
> > +#ifdef CONFIG_SMP
> > +int spm_cpu_mtcmos_on(int cpu)
> 
> The idea was that the code that the current driver has in
> scpsys_power_on/scpsys_power_off is shared with this function. If we
> don't do this then it indeed doesn't make much sense to put it into the
> same file.
> 
> From what I see we would need to change the prototype to something like
> 
> static int __scpsys_power_on(struct scp_domain_data *)
> 
> (maybe with some additional base addresses and stuff)
> 
> struct scp_domain_data would additionally need sram_isoint_b and sram_ckiso
> members.
> 
> Sascha
> 
Hi Sascha,
   The CPU power sequence is quite different with the others, as
described below.

* Non-CPU
   1) Set PWR_ON_BIT, PWR_ON_2ND_BIT
   2) Wait PWR_ACK
   3) Clear PWR_CLK_DIS_BIT
   4) Clear PWR_ISO_BIT
   5) Set PWR_RST_B_BIT
   6) Clear SRAM_PDN
   7) Wait SRAM_PDN_ACK
* CPU
   1) Set PWR_ON_BIT, PWR_ON_2ND_BIT
   2) Wait PWR_ACK
   3) Clear PWR_ISO_BIT
   4) Clear L1_PDN to power on L1
   5) Wait L1_PDN_ACK
   6) Set SRAM_ISOINT_B
   7) Clear SRAM_CKISO
   8) Clear PWR_CLK_DIS
   9) Set PWR_RST_B
For multi-cluster SoC, the cluster power sequence is also different.

Please think if this is a good idea if we integrate the CPU support into
the scpsys_power_on()? Based on the readability and compatible
considerations, we provide this patch. 
Thanks
Scott
