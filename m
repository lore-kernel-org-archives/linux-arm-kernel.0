From: daniel@ffwll.ch (Daniel Vetter)
Date: Thu, 4 Aug 2016 12:58:15 +0200
Subject: [PATCH 2/2 v16] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <CAFqH_53PgPs3_h7XNFEu4u0W6GW7vyWCNFf2vq8Yn7sH2LbFwA@mail.gmail.com>
References: <1464861445-11086-1-git-send-email-jitao.shi@mediatek.com>
 <1464861445-11086-2-git-send-email-jitao.shi@mediatek.com>
 <CACvgo53002XCPLufbJHQLC1uL1nNS7_0gh=napedetmvT6FoSw@mail.gmail.com>
 <CAGS+omDsDS5tx=+Efq8LWNd3-asU4r2h=-AE6vdKgfG-p6vdAA@mail.gmail.com>
 <CAKMK7uEkUOq1CB3tj_1Qx50fBpw9B39+c3asX6MPNexT=dv9fA@mail.gmail.com>
 <CAFqH_53PgPs3_h7XNFEu4u0W6GW7vyWCNFf2vq8Yn7sH2LbFwA@mail.gmail.com>
Message-ID: <20160804105814.GH6232@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 12:35:59PM +0200, Enric Balletbo Serra wrote:
> 2016-07-12 12:13 GMT+02:00 Daniel Vetter <daniel@ffwll.ch>:
> > On Wed, Jun 29, 2016 at 6:31 AM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> >> On Fri, Jun 17, 2016 at 3:14 AM, Emil Velikov <emil.l.velikov@gmail.com> wrote:
> >>>> +static ssize_t ps8640_update_fw_store(struct device *dev,
> >>>> +                                     struct device_attribute *attr,
> >>>> +                                     const char *buf, size_t count)
> >>>> +{
> >>>> +       struct i2c_client *client = to_i2c_client(dev);
> >>>> +       struct ps8640 *ps_bridge = i2c_get_clientdata(client);
> >>>> +       const struct firmware *fw;
> >>>> +       int error;
> >>>> +
> >>>> +       error = request_firmware(&fw, PS_FW_NAME, dev);
> >>> Can the device operate without a firmware ? If not, why is the
> >>> firmware loaded so later/after user interaction (via sysfs) ? I don't
> >>> recall any other driver in DRM to use such an approach.
> >>
> >> The PS8640 has internal flash, so it should always already have a
> >> working firmware.
> >> This sysfs interface is useful for user space initiated field firmware updates.
> >
> > Might be better to just do a request_firmware on driver load, and
> > simply proceed if it's not there. Adding a sysfs interface (which is
> > abi) seems way too much overkill for this imo. If you want to upgrade
> > the firmware you can then just drop it into the right directory, with
> > no further interaction needed.
> 
> IMHO I'm not sure if for this use case request_firmware on driver load
> is a good idea. Flash the non-volatile internal chip can be a slow
> operation and if you forget to remove the firmware after drop it into
> the right directory apart from slow down the driver probe you can
> damage the chip depending on the write endurance of the chip.

Ah ok. Explaining this in the commit message would be really good.

> This sysfs interface is used on other subsystems when there is a
> non-volatile memory, as example you can see at [1], [2]. Unfortunately
> not all are using the same sysfs interface and maybe this should be
> standardized (maybe it's an opportunity to define it)

+1 on standardizing this.
-Daniel
> 
> Regards,
>  Enric
> 
> [1] http://lxr.free-electrons.com/source/drivers/input/touchscreen/wdt87xx_i2c.c#L922
> [2] http://lxr.free-electrons.com/source/drivers/scsi/pm8001/pm8001_ctl.c#L732
> 
> 
> > -Daniel
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel at lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
