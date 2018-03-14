From: mdharm-usb@one-eyed-alien.net (Matthew Dharm)
Date: Tue, 13 Mar 2018 23:53:15 -0700
Subject: [PATCH] Add Apple Carplay driver
In-Reply-To: <1521007356-12306-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1521007356-12306-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <CAA6KcBAnLYZ2UyUB6Ecv96D0zWhmce2BMmA_iWx04njeNYsd9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Why is this a kernel-level driver, rather than a userspace application
that uses libusb to send the single vendor-specific command required?
Since this command would be applicable to many CarPlay devices, with
many different VID/PIDs, it would seem to make more sense as a
userspace app that took a reference to a USB device or VID/PID.

Matt

On Tue, Mar 13, 2018 at 11:02 PM, Chunfeng Yun
<chunfeng.yun@mediatek.com> wrote:
> From bf48dcd9cb254576cfea373c9a5d2ab996408895 Mon Sep 17 00:00:00 2001
> From: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Date: Tue, 13 Mar 2018 11:47:38 +0800
> Subject: [PATCH] Add Apple Carplay driver
>
> Some Apple devices which support Carplay can enter USB Host Mode from USB
> Device Mode after receiving a specific USB Vendor Request. There is a
> requirement apply to accesssories that support the USB dual role switch
> feature, and must have a USB-A receptacle that is capable of functioning
> in both USB Host and USB Device roles.
> It means that the driver should supports manual Dual-Role switch, due to
> no IDDIG pin is avaliable.
>
> There is no suitable place to add this spicific USB Vendor Request, so
> here I extract a single driver which allow user force to send it by a debug
> interface when need it, and keep it independent on USB Dual-Role Controller
> Drivers.
> But to implement carplay feature, there are some requirments for USB Dual-Role
> Driver:
> 1. supports manual dual-role switch, such as, by a debug interface;
> 2. keep vbus alive even when switch host into device mode;
>
> More information please refer to "Chapter 46. USB Role Switch" in
> MFI Accessroy Interface Specification.pdf
>
> Chunfeng Yun (1):
>   usb: misc: supports Apple Carplay driver
>
>  drivers/usb/misc/Kconfig   |    9 +++
>  drivers/usb/misc/Makefile  |    1 +
>  drivers/usb/misc/carplay.c |  193 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 203 insertions(+)
>  create mode 100644 drivers/usb/misc/carplay.c
>
> --
> 1.7.9.5
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Matthew Dharm
Former Maintainer, USB Mass Storage driver for Linux
