From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Wed, 5 Oct 2016 10:15:45 +0530
Subject: PROBLEM: DWC3 USB 3.0 not working on Odroid-XU4 with Exynos 5422
In-Reply-To: <CANAwSgQ2j+NtDwgn972-1UdY=j4DEsB+0d7VdhoC9i9WHRc9yQ@mail.gmail.com>
References: <1472414695.3845.3.camel@mniewoehner.de>
 <87lgzgdof3.fsf@linux.intel.com>
 <57C41582.1030604@linux.intel.com> <1472468730.4925.3.camel@mniewoehner.de>
 <CANAwSgQMsK8YPxR==UXtR49kiJzYhkzvSCNwn8mDJfj-3wpa2w@mail.gmail.com>
 <CAFp+6iGrS0DTP=KUKDvk3NwWB32+1uj-irKT6fn5XTcfk572Hg@mail.gmail.com>
 <1475578687.1912.28.camel@mniewoehner.de>
 <CAFp+6iGx-jf+xrdHF=0J3FK9dDBg54zESYNVo8bz2Qz6G4gEZg@mail.gmail.com>
 <CANAwSgQ2j+NtDwgn972-1UdY=j4DEsB+0d7VdhoC9i9WHRc9yQ@mail.gmail.com>
Message-ID: <CAFp+6iE6aqvOKE4HVCeCokPk_oTHLduS6Gsv+CF4_p4JjkF2TQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anand,


On Tue, Oct 4, 2016 at 8:39 PM, Anand Moon <linux.amoon@gmail.com> wrote:
> Hi Vivek,
>

[snip]

>
> What I feel is that their need to be some reset of usb phy so that
> device are assigned to respective bus ports.

The phy resets are what we do in the phy-exynos5-usbdrd driver. In
addition to what we
have currently in this phy driver, we just need the phy calibration
patch [1] for phy configurations.

[1] https://lkml.org/lkml/2015/2/2/259

> odroid at odroid:~$ lsusb -t
> /:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
> /:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
>     |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 480M

This shows the ethernet device gets detected on the high-speed port of one
of the controller.
The lsusb output for kernel v4.7.x posted by Michael show that the
ethernet device got detected on super-speed port of the controller.
So, there seems to be a difference between the two.
Or, is this how it is behaving ?

Is this lsusb output on 4.8 kernel with the patch [1] ?

> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 5000M
>         |__ Port 1: Dev 3, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
>         |__ Port 2: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
> /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 480M
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=exynos-ehci/3p, 480M
>     |__ Port 1: Dev 3, If 0, Class=Mass Storage, Driver=usb-storage, 480M
>
>
> Bus 06.Port should register the Realtek Ethernet r8153 device.
> But I am not able to trace out how it's should happen.

If i understand, below is how the configuration looks like on the board?

                +-----------------------+
        +------>|                       |
        |       |       Bus 6           |-------+
+-----------+   |    (super-speed)      |       |
|           |   +-----------------------+       |
|Controller |                                   | --------> Ethernet device
|    2      |                                   |
|           |   +-----------------------+       |
+-----------+   |                       |       |
        |       |       Bus 5           |-------+
        +------>|   (high-speed)        |
                +-----------------------+


                +-----------------------+
        +------>|                       |
        |       |       Bus 4           |-------+
+-----------+   |    (super-speed)      |       |
|           |   +-----------------------+       |
|Controller |                                   | --------> (On board
hub ?? _OR_ external hub with downstream devices) ???
|    1      |                                   |
|           |   +-----------------------+       |
+-----------+   |                       |       |
        |       |       Bus 3           |-------+
        +------>|   (high-speed)        |
                +-----------------------+


Thanks
Vivek


--
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
