From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 27 Apr 2018 10:57:06 +0200
Subject: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
In-Reply-To: <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
References: <20180426152920.21569-1-brgl@bgdev.pl>
 <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com>
 <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
Message-ID: <CAMpxmJUR+31axmAe2TNq00aUg40bnC=5k=2cVX019Vncr7cRkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-04-27 9:52 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> On Fri, Apr 27, 2018 at 4:28 AM, David Lechner <david@lechnology.com> wrote:
>> On 04/26/2018 12:31 PM, Rich Felker wrote:
>>>
>>> On Thu, Apr 26, 2018 at 05:29:18PM +0200, Bartosz Golaszewski wrote:
>>>>
>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>
>>>> This is a follow to my series[1] the aim of which was to introduce device
>>>> tree
>>>> support for early platform devices.
>>>>
>>>> It was received rather negatively. Aside from using device tree to pass
>>>> implementation specific details to the system, two important concerns
>>>> were
>>>> raised: no probe deferral support and the fact that currently the early
>>>> devices
>>>> never get converted to actual platform drivers. This series is a
>>>> proof-of-concept that's trying to address those issues.
>>>>
>>>> The only user of the current version of early platform drivers is the
>>>> SuperH
>>>> architecture. If this series eventually gets merged, we could simply
>>>> replace
>>>> the other solution.
>>>
>>>
>>> Looking at a quick output of:
>>>
>>>         grep -r -A10 early_devices[[] arch/sh/kernel/
>>>
>>> it looks like all of the existing early platform devices are serial
>>> ports, clocks, and clocksources. The switch to device tree should pick
>>> them all up from CLK_OF_DECLARE, TIMER_OF_DECLARE, and
>>> EARLYCON_DECLARE. Until that's complete, the existing code works
>>> as-is. I don't see what problem you're trying to solve.
>>
>>
>> The problem for us is that clk maintainers don't want new drivers to use
>> CLK_OF_DECLARE and instead use platform devices. I have just written such
>> a new driver that is shared by 6 different SoCs. For some combinations of
>> SoCs and clocks, using a platform device is fine but on others we need to
>> register early, so the drivers now have to handle both cases, which is
>> kind of messy and fragile. If there is a generic way to register platform
>> devices early, then the code is simplified because we only have to handle
>> one method of registering the clocks instead of two.
>
> The early_platform code is certainly not a way to make things simpler,
> it just adds one more way of doing the same thing that OF_CLK_DECLARE
> already does. We removed the last early_platform users on ARM a few
> years ago, and I would hope to leave it like that.
>
> I haven't seen the discussion about your clock drivers, but I know that
> usually only a very small subset of the clocks on an SoC are needed
> that 'early', and you should use a regular platform driver for the rest.
>
> Can you elaborate on which devices need to access your clocks before
> you are able to initialize the clk driver through the regular platform_driver
> framework? Do any of these need complex interactions with the clk
> subsystem, or do you just need to ensure they are turned on?
>
>      Arnd

The problem I'm trying to solve is the following:

We have platforms out there which still use both board files and
device tree. They are still comercially supported and are not going
anywhere anytime soon. Some of these platforms are being actively
maintained and cleaned-up. An example is the DaVinci platform: David
has recently converted all the SoCs and boards to using the common
clock framework. I'm cleaning up some other parts too.

The problem with the legacy board code is that a lot of things that
should be platform drivers ended up in arch/arm/mach-*. We're now
slowly moving this code to drivers/ but some initialization code
(timers, critical clocks, irqs) needs to be called early in the boot
sequence.

When you're saying that we already have all the OF_DECLARE macros, it
seems to me that you're forgetting that we also want to keep
supporting the board files. So without the early platform drivers we
need to use a mix of OF_DECLARE and handcrafted initialization in
arch/arm/mach-* since we can't call platform_device_register() that
early. This blocks us from completely moving the should-be-driver code
to drivers/, because these drivers *need* to support both cases.

The main problem with OF_DECLARE is that although we have
corresponding device nodes, we never actually register any real linux
devices. If we add to this the fact that current early platform
drivers implementation is broken (for reasons I mentioned in the cover
letter) the support gets really messy, since we can have up to three
entry points to the driver's code. Other issues come to mind as well:
if we're using OF_DECLARE we can't benefit from devm* routines.

My aim is to provide a clean, robust and generic way of probing
certain devices early and then converting them to actual platform
devices when we're advanced enough into the boot sequence. If we
merged such a framework, we could work towards removing both the
previous early platform devices (in favor of the new mechanism) and
maybe even deprecating and replacing OF_DECLARE(), since we could
simply early probe the DT drivers. Personally I see OF_DECLARE as a
bigger hack than early devices.

My patch tries to address exactly the use cases we're facing - for
example by providing means to probe devices twice (early and late) and
to check the state we're at in order for users to be able to just do
the critical initialization early on and then continue with regular
stuff later.

Best regards,
Bartosz Golaszewski
