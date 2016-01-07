From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 7 Jan 2016 08:18:02 -0600
Subject: [PATCH v2 0/3] USB: add generic onboard USB HUB driver
In-Reply-To: <20160106032027.GA23726@shlinux2>
References: <CAL411-rK6qfkbQsSjvXH5VPAQAm4tMyD6fVTEgFQrpLHNGMXeA@mail.gmail.com>
 <Pine.LNX.4.44L0.1512181030590.1682-100000@iolanthe.rowland.org>
 <CAL411-qKE=12VZAN9=tUWPqkC5BfSgpQb9aNgCU6rmPLasXNHQ@mail.gmail.com>
 <CAL_Jsq+P8SBmWzNURrmNgz8soCn4QPOPid4SXF0a3TYL_SH27A@mail.gmail.com>
 <20160106032027.GA23726@shlinux2>
Message-ID: <CAL_Jsq+rqv1NBSUToX5BsbnBp_goUWhdczU7ETSxOrJ5D4D1rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 5, 2016 at 9:20 PM, Peter Chen <hzpeterchen@gmail.com> wrote:
> On Tue, Jan 05, 2016 at 08:36:31AM -0600, Rob Herring wrote:
>> > 2. There are MFD USB devices, which includes several interfaces under
>> > USB device,
>> > like i2c, gpios, etc. Due to lack of device tree support, USB
>> > class/device driver doesn't know
>> > which kinds of interfaces are needed for this board.
>>
>> Are you talking about a device hard wired on the same board or
>> something like GPIOs on FTDI chip which could be hot-plugged in any
>> host (including non-DT based)?
>
> I talked about the case that the device hard wired on the board.
> Hot-plug device's bus topology is unknown, we can't describe it
> statically at dts.

Correct, upstream (the USB side) can't be described, but it is the
downstream side we care about describing.

>> For the hotplug case, we will need a way to associate a DT overlay
>> with the USB device and there may not even be a base DT to map the
>> overlay into. In this case, the USB device's driver will need to load
>> the overlay and trigger enumerating the child devices. Anyway, this is
>> a separate issue from your problem.
>>
>
> Since both you and Alan agree with my problem should be fixed at
> bootloader, I give the kernel solution up.

Surprising, no one ever seems to agree with that solution... There
will be people with this problem and unable to update their
bootloader.

> The another thing I open to discuss is how to let USB devices know its
> device node, the user reported issue that they can't handle interfaces
> below in USB device since that.

The driver for the USB device would need to load a DT overlay and from
that it should be able to get its node and child nodes. The hard part
is figuring out where to put the sub tree defined in the overlay as
either there is no base DT (think x86) or there is but we don't want
to describe the whole USB bus topology in DT (in theory we could
populate USB nodes dynamically as USB devices are discovered).

Rob
