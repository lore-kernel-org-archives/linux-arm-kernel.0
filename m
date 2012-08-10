From: p.paneri@samsung.com (Praveen Paneri)
Date: Fri, 10 Aug 2012 13:06:42 +0530
Subject: [PATCH v4 1/5] usb: phy: samsung: Introducing usb phy driver for
 hsotg
In-Reply-To: <CAAe_U6K=h7gP+fTQTkzP_WQfccVMYhG+UtsLprDMrsozuBywoQ@mail.gmail.com>
References: <1344582631-13658-1-git-send-email-p.paneri@samsung.com>
 <1344582631-13658-2-git-send-email-p.paneri@samsung.com>
 <CAAe_U6K=h7gP+fTQTkzP_WQfccVMYhG+UtsLprDMrsozuBywoQ@mail.gmail.com>
Message-ID: <CAD6zSYOSfkuEO7Bv+AFLrHKiFMj77v+EMYVjGrAytGTCurLPuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2012 at 12:49 PM, ABRAHAM, KISHON VIJAY <kishon@ti.com> wrote:
> Hi,
>
> On Fri, Aug 10, 2012 at 12:40 PM, Praveen Paneri <p.paneri@samsung.com> wrote:
>> This driver uses usb_phy interface to interact with s3c-hsotg. Supports
>> phy_init and phy_shutdown functions to enable/disable phy. Tested with
>> smdk6410 and smdkv310. More SoCs can be brought under later.
>>
>> Signed-off-by: Praveen Paneri <p.paneri@samsung.com>
>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>  .../devicetree/bindings/usb/samsung-usbphy.txt     |    9 +
>>  drivers/usb/phy/Kconfig                            |    8 +
>>  drivers/usb/phy/Makefile                           |    1 +
>>  drivers/usb/phy/samsung-usbphy.c                   |  345 ++++++++++++++++++++
>>  drivers/usb/phy/samsung-usbphy.h                   |   48 +++
>>  include/linux/platform_data/samsung-usbphy.h       |   27 ++
>>  6 files changed, 438 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/usb/samsung-usbphy.txt
>>  create mode 100644 drivers/usb/phy/samsung-usbphy.c
>>  create mode 100644 drivers/usb/phy/samsung-usbphy.h
>>  create mode 100644 include/linux/platform_data/samsung-usbphy.h
>>
>> diff --git a/Documentation/devicetree/bindings/usb/samsung-usbphy.txt b/Documentation/devicetree/bindings/usb/samsung-usbphy.txt
>> new file mode 100644
>> index 0000000..fefd9c8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/samsung-usbphy.txt
>> @@ -0,0 +1,9 @@
>> +* Samsung's usb phy transceiver
>> +
>> +The Samsung's phy transceiver is used for controlling usb otg phy for
>> +s3c-hsotg usb device controller.
>> +
>> +Required properties:
>> +- compatible : should be "samsung,exynos4210-usbphy"
>> +- reg : base physical address of the phy registers and length of memory mapped
>> +       region.
>> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
>> index e7cf84f..d916477 100644
>> --- a/drivers/usb/phy/Kconfig
>> +++ b/drivers/usb/phy/Kconfig
>> @@ -15,3 +15,11 @@ config USB_ISP1301
>>
>>           To compile this driver as a module, choose M here: the
>>           module will be called isp1301.
>> +
>> +config SAMSUNG_USBPHY
>> +       bool "Samsung USB PHY controller Driver"
>> +       depends on USB_S3C_HSOTG
>> +       select USB_OTG_UTILS
>> +       help
>> +         Enable this to support Samsung USB phy controller for samsung
>> +         SoCs.
>> diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
>> index eca095b..dfca70d 100644
>> --- a/drivers/usb/phy/Makefile
>> +++ b/drivers/usb/phy/Makefile
>> @@ -5,3 +5,4 @@
>>  ccflags-$(CONFIG_USB_DEBUG) := -DDEBUG
>>
>>  obj-$(CONFIG_USB_ISP1301)              += isp1301.o
>> +obj-$(CONFIG_SAMSUNG_USBPHY)           += samsung-usbphy.o
>> diff --git a/drivers/usb/phy/samsung-usbphy.c b/drivers/usb/phy/samsung-usbphy.c
>> new file mode 100644
>> index 0000000..739b6c9
>> --- /dev/null
>> +++ b/drivers/usb/phy/samsung-usbphy.c
>> @@ -0,0 +1,345 @@
>> +/* linux/drivers/usb/phy/samsung-usbphy.c
>> + *
>> + * Copyright (c) 2012 Samsung Electronics Co., Ltd.
>> + *              http://www.samsung.com
>> + *
>> + * Author: Praveen Paneri <p.paneri@samsung.com>
>> + *
>> + * Samsung USB2.0 High-speed OTG transceiver, talks to S3C HS OTG controller
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>
> I suggest you drop that last paragraph unless you want to keep track
> of Free Software Foundation office. Right now it is 51 Franklin
> Street, Boston (http://www.fsf.org/about/contact/) :-)
Yeah! it can be dropped :-)

Praveen
>
> -Kishon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
