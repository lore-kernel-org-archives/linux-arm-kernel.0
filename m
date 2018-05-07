From: tfiga@chromium.org (Tomasz Figa)
Date: Mon, 07 May 2018 06:13:27 +0000
Subject: [PATCH v6 05/17] media: rkisp1: add Rockchip ISP1 subdev driver
In-Reply-To: <20180503090909.o3dyhukzs2y7em5z@tarshish>
References: <20180308094807.9443-1-jacob-chen@iotwrt.com>
 <20180308094807.9443-6-jacob-chen@iotwrt.com>
 <20180503090909.o3dyhukzs2y7em5z@tarshish>
Message-ID: <CAAFQd5CvBv4hkE=PSHBJTYa9Lj0SyggxpMBEAYD=if0=T0uzHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Thu, May 3, 2018 at 6:09 PM Baruch Siach <baruch@tkos.co.il> wrote:

> Hi Jacob,

> On Thu, Mar 08, 2018 at 05:47:55PM +0800, Jacob Chen wrote:
> > +static int rkisp1_isp_sd_s_power(struct v4l2_subdev *sd, int on)
> > +{
> > +     struct rkisp1_device *isp_dev = sd_to_isp_dev(sd);
> > +     int ret;
> > +
> > +     v4l2_dbg(1, rkisp1_debug, &isp_dev->v4l2_dev, "s_power: %d\n",
on);
> > +
> > +     if (on) {
> > +             ret = pm_runtime_get_sync(isp_dev->dev);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             rkisp1_config_clk(isp_dev);
> > +     } else {
> > +             ret = pm_runtime_put(isp_dev->dev);

> I commented this line out to make more than one STREAMON work. Otherwise,
the
> second STREAMON hangs. I guess the bug is not this driver. Probably
something
> in drivers/soc/rockchip/pm_domains.c. Just noting that in case you or
someone
> on Cc would like to investigate it further.

> I tested v4.16-rc4 on the Tinkerboard.

Looks like that version doesn't include the IOMMU PM and clock handling
rework [1], which should fix a lot of runtime PM issues. FWIW, linux-next
seems to already include it.

[1] https://lkml.org/lkml/2018/3/23/44

Best regards,
Tomasz
