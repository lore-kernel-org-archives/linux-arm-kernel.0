From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Nov 2017 18:03:03 +0100
Subject: [PATCH v3 3/5] misc serdev: Add w2sg0004 (gps receiver) power
 control driver
In-Reply-To: <AFD95D2E-2EBB-4EBF-9B3B-E68ED98E5437@goldelico.com>
References: <cover.1510759152.git.hns@goldelico.com>
 <9e1525e72afe890ea390fd153c1f3a1b0866c986.1510759152.git.hns@goldelico.com>
 <CAK8P3a3ZtqXVobx5hdxUZyAQRYs2Y6Aw2Qpo2puSBb_AVa_aVA@mail.gmail.com>
 <AFD95D2E-2EBB-4EBF-9B3B-E68ED98E5437@goldelico.com>
Message-ID: <CAK8P3a1Ah35mmbw0qN=zp8TMN9HVgdtTSkkSCCayC-5b6Q960A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15, 2017 at 5:27 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>> Am 15.11.2017 um 16:54 schrieb Arnd Bergmann <arnd@arndb.de>:
>> On Wed, Nov 15, 2017 at 4:19 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>> Add driver for Wi2Wi W2SG0004/84 GPS module connected through uart.
>
> There is one more goal. Some people are dreaming about a generic GPS interface.
> Then, the driver wouldn't have to register a /dev/GPS tty any more but a
> gps_interface and mangle serial data as requested by that API. This will become
> a simple upgrade.
>
> So you can consider creating a new tty as sort of temporary solution. Like we
> had for years for UART HCI based bluetooth devices using a user-space daemon.

It shouldn't be hard to split out the tty_driver portion of your file from the
part that registers the port, basically getting two files that each handle
half of the work, and the second one would be generic from the start.

>>> +       /* initialize the tty driver */
>>> +       data->tty_drv->owner = THIS_MODULE;
>>> +       data->tty_drv->driver_name = "w2sg0004";
>>> +       data->tty_drv->name = "ttyGPS";
>>> +       data->tty_drv->major = 0;
>>> +       data->tty_drv->minor_start = 0;
>>> +       data->tty_drv->type = TTY_DRIVER_TYPE_SERIAL;
>>> +       data->tty_drv->subtype = SERIAL_TYPE_NORMAL;
>>> +       data->tty_drv->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
>>> +       data->tty_drv->init_termios = tty_std_termios;
>>> +       data->tty_drv->init_termios.c_cflag = B9600 | CS8 | CREAD |
>>> +                                             HUPCL | CLOCAL;
>>> +       /*
>>> +        * optional:
>>> +        * tty_termios_encode_baud_rate(&data->tty_drv->init_termios,
>>> +                                       115200, 115200);
>>> +        * w2sg_tty_termios(&data->tty_drv->init_termios);
>>> +        */
>>> +       tty_set_operations(data->tty_drv, &w2sg_serial_ops);
>>
>> While I'm still not sure about why we want nested tty port, it
>> seems that we should have only one tty_driver that gets initialized
>> at module load time, rather than one driver structure per port.
>
> If we have several such chips connected to different serdev UARTs
> we need different /dev/GPS to separate them in user-space.

I understand that you need multiple devices, but I don't see
what having multiple drivers that all share the same name
"w2sg0004" helps. I would have expected that to fail in
tty_register_driver() when you get to the second driver,
but looking at the code, it doesn't actually try to make the name
unique proc_tty_register_driver() will fail to create the second
procfs file, but we ignore that failure.

Why not call tty_register_driver() in the init function rather than probe()?

>>> +       /* register the tty driver */
>>> +       err = tty_register_driver(data->tty_drv);
>>> +       if (err) {
>>> +               pr_err("%s - tty_register_driver failed(%d)\n",
>>> +                       __func__, err);
>>> +               put_tty_driver(data->tty_drv);
>>> +               goto err_rfkill;
>>> +       }
>>> +
>>> +       tty_port_init(&data->port);
>>> +       data->port.ops = &w2sg_port_ops;
>>> +
>>> +/*
>>> + * FIXME: this appears to reenter this probe() function a second time
>>> + * which only fails because the gpio is already assigned
>>> + */
>>> +
>>> +       data->dev = tty_port_register_device(&data->port,
>>> +                       data->tty_drv, minor, &serdev->dev);
>>
>> This seems to be a result of having nested tty ports, and both
>> ports point to the same device.
>
> The UART tty would be e.g. /dev/ttyO2 (on OMAP3) if no driver is
> installed. And the new one that is registered is /dev/GPS0. So the
> tty subsystem doesn't (or shouldn't) know they are related. They
> are only related/connected inside this driver. So I assume that
> some locking or reentrancy happens in tty_port_register_device().

I meant the serdev->dev pointer that you pass into
tty_port_register_device() seems to be the same one that
got passed into the first tty_port_register_device() in the
parent uart_port.

I just checked the current mainline code, and it doesn't seem
to actually call serdev_tty_port_register() from
tty_port_register_device(), so maybe the comment was
based on an older version of the serdev framework?

It seems like something that should be fixed, so maybe
put a WARN_ON() at the beginning of the probe
function to see where we come from.

      Arnd
