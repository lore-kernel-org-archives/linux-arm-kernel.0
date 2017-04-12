From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Wed, 12 Apr 2017 09:25:35 +0100
Subject: [PATCH v2 1/5] dt-bindings: gpu: add bindings for the ARM Mali
 Midgard GPU
In-Reply-To: <8676554.1IW2xieEGM@diego>
References: <cover.1491118230.git.guillaume.tucker@collabora.com>
 <a01a50d3-bb1b-2c56-2a15-30651fa2fac9@baylibre.com>
 <936a53ee-2ed8-11e4-a860-744256676af9@collabora.com>
 <8676554.1IW2xieEGM@diego>
Message-ID: <7a875b2d-f288-8136-de04-11e744f0118b@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 11/04/17 21:52, Heiko St?bner wrote:
> Hi Guillaume,
>
> Am Dienstag, 11. April 2017, 18:40:37 CEST schrieb Guillaume Tucker:
>> On 03/04/17 09:12, Neil Armstrong wrote:
>>> On 04/02/2017 09:59 AM, Guillaume Tucker wrote:
>>>> +Optional:
>>>> +
>>>> +- clocks : Phandle to clock for the Mali Midgard device.
>>>> +- clock-names : Shall be "clk_mali".
>>>> +- mali-supply : Phandle to regulator for the Mali device. Refer to
>>>> +  Documentation/devicetree/bindings/regulator/regulator.txt for details.
>>>> +- operating-points : Refer to
>>>> Documentation/devicetree/bindings/power/opp.txt +  for details.
>>>
>>> Please add :
>>>    * Must be one of the following:
>>>       "arm,mali-t820"
>>>
>>>    * And, optionally, one of the vendor specific compatible:
>>>       "amlogic,meson-gxm-mali"
>>>
>>> with my Ack for the amlogic platform.
>>
>> It seems to me that as long as the GPU architecture hasn't been
>> modified (I don't think I've ever encountered such a case) then
>> it has to be a standard ARM Mali type regardless of the SoC
>> vendor.  So unless a Mali-T820 in the Amlogic S912 SoC is not the
>> same as a T820 in a different SoC, please forgive me but I don't
>> understand why a vendor compatible string is needed.  My main
>> concern is that it's going to be very hard to keep that list
>> up-to-date with all existing Midgard SoC variants.  If do we need
>> to add vendor compatible strings to correctly describe the
>> hardware then I'm happy to add the amlogic one in my patch v3; I
>> would just like to understand why that's necessary.
>
> SoC vendors in most cases hook ip blocks into their socs in different
> and often strange ways. After all it's not some discrete ic you solder
> onto a board, but instead a part of the soc itself.

Thanks for your explanation.  I see, it's really about special
things that are not supported by the standard Midgard kernel
driver.

> So in most cases you will have some hooks outside the actual gpu iospace
> that can be used to tune different things about how the gpu interacts with
> the system. Which is probably also the reason the midgard kernel driver
> has this ugly "platform" subdirectory for compile-time platform selection.

I see the "platform" directory approach as an old and deprecated
way of supporting platforms, upstreaming the dt bindings goes in
the direction of using solely the device tree to describe the GPU
hardware (i.e. CONFIG_MALI_PLATFORM_DEVICETREE).  If something
quirky is needed in the platform, it should be possible to
support it outside the GPU driver (platform devfreq etc...).

Back to the original intent of enabling distros to make Mali GPU
driver packages, when using the device tree you can have a single
kernel driver package for all Midgard platforms.  When using the
third-party platform sources approach, you need to make an extra
package for each one of them.

So if there is value in supporting platforms that absolutely
require something special due to their hardware GPU integration,
then yes I see why vendor dt bindings might be useful.  However
it seems to me that this should really be an exception and
avoided whenever possible.

> On my rk3288 for example we have [0] in the chromeos tree, that handles
> the oddities of the midgard on the rk3288 used in a lot of Chromebooks.
> There are soc-specific oddities of frequencies, frequency-scaling and
> whatnot. And there are also more gpu-specific setting in syscon areas
> of the soc (pmu and grf) that can also influence the gpus performance
> and might need tweaking at some point.

For the rk3288, this is purely a software implementation issue on
the chromeos-3.14 branch.  With mainline kernel, you can use
devfreq and no platform files at all (that's how I tested these
dt bindings).  So as far as I know, there's no need for a vendor
compatible string on rk3288.

> That doesn't even take into account that there may even be differences
> on how things are synthesized that we don't know about. See all the
> variants of the dw_hdmi ip block (imx, rockchip, meson [more?]) .

I'm not too familiar with that driver, just had a quick look and
it seems to be a different issue as there's a kernel config for
each platform to build separate driver modules.  And it looks
like they are actually needed to cope with variants of the
hardware inside the display processor block, unlike with the Mali
GPU which in principle should always be the same.  I've run this
Midgard driver without any platform files and using devfreq at
least on rk3288 Firefly, Exynos 5422 ODROID-XU3 and Juno and they
all have a vanilla Mali GPU hw block.  It's just wired
differently in each SoC.

> So we really want to have the special compatibles in place, to be prepared
> for the future per-soc oddities that always appear :-) .

How about aiming for the ideal case where vendor-specific things
are not needed and add them if and when they really become
inevitable and worth the cost?

Thanks,
Guillaume

> [0] https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14/drivers/gpu/arm/midgard/platform/rk/
