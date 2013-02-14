From: dianders@chromium.org (Doug Anderson)
Date: Wed, 13 Feb 2013 16:38:34 -0800
Subject: [PATCH v1 2/4] ARM: dts: Add i2c-arbitrator bus for
 exynos5250-snow
In-Reply-To: <511BFFD2.8090102@wwwdotorg.org>
References: <1360778532-7480-1-git-send-email-dianders@chromium.org>
 <1360778532-7480-2-git-send-email-dianders@chromium.org>
 <511BFFD2.8090102@wwwdotorg.org>
Message-ID: <CAD=FV=XLMYAyW7W3PtoUmROOgttuypHKNWtrcALw3t6jdyEDPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,


On Wed, Feb 13, 2013 at 1:04 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 02/13/2013 11:02 AM, Doug Anderson wrote:
>> We need to use the i2c-arbitrator to talk to any of the devices on i2c
>> bus 4 on exynos5250-snow so that we don't confuse the embedded
>> controller (EC).  Add the i2c-arbitrator to the device tree.  As we
>> add future devices (keyboard, sbs, tps65090) we'll add them on top of
>> this.
>>
>> The arbitrated bus is numbered 104 simply as a convenience to make it
>> easier for people poking around to guess that it might have something
>> to do with the physical bus 4.
>>
>> The addition is split between the cros5250-common and the snow device
>> tree file since not all cros5250-class devices use arbitration.
>
>> diff --git a/arch/arm/boot/dts/cros5250-common.dtsi b/arch/arm/boot/dts/cros5250-common.dtsi
>
>>       i2c at 12CA0000 {
>> -             status = "disabled";
>> +             samsung,i2c-sda-delay = <100>;
>> +             samsung,i2c-max-bus-freq = <66000>;
>
> Shouldn't that use the standard clock-frequency property?

At the moment this is the way that you specify it for the i2c
controller we're using...


>> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
>
>> +     i2c-arbitrator {
>> +             compatible = "i2c-arbitrator";
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>
>> +             /* Use ID 104 as a hint that we're on physical bus 4 */
>> +             i2c_104: i2c at 0 {
>
> Does something use that hint? It sounds a little odd.

The i2c bus numbering patches will end up creating "/dev/i2c-104".
...so the hint is really for developers who are poking around.  It's
definitely a strange number and that's part of the point.  Right now
there's nothing preventing someone from using 'i2cdetect' or 'i2cget'
on bus 4 and bypassing arbitration.  My hope was that having something
crazy like "104" would help someone realize that it's a bad idea.

...besides, if I don't come up with _some_ number then this will get
assigned the first unused ID which could be extra confusing.

-Doug
