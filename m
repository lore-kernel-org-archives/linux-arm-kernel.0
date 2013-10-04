From: inki.dae@samsung.com (Inki Dae)
Date: Sat, 05 Oct 2013 01:01:27 +0900
Subject: [PATCH v2 4/5] drm/exynos: Initialize ptn3460 if present
In-Reply-To: <CAOw6vbKm+N8ZNyL8HQNhm2TnQOD8---1DkxE-n1LxWz-Y2=MNw@mail.gmail.com>
References: <1380670860-17621-1-git-send-email-seanpaul@chromium.org>
 <1380839303-4834-1-git-send-email-seanpaul@chromium.org>
 <1380839303-4834-5-git-send-email-seanpaul@chromium.org>
 <CAAQKjZNKLtqKK8eoKukHwARBMBYdWfHwxdWS-aU=YjYW+KU+Gg@mail.gmail.com>
 <CAOw6vbKWjBL8jZ9iQ_Nk7-SmoTcTZ8TSMiwjOc2qT=HaJYFjAw@mail.gmail.com>
 <CAAQKjZMfP_Cgo5hPPTiwKa_+Ph+GUt2Fbdtipd5V=CQEDy3eSQ@mail.gmail.com>
 <CAOw6vbL_W-8S+htX9KB2ABbtr9+JhfxHuL2ikJG7CrqEkeo9NA@mail.gmail.com>
 <03d801cec112$a477f4a0$ed67dde0$%dae@samsung.com>
 <CAOw6vbKm+N8ZNyL8HQNhm2TnQOD8---1DkxE-n1LxWz-Y2=MNw@mail.gmail.com>
