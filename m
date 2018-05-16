From: chunkeey@gmail.com (Christian Lamparter)
Date: Wed, 16 May 2018 22:29:48 +0200
Subject: [PATCH v4] pinctrl: msm: fix gpio-hog related boot issues
In-Reply-To: <152648467672.210890.17814748620132622851@swboyd.mtv.corp.google.com>
References: <20180412190138.12372-1-chunkeey@gmail.com>
 <CACRpkdZPEHvnQdwh5Uu5kwqK7yVGTaw_cZR+GOzsG9pg4oEktA@mail.gmail.com>
 <152648467672.210890.17814748620132622851@swboyd.mtv.corp.google.com>
Message-ID: <3220588.XpgAMh8mx0@debian64>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, May 16, 2018 5:31:16 PM CEST Stephen Boyd wrote:
> Quoting Linus Walleij (2018-04-26 05:03:45)
> > On Thu, Apr 12, 2018 at 9:01 PM, Christian Lamparter <chunkeey@gmail.com> wrote:
> > 
> > > Sven Eckelmann reported an issue with the current IPQ4019 pinctrl.
> > > Setting up any gpio-hog in the device-tree for his device would
> > > "kill the bootup completely":
> > >
> > > | [    0.477838] msm_serial 78af000.serial: could not find pctldev for node /soc/pinctrl at 1000000/serial_pinmux, deferring probe
> > > | [    0.499828] spi_qup 78b5000.spi: could not find pctldev for node /soc/pinctrl at 1000000/spi_0_pinmux, deferring probe
> > > | [    1.298883] requesting hog GPIO enable USB2 power (chip 1000000.pinctrl, offset 58) failed, -517
> > > | [    1.299609] gpiochip_add_data: GPIOs 0..99 (1000000.pinctrl) failed to register
> > > | [    1.308589] ipq4019-pinctrl 1000000.pinctrl: Failed register gpiochip
> > > | [    1.316586] msm_serial 78af000.serial: could not find pctldev for node /soc/pinctrl at 1000000/serial_pinmux, deferring probe
> > > | [    1.322415] spi_qup 78b5000.spi: could not find pctldev for node /soc/pinctrl at 1000000/spi_0_pinmux, deferri
> > >
> > > This was also verified on a RT-AC58U (IPQ4018) which would
> > > no longer boot, if a gpio-hog was specified. (Tried forcing
> > > the USB LED PIN (GPIO0) to high.).
> > >
> > > The problem is that Pinctrl+GPIO registration is currently
> > > peformed in the following order in pinctrl-msm.c:
> > >         1. pinctrl_register()
> > >         2. gpiochip_add()
> > >         3. gpiochip_add_pin_range()
> > >
> > > The actual error code -517 == -EPROBE_DEFER is coming from
> > > pinctrl_get_device_gpio_range(), which is called through:
> > >         gpiochip_add
> > >             of_gpiochip_add
> > >                 of_gpiochip_scan_gpios
> > >                     gpiod_hog
> > >                         gpiochip_request_own_desc
> > >                             __gpiod_request
> > >                                 chip->request
> > >                                     gpiochip_generic_request
> > >                                        pinctrl_gpio_request
> > >                                           pinctrl_get_device_gpio_range
> > >
> > > pinctrl_get_device_gpio_range() is unable to find any valid
> > > pin ranges, since nothing has been added to the pinctrldev_list yet.
> > > so the range can't be found, and the operation fails with -EPROBE_DEFER.
> > >
> > > This patch fixes the issue by adding the "gpio-ranges" property to
> > > the pinctrl device node of all upstream Qcom SoC. The pin ranges are
> > > then added by the gpio core.
> > >
> > > In order to remain compatible with older, existing DTs (and ACPI)
> > > a check for the "gpio-ranges" property has been added to
> > > msm_gpio_init(). This prevents the driver of adding the same entry
> > > to the pinctrldev_list twice.
> > >
> > > Reported-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
> > > Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> > 
> > This patch looks VERY good to me.
> > 
> 
> Why can't we register the gpiochip and tell it about the pin ranges in
> one API call instead of adding the chip and then adding the ranges? It
> doesn't look right to have to go and update all the DT nodes to list
> this information that is already known in the driver because the kernel
> implementation can't handle the order of operations correctly.
The problem is that gpiochip_add_pin_range() was not intended for
DT-based pinctrls... but it got used anyway.

This topic came up in an earlier post:
"Re: pinctrl: qcom: ipq4019: Use of gpio-hog's" [0] (you must have gotten
this mail too, since you are on the Cc.) which links to a ML thread titled
"Re: [GIT PULL] SPEAr pinctrl updates for v-3.5" 

For your convenience: (this post is from 2012-09-03 - so it's 5-6 years
old by now and it looks like it predates even the DT pinctrl-msm driver.
(Not entirely sure?))
<http://thread.gmane.org/gmane.linux.ports.arm.kernel/184943>
|[...]
|But I want two similar function named:
|
|gpiochip_add_pin_range();
|gpiochip_remove_pin_range();
|
|*that can be used for platforms that doesn't support DT.*
|
|For example I'd like to convert over some of my existing
|drivers that do not have DT support to do this thing instead
|of registering ranges from the pin controller...

I think you must have come across similar issues with the
"gpio-reserved-ranges" property you recently added. Because
from what I can glimpse from the
"[2/3] dt-bindings: pinctrl: Add a ngpios-ranges property" 
<https://patchwork.kernel.org/patch/10153785/> series.
The gpio-reserved-ranges property would also need to be added
to existing products (msm8996) as well, right?
("I stuck this inside msm8996, but maybe it can go somewhere more generic?")

> Furthermore, it looks like this becomes a silent requirement to add the
> gpio-ranges property into the DT so that hogs work, but none of the
> bindings have been updated in this patch to indicate that.
The pinctrl-msm.c driver will fallback to using gpiochip_add_pin_range(),
if the gpio-ranges property is not present. So all existing and compiled 
devicetree binaries files will remain compatible.

As for adding the gpio-ranges to the dt binding text files under
Documentation/devicetree/bindings/pinctrl/: Sure. No problem. I can add
them too :).

But I do have a question: Should I also include the missing declaration
of the gpio-reserved-ranges properties too? (I can make the patches over
the long weekend. If I hear nothing from anyone, I'll post them on Monday).

(Also, it looks like the nvidia tegra pinctrl-driver has the gpio-ranges
property in the DTS, but not in the binding documentation. I'll add
that to the nvidia pile.)

Thanks,
Christian

[0] <https://www.spinics.net/lists/linux-arm-msm/msg34833.html>
