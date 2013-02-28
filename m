From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 28 Feb 2013 14:06:09 +0800
Subject: [PATCH v10 6/8] usb: chipidea: imx: add internal vbus
 regulator control
In-Reply-To: <CAB7JpEHq6rDS4=twUf7gito5zxinYiHZban77psKEQ962z0LYw@mail.gmail.com>
References: <1361946799-29471-1-git-send-email-peter.chen@freescale.com>
 <1361946799-29471-7-git-send-email-peter.chen@freescale.com>
 <CAB7JpEHq6rDS4=twUf7gito5zxinYiHZban77psKEQ962z0LYw@mail.gmail.com>
Message-ID: <20130228060608.GD19387@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 09:08:11PM +0200, Alexander Shishkin wrote:
>    On Feb 27, 2013 8:34 AM, "Peter Chen" <peter.chen@freescale.com> wrote:
>    >
>    > - For host, the vbus should always be on.
>    > - For otg, the vbus is off defaultly, the vbus needs to be
>    > turned on/off when usb role switches.
>    >
>    > + * @reg_vbus: used to control internal vbus regulator
>    >   */
>    >  struct ci13xxx {
>    >         struct device                   *dev;
>    > @@ -172,6 +173,7 @@ struct ci13xxx {
>    >         struct usb_otg                  otg;
>    >         bool                            id_event;
>    >         bool                            b_sess_valid_event;
>    > +       struct regulator                *reg_vbus;
>    >  };
> 
>    I suggest that this regulator be taken care of by either the platform code
>    or phy layer, it doesn't look like it really belongs in chipidea core. The
>    easiest way I guess would be to do something similar to the notify
>    callback in msm platform code.

VBUS operation is typical operation during the USB code, eg, we need
to open vbus at Host mode, we need close/open vbus during host<->gadget
switch.

I suggest vbus regulator is specified at platform code, and assign it
to ci core's pdata, like sasche's patch pdata->dr_mode and pdata->phy_mode.

At core code, we can have a vbus operation API for on/off vbus if vbus
regulator is existed.

-- 

Best Regards,
Peter Chen
