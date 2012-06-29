From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jun 2012 13:58:28 +0000
Subject: [PATCH 1/3] mfd: support 88pm80x in 80x driver
In-Reply-To: <4FED196D.6090500@marvell.com>
References: <1340853214-5429-1-git-send-email-zhouqiao@marvell.com>
 <201206281121.56769.arnd@arndb.de> <4FED196D.6090500@marvell.com>
Message-ID: <201206291358.28788.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 June 2012, Qiao Zhou wrote:
> On 06/28/2012 07:21 PM, Arnd Bergmann wrote:

> >> All I2C operations are accessed by 80x-i2c driver, and register access is via
> >> regmap interface.
> >>
> >> The benefit is that client drivers only need one kind of read/write API. I2C
> >> and MFD driver can be shared in both 800 and 805.
> >
> > I'm not sure what the purpose of this split is. Usually you only separate out
> > the i2c parts if the same driver has multiple host-side interfaces, e.g. i2c
> > and spi. If your driver only has one of them, it's easier to just have one
> > file. Using regmap however seems to be a good idea nonetheless.
> >
> > I would also suggest you consider splitting the driver into three separate
> > parts after moving the i2c file into the core file:
> >
> > a) one "library" that contains the common code and exports symbols
> > b) one driver for 805 that contains just the 805 specific parts and
> >     registers the i2c driver for 805
> > c) one driver for 800 that contains just the 800 specific parts and
> >     registers the i2c driver for 800
> >
> > Does that sound reasonable?
> >
> > There is very little common that is actually part of the 88pm80x_common
> > file, everything else is specific to just one of the variants. The only common
> > parts I found are device_irq_init_80x and device_irq_exit_80x, and
> > even for those I'm not sure if it wouldn't be easier to just
> > have separate functions.
> >
> > The common parts seem to be mostly in your current _i2c.c file, so that could
> > instead become the common file when you split 805 from 800. You basically
> > just export the pm_ops and the probe/remove functions and let that be called
> > from the individual drivers.
>
> Arnd, the comments is inaccurate for I2C operations. actually all I2C 
> operations are handled by regmap in the new driver. and no more API 
> needs to be exported by 88pm80x-i2c driver. driver which needs to access 
> registers only uses uses regmap handle via dev_get_regmap, only i2c 
> client needed. actually there is no split in I2C operations. please let 
> me know if I miss your meaning.

The point was something else: The regmap always uses i2c behind the covers,
unlike drivers that have a common file using regmap to abstract the
interface so that they can be used with either i2c or spi.

> in the 88pm80x_core.c, actually it only has five functions, 
> irq_init_80x, irq_exit_80x, dev_init_800, dev_init_805, dev_exit_80x. 
> there is indeed few common part. so I assume your meaning is that: 
> creating 88pm800_core.c and 88pm805_core.c separtely, which implement 
> irq_init, irq_exit, dev_init, dev_exit for its own chip. is that correct?

Right. However, I would go further and swap the layering of the driver
parts: Right now, a common pm08x_probe from the common i2c_driver structure
calls the specific device_800_init and device_805_init through
a global pm80x_device_init. When you do the split, I would move the
i2c_driver structure to each of the two 88pm80?_core.c files and have
an individual probe function in them that calls the common pm08x_probe
and then its own device_init.

This is the layering that most other subsystems use when you have drivers
sharing some common code.

> >> diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
> >> new file mode 100644
> >> index 0000000..9e2e11d
> >> --- /dev/null
> >
> > A lot of the contents of this file should not really be globally visible.
> > Most of the register definitions are just used by the common mfd driver,
> > so I would put them in a header file in the mfd directory or (even better)
> > just into the .c file that uses them.
> yes, would category these registers. some registers which is used by 
> regulator/rtc/onkey/codec/headset det/MISC would be kept in this header 
> file, while others would be removed from globally visibility.

Ok, sounds good.

	Arnd
