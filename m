From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 12 Jul 2016 12:13:52 +0200
Subject: [PATCH 2/2 v16] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <CAGS+omDsDS5tx=+Efq8LWNd3-asU4r2h=-AE6vdKgfG-p6vdAA@mail.gmail.com>
References: <1464861445-11086-1-git-send-email-jitao.shi@mediatek.com>
 <1464861445-11086-2-git-send-email-jitao.shi@mediatek.com>
 <CACvgo53002XCPLufbJHQLC1uL1nNS7_0gh=napedetmvT6FoSw@mail.gmail.com>
 <CAGS+omDsDS5tx=+Efq8LWNd3-asU4r2h=-AE6vdKgfG-p6vdAA@mail.gmail.com>
Message-ID: <CAKMK7uEkUOq1CB3tj_1Qx50fBpw9B39+c3asX6MPNexT=dv9fA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 6:31 AM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> On Fri, Jun 17, 2016 at 3:14 AM, Emil Velikov <emil.l.velikov@gmail.com> wrote:
>>> +static ssize_t ps8640_update_fw_store(struct device *dev,
>>> +                                     struct device_attribute *attr,
>>> +                                     const char *buf, size_t count)
>>> +{
>>> +       struct i2c_client *client = to_i2c_client(dev);
>>> +       struct ps8640 *ps_bridge = i2c_get_clientdata(client);
>>> +       const struct firmware *fw;
>>> +       int error;
>>> +
>>> +       error = request_firmware(&fw, PS_FW_NAME, dev);
>> Can the device operate without a firmware ? If not, why is the
>> firmware loaded so later/after user interaction (via sysfs) ? I don't
>> recall any other driver in DRM to use such an approach.
>
> The PS8640 has internal flash, so it should always already have a
> working firmware.
> This sysfs interface is useful for user space initiated field firmware updates.

Might be better to just do a request_firmware on driver load, and
simply proceed if it's not there. Adding a sysfs interface (which is
abi) seems way too much overkill for this imo. If you want to upgrade
the firmware you can then just drop it into the right directory, with
no further interaction needed.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
