From: hsinyi@chromium.org (Hsin-Yi Wang)
Date: Wed, 28 Nov 2018 14:59:33 +0800
Subject: [PATCH] usb/mtu3: power down device ip at setup
In-Reply-To: <1543386149.32173.87.camel@mhfsdcap03>
References: <20181128060412.630-1-hsinyi@chromium.org>
 <1543386149.32173.87.camel@mhfsdcap03>
Message-ID: <CAJMQK-got7Xo2mfKqhjuL6C5OJUov79JPRf9JA5+zL1b1saUSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chunfeng,
On mt8183, We found `ip sleep failed!!!` with powerd_dbus_suspend.
Referenced from xhci, it power down device ip at
xhci_mtk_ssusb_config(). Also if dr_mode is PERIPHERAL and OTG, they
both power down device ip at ssusb_gadget_init().

On Wed, Nov 28, 2018 at 2:22 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> Hi Hsin-Yi,
>
> On Wed, 2018-11-28 at 14:04 +0800, Hsin-Yi, Wang wrote:
> > Originally, when dr_mode is USB_DR_MODE_HOST, it didn't power down device ip,
> > so host ip sleep will fail at ssusb_host_disable.
> >
> > Power down device ip at ssusb_host_setup.
> >
> > Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
> > ---
> >  drivers/usb/mtu3/mtu3_host.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
> > index c871b94f3e6f..d17cf43305db 100644
> > --- a/drivers/usb/mtu3/mtu3_host.c
> > +++ b/drivers/usb/mtu3/mtu3_host.c
> > @@ -192,9 +192,17 @@ int ssusb_host_disable(struct ssusb_mtk *ssusb, bool suspend)
> >  static void ssusb_host_setup(struct ssusb_mtk *ssusb)
> >  {
> >       struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
> > +     void __iomem *ibase = ssusb->ippc_base;
> >
> >       host_ports_num_get(ssusb);
> >
> > +     /*
> > +      * device ip is default power-on in fact
> The device ip is power-off by default, no need power down it here.
>
> On which platform did you encounter the issue?
>
> > +      * power down device ip, otherwise ip-sleep will fail
> > +      */
> > +     if (ssusb->dr_mode == USB_DR_MODE_HOST)
> > +             mtu3_setbits(ibase, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
> > +
>
>
> >       /*
> >        * power on host and power on/enable all ports
> >        * if support OTG, gadget driver will switch port0 to device mode
>
>