Message-ID: <03df01cec11a$fc08d1f0$f41a75d0$%dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Sean Paul [mailto:seanpaul at chromium.org]
> Sent: Saturday, October 05, 2013 12:05 AM
> To: Inki Dae
> Cc: Kukjin Kim; DRI mailing list; linux-samsung-soc; Linux ARM Kernel;
> Linux Kernel Mailing List; linux-doc at vger.kernel.org;
> devicetree at vger.kernel.org; Dave Airlie
> Subject: Re: [PATCH v2 4/5] drm/exynos: Initialize ptn3460 if present
> 
> On Fri, Oct 4, 2013 at 11:01 AM, Inki Dae <inki.dae@samsung.com> wrote:
> >
> >
> >> -----Original Message-----
> >> From: Sean Paul [mailto:seanpaul at chromium.org]
> >> Sent: Friday, October 04, 2013 11:17 PM
> >> To: Inki Dae
> >> Cc: Kukjin Kim; DRI mailing list; linux-samsung-soc at vger.kernel.org;
> >> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> linux-
> >> doc at vger.kernel.org; devicetree at vger.kernel.org; Dave Airlie
> >> Subject: Re: [PATCH v2 4/5] drm/exynos: Initialize ptn3460 if present
> >>
> >> On Fri, Oct 4, 2013 at 12:18 AM, Inki Dae <inki.dae@samsung.com> wrote:
> >> > 2013/10/4 Sean Paul <seanpaul@chromium.org>:
> >> >> On Thu, Oct 3, 2013 at 10:29 PM, Inki Dae <inki.dae@samsung.com>
> wrote:
> >> >>> 2013/10/4 Sean Paul <seanpaul@chromium.org>:
> >> >>>> This patch adds code to look for the ptn3460 in the device tree
> file
> >> on
> >> >>>> exynos initialization. If ptn node is found, the driver will
> >> initialize
> >> >>>> the ptn3460 driver and skip creating a DP connector (since the
> bridge
> >> >>>> driver will register its own connector).
> >> >>>>
> >> >>>> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> >> >>>> ---
> >> >>>>
> >> >>>> v2:
> >> >>>>         - Changed include from of_i2c.h to i2c.h
> >> >>>>         - Changed of_find_by_name to of_find_compatible
> >> >>>>
> >> >>>>  drivers/gpu/drm/exynos/exynos_drm_core.c | 44
> >> +++++++++++++++++++++++++++++++-
> >> >>>>  1 file changed, 43 insertions(+), 1 deletion(-)
> >> >>>>
> >> >>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_core.c
> >> b/drivers/gpu/drm/exynos/exynos_drm_core.c
> >> >>>> index 1bef6dc..08ca4f9 100644
> >> >>>> --- a/drivers/gpu/drm/exynos/exynos_drm_core.c
> >> >>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_core.c
> >> >>>> @@ -12,7 +12,9 @@
> >> >>>>   * option) any later version.
> >> >>>>   */
> >> >>>>
> >> >>>> +#include <linux/i2c.h>
> >> >>>>  #include <drm/drmP.h>
> >> >>>> +#include <drm/bridge/ptn3460.h>
> >> >>>>  #include "exynos_drm_drv.h"
> >> >>>>  #include "exynos_drm_encoder.h"
> >> >>>>  #include "exynos_drm_connector.h"
> >> >>>> @@ -20,6 +22,40 @@
> >> >>>>
> >> >>>>  static LIST_HEAD(exynos_drm_subdrv_list);
> >> >>>>
> >> >>>> +struct bridge_init {
> >> >>>> +       struct i2c_client *client;
> >> >>>> +       struct device_node *node;
> >> >>>> +};
> >> >>>> +
> >> >>>> +static bool find_bridge(const char *compat, struct bridge_init
> >> *bridge)
> >> >>>> +{
> >> >>>> +       bridge->client = NULL;
> >> >>>> +       bridge->node = of_find_compatible_node(NULL, NULL,
compat);
> >> >>>
> >> >>> Then, shouldn't the lvds-bridge driver be implemented as i2c driver
> so
> >> >>> that such tricky isn't needed? Is there any reason you use such
> tricky
> >> >>> codes?
> >> >>>
> >> >>
> >> >> This is what I was explaining earlier today. If the bridge driver is
> >> >> just an i2c driver, it won't get a pointer to drm_device, and can't
> >> >> register itself as a drm_bridge or drm_connector. To solve this, you
> >> >> need the ptn3460_init callback.
> >> >>
> >> >
> >> > No, I think you can use sub driver. how about registering to exynos
> >> > drm core that driver using exynos_drm_subdrv_register function after
> >> > probed? Is there something I am missing?
> >> >
> >>
> >> The ptn driver isn't exynos-specific, so I don't think making it an
> >> exynos_drm_subdrv is appropriate.
> >>
> >
> > I _really know_ that the ptn driver isn't exynos-specific. I mean that
> you
> > can use exynos_drm_subdrv somehow. ie. you can add a new bridge module
> > specific to exynos, and this module can register its own sub driver at
> end
> > of probe. Why do you try to use such tricky codes?
> >
> 
> So I create a new exynos_lvds_driver which is an i2c driver. When that
> probes, all it does is register that driver as an exynos_drm_subdrv.
> Then in the subdrv probe I call into ptn3460_init?
> 
> That seems a lot more tricky than just calling ptn3460_init directly...
> 

Why more tricky? At least the dt binding will be done in device driver.

Anyway, this also is reasonable to me. It seems that we need a bit different
design for such bridge driver.

Basically, exysnos drm fimd driver has one encoder and one connector, and
these are connected each other, and this connector means lcd panel without
any display bus. So if we want to use display bus, it might need to create a
new encoder and connector for the display bus device. It seems that this way
is more reasonable to me.
ie.  if we want for image data goes from fimd to lcd panel, we can connect a
existing connector and crtc of fimd, and if fimd to display bus, we can
connect the new connector and the crtc of fimd through setcrtc or setplane.

Of course, for this we would need more works and efforts. Such tricky codes
definitely are not good.

Thanks,
Inki Dae

> Sean
> 
> 
> > Thanks,
> > Inki Dae
> >
> >> Sean
> >>
> >> >
> >> >> If it's an i2c driver with the ptn3460_init callback, where it
> parses
> >> >> the dt in probe, then you have a race between the ptn probe and the
> >> >> ptn init/drm hooks. ie: it's possible drm will initialize and call
> >> >> disable/post_disable/pre_enable/enable before things have been
> probed.
> >> >
> >> > And also, exynos drm core will call a probe callback of the sub
> driver
> >> > after _drm is initialized_. Is there something I am missing?
> >> >
> >> >> To solve this, you need to use some global state and/or locking.
> >> >>
> >> >> So, to summarize. We can have this of_find_compatible with a init
> >> >> callback, or we can have an i2c driver + global state/locking + init
> >> >> callback. I chose the former, since it seemed easier.
> >> >>
> >> >> If you have a better way to achieve this, I'm definitely interested,
> >> >> but I saw this as the lesser of two evils.
> >> >>
> >> >> Sean
> >> >>
> >> >>> I think you need to implement the lvds-bridge driver as i2c driver,
> >> >>> and then consider how to take care of this. I mean let's find a
> better
> >> >>> way how we could take care of the i2c based driver in exynos drm
> >> >>> framework or driver. In all cases, such tricky codes are not good.
> >> >>>
> >> >>>> +       if (!bridge->node)
> >> >>>> +               return false;
> >> >>>> +
> >> >>>> +       bridge->client = of_find_i2c_device_by_node(bridge->node);
> >> >>>> +       if (!bridge->client)
> >> >>>> +               return false;
> >> >>>> +
> >> >>>> +       return true;
> >> >>>> +}
> >> >>>> +
> >> >>>> +/* returns the number of bridges attached */
> >> >>>> +static int exynos_drm_attach_lcd_bridge(struct drm_device *dev,
> >> >>>> +               struct drm_encoder *encoder)
> >> >>>> +{
> >> >>>> +       struct bridge_init bridge;
> >> >>>> +       int ret;
> >> >>>> +
> >> >>>> +       if (find_bridge("nxp,ptn3460", &bridge)) {
> >> >>>> +               ret = ptn3460_init(dev, encoder, bridge.client,
> >> bridge.node);
> >> >>>> +               if (!ret)
> >> >>>> +                       return 1;
> >> >>>> +       }
> >> >>>> +       return 0;
> >> >>>> +}
> >> >>>> +
> >> >>>>  static int exynos_drm_create_enc_conn(struct drm_device *dev,
> >> >>>>                                         struct exynos_drm_subdrv
> > *subdrv)
> >> >>>>  {
> >> >>>> @@ -36,6 +72,13 @@ static int exynos_drm_create_enc_conn(struct
> >> drm_device *dev,
> >> >>>>                 DRM_ERROR("failed to create encoder\n");
> >> >>>>                 return -EFAULT;
> >> >>>>         }
> >> >>>> +       subdrv->encoder = encoder;
> >> >>>> +
> >> >>>> +       if (subdrv->manager->display_ops->type ==
> >> EXYNOS_DISPLAY_TYPE_LCD) {
> >> >>>> +               ret = exynos_drm_attach_lcd_bridge(dev, encoder);
> >> >>>> +               if (ret)
> >> >>>> +                       return 0;
> >> >>>> +       }
> >> >>>>
> >> >>>>         /*
> >> >>>>          * create and initialize a connector for this sub driver
and
> >> >>>> @@ -48,7 +91,6 @@ static int exynos_drm_create_enc_conn(struct
> >> drm_device *dev,
> >> >>>>                 goto err_destroy_encoder;
> >> >>>>         }
> >> >>>>
> >> >>>> -       subdrv->encoder = encoder;
> >> >>>>         subdrv->connector = connector;
> >> >>>>
> >> >>>>         return 0;
> >> >>>> --
> >> >>>> 1.8.4
> >> >>>>
> >> >>>> --
> >> >>>> To unsubscribe from this list: send the line "unsubscribe linux-
> >> samsung-soc" in
> >> >>>> the body of a message to majordomo at vger.kernel.org
> >> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> >> --
> >> >> To unsubscribe from this list: send the line "unsubscribe linux-
> >> samsung-soc" in
> >> >> the body of a message to majordomo at vger.kernel.org
> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
