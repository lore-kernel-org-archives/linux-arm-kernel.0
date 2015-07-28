From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 28 Jul 2015 12:05:55 +0800
Subject: [PATCH v4 6/7] clk: mediatek: Add USB clock support in MT8173
 APMIXEDSYS
In-Reply-To: <CAGS+omA0PPThRKEV=Xy3VkS+ifg55oy+gi_d5Sr+TQJorh8a0g@mail.gmail.com>
References: <1437706925-3222-1-git-send-email-jamesjj.liao@mediatek.com>
 <1437706925-3222-7-git-send-email-jamesjj.liao@mediatek.com>
 <CAGS+omA0PPThRKEV=Xy3VkS+ifg55oy+gi_d5Sr+TQJorh8a0g@mail.gmail.com>
Message-ID: <1438056355.17770.9.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Fri, 2015-07-24 at 19:28 +0800, Daniel Kurtz wrote:
> On Fri, Jul 24, 2015 at 11:02 AM, James Liao <jamesjj.liao@mediatek.com> wrote:
> > +struct clk *mtk_clk_register_ref2usb_tx(const char *name,
> > +                       const char *parent_name, void __iomem *reg)
> 
> struct clk * __init mtk_clk_register_ref2usb_tx(

It will be added in next patch.

> >
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> > -#include <linux/slab.h>
> > -#include <linux/mfd/syscon.h>
> 
> nit: this looks like an unrelated change that can be in its own patch.

It will be in a separated patch.

> >
> > +typedef struct clk *(*mtk_clk_register_ex)(const char *, const char *,
> > +                                       void __iomem *);
> > +
> > +struct mtk_clk_ex {
> > +       int id;
> > +       const char *name;
> > +       const char *parent;
> > +       u32 reg_ofs;
> > +       mtk_clk_register_ex reg_clk_ex;
> 
> 
> This "mtk_clk_ex" abstraction seems unnecessarily complicated for a
> one-off USB clock.
> Just call mtk_clk_register_ref2usb_tx() directly from mtk_apmixedsys_init().

Use a table to associate related constants and names is more readable,
such as:

  APMIXED_EX(CLK_APMIXED_REF2USB_TX, "ref2usb_tx", ... 

If we call mtk_clk_register_ref2usb_tx() directly, it will be:

  clk = mtk_clk_register_ref2usb_tx("ref2usb_tx", ...);
  clk_data-clks[CLK_APMIXED_REF2USB_TX] = clk;

Do you prefer the last one?


Best regards,

James
