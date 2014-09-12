From: balbi@ti.com (Felipe Balbi)
Date: Fri, 12 Sep 2014 15:20:08 -0500
Subject: [Patch v9 2/3] usb: dwc3: Add Qualcomm DWC3 glue layer driver
In-Reply-To: <CAMf-jSm2fPPstFD2h4-gG=MCDty34f-O0ooizDEKyQUd3+CxGQ@mail.gmail.com>
References: <1410550088-8754-1-git-send-email-agross@codeaurora.org>
 <1410550088-8754-3-git-send-email-agross@codeaurora.org>
 <CAMf-jSm2fPPstFD2h4-gG=MCDty34f-O0ooizDEKyQUd3+CxGQ@mail.gmail.com>
Message-ID: <20140912202008.GB25500@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 13, 2014 at 01:44:25AM +0530, Pramod Gurav wrote:
> Andy,
> Couple of minor comments.
> 
> On Sat, Sep 13, 2014 at 12:58 AM, Andy Gross <agross@codeaurora.org> wrote:
> 
> > From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> >
> > DWC3 glue layer is hardware layer around Synopsys DesignWare
> > USB3 core. Its purpose is to supply Synopsys IP with required
> > clocks, voltages and interface it with the rest of the SoC.
> >
> > Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> > Signed-off-by: Andy Gross <agross@codeaurora.org>
> > ---
> >  drivers/usb/dwc3/Kconfig     |    8 +++
> >  drivers/usb/dwc3/Makefile    |    1 +
> >  drivers/usb/dwc3/dwc3-qcom.c |  131
> > ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 140 insertions(+)
> >  create mode 100644 drivers/usb/dwc3/dwc3-qcom.c
> >
> >
> <..>
> 
> 
> > +#include <linux/platform_device.h>
> > +
> > +struct dwc3_qcom {
> > +       struct device           *dev;
> > +
> >
> Extra new line here.

that's not an issue however.

> > +       struct clk              *core_clk;
> > +       struct clk              *iface_clk;
> > +       struct clk              *sleep_clk;
> > +};
> > +
> > +static int dwc3_qcom_probe(struct platform_device *pdev)
> > +{
> > +       struct device_node *node = pdev->dev.of_node;
> > +       struct dwc3_qcom *qdwc;
> > +       int ret = 0;
> >
> Initialization not required.

I'll fix this one as I'm already applying this patch.

> > +
> > +       qdwc = devm_kzalloc(&pdev->dev, sizeof(*qdwc), GFP_KERNEL);
> > +       if (!qdwc)
> > +               return -ENOMEM;
> > +
> > +       platform_set_drvdata(pdev, qdwc);
> > +
> > +       qdwc->dev = &pdev->dev;
> > +
> > +       qdwc->core_clk = devm_clk_get(qdwc->dev, "core");
> > +       if (IS_ERR(qdwc->core_clk)) {
> > +               dev_err(qdwc->dev, "failed to get core clock\n");
> > +               return PTR_ERR(qdwc->core_clk);
> > +       }
> > +
> > +       qdwc->iface_clk = devm_clk_get(qdwc->dev, "iface");
> > +       if (IS_ERR(qdwc->iface_clk)) {
> > +               dev_dbg(qdwc->dev, "failed to get optional iface clock\n");
> > +               qdwc->iface_clk = NULL;
> > +       }
> > +
> > +       qdwc->sleep_clk = devm_clk_get(qdwc->dev, "sleep");
> > +       if (IS_ERR(qdwc->sleep_clk)) {
> > +               dev_dbg(qdwc->dev, "failed to get optional sleep clock\n");
> > +               qdwc->sleep_clk = NULL;
> > +       }
> > +
> > +       ret = clk_prepare_enable(qdwc->core_clk);
> > +       if (ret) {
> > +               dev_err(qdwc->dev, "failed to enable core clock\n");
> > +               goto err_core;
> > +       }
> > +
> > +       ret = clk_prepare_enable(qdwc->iface_clk);
> >
> Should not we check if  qdwc->iface_clk is valid?

read the sources luke.

> > +err_clks:
> > +       clk_disable_unprepare(qdwc->sleep_clk);
> >
> IS_ERR check before above statement not needed as we have continued with
> probe even after failure og devm_clk_get?

read more carefully, there's a detail which you're missing.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140912/10f96815/attachment-0001.sig>
