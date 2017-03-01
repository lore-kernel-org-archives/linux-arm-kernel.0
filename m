From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 1 Mar 2017 18:46:56 +0530
Subject: [PATCH v2 3/3] media: dt-bindings: vpif: new optional property
In-Reply-To: <CAMpxmJW4Rd6UvdkeS6GLOJeiGMV_XVTznL5T2L3+K9UgE=bWkw@mail.gmail.com>
References: <1487771027-7763-1-git-send-email-bgolaszewski@baylibre.com>
 <1487771027-7763-4-git-send-email-bgolaszewski@baylibre.com>
 <20170227225209.26oieqwbafqjga2a@rob-hp-laptop>
 <6b392a4a-2de8-9981-ad40-ca7201bf813d@ti.com>
 <CAMpxmJW4Rd6UvdkeS6GLOJeiGMV_XVTznL5T2L3+K9UgE=bWkw@mail.gmail.com>
Message-ID: <2aeaecfd-b3a8-99a8-0530-9d221a9127dd@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 February 2017 04:30 PM, Bartosz Golaszewski wrote:
> 2017-02-28 6:36 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
>> On Tuesday 28 February 2017 04:22 AM, Rob Herring wrote:
>>> On Wed, Feb 22, 2017 at 02:43:47PM +0100, Bartosz Golaszewski wrote:
>>>> Add an optional property - enable-gpios - which can be used to specify
>>>> the GPIOs that must be requested to select the vpif functionality.
>>>>
>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/media/ti,da850-vpif.txt | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/media/ti,da850-vpif.txt b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
>>>> index df7182a..23c5405 100644
>>>> --- a/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
>>>> +++ b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
>>>> @@ -13,6 +13,9 @@ Required properties:
>>>>  - reg: physical base address and length of the registers set for the device;
>>>>  - interrupts: should contain IRQ line for the VPIF
>>>>
>>>> +Optional properties:
>>>> +- enable-gpios: phandle of the GPIOs used to select the vpif functionality
>>>
>>> What does this control exactly? The GPIOs belong in the node they are
>>> connected to and having GPIOs routed to this block seems strange.
>>
>> The DA850 EVM board implements on-board muxing which lets the video
>> input (via VPIF) to be routed to a TVP5147 (video decoder) for composite
>> input or to a camera header. There are other mux options which use the
>> same VPIF SoC pins (RMII ethernet or character LCD).
>>
>> There is a three-to-eight demux on the board which drives enable signals
>> to buffers letting you choose from these options.
>>
>> From your response, it looks like you want the enable-gpios property to
>> be in the TVP5147 or camera node. That does make sense to me.
>>
> 
> Wouldn't that cause races again? The TVP5147 ADC is probed from within
> the vpif driver as a media subdev (after initialize_vpif(),
> v4l2_device_register(), irq requests etc.).

When TVP5147 probe fails with -EPROBE_DEFER, I assume the error can
propagate back to vpif_probe() which would then de-register the V4L2
device as part of probe error unwinding. That should then allow the
probe to be retried at a later time.

Thanks,
Sekhar

> 
> Thanks,
> Bartosz
> 
