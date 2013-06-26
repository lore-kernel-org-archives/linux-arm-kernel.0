From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 26 Jun 2013 11:22:30 +0200
Subject: [PATCH 1/2] Initial support for Allwinner's Security ID fuses
In-Reply-To: <20130624160440.GA15201@kroah.com>
References: <1371502778-15849-1-git-send-email-oliver+list@schinagl.nl>
 <1371502778-15849-2-git-send-email-oliver+list@schinagl.nl>
 <20130617225847.GA9494@kroah.com> <20130624092942.GG26008@lukather>
 <20130624160440.GA15201@kroah.com>
Message-ID: <CAMuHMdVkyTXDsEyAvD4pHBiXHADbncGUHeeqXBCQMbU7t6TTDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 6:04 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, Jun 24, 2013 at 11:29:42AM +0200, Maxime Ripard wrote:
>> On Mon, Jun 17, 2013 at 03:58:47PM -0700, Greg KH wrote:
>> > On Mon, Jun 17, 2013 at 10:59:37PM +0200, Oliver Schinagl wrote:
>> > > +static int __init sunxi_sid_probe(struct platform_device *pdev)
>> > > +{
>> > > + u8 entropy[SID_SIZE];
>> > > + unsigned int i;
>> > > + struct resource *res;
>> > > + void __iomem *sid_reg_base;
>> > > + int ret;
>> > > +
>> > > + res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> > > + sid_reg_base = devm_ioremap_resource(&pdev->dev, res);
>> > > + if (IS_ERR(sid_reg_base))
>> > > +         return PTR_ERR(sid_reg_base);
>> > > + platform_set_drvdata(pdev, sid_reg_base);
>> > > +
>> > > + ret = device_create_bin_file(&pdev->dev, &sid_bin_attr);
>> > > + if (ret)
>> > > +         return ret;
>> >
>> > You just raced with userspace, having the file show up after the device
>> > was announced to users that it was there.  Please use the proper device
>> > file api to add default attributes to prevent this from happening.
>>
>> Sorry if the question looks dumb, but what kind of race can we generate
>> here?
>
> Userspace gets told about the device from the driver core, udev runs and
> reads all of the attributes, then your probe function comes along and
> adds a new attribute.  Userspace will then not know about it at all.
>
>> The device_create_bin_file is the last call that we make (if we except
>> the entropy stuff, but it doesn't really matter here), so after we
>> created the file, we have everything properly initialised so that our
>> functions can be called, right?
>>
>> And another dumb question for you, what is the "proper device file API"
>> you are referring to ? :)
>
> Please read Documentation/driver_model/device.txt and see the section on
> Attributes for what to do.  If you have specific questions after reading
> that, please let me know.

Woops, then we have plenty of existing drivers to fix, e.g. all/most RTC drivers
exposing an NVRAM file through sysfs:

$ git grep -w sysfs_create_bin_file drivers/rtc/
drivers/rtc/rtc-cmos.c: retval = sysfs_create_bin_file(&dev->kobj, &nvram);
drivers/rtc/rtc-ds1305.c: status =
sysfs_create_bin_file(&spi->dev.kobj, &nvram);
drivers/rtc/rtc-ds1307.c: err =
sysfs_create_bin_file(&client->dev.kobj, ds1307->nvram);
drivers/rtc/rtc-ds1511.c: ret = sysfs_create_bin_file(&pdev->dev.kobj,
&ds1511_nvram_attr);
drivers/rtc/rtc-ds1553.c: ret = sysfs_create_bin_file(&pdev->dev.kobj,
&ds1553_nvram_attr);
drivers/rtc/rtc-ds1742.c: ret = sysfs_create_bin_file(&pdev->dev.kobj,
&pdata->nvram_attr);
drivers/rtc/rtc-m48t59.c: ret = sysfs_create_bin_file(&pdev->dev.kobj,
&m48t59_nvram_attr);
drivers/rtc/rtc-rp5c01.c: error =
sysfs_create_bin_file(&dev->dev.kobj, &priv->nvram_attr);
drivers/rtc/rtc-stk17ta8.c: ret =
sysfs_create_bin_file(&pdev->dev.kobj, &stk17ta8_nvram_attr);
drivers/rtc/rtc-tx4939.c: ret = sysfs_create_bin_file(&pdev->dev.kobj,
&tx4939_rtc_nvram_attr);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
