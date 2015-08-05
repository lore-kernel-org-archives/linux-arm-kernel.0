From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 5 Aug 2015 09:25:51 +0800
Subject: [PATCH v2 06/10] usb: chipidea: add ahb burst configuration
 interface
In-Reply-To: <CAL_JsqJn16OvfL_Ggf1wSi2XkJkjDMrmuRit3q8eVY5bNp8oYw@mail.gmail.com>
References: <1438577238-10153-1-git-send-email-peter.chen@freescale.com>
 <1438577238-10153-7-git-send-email-peter.chen@freescale.com>
 <CAL_JsqJn16OvfL_Ggf1wSi2XkJkjDMrmuRit3q8eVY5bNp8oYw@mail.gmail.com>
Message-ID: <20150805012550.GG25143@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 09:04:27AM -0500, Rob Herring wrote:
> On Sun, Aug 2, 2015 at 11:47 PM, Peter Chen <peter.chen@freescale.com> wrote:
> > The users can change it through dts or platform data if they
> > want to change the default value.
> >
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  drivers/usb/chipidea/bits.h  |  3 +++
> >  drivers/usb/chipidea/core.c  | 14 ++++++++++++++
> >  include/linux/usb/chipidea.h |  2 ++
> >  3 files changed, 19 insertions(+)
> >
> > diff --git a/drivers/usb/chipidea/bits.h b/drivers/usb/chipidea/bits.h
> > index 831a8f6..462ad02 100644
> > --- a/drivers/usb/chipidea/bits.h
> > +++ b/drivers/usb/chipidea/bits.h
> > @@ -25,6 +25,9 @@
> >  #define VERSION                      (0xF << 25)
> >  #define CIVERSION            (0x7 << 29)
> >
> > +/* SBUSCFG */
> > +#define AHBBRST_MASK           0x7
> > +
> >  /* HCCPARAMS */
> >  #define HCCPARAMS_LEN         BIT(17)
> >
> > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> > index 38bd036..f60cbf6 100644
> > --- a/drivers/usb/chipidea/core.c
> > +++ b/drivers/usb/chipidea/core.c
> > @@ -439,6 +439,9 @@ void ci_platform_configure(struct ci_hdrc *ci)
> >
> >         hw_write(ci, OP_USBCMD, 0xff0000, ci->platdata->itc_setting << 16);
> >
> > +       if (ci->platdata->flags & CI_HDRC_OVERRIDE_AHB_BURST)
> > +               hw_write_id_reg(ci, ID_SBUSCFG, AHBBRST_MASK,
> > +                       ci->platdata->ahb_burst_config);
> >  }
> >
> >  /**
> > @@ -647,6 +650,17 @@ static int ci_get_platdata(struct device *dev,
> >                 }
> >         }
> >
> > +       if (of_find_property(dev->of_node, "ahb-burst-config", NULL)) {
> > +               ret = of_property_read_u32(dev->of_node, "ahb-burst-config",
> > +                       &platdata->ahb_burst_config);
> > +               if (ret) {
> > +                       dev_err(dev,
> > +                               "failed to get ahb-burst-config\n");
> > +                       return ret;
> > +               }
> > +               platdata->flags |= CI_HDRC_OVERRIDE_AHB_BURST;
> > +       }
> > +
> 
> This can be simplified to:
> 
> ret = of_property_read_u32(dev->of_node, "ahb-burst-config",
> &platdata->ahb_burst_config);
> if (!ret)
>   platdata->flags |= CI_HDRC_OVERRIDE_AHB_BURST;
> 
> The error condition can't really happen.
> 

Why the error condition can't really happen? If the value of
this property at dts is invalid, we would like return error.

For non-exist property, it is normal case; for invalid property,
we would like return error, and quit.

-- 

Best Regards,
Peter Chen
