From: lars@metafoo.de (Lars-Peter Clausen)
Date: Fri, 15 May 2015 22:40:59 +0200
Subject: [alsa-devel] [PATCH 1/4] ASoC: rockchip: add rockchip machine
 driver
In-Reply-To: <CAEUnVG5nkagx7CZC3t=-oOAyXOBaxxVynBxaGMf0NJpfr9ZVbA@mail.gmail.com>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
 <1431422797-31903-2-git-send-email-zhengxing@rock-chips.com>
 <20150512192215.GZ3066@sirena.org.uk> <55535035.5070608@rock-chips.com>
 <20150513164250.GB2761@sirena.org.uk>
 <CAEUnVG5+PqhkZ4TBMnfdbUr66-EaLVGDEewJ_=XZnfbvBEn13w@mail.gmail.com>
 <CAEUnVG5nkagx7CZC3t=-oOAyXOBaxxVynBxaGMf0NJpfr9ZVbA@mail.gmail.com>
Message-ID: <555659DB.9010204@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2015 01:11 AM, Dylan Reid wrote:
> On Wed, May 13, 2015 at 10:21 AM, Dylan Reid <dgreid@chromium.org> wrote:
>> On Wed, May 13, 2015 at 9:42 AM, Mark Brown <broonie@kernel.org> wrote:
>>> On Wed, May 13, 2015 at 09:23:01PM +0800, zhengxing wrote:
>>>> On 2015?05?13? 03:22, Mark Brown wrote:
>>>
>>>>> Is it not possible to extend simple card to handle your use cases?
>>>>> Given the very generic naming and the fact that things like jack
>>>>> detection and so on should depend on the CODEC and board usually rather
>>>>> than on the SoC it doesn't sound like this is Rockchip specific.
>>>
>>>>> This also looks like you're reimplementing some device model enumeration
>>>>> stuff which probably shouldn't be happening but let's understand the
>>>>> problem you're trying to solve here before going too far into the code.
>>>
>>>> Because we are trying to bring rt5650 in the project, so we intend to
>>>> describe supported codecs with DTS via only a rockchip machine driver file,
>>>> others remain pre-implement(like max98090 / rt5645 that vendor machine
>>>> driver).
>>>
>>> I don't undertand what you're saying here, sorry - why is this not just
>>> a case of writing multiple machine drivers?
>>
>> I don't understand this either.  I'd think the best solution is
>> simple-card, configured through DTS for each device.
>>
>>>
>>>> I communicated with Dylan, and he told me that the jack detection is an
>>>> issue in the simple-card, and suggested we are better to send them at
>>>> present.
>>>
>>> But what are these issues?
>>
>> The issue I was referring to when I spoke with rock chip was the need
>> to pass the jack simple-card creates to the headset chip or codec.  We
>> need a way to specify a device like a tsa227e or rt5650 to pass the
>> jack to, which events are supported by the jack, and a generic API for
>> passing the jack.
>
> I'm having some trouble envisioning how to pass the jack to the
> headset chip in a generic way.  A callback could be added to
> snd_soc_component_driver, or a snd_soc_headset_driver could be added.
> The headset_drive would fit the ts3a227e well, but not the rt5645
> which is also a full blown codec.

Yea, our current jack detection code is quite rudimentary when it comes to 
writing generic code.

I think the proper way to support this is come up with the concept of jack 
detection providers and consumers. A component can register a jack detection 
provider just like it can register a DAI. And then in the board driver you'd 
just link the jack detection logic to the jack using the usual approach, 
which is also used for DAIs (e.g. of node or device name). The core would 
then take care of calling a enable callback or whatever is required to setup 
the jack detection logic in the driver.

This would also nicely solve the issue with the GPIO jack detectors, where 
we currently can't really handle -EPROBE_DEFER. The GPIO would be requested 
by a jack detection provider which can request them before the card is 
registered rather than having to do the requesting in the card's init callback.

- Lars
