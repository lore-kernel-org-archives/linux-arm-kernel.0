From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Apr 2018 10:55:50 +0200
Subject: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
In-Reply-To: <6194511c-b649-8c02-7db0-3514bfb292f5@ti.com>
References: <20180426152920.21569-1-brgl@bgdev.pl>
 <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com>
 <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
 <6194511c-b649-8c02-7db0-3514bfb292f5@ti.com>
Message-ID: <CAK8P3a394ig-OSzZLj+50gnBw1x_c41EicuM7mF_ubswweQoSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 10:29 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> On Friday 27 April 2018 01:22 PM, Arnd Bergmann wrote:
>> On Fri, Apr 27, 2018 at 4:28 AM, David Lechner <david@lechnology.com> wrote:
>>> On 04/26/2018 12:31 PM, Rich Felker wrote:

>>
>> I haven't seen the discussion about your clock drivers, but I know that
>> usually only a very small subset of the clocks on an SoC are needed
>> that 'early', and you should use a regular platform driver for the rest.
>
> Its true that the subset is small, but they are either PLL bypass clocks
> or clocks derived out of the main clock gate controller on the Soc
> (DaVinci PSC). So we need some non-platform-device based initialization
> support in the two main clock drivers used on mach-davinci anyway.
>
>> Can you elaborate on which devices need to access your clocks before
>> you are able to initialize the clk driver through the regular platform_driver
>> framework? Do any of these need complex interactions with the clk
>> subsystem, or do you just need to ensure they are turned on?
>
> Its just the timer IP. There is no complex interaction, just need to
> ensure that the clock is registered with the framework and also switched
> on when there is a gate clock.
>
> The latest attempt by David for this was posted last night here:
>
> https://lkml.org/lkml/2018/4/26/1093

Ok, so the workaround in that series is to set up the timer clk manually
in the SoC specific code (dm365_init_time etc) and register it to the
clk subsystem, right?

That seems to be a much more appropriate workaround than adding
back early_platform devices. We can always try to do something better
later, but for now I'm happy with that as a workaround.

Please clarify: do we have to set up the clk registers for the timer
here just because we can't rely on the bootloader to have it set up
initially, or is there some other reason? I think what some other
platforms do is to treat the timer clock as a fixed-rate clock that
is not managed by the actual clk driver but is set up by uboot
before we enter the kernel, and then the clk driver just makes sure
it doesn't turn that clk off later.

        Arnd
