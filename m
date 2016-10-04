From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Tue, 4 Oct 2016 11:32:22 +0530
Subject: PROBLEM: DWC3 USB 3.0 not working on Odroid-XU4 with Exynos 5422
In-Reply-To: <CANAwSgQMsK8YPxR==UXtR49kiJzYhkzvSCNwn8mDJfj-3wpa2w@mail.gmail.com>
References: <1472414695.3845.3.camel@mniewoehner.de>
 <87lgzgdof3.fsf@linux.intel.com>
 <57C41582.1030604@linux.intel.com> <1472468730.4925.3.camel@mniewoehner.de>
 <CANAwSgQMsK8YPxR==UXtR49kiJzYhkzvSCNwn8mDJfj-3wpa2w@mail.gmail.com>
Message-ID: <CAFp+6iGrS0DTP=KUKDvk3NwWB32+1uj-irKT6fn5XTcfk572Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,


On Tue, Aug 30, 2016 at 10:32 AM, Anand Moon <linux.amoon@gmail.com> wrote:
> Hi All
>
> Adding Vivek Gautam.

Sorry for missing out this conversation. I am no longer part of Samsung.

>
> On 29 August 2016 at 16:35, Michael Niew?hner <linux@mniewoehner.de> wrote:
>> Hi Mathias,
>> On Mo, 2016-08-29 at 13:59 +0300, Mathias Nyman wrote:
>>> On 29.08.2016 10:28, Felipe Balbi wrote:
>>> >
>>> >
>>> > Hi,
>>> >
>>> > Michael Niew?hner <linux@mniewoehner.de> writes:
>>> > >
>>> > > [1.] One line summary of the problem:
>>> > > DWC3 USB 3.0 not working on Odroid-XU4 with Exynos 5422
>>> > >
>>> > > [2.] Full description of the problem/report:
>>> > > No usb 3.0 devices are being detected when attached while USB 2.0
>>> > > devices work on the same port.
>>> > > USB 3.0 works after applying patches [9.1] and [9.2], but seems
>>> > > to be
>>> > > buggy. The usb hub is redetected every time an usb device is
>>> > > attached.

[snip]

>>> >
>>> > >
>>> > > [9.] Other notes, patches, fixes, workarounds:
>>> > > [9.1] https://lkml.org/lkml/2014/4/28/234
>>> > > [9.2] https://lkml.org/lkml/2015/2/2/259

These patches are required to get USB super-speed working on Exynos5420/5800.
But they did not make to upstream. There was resistance on adding new
phy_calibrate()
callback.

Without these patches the Exynos5420/5800 will enumerate all
super-speed capable devices
as high-speed devices.
Last time we checked with exynos542x smdk boards and peach-* boards,
we could get the
Super - speed devices working. I have not tested odroid anytime so
don't have much idea about the
its intricacies.
I guess Anand was able to use these patches to get his kernel working in past.

When you have a downstream on-board usb hub, ideally it should be able
to detect the devices
and not reset everytime you connect a new device (like you mentioned earlier).
There can be two possible reasons why the hub keeps getting reset ever
after applying the above
mentioned patches:
1) the clock rates are not proper.
2) the regulator load setting is not enough to drive the hub.

Anand, can you please point Michael to an older kernel with which you
could test usb on odroid successfully ?
You can compare the clocks with an older version and see if there'a
any difference.

Any possibility of any other framework (such as, bus-freq) trimming
down the clock - rates ?


[snip]

>
> There are two dwc3 ports in the SoC : one for Gbit Ethernet another
> one for on-board GL3521 USB 3.0 hub controller.
>
> 3.10.x kernel
> odroid at odroid:~$ lsusb -t
> /:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
>     |__ Port 1: Dev 2, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
> /:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 5000M
> /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 480M
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=s5p-ehci/3p, 480M
>
> 4.x kernel
> odroid at odroid:~$ lsusb -t
> /:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
> /:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
>     |__ Port 1: Dev 2, If 0, Class=Vendor Specific Class, Driver=r8152, 480M
> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 5000M
>         |__ Port 1: Dev 3, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
>         |__ Port 2: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
> /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 480M
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=exynos-ehci/3p, 480M

[snip]

Michael, please paste the output of lsusb -t and/or lsusb -v as well.


Best regards
Vivek

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
