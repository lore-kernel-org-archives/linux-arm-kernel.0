From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 21 Dec 2012 10:22:50 +0800
Subject: 3.7 kernel hangs when doing scp
In-Reply-To: <CAOMZO5Dhasq11fyJj73_UcyVdoz-N0MAHBu0=PQUxRn42VOdkw@mail.gmail.com>
References: <CAOMZO5Bc5stXXviuf3OL9vAHw+ER=GzzV1q=5Yr5q=AnfoGiGw@mail.gmail.com>
 <20121218024353.GA17118@kroah.com>
 <CAOMZO5DTB79e3W1_i2NLin7RWXVzraoysEGVLxv9_aoRS39D4Q@mail.gmail.com>
 <20121220043943.GA992@nchen-desktop>
 <CAOMZO5B1DyktHa0Vfb4+-H9bdxaoacas6ZCHEH0bDLuKiCB6hA@mail.gmail.com>
 <CAOMZO5B5hv+oG+8fQYyFxRb=VLOiPmC8+0LhAFLOOzBY4z6PZA@mail.gmail.com>
 <CAOMZO5Dhasq11fyJj73_UcyVdoz-N0MAHBu0=PQUxRn42VOdkw@mail.gmail.com>
Message-ID: <20121221022249.GA16251@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 09:18:43AM -0200, Fabio Estevam wrote:
> On Thu, Dec 20, 2012 at 8:45 AM, Fabio Estevam <festevam@gmail.com> wrote:
> 
> > Would this be the correct fix?
> >
> > --- a/include/linux/usb/chipidea.h
> > +++ b/include/linux/usb/chipidea.h
> > @@ -18,7 +18,7 @@ struct ci13xxx_platform_data {
> >  #define CI13XXX_REGS_SHARED            BIT(0)
> >  #define CI13XXX_REQUIRE_TRANSCEIVER    BIT(1)
> >  #define CI13XXX_PULLUP_ON_VBUS         BIT(2)
> > -#define CI13XXX_DISABLE_STREAMING      BIT(3)
> > +#define CI13XXX_DISABLE_STREAMING      BIT(4)
> 
> Ops, these are just the platform data flags.
> 
> I will take a look on why the chipidea driver is not properly
> disabling stream mode.

Current chipidea driver only considers disable stream mode at device
mode, in fact, it may be related to below chipidea bug, and needs
to consider all usb modes.

STAR 9000378958
Title: Non-Double Word Aligned Buffer Address Sometimes Causes Host to Hang on OUT Retry 
www.synopsys.com/dw/star.php?c=dwc_usb2_hs_otg_controller&fixedIn=2.20a

To fix this, we need to add CI13XXX_DISABLE_STREAMING after role->start/init.


> 
> Regards,
> 
> Fabio Estevam
> 

-- 

Best Regards,
Peter Chen
