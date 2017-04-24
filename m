From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 24 Apr 2017 08:02:39 -0500
Subject: [PATCH v2 1/5] dt-bindings: gpu: add bindings for the ARM Mali
 Midgard GPU
In-Reply-To: <92e0492a-bd17-0171-10a3-8af5044ba6cc@collabora.com>
References: <cover.1491118230.git.guillaume.tucker@collabora.com>
 <a01a50d3-bb1b-2c56-2a15-30651fa2fac9@baylibre.com>
 <936a53ee-2ed8-11e4-a860-744256676af9@collabora.com>
 <8676554.1IW2xieEGM@diego>
 <7a875b2d-f288-8136-de04-11e744f0118b@collabora.com>
 <e8ff3ab8-3bf8-d731-a987-3bb8442cfc0a@baylibre.com>
 <92e0492a-bd17-0171-10a3-8af5044ba6cc@collabora.com>
Message-ID: <CAL_Jsq+G46_hYV9s+emxUGPjJSFDMEhsvZFDu_gs7gK_nC34kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 4:36 AM, Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
> Hi Neil,
>
>
> On 12/04/17 09:48, Neil Armstrong wrote:
>>
>> Hi Guillaume,
>>
>> On 04/12/2017 10:25 AM, Guillaume Tucker wrote:
>>>
>>> Hi Heiko,
>>>
>>> On 11/04/17 21:52, Heiko St?bner wrote:
>>>>
>>>> Hi Guillaume,
>>>>
>>>> Am Dienstag, 11. April 2017, 18:40:37 CEST schrieb Guillaume Tucker:
>>>>>
>>>>> On 03/04/17 09:12, Neil Armstrong wrote:
>>>>>>
>>>>>> On 04/02/2017 09:59 AM, Guillaume Tucker wrote:
>>>>>>>
>>>>>>> +Optional:
>>>>>>> +
>>>>>>> +- clocks : Phandle to clock for the Mali Midgard device.
>>>>>>> +- clock-names : Shall be "clk_mali".
>>>>>>> +- mali-supply : Phandle to regulator for the Mali device. Refer to
>>>>>>> +  Documentation/devicetree/bindings/regulator/regulator.txt for
>>>>>>> details.
>>>>>>> +- operating-points : Refer to
>>>>>>> Documentation/devicetree/bindings/power/opp.txt +  for details.
>>>>>>
>>>>>>
>>>>>> Please add :
>>>>>>    * Must be one of the following:
>>>>>>       "arm,mali-t820"
>>>>>>
>>>>>>    * And, optionally, one of the vendor specific compatible:
>>>>>>       "amlogic,meson-gxm-mali"
>>>>>>
>>>>>> with my Ack for the amlogic platform.
>>>>>
>>>>>
>>>>> It seems to me that as long as the GPU architecture hasn't been
>>>>> modified (I don't think I've ever encountered such a case) then
>>>>> it has to be a standard ARM Mali type regardless of the SoC
>>>>> vendor.  So unless a Mali-T820 in the Amlogic S912 SoC is not the
>>>>> same as a T820 in a different SoC, please forgive me but I don't
>>>>> understand why a vendor compatible string is needed.  My main
>>>>> concern is that it's going to be very hard to keep that list
>>>>> up-to-date with all existing Midgard SoC variants.  If do we need
>>>>> to add vendor compatible strings to correctly describe the
>>>>> hardware then I'm happy to add the amlogic one in my patch v3; I
>>>>> would just like to understand why that's necessary.
>>>>
>>>>
>>>> SoC vendors in most cases hook ip blocks into their socs in different
>>>> and often strange ways. After all it's not some discrete ic you solder
>>>> onto a board, but instead a part of the soc itself.
>>>
>>>
>>> Thanks for your explanation.  I see, it's really about special
>>> things that are not supported by the standard Midgard kernel
>>> driver.
>>>
>>>> So in most cases you will have some hooks outside the actual gpu iospace
>>>> that can be used to tune different things about how the gpu interacts
>>>> with
>>>> the system. Which is probably also the reason the midgard kernel driver
>>>> has this ugly "platform" subdirectory for compile-time platform
>>>> selection.
>>>
>>>
>>> I see the "platform" directory approach as an old and deprecated
>>> way of supporting platforms, upstreaming the dt bindings goes in
>>> the direction of using solely the device tree to describe the GPU
>>> hardware (i.e. CONFIG_MALI_PLATFORM_DEVICETREE).  If something
>>> quirky is needed in the platform, it should be possible to
>>> support it outside the GPU driver (platform devfreq etc...).
>>
>>
>> If this was so simple...
>>
>> This is why the "vendor" compatible is optional.
>>
>> And on another side, the binding were written by ARM, are may not be
>> compatible with how the mainline Linux handles these uses-cases.
>>
>> ARM added some tweaks to handle some weird integration using DT
>> properties,
>> but this should definitely go in platform specific code instead.
>
>
> OK, sorry I was approaching the issue from a completely different
> and somewhat more idealistic angle.  My impression is that if the
> driver was in mainline then it would be maintained in such a way
> that vendor compatible strings would not be required, but this is
> all hypothetical.
>
> So in practice, I think I now better understand why vendor
> compatible strings may still be needed.  And they're optional, so
> harmless to other platforms, so it's all fine with me :)

SoC specific compatibles are required. They are only optional for a
driver to use.

Rob
