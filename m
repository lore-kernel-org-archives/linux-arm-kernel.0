From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 10 Jul 2014 18:41:55 +0300
Subject: a case for a common efuse API?
In-Reply-To: <20140710142616.GD27469@lukather>
References: <53BC4DD7.20906@codeaurora.org> <20140709083509.GQ13423@lukather>
 <53BDD0F3.7040906@codeaurora.org> <20140710142616.GD27469@lukather>
Message-ID: <53BEB443.9000606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2014 05:26 PM, Maxime Ripard wrote:
> On Wed, Jul 09, 2014 at 04:32:03PM -0700, Stephen Boyd wrote:
>> On 07/09/14 01:35, Maxime Ripard wrote:
>>> Hi Stephen,
>>>
>>> On Tue, Jul 08, 2014 at 01:00:23PM -0700, Stephen Boyd wrote:
>>>> Hi,
>>>>
>>>> On MSM chips we have some efuses (called qfprom) where we store things
>>>> like calibration data, speed bins, etc. We need to read out data from
>>>> the efuses in various drivers like the cpufreq, thermal, etc. This
>>>> essentially boils down to a bunch of readls on the efuse from a handful
>>>> of different drivers. In devicetree this looks a little odd because
>>>> these drivers end up having an extra reg property (or two) that points
>>>> to a register in the efuse and some length, i.e you see this:
>>>>
>>>> 	thermal-sensor at 34000 {
>>>> 		compatible = "sensor";
>>>> 		reg = <0x34000 0x1000>, <0x10018 0xc>;
>>>> 		reg-names = "sensor", "efuse_calib";
>>>> 	}
>>>>
>>>>
>>>> I imagine in DT we want something more like this:
>>>>
>>>> 	efuse: efuse at 10000 {
>>>> 		compatible = "efuse";
>>>> 		reg = <0x10000 0x1000>;
>>>> 	}
>>>>
>>>> 	thermal-sensor at 34000 {
>>>> 		compatible = "sensor";
>>>> 		reg = <0x34000 0x1000>;
>>>> 		efuse = <&efuse 0x18>;
>>>> 	}

Why don't use "syscon" framework for your needs? (mfd/syscon.c)

>>> We have pretty much the same things in the Allwinner SoCs. We have an
>>> efuse directly mapped into memory, with a few informations like a MAC
>>> address, the SoC ID, the serial number, some RSA keys for the device,
>>> etc.
>>>
>>> The thing is, some boards expose these informations in an external
>>> EEPROM as well.
>>>
>>> I started working and went quite far to create an "eeprom" framework
>>> to handle these cases, with a dt representation similar to what you
>>> were exposing.
>>>
>>> https://github.com/mripard/linux/tree/eeprom-framework-at24
>>>
>>> It was working quite well, I was about to send it, but was told that I
>>> should all be moved to MTD, and given up on it.
>>
>> Did anything ever get merged? Or the whole thing was dropped?
>
> Nope, I just never posted it. I could send it as an RFC though, and
> see what are the feedbacks.
>
>> That branch looks like what I want, assuming we could get an agreement
>> on the binding. It looks like pretty much every SoC has this, and there
>> isn't any API or binding for it that I've seen. The only thing I see is
>> Documentation/devicetree/bindings/eeprom.txt and that doesn't cover the
>> client aspect at all.
>>
>> Taking a quick peek at the code, it might be better to change the read
>> API to take a buffer and length, so that the caller doesn't need to free
>> the data allocated by the eeprom layer. It also makes it symmetrical
>> with the write API. We'd probably also need to make it work really early
>> for SoC's like Tegra where we want to read the SoC revision early. So
>> probably split off the device registration part to a later time to allow
>> register() to be called early.
>
> I guess that the kind of things we could discuss after posting these
> patches, but yep, it looks reasonnable.
>
> I'll try to get things a bit cleaner, and post them in the next days.
>

Regards,
-grygorii
