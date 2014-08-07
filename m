From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 07 Aug 2014 10:40:36 +0200
Subject: [PATCH v6 00/10] ARM: dts: exynos: Prepare Spring
In-Reply-To: <CAD=FV=WFNW_5KZvLMk0kK1JQsdWLeo2kCjpQsFuxKNSnOKzfgw@mail.gmail.com>
References: <1406940750-15880-1-git-send-email-afaerber@suse.de>	<53DC4E41.4050200@collabora.co.uk>	<CAD=FV=V_vXZLMaTMFdgr62=zRXucZA6D3PvS0Mb40he0ShHTfA@mail.gmail.com>	<53DCBC84.8080600@suse.de>
 <CAD=FV=WFNW_5KZvLMk0kK1JQsdWLeo2kCjpQsFuxKNSnOKzfgw@mail.gmail.com>
Message-ID: <53E33B84.2010108@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 08/04/2014 05:42 PM, Doug Anderson wrote:
> 
> 
>> For the touchpad it seems DT support has landed in the input tree as
>> "atmel,maxtouch". Backporting just that patch does not make it work
>> though. (Tried the rejected pinctrl approach to be on the safe side.)
>> https://code.google.com/p/chromium/issues/detail?id=371114
>> https://patchwork.kernel.org/patch/3976801/
> 
> This is the same work as needed for pit and pi, I believe.  Perhaps
> Javier or Dmitry has this on their todo list?
> 
> 

I posted a couple of patches that allowed me to have the atmel touchpad working
on Peach Pit. I found two issues while testing the driver:

a) The device keycode event capabilities are hardcoded in the downstream Chrome
OS driver while the mainline driver expect these to be defined in the DT. The
property is called "linux,gpio-keymap" since it seems that the actual
implementation is using a set of GPIOs. But this is handled by the firmware
since the kernel just read a status register from the atmel T9 object.

I found the property confusing at first since it didn't have anything to do with
Linux GPIO so posted a patch to add an example to the DT binding doc in order to
make it easier to understand [0].

b) The driver overwrites the edge/level flags parsed by OF core and expects that
the IRQ type will be passed using platform data. The downstream Chrome OS driver
defaults the type to IRQF_TRIGGER_FALLING if this is not provided while the
mainline does not have a default so it's just 0 (IRQ_TYPE_NONE).

This is fixed by reading back the IRQ type from the struct irq_data when parsing
the DT data [1].

The DTS changes to make the atmel touchpad work on Peach Pit were posted in [2].
Changes for Pi were included as well since it should be the same but it was not
tested since I don't have access to that machine, testing will be highly
appreciated.

> 
> -Doug
> 

Thanks a lot and best regards,
Javier

[0]: https://lkml.org/lkml/2014/8/6/584
[1]: https://lkml.org/lkml/2014/8/7/82
[2]: https://lkml.org/lkml/2014/8/6/589
