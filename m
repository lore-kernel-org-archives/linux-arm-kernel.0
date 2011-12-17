From: richard.zhao@linaro.org (Richard Zhao)
Date: Sat, 17 Dec 2011 12:01:07 +0800
Subject: [RFC V2 4/8] ARM i.MX: Add generic support for pllv2
In-Reply-To: <CAPtuhTgtqY3mShL-aH6pOZe9OTpr1_joHtYfJAC25jE9qYrkOQ@mail.gmail.com>
References: <1323854638-3455-1-git-send-email-richard.zhao@linaro.org>
 <1323854638-3455-5-git-send-email-richard.zhao@linaro.org>
 <CAPtuhTgtqY3mShL-aH6pOZe9OTpr1_joHtYfJAC25jE9qYrkOQ@mail.gmail.com>
Message-ID: <20111217040104.GA2213@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2011 at 03:17:02PM -0800, Mike Turquette wrote:
> On Wed, Dec 14, 2011 at 1:23 AM, Richard Zhao <richard.zhao@linaro.org> wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> >
> > The pllv2 is found on i.MX5 SoCs.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> > ?arch/arm/plat-mxc/Kconfig ? ? ? ? ? ? ?| ? ?4 +
> > ?arch/arm/plat-mxc/Makefile ? ? ? ? ? ? | ? ?1 +
> > ?arch/arm/plat-mxc/clk-pllv2.c ? ? ? ? ?| ?221 ++++++++++++++++++++++++++++++++
> > ?arch/arm/plat-mxc/include/mach/clock.h | ? 26 ++++
> > ?4 files changed, 252 insertions(+), 0 deletions(-)
> > ?create mode 100644 arch/arm/plat-mxc/clk-pllv2.c
> >
> > diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
> > index b3a1f2b..903c15e 100644
> > --- a/arch/arm/plat-mxc/Kconfig
> > +++ b/arch/arm/plat-mxc/Kconfig
> > @@ -106,4 +106,8 @@ config IRAM_ALLOC
> > ? ? ? ?bool
> > ? ? ? ?select GENERIC_ALLOCATOR
> >
> > +config IMX_CLK_PLLV2
> > + ? ? ? bool
> > + ? ? ? depends on GENERIC_CLK
> > +
> > ?endif
> > diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
> > index b9f0f5f..96d45dc 100644
> > --- a/arch/arm/plat-mxc/Makefile
> > +++ b/arch/arm/plat-mxc/Makefile
> > @@ -6,6 +6,7 @@
> > ?obj-y := clock.o time.o devices.o cpu.o system.o irq-common.o
> >
> > ?obj-$(CONFIG_ARM_GIC) += gic.o
> > +obj-$(CONFIG_IMX_CLK_PLLV2) += clk-pllv2.o
> > ?obj-$(CONFIG_MXC_TZIC) += tzic.o
> > ?obj-$(CONFIG_MXC_AVIC) += avic.o
> >
> > diff --git a/arch/arm/plat-mxc/clk-pllv2.c b/arch/arm/plat-mxc/clk-pllv2.c
> > new file mode 100644
> > index 0000000..ee94c60
> > --- /dev/null
> > +++ b/arch/arm/plat-mxc/clk-pllv2.c
> > @@ -0,0 +1,221 @@
> > +#include <linux/kernel.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/errno.h>
> > +#include <linux/delay.h>
> > +
> > +#include <asm/div64.h>
> > +
> > +#include <mach/clock.h>
> > +
> > +#define to_clk_pllv2(ck) (container_of(clk, struct clk_pllv2, clk))
> > +
> > +/* PLL Register Offsets */
> > +#define MXC_PLL_DP_CTL ? ? ? ? ? ? ? ? 0x00
> > +#define MXC_PLL_DP_CONFIG ? ? ? ? ? ? ?0x04
> > +#define MXC_PLL_DP_OP ? ? ? ? ? ? ? ? ?0x08
> > +#define MXC_PLL_DP_MFD ? ? ? ? ? ? ? ? 0x0C
> > +#define MXC_PLL_DP_MFN ? ? ? ? ? ? ? ? 0x10
> > +#define MXC_PLL_DP_MFNMINUS ? ? ? ? ? ?0x14
> > +#define MXC_PLL_DP_MFNPLUS ? ? ? ? ? ? 0x18
> > +#define MXC_PLL_DP_HFS_OP ? ? ? ? ? ? ?0x1C
> > +#define MXC_PLL_DP_HFS_MFD ? ? ? ? ? ? 0x20
> > +#define MXC_PLL_DP_HFS_MFN ? ? ? ? ? ? 0x24
> > +#define MXC_PLL_DP_MFN_TOGC ? ? ? ? ? ?0x28
> > +#define MXC_PLL_DP_DESTAT ? ? ? ? ? ? ?0x2c
> > +
> > +/* PLL Register Bit definitions */
> > +#define MXC_PLL_DP_CTL_MUL_CTRL ? ? ? ? ? ? ? ?0x2000
> > +#define MXC_PLL_DP_CTL_DPDCK0_2_EN ? ? 0x1000
> > +#define MXC_PLL_DP_CTL_DPDCK0_2_OFFSET 12
> > +#define MXC_PLL_DP_CTL_ADE ? ? ? ? ? ? 0x800
> > +#define MXC_PLL_DP_CTL_REF_CLK_DIV ? ? 0x400
> > +#define MXC_PLL_DP_CTL_REF_CLK_SEL_MASK ? ? ? ?(3 << 8)
> > +#define MXC_PLL_DP_CTL_REF_CLK_SEL_OFFSET ? ? ?8
> > +#define MXC_PLL_DP_CTL_HFSM ? ? ? ? ? ?0x80
> > +#define MXC_PLL_DP_CTL_PRE ? ? ? ? ? ? 0x40
> > +#define MXC_PLL_DP_CTL_UPEN ? ? ? ? ? ?0x20
> > +#define MXC_PLL_DP_CTL_RST ? ? ? ? ? ? 0x10
> > +#define MXC_PLL_DP_CTL_RCP ? ? ? ? ? ? 0x8
> > +#define MXC_PLL_DP_CTL_PLM ? ? ? ? ? ? 0x4
> > +#define MXC_PLL_DP_CTL_BRM0 ? ? ? ? ? ?0x2
> > +#define MXC_PLL_DP_CTL_LRF ? ? ? ? ? ? 0x1
> > +
> > +#define MXC_PLL_DP_CONFIG_BIST ? ? ? ? 0x8
> > +#define MXC_PLL_DP_CONFIG_SJC_CE ? ? ? 0x4
> > +#define MXC_PLL_DP_CONFIG_AREN ? ? ? ? 0x2
> > +#define MXC_PLL_DP_CONFIG_LDREQ ? ? ? ? ? ? ? ?0x1
> > +
> > +#define MXC_PLL_DP_OP_MFI_OFFSET ? ? ? 4
> > +#define MXC_PLL_DP_OP_MFI_MASK ? ? ? ? (0xF << 4)
> > +#define MXC_PLL_DP_OP_PDF_OFFSET ? ? ? 0
> > +#define MXC_PLL_DP_OP_PDF_MASK ? ? ? ? 0xF
> > +
> > +#define MXC_PLL_DP_MFD_OFFSET ? ? ? ? ?0
> > +#define MXC_PLL_DP_MFD_MASK ? ? ? ? ? ?0x07FFFFFF
> > +
> > +#define MXC_PLL_DP_MFN_OFFSET ? ? ? ? ?0x0
> > +#define MXC_PLL_DP_MFN_MASK ? ? ? ? ? ?0x07FFFFFF
> > +
> > +#define MXC_PLL_DP_MFN_TOGC_TOG_DIS ? ?(1 << 17)
> > +#define MXC_PLL_DP_MFN_TOGC_TOG_EN ? ? (1 << 16)
> > +#define MXC_PLL_DP_MFN_TOGC_CNT_OFFSET 0x0
> > +#define MXC_PLL_DP_MFN_TOGC_CNT_MASK ? 0xFFFF
> > +
> > +#define MXC_PLL_DP_DESTAT_TOG_SEL ? ? ?(1 << 31)
> > +#define MXC_PLL_DP_DESTAT_MFN ? ? ? ? ?0x07FFFFFF
> > +
> > +#define MAX_DPLL_WAIT_TRIES ? ?1000 /* 1000 * udelay(1) = 1ms */
> > +
> > +static unsigned long clk_pllv2_get_rate(struct clk *clk)
> 
> Nitpick: can you name this clk_pllv2_recalc_rate?  That's because this
> function should be called by clk_recalc_rate, whereas clk_get_rate
> just returns the cached value in clk->rate.  Improves readability I
> think.
ok, thanks.
> 
> > +{
> > + ? ? ? long mfi, mfn, mfd, pdf, ref_clk, mfn_abs;
> > + ? ? ? unsigned long dp_op, dp_mfd, dp_mfn, dp_ctl, pll_hfsm, dbl;
> > + ? ? ? void __iomem *pllbase;
> > + ? ? ? s64 temp;
> > + ? ? ? unsigned long parent_rate;
> > + ? ? ? struct clk_pllv2 *pll = to_clk_pllv2(clk);
> > +
> > + ? ? ? parent_rate = clk->parent->rate;
> > +
> > + ? ? ? pllbase = pll->base;
> > +
> > + ? ? ? dp_ctl = __raw_readl(pllbase + MXC_PLL_DP_CTL);
> > + ? ? ? pll_hfsm = dp_ctl & MXC_PLL_DP_CTL_HFSM;
> > + ? ? ? dbl = dp_ctl & MXC_PLL_DP_CTL_DPDCK0_2_EN;
> > +
> > + ? ? ? if (pll_hfsm == 0) {
> > + ? ? ? ? ? ? ? dp_op = __raw_readl(pllbase + MXC_PLL_DP_OP);
> > + ? ? ? ? ? ? ? dp_mfd = __raw_readl(pllbase + MXC_PLL_DP_MFD);
> > + ? ? ? ? ? ? ? dp_mfn = __raw_readl(pllbase + MXC_PLL_DP_MFN);
> > + ? ? ? } else {
> > + ? ? ? ? ? ? ? dp_op = __raw_readl(pllbase + MXC_PLL_DP_HFS_OP);
> > + ? ? ? ? ? ? ? dp_mfd = __raw_readl(pllbase + MXC_PLL_DP_HFS_MFD);
> > + ? ? ? ? ? ? ? dp_mfn = __raw_readl(pllbase + MXC_PLL_DP_HFS_MFN);
> > + ? ? ? }
> > + ? ? ? pdf = dp_op & MXC_PLL_DP_OP_PDF_MASK;
> > + ? ? ? mfi = (dp_op & MXC_PLL_DP_OP_MFI_MASK) >> MXC_PLL_DP_OP_MFI_OFFSET;
> > + ? ? ? mfi = (mfi <= 5) ? 5 : mfi;
> > + ? ? ? mfd = dp_mfd & MXC_PLL_DP_MFD_MASK;
> > + ? ? ? mfn = mfn_abs = dp_mfn & MXC_PLL_DP_MFN_MASK;
> > + ? ? ? /* Sign extend to 32-bits */
> > + ? ? ? if (mfn >= 0x04000000) {
> > + ? ? ? ? ? ? ? mfn |= 0xFC000000;
> > + ? ? ? ? ? ? ? mfn_abs = -mfn;
> > + ? ? ? }
> > +
> > + ? ? ? ref_clk = 2 * parent_rate;
> > + ? ? ? if (dbl != 0)
> > + ? ? ? ? ? ? ? ref_clk *= 2;
> > +
> > + ? ? ? ref_clk /= (pdf + 1);
> > + ? ? ? temp = (u64) ref_clk * mfn_abs;
> > + ? ? ? do_div(temp, mfd + 1);
> > + ? ? ? if (mfn < 0)
> > + ? ? ? ? ? ? ? temp = -temp;
> > + ? ? ? temp = (ref_clk * mfi) + temp;
> > +
> > + ? ? ? return temp;
> > +}
> > +
> > +static int clk_pllv2_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > + ? ? ? u32 reg;
> > + ? ? ? void __iomem *pllbase;
> > + ? ? ? struct clk_pllv2 *pll = to_clk_pllv2(clk);
> > +
> > + ? ? ? long mfi, pdf, mfn, mfd = 999999;
> > + ? ? ? s64 temp64;
> > + ? ? ? unsigned long quad_parent_rate;
> > + ? ? ? unsigned long pll_hfsm, dp_ctl;
> > + ? ? ? unsigned long parent_rate;
> > +
> > + ? ? ? parent_rate = clk->parent->rate;
> > +
> > + ? ? ? pllbase = pll->base;
> > +
> > + ? ? ? quad_parent_rate = 4 * parent_rate;
> > + ? ? ? pdf = mfi = -1;
> > + ? ? ? while (++pdf < 16 && mfi < 5)
> > + ? ? ? ? ? ? ? mfi = rate * (pdf+1) / quad_parent_rate;
> > + ? ? ? if (mfi > 15)
> > + ? ? ? ? ? ? ? return -EINVAL;
> > + ? ? ? pdf--;
> > +
> > + ? ? ? temp64 = rate * (pdf+1) - quad_parent_rate * mfi;
> > + ? ? ? do_div(temp64, quad_parent_rate/1000000);
> > + ? ? ? mfn = (long)temp64;
> > +
> > + ? ? ? dp_ctl = __raw_readl(pllbase + MXC_PLL_DP_CTL);
> > + ? ? ? /* use dpdck0_2 */
> > + ? ? ? __raw_writel(dp_ctl | 0x1000L, pllbase + MXC_PLL_DP_CTL);
> > + ? ? ? pll_hfsm = dp_ctl & MXC_PLL_DP_CTL_HFSM;
> > + ? ? ? if (pll_hfsm == 0) {
> > + ? ? ? ? ? ? ? reg = mfi << 4 | pdf;
> > + ? ? ? ? ? ? ? __raw_writel(reg, pllbase + MXC_PLL_DP_OP);
> > + ? ? ? ? ? ? ? __raw_writel(mfd, pllbase + MXC_PLL_DP_MFD);
> > + ? ? ? ? ? ? ? __raw_writel(mfn, pllbase + MXC_PLL_DP_MFN);
> > + ? ? ? } else {
> > + ? ? ? ? ? ? ? reg = mfi << 4 | pdf;
> > + ? ? ? ? ? ? ? __raw_writel(reg, pllbase + MXC_PLL_DP_HFS_OP);
> > + ? ? ? ? ? ? ? __raw_writel(mfd, pllbase + MXC_PLL_DP_HFS_MFD);
> > + ? ? ? ? ? ? ? __raw_writel(mfn, pllbase + MXC_PLL_DP_HFS_MFN);
> > + ? ? ? }
> > +
> > + ? ? ? return 0;
> > +}
> > +
> > +static long clk_pllv2_round_rate(struct clk *clk, unsigned long rate,
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned long *prate)
> > +{
> > + ? ? ? *prate = 0;
> 
> Should check if prate != NULL.  For instance clk_round_rate doesn't
> pass in a real parent_rate:
> http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=blob;f=drivers/clk/clk.c;h=8cadadd744967cdf90df864f8b250a248033790a;hb=f9f6f555d44749912b5f55d5077604d6ad1ae840#l241
right, thanks.

Richard
> 
> Regards,
> Mike
