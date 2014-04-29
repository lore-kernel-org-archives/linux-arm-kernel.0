From: yegorslists@googlemail.com (Yegor Yefremov)
Date: Tue, 29 Apr 2014 08:16:15 +0200
Subject: [PATCH] ARM: dts: am33xx: fix DMA support for the second USB
 interface
In-Reply-To: <535F2B19.7020300@ti.com>
References: <1398674237-4129-1-git-send-email-yegorslists@googlemail.com>
 <535E64EF.2020108@ti.com>
 <CAGm1_kt_yQZowthaFq=imM5J6=1FkJX_1LtRV7eEiqeursbDZQ@mail.gmail.com>
 <535F2B19.7020300@ti.com>
Message-ID: <CAGm1_kvBbT6bjUMitwP5jLYjFfT-yAixUEQu6u7AudOJgAXSMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 6:31 AM, George Cherian <george.cherian@ti.com> wrote:
> On 4/28/2014 9:47 PM, Yegor Yefremov wrote:
>>
>> On Mon, Apr 28, 2014 at 4:25 PM, George Cherian <george.cherian@ti.com>
>> wrote:
>>>
>>> On 4/28/2014 2:07 PM, yegorslists at googlemail.com wrote:
>>>>
>>>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>>>
>>>> This patch creates unique DMA channels for the second USB
>>>> interface, otherwise the second USB interface is not usable
>>>> at all.
>>>
>>> MUSB_DMA_NUM_CHANNELS is 15, so if you pass  any dma-names > 15 (>
>>> rx15/tx15),
>>> the dma_controller_create in musb_core.c fails and it falls back to PIO
>>> mode.
>>
>> What's the proper fix for the DMA issue?
>
> I could not understand what issue you are referring to.
> In my setup I use both BBB and BBW (Beagle Bone Black/White)with one USB in
> host (USB1)
> and one USB in gadget (USB0). I dont see any issues with DMA.
>
> Can you be more specific?

I've totally overlooked the DMA channel allocation errors (though usb0
in host mode was working, usb1 in OTG not).

of_get_named_gpiod_flags: can't parse gpios property of node
'/ocp/usb at 47400000/usb-phy at 47401300[0]'
47401300.usb-phy supply vcc not found, using dummy regulator
musb-hdrc musb-hdrc.0.auto: Failed to request rx1.
musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517
platform musb-hdrc.0.auto: Driver musb-hdrc requests probe deferral
of_get_named_gpiod_flags: can't parse gpios property of node
'/ocp/usb at 47400000/usb-phy at 47401b00[0]'
47401b00.usb-phy supply vcc not found, using dummy regulator
musb-hdrc musb-hdrc.1.auto: Failed to request rx1.
musb-hdrc musb-hdrc.1.auto: musb_init_controller failed with status -517
platform musb-hdrc.1.auto: Driver musb-hdrc requests probe deferral

This patch fixes the issue: "ARM: dts: am33xx: Move the cppi41dma node
so it's probed early"

Thanks.

Yegor
