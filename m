From: balbi@ti.com (Felipe Balbi)
Date: Fri, 12 Sep 2014 15:29:43 -0500
Subject: [Patch v9 2/3] usb: dwc3: Add Qualcomm DWC3 glue layer driver
In-Reply-To: <541356CE.1020902@smartplayin.com>
References: <1410550088-8754-1-git-send-email-agross@codeaurora.org>
 <1410550088-8754-3-git-send-email-agross@codeaurora.org>
 <CAMf-jSm2fPPstFD2h4-gG=MCDty34f-O0ooizDEKyQUd3+CxGQ@mail.gmail.com>
 <20140912202008.GB25500@saruman.home>
 <541356CE.1020902@smartplayin.com>
Message-ID: <20140912202942.GC25500@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Sep 13, 2014 at 01:55:50AM +0530, Pramod Gurav wrote:
> >>> +       qdwc = devm_kzalloc(&pdev->dev, sizeof(*qdwc), GFP_KERNEL);
> >>> +       if (!qdwc)
> >>> +               return -ENOMEM;
> >>> +
> >>> +       platform_set_drvdata(pdev, qdwc);
> >>> +
> >>> +       qdwc->dev = &pdev->dev;
> >>> +
> >>> +       qdwc->core_clk = devm_clk_get(qdwc->dev, "core");
> >>> +       if (IS_ERR(qdwc->core_clk)) {
> >>> +               dev_err(qdwc->dev, "failed to get core clock\n");
> >>> +               return PTR_ERR(qdwc->core_clk);
> >>> +       }
> >>> +
> >>> +       qdwc->iface_clk = devm_clk_get(qdwc->dev, "iface");
> >>> +       if (IS_ERR(qdwc->iface_clk)) {
> >>> +               dev_dbg(qdwc->dev, "failed to get optional iface clock\n");
> >>> +               qdwc->iface_clk = NULL;
> >>> +       }
> >>> +
> >>> +       qdwc->sleep_clk = devm_clk_get(qdwc->dev, "sleep");
> >>> +       if (IS_ERR(qdwc->sleep_clk)) {
> >>> +               dev_dbg(qdwc->dev, "failed to get optional sleep clock\n");
> >>> +               qdwc->sleep_clk = NULL;
> >>> +       }
> >>> +
> >>> +       ret = clk_prepare_enable(qdwc->core_clk);
> >>> +       if (ret) {
> >>> +               dev_err(qdwc->dev, "failed to enable core clock\n");
> >>> +               goto err_core;
> >>> +       }
> >>> +
> >>> +       ret = clk_prepare_enable(qdwc->iface_clk);
> >>>
> >> Should not we check if  qdwc->iface_clk is valid?
> > 
> > read the sources luke.
> Now I read that its initialized to NULL in fail case but should we call
> prepare_enable at all if its NULL?

now read the source of clk_enable() and clk_prepare() ;-) NULL is a
valid clock, it just returns 0. This is better than sprinkling IS_ERR()
all over the place.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140912/c311eead/attachment.sig>
