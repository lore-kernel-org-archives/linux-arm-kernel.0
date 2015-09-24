From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 24 Sep 2015 16:23:09 +0800
Subject: [linux-sunxi] Re: [PATCH v4 2/5] soc: sunxi: Add driver for
 Allwinner Reduced Serial Bus
In-Reply-To: <20150923164532.GT30445@sirena.org.uk>
References: <1443024323-9115-1-git-send-email-wens@csie.org>
 <1443024323-9115-3-git-send-email-wens@csie.org>
 <20150923164532.GT30445@sirena.org.uk>
Message-ID: <CAGb2v65Q1fMs5mxk8m64US+82oVkfmRyx3D2Yf_VhZwOpPHXVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 12:45 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Sep 24, 2015 at 12:05:18AM +0800, Chen-Yu Tsai wrote:
>
>> +static int sunxi_rsb_device_probe(struct device *dev)
>> +{
>> +     const struct sunxi_rsb_driver *drv = to_sunxi_rsb_driver(dev->driver);
>> +     struct sunxi_rsb_device *rdev = to_sunxi_rsb_device(dev);
>> +     int ret;
>> +
>> +     if (dev->bus != &sunxi_rsb_bus)
>> +             return 0;
>
> That's a bit worrying...  why might this get called for something other
> than a rsb device?

You're right. sunxi_rsb_bus is self contained (not exported) in sunxi_rsb.c,
so it's safe to assume that the devices going through sunxi_rsb_device_probe()
and sunxi_rsb_device_remove() are indeed sunxi_rsb slave devices.

I'll remove the checks from both functions.

>> +struct regmap *devm_regmap_init_sunxi_rsb(struct sunxi_rsb_device *rdev,
>> +                                       const struct regmap_config *config);
>
> This should work most of the time but you might want to take a look at
> the changes introduced in 3cfe7a74d42b (regmap: Use different lockdep
> class for each regmap init call) and follow a similar pattern for RSB to
> avoid spurious lockdep warnings in some configurations - see the commit
> log for that change for a full explanation.

This seems easy enough. I'll follow the patterns found in linux/regmap.h.

> Otherwise the regmap bit of this looks good, I'll try to have another
> look through at the rest of the code later.

Thanks!


Regards
ChenYu
