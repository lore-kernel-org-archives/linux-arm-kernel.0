From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 28 Nov 2018 15:02:56 +0800
Subject: [PATCH] usb/mtu3: power down device ip at setup
In-Reply-To: <CAJMQK-joY4M-=4+XoYAC5SJUie554i_EO=7VgrkJj2JNbbDdxg@mail.gmail.com>
References: <20181128060412.630-1-hsinyi@chromium.org>
 <1543386149.32173.87.camel@mhfsdcap03>
 <CAJMQK-joY4M-=4+XoYAC5SJUie554i_EO=7VgrkJj2JNbbDdxg@mail.gmail.com>
Message-ID: <1543388576.32173.106.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-11-28 at 14:26 +0800, Hsin-Yi Wang wrote:
> Hi Chunfeng,
> On mt8183, We found `ip sleep failed!!!` with powerd_dbus_suspend.
Did you enable usb device mode in BROM or LK stage? e.g. download image
by fastboot / flashtool

>  Referenced from xhci, it also power down device ip at
> xhci_mtk_ssusb_config().
It may happen when user downloads images by usb device in LK/BROM stage,
but not disable it before enter kernel stage.

>  Also if dr_mode is PERIPHERAL and OTG, they both power down device ip
> at ssusb_gadget_init().
Yes, it tries to save power;
> 
> On Wed, Nov 28, 2018 at 2:22 PM Chunfeng Yun
> <chunfeng.yun@mediatek.com> wrote:
> 
>         Hi Hsin-Yi,
>         
>         On Wed, 2018-11-28 at 14:04 +0800, Hsin-Yi, Wang wrote:
>         > Originally, when dr_mode is USB_DR_MODE_HOST, it didn't
>         power down device ip,
>         > so host ip sleep will fail at ssusb_host_disable.
>         > 
>         > Power down device ip at ssusb_host_setup.
>         > 
>         > Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
>         > ---
>         >  drivers/usb/mtu3/mtu3_host.c | 8 ++++++++
>         >  1 file changed, 8 insertions(+)
>         > 
>         > diff --git a/drivers/usb/mtu3/mtu3_host.c
>         b/drivers/usb/mtu3/mtu3_host.c
>         > index c871b94f3e6f..d17cf43305db 100644
>         > --- a/drivers/usb/mtu3/mtu3_host.c
>         > +++ b/drivers/usb/mtu3/mtu3_host.c
>         > @@ -192,9 +192,17 @@ int ssusb_host_disable(struct ssusb_mtk
>         *ssusb, bool suspend)
>         >  static void ssusb_host_setup(struct ssusb_mtk *ssusb)
>         >  {
>         >       struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
>         > +     void __iomem *ibase = ssusb->ippc_base;
>         >  
>         >       host_ports_num_get(ssusb);
>         >  
>         > +     /*
>         > +      * device ip is default power-on in fact
>         The device ip is power-off by default, no need power down it
>         here.
>         
>         On which platform did you encounter the issue?
>         
>         > +      * power down device ip, otherwise ip-sleep will fail
>         > +      */
>         > +     if (ssusb->dr_mode == USB_DR_MODE_HOST)
>         > +             mtu3_setbits(ibase, U3D_SSUSB_IP_PW_CTRL2,
>         SSUSB_IP_DEV_PDN);
>         > +
Could you please put it in ssusb_ip_sw_reset(), after ip reset, in
mtu3_plat.c, if it fix the issue?

>         >       /*
>         >        * power on host and power on/enable all ports
>         >        * if support OTG, gadget driver will switch port0 to
>         device mode
>         
>         
