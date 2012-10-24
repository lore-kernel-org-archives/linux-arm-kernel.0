From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Oct 2012 19:18:53 +0200
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <20121024165749.GB32220@arwen.pp.htv.fi>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121022155028.GA13791@core.coreip.homeip.net>
 <508660D4.9030507@ti.com>
 <20121023200249.GA2712@core.coreip.homeip.net>
 <CACRpkdYwA7O8AqB8YFCK-c3e6-7FcbhMOiPEUq-cKJni_PO-Ow@mail.gmail.com>
 <20121024161801.GB16350@core.coreip.homeip.net>
 <20121024165749.GB32220@arwen.pp.htv.fi>
Message-ID: <CACRpkdb3ixJWDhJVOX4ZM-xqk37v5k8zhhFGBH-uxgFHHeVEfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 6:57 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Oct 24, 2012 at 09:18:01AM -0700, Dmitry Torokhov wrote:
>> OK, so with drivers/base/, have you considered doing default pinctrl
>> selection in bus's probe() methods? Yo would select the default
>> configuration before starting probing the device and maybe select idle
>> when probe fails or device is unbound? That would still keep the link
>> between device object and pinctrl and there less busses than device
>> drivers out there.
>
> it starts to become confusing after a while. I mean, there's a reason
> why all drivers explictly call pm_runtim_enable(), right ?
>
> From a first thought, one could think of just yanking that into bus'
> probe() as you may suggest, but sometimes the device is already enabled,
> so we need extra tricks:
>
> pm_runtime_set_active();
> pm_runtime_enable();
> pm_runtime_get();
>
> the same could happen with pinctrl eventually. What if a device needs to
> do something else (an errata fix as an example) before requesting
> pinctrl's default state ?

I can confirm this. Just the ordering between enabling/disabling
resources like clock/pins/powerdomain screw things up for us
and even if we can surely centralize parts of this code as such
into the drivers/base or pm_* namespace we would still need
explicit calls from the driver.

I'm thinking that maybe the best helpers are actually static
inline functions in the <linux/pinctrl/consumer.h> header
rather than moving anything into drivers/base/* if the
code duplication is the real problem.

Yours,
Linus Walleij
