From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Wed, 15 Nov 2017 17:27:21 +0100
Subject: [PATCH v3 3/5] misc serdev: Add w2sg0004 (gps receiver) power
 control driver
In-Reply-To: <CAK8P3a3ZtqXVobx5hdxUZyAQRYs2Y6Aw2Qpo2puSBb_AVa_aVA@mail.gmail.com>
References: <cover.1510759152.git.hns@goldelico.com>
 <9e1525e72afe890ea390fd153c1f3a1b0866c986.1510759152.git.hns@goldelico.com>
 <CAK8P3a3ZtqXVobx5hdxUZyAQRYs2Y6Aw2Qpo2puSBb_AVa_aVA@mail.gmail.com>
Message-ID: <AFD95D2E-2EBB-4EBF-9B3B-E68ED98E5437@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> Am 15.11.2017 um 16:54 schrieb Arnd Bergmann <arnd@arndb.de>:
> 
> On Wed, Nov 15, 2017 at 4:19 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>> Add driver for Wi2Wi W2SG0004/84 GPS module connected through uart.
>> 
>> Use serdev API hooks to monitor and forward the UART traffic to /dev/GPSn
>> and turn on/off the module. It also detects if the module is turned on (sends data)
>> but should be off, e.g. if it was already turned on during boot or power-on-reset.
>> 
>> Additionally, rfkill block/unblock can be used to control an external LNA
>> (and power down the module if not needed).
>> 
>> The driver concept is based on code developed by NeilBrown <neilb@suse.de>
>> but simplified and adapted to use the new serdev API introduced in 4.11.
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> 
> I'm a bit confused by the concept here. Did I understand it right that this
> attaches to a tty_port and then registers another tty_driver with one
> tty_port for the first port?

Yes. It attaches to a serdev (which is a tty_port hidden from user-space) and
creates its own to be accessible from user-space.

It seems that this is very difficult to understand since I have to explain
it again and again every time I submit a new version :) Maybe I should write
some document to cite :)

Basically we only want to control power on/off of the chip but need to tap
the data stream to monitor the chip as described in the commit message. But
we do not need to modify data. The ideal solution would be that serdev wouldn't
hide the original /dev/tty for the UART but I was told that this is not possible
with serdev API.

We could also run the chip without a driver and use the original /dev/tty - but
then we have no power control of a power-hungry chip in a mobile device. And
without kernel driver, we can't turn it off automatically during suspend.

BTW: we did discuss how to do this chip right for years (IMHO the first proposal
was 2012 or 2013 by Neil Brown). Nowadays, the serdev DT structure demands that it
is a serdev and nothing else. Hence we have to live with what serdev provides
as API and make it a serdev driver.

There is one more goal. Some people are dreaming about a generic GPS interface.
Then, the driver wouldn't have to register a /dev/GPS tty any more but a
gps_interface and mangle serial data as requested by that API. This will become
a simple upgrade.

So you can consider creating a new tty as sort of temporary solution. Like we
had for years for UART HCI based bluetooth devices using a user-space daemon.

> 
>> +static int w2sg_probe(struct serdev_device *serdev)
>> +{
>> +       struct w2sg_pdata *pdata = NULL;
>> +       struct w2sg_data *data;
>> +       struct rfkill *rf_kill;
>> +       int err;
>> +       int minor;
>> +
>> +       pr_debug("%s()\n", __func__);
>> +
>> +       minor = 0;
>> +       if (w2sg_by_minor[minor]) {
>> +               pr_err("w2sg minor is already in use!\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       if (serdev->dev.of_node) {
>> +               struct device *dev = &serdev->dev;
>> +               enum of_gpio_flags flags;
>> +
>> +               pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> +               if (!pdata)
>> +                       return -ENOMEM;
> 
> This looks like it's a leftover from pre-DT days, but it doesn't
> actually work without DT in the current form. How about
> merging the contents of w2sg_pdata into w2sg_data?

Ok. As said the driver core is very old...

I'll look into this asap.

> 
>> +
>> +       /* initialize the tty driver */
>> +       data->tty_drv->owner = THIS_MODULE;
>> +       data->tty_drv->driver_name = "w2sg0004";
>> +       data->tty_drv->name = "ttyGPS";
>> +       data->tty_drv->major = 0;
>> +       data->tty_drv->minor_start = 0;
>> +       data->tty_drv->type = TTY_DRIVER_TYPE_SERIAL;
>> +       data->tty_drv->subtype = SERIAL_TYPE_NORMAL;
>> +       data->tty_drv->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
>> +       data->tty_drv->init_termios = tty_std_termios;
>> +       data->tty_drv->init_termios.c_cflag = B9600 | CS8 | CREAD |
>> +                                             HUPCL | CLOCAL;
>> +       /*
>> +        * optional:
>> +        * tty_termios_encode_baud_rate(&data->tty_drv->init_termios,
>> +                                       115200, 115200);
>> +        * w2sg_tty_termios(&data->tty_drv->init_termios);
>> +        */
>> +       tty_set_operations(data->tty_drv, &w2sg_serial_ops);
> 
> While I'm still not sure about why we want nested tty port, it
> seems that we should have only one tty_driver that gets initialized
> at module load time, rather than one driver structure per port.

If we have several such chips connected to different serdev UARTs
we need different /dev/GPS to separate them in user-space.

> 
>> +       /* register the tty driver */
>> +       err = tty_register_driver(data->tty_drv);
>> +       if (err) {
>> +               pr_err("%s - tty_register_driver failed(%d)\n",
>> +                       __func__, err);
>> +               put_tty_driver(data->tty_drv);
>> +               goto err_rfkill;
>> +       }
>> +
>> +       tty_port_init(&data->port);
>> +       data->port.ops = &w2sg_port_ops;
>> +
>> +/*
>> + * FIXME: this appears to reenter this probe() function a second time
>> + * which only fails because the gpio is already assigned
>> + */
>> +
>> +       data->dev = tty_port_register_device(&data->port,
>> +                       data->tty_drv, minor, &serdev->dev);
> 
> This seems to be a result of having nested tty ports, and both
> ports point to the same device.

The UART tty would be e.g. /dev/ttyO2 (on OMAP3) if no driver is
installed. And the new one that is registered is /dev/GPS0. So the
tty subsystem doesn't (or shouldn't) know they are related. They
are only related/connected inside this driver. So I assume that
some locking or reentrancy happens in tty_port_register_device().

BR and thanks,
Nikolaus Schaller
