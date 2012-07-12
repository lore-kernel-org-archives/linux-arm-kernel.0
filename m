From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 12 Jul 2012 18:24:01 +0800
Subject: [PATCH v2 1/2] pinctrl: pinctrl-imx: add support for set bits
 for general purpose registers
In-Reply-To: <4FFE9D7E.1080302@gmail.com>
References: <1342084080-3145-1-git-send-email-b29396@freescale.com>
 <4FFE9D7E.1080302@gmail.com>
Message-ID: <20120712102400.GE21635@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2012 at 05:48:46PM +0800, Hui Wang wrote:
> Dong Aisheng wrote:
> >From: Dong Aisheng <dong.aisheng@linaro.org>
> >
> >The General Purpose Registers (GPR) is used to select operating modes for
> >general features in the SoC, usually not related to the IOMUX itself,
> >but it does belong to IOMUX controller.
> >We simply provide an convient API for driver to call to write/read the general
> >purpose register bits if needed.
> >
> >Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> >---
> >ChangeLog v1->v2:
> >* add gpr read api
> >* change api name a bit to *_write and *_read
> >* add -EPROBE_DEFER support
> >* define macros for gpr registers for imx6q
> >* change driver loadding priority to postcore_init at satisfy clients driver
> >  to use imx_pinctrl_gpr_{read | write} APIs at best
> >---
> > drivers/pinctrl/pinctrl-imx.c   |   29 ++++
> > drivers/pinctrl/pinctrl-imx51.c |    2 +-
> > drivers/pinctrl/pinctrl-imx53.c |    2 +-
> > drivers/pinctrl/pinctrl-imx6q.c |    2 +-
> > include/linux/fsl/imx-pinctrl.h |  340 +++++++++++++++++++++++++++++++++++++++
> > 5 files changed, 372 insertions(+), 3 deletions(-)
> > create mode 100644 include/linux/fsl/imx-pinctrl.h
> >
> >diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
> >index 44e9726..1725e07 100644
> >--- a/drivers/pinctrl/pinctrl-imx.c
> >+++ b/drivers/pinctrl/pinctrl-imx.c
> >@@ -54,6 +54,34 @@ struct imx_pinctrl {
> > 	const struct imx_pinctrl_soc_info *info;
> > };
> >+static struct imx_pinctrl *imx_pinctrl;
> >+/*
> >+ * Set bits for general purpose registers
> >+ */
> >+int imx_pinctrl_gpr_write(u8 gpr, u32 mask, u32 value)
> >+{
> >+	u32 reg;
> >+
> >+	if (!imx_pinctrl)
> >+		return -EPROBE_DEFER;
> >+
> >+	reg = readl(imx_pinctrl->base + gpr);
> >+	reg &= ~mask;
> >+	writel(reg | value, imx_pinctrl->base + gpr);
> >+
> >+	return 0;
> >+}
> >+EXPORT_SYMBOL_GPL(imx_pinctrl_gpr_write);
> >+
> >+int imx_pinctrl_gpr_read(u8 gpr)
> >+{
> >+	if (!imx_pinctrl)
> >+		return -EPROBE_DEFER;
> >+
> >+	return readl(imx_pinctrl->base + gpr);
> Suppose the MSB of the register content is 1, how does the caller
> distinguish if the function return an error or return a register
> content?
I think it worth a BUG() here.

Thanks
Richard
 
