From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 24 May 2016 11:04:33 +0200
Subject: [PATCHv3] support for AD5820 camera auto-focus coil
In-Reply-To: <574049EF.2090208@gmail.com>
References: <20160517181927.GA28741@amd> <20160521054336.GA27123@amd>
 <573FFF51.1000004@gmail.com> <20160521105607.GA20071@amd>
 <574049EF.2090208@gmail.com>
Message-ID: <20160524090433.GA1277@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >+static int ad5820_registered(struct v4l2_subdev *subdev)
> >+{
> >+	struct ad5820_device *coil = to_ad5820_device(subdev);
> >+	struct i2c_client *client = v4l2_get_subdevdata(subdev);
> >+
> >+	coil->vana = regulator_get(&client->dev, "VANA");
> 
> devm_regulator_get()?

I'd rather avoid devm_ here. Driver is simple enough to allow it.

> >+#define AD5820_RAMP_MODE_LINEAR		(0 << 3)
> >+#define AD5820_RAMP_MODE_64_16		(1 << 3)
> >+
> >+struct ad5820_platform_data {
> >+	int (*set_xshutdown)(struct v4l2_subdev *subdev, int set);
> >+};
> >+
> >+#define to_ad5820_device(sd)	container_of(sd, struct ad5820_device, subdev)
> >+
> >+struct ad5820_device {
> >+	struct v4l2_subdev subdev;
> >+	struct ad5820_platform_data *platform_data;
> >+	struct regulator *vana;
> >+
> >+	struct v4l2_ctrl_handler ctrls;
> >+	u32 focus_absolute;
> >+	u32 focus_ramp_time;
> >+	u32 focus_ramp_mode;
> >+
> >+	struct mutex power_lock;
> >+	int power_count;
> >+
> >+	int standby : 1;
> >+};
> >+
> 
> The same for struct ad5820_device, is it really part of the public API?

Let me check what can be done with it.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
