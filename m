From: hsinyi@chromium.org (Hsin-Yi Wang)
Date: Thu, 29 Nov 2018 15:50:04 +0800
Subject: [PATCH v4] usb/mtu3: power down device ip at setup
In-Reply-To: <1543472774.32173.114.camel@mhfsdcap03>
References: <20181128095358.42498-1-hsinyi@chromium.org>
 <20181129031627.45006-1-hsinyi@chromium.org>
 <1543472774.32173.114.camel@mhfsdcap03>
Message-ID: <CAJMQK-i0a0J54hx2ii-Zr9=LoAeOWNUfDS_vBPbDkx7sGOZ=Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks!

On Thu, Nov 29, 2018 at 2:26 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> hi Hsin-Yi,
>
> On Thu, 2018-11-29 at 11:16 +0800, Hsin-Yi, Wang wrote:
> > Originally, when dr_mode is USB_DR_MODE_HOST, it didn't power down device ip,
> > so host ip sleep will fail at ssusb_host_disable.
> >
> > Power down device ip at ssusb_host_setup.
> >
> > Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
> > ---
> > ChangeLog:
> > V3->V4:
> >   *update comment
> > ---
> >  drivers/usb/mtu3/mtu3_plat.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
> > index 46551f6d16fd..e086630e41a9 100644
> > --- a/drivers/usb/mtu3/mtu3_plat.c
> > +++ b/drivers/usb/mtu3/mtu3_plat.c
> > @@ -200,6 +200,14 @@ static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
> >       mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
> >       udelay(1);
> >       mtu3_clrbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
> > +
> > +     /*
> > +      * device ip may be powered on in firmware/BROM stage before entering
> > +      * kernel stage;
> > +      * power down device ip, otherwise ip-sleep will fail when working as
> > +      * host only mode
> > +      */
> > +     mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
> >  }
> >
> >  /* ignore the error if the clock does not exist */
>
> Acked-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>
> Thanks a lot
>
>
>
