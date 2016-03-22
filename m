From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 22 Mar 2016 15:33:53 +0800
Subject: [linux-sunxi] Re: [PATCH 0/4] Add AXP209 GPIO driver
In-Reply-To: <20160322072214.GJ30977@lukather>
References: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
 <56E0146E.6050102@redhat.com> <20160309152822.GQ8418@lukather>
 <56E044C1.7080300@redhat.com> <20160322072214.GJ30977@lukather>
Message-ID: <CAGb2v67iotNrrSNZ6n1SeHYAn-FoAp5vB+HYp2K580wZ3V9cNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 22, 2016 at 3:22 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Wed, Mar 09, 2016 at 04:44:01PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 09-03-16 16:28, Maxime Ripard wrote:
>> >Hi,
>> >
>> >On Wed, Mar 09, 2016 at 01:17:50PM +0100, Hans de Goede wrote:
>> >>Hi,
>> >>
>> >>On 09-03-16 11:50, Maxime Ripard wrote:
>> >>>Hi,
>> >>>
>> >>>The axp209 PMIC used in combination to some Allwinner SoCs has a bunch
>> >>>of GPIOs accessible. Some boards use these to control their backlight
>> >>>or a few LEDs.
>> >>
>> >>Thanks for working on this, but IMHO this cannot go upstream like this,
>> >>the gpio pins on the axp pmics need a pinctrl driver, not a gpio
>> >>driver. I.E. on the axp209 gpio0 and gpio1 can also be used to output
>> >>an additional low-noise ldo (so as a regulator), or as an adc input.
>> >
>> >Eventually, yes, it needs both. But they don't even have to be the
>> >same driver, since they provide two different features. The only
>> >reason we have that construct in the pio case is because they share
>> >the same address space, but in the AXP case, the regmap and our mfd
>> >take care of that already.
>>
>> Hmm, so your suggesting to have mfd instantiate 2 platform devices
>> for this, a gpio and a pinctrl device, each with their own
>> driver. Yes that would work, but I'm a bit worried about the 2
>> racing or some such since they both will end up touching
>> bit 0-2 of register 0x90 / 0x92, more-over since they are both
>> touching the exact same bits I've the feeling that this really
>> should be one driver.
>
> I don't think that's an issue. We basically have two cases here:
> either we have a driver using the pin or not.
>
> If we have a driver using it, then pinctrl will make sure we have an
> exclusive use of the pin, before the gpio is requested and we start
> changing that value. If not, then no one cares anyway.

AFAIK pinctrl binding happens before probe time, and is tied to the
DT. Each driver requesting pins would have to have a separate node.
Seems like there isn't one for the regulators.

Or we'd have to manually configure them for each regulator that needs
them, and list the relevant pinctrl properties under its own node.
One "on" and "off" setting pair for each LDO_IO regulator. We could
then tie the settings to the regulator device, not the underlying
mfd sub-device.

ChenYu

>>
>> I guess that in a proper written dts we either use pinctrl to enable
>> a special function, or gpio, but still.
>>
>> >>I've been working on gsl1680 touchscreen support lately and on at least
>> >>a few a23 tablets, the low-noise ldo is used as AVCC for the touchscreen
>> >>controller.
>> >
>> >Yeah, the AXP209 also has an ADC connected to these pins.
>> >
>> >>Now these use an axp223 pmic, but nothing is stopping someone from
>> >>doing something similar with an axp209 and I think it would be best
>> >>to support this from day one, rather then hope we can retro-fit this
>> >>later without breaking dts.
>> >
>> >I considered that, but I don't see how it would break the DT later. If
>> >someone wants to enable say the ADC, he will of course have to add the
>> >pinctrl driver, and the pinctrl handles, but the old DT will only
>> >reference the gpio driver directly, which would still be something
>> >that would work.
>>
>> I was assuming we would use one mfd-child(-platform)-device for this,
>> not two. I guess that with 2 devices you're right and there should
>> not be any problem, still as said it feels wrong-ish to have 2 drivers
>> poking bits 0-2 of reg 0x90 / reg 0x92.
>
> Note that the PIO is built on the same model and it works, while we
> have 3 drivers in one. The only reason why we have everything linked
> to the same device is because we have to share the address space, but
> regmap takes care of that here.
>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
