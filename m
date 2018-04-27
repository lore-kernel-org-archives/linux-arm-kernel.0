From: dalias@libc.org (Rich Felker)
Date: Thu, 26 Apr 2018 22:54:21 -0400
Subject: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
In-Reply-To: <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com>
References: <20180426152920.21569-1-brgl@bgdev.pl>
 <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com>
Message-ID: <20180427025421.GN3094@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 09:28:39PM -0500, David Lechner wrote:
> On 04/26/2018 12:31 PM, Rich Felker wrote:
> >On Thu, Apr 26, 2018 at 05:29:18PM +0200, Bartosz Golaszewski wrote:
> >>From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>
> >>This is a follow to my series[1] the aim of which was to introduce device tree
> >>support for early platform devices.
> >>
> >>It was received rather negatively. Aside from using device tree to pass
> >>implementation specific details to the system, two important concerns were
> >>raised: no probe deferral support and the fact that currently the early devices
> >>never get converted to actual platform drivers. This series is a
> >>proof-of-concept that's trying to address those issues.
> >>
> >>The only user of the current version of early platform drivers is the SuperH
> >>architecture. If this series eventually gets merged, we could simply replace
> >>the other solution.
> >
> >Looking at a quick output of:
> >
> >	grep -r -A10 early_devices[[] arch/sh/kernel/
> >
> >it looks like all of the existing early platform devices are serial
> >ports, clocks, and clocksources. The switch to device tree should pick
> >them all up from CLK_OF_DECLARE, TIMER_OF_DECLARE, and
> >EARLYCON_DECLARE. Until that's complete, the existing code works
> >as-is. I don't see what problem you're trying to solve.
> 
> The problem for us is that clk maintainers don't want new drivers to use
> CLK_OF_DECLARE and instead use platform devices. I have just written such
> a new driver that is shared by 6 different SoCs. For some combinations of
> SoCs and clocks, using a platform device is fine but on others we need to
> register early, so the drivers now have to handle both cases, which is
> kind of messy and fragile. If there is a generic way to register platform
> devices early, then the code is simplified because we only have to handle
> one method of registering the clocks instead of two.

Can you get them to explain why? This sounds wrong.

Rich
