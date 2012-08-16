From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 16 Aug 2012 15:12:10 -0600
Subject: [PATCH] pinctrl: imx5: start numbering pad from 0
In-Reply-To: <20120816033006.GA11999@shlinux2.ap.freescale.net>
References: <1344869278-27334-1-git-send-email-shawn.guo@linaro.org>
 <CAKGA1b=DqyZvSre3C4YQ3GM6RuFtFsGWDkF784iKggrNzwiKpg@mail.gmail.com>
 <CAP1dx+zQvBurT9oCmfJ0dGHHV3rbgdy+0Yh_hoPL9jQB8QNxKw@mail.gmail.com>
 <CAKGA1bmHqyDGyvZjEcQ+RO1jHiZNZKNu3BGkyUXzYfwVaySYEQ@mail.gmail.com>
 <CAP1dx+x0_j_f3Pj+9+YHcwoTqjGLXouf7t+SoCCMVGKJNOHCPw@mail.gmail.com>
 <20120815054436.GK2232@pengutronix.de>
 <20120815065526.GG19681@shlinux2.ap.freescale.net>
 <20120815075117.GL2232@pengutronix.de>
 <20120815092539.GH19681@shlinux2.ap.freescale.net>
 <20120815135947.GC2258@S2101-09.ap.freescale.net>
 <20120816033006.GA11999@shlinux2.ap.freescale.net>
Message-ID: <502D622A.1030104@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/2012 09:30 PM, Dong Aisheng wrote:
> On Wed, Aug 15, 2012 at 09:59:50PM +0800, Shawn Guo wrote:
> ...
>>> Another known issue is that via this way, that means the pinctrl subsystem
>>> can only see the using pads, this is a bit not align with the pinctrl
>>> subsystem design. No sure if Linus would like to see it.
>>>
>> I do not quite follow on this.  The "enum imx51_pads" will still be
>> there, so all the pads will still be visible to the pinctrl system.
>>
> Sorry, i did not describe it accurately.
> The problem is that those pins are visible to pinctrl subystem, but the pinctrl
> subsystem can not manage them all.
> Not sure this meet Linus's original design purpose.
> Because for the way proposed, all the pin's basic properties like mux_reg, config_reg
> are parsed from device tree at runtime.
> If a pin is not used in device tree, the driver can not know this pin's
> corresponding registers.
> Thus, for those unused pins, we can not manage it on mux or config in pinctrl
> subsystem and driver.
> 
> For example, the pin_config_get/pin_config_set API in
> include/linux/pinctrl/consumer.h can not work for such pins.

Hmmm. Given we support all pin mux/config options from the mapping
table, I'd question whether that API should even exist any more...

> Then imx_pinconf_dbg_show in current driver may need change since it does not
> support show all pins's config value.

The pinctrl core assumes that the pin numbering space could be sparse.
For example, see that pinconf.c:pinconf_pins_show() "continues" the loop
if pin_desc_get() fails for a particular pin number. So just based on
what I've read in this one email, I think this is fine.

> It looks like not a big issue currently since i did not see any client driver
> using this API.
> But i'm not sure if we may have this requirement in the future.
> For example, is it possible that pinctrl subsystem may support configure pins
> via sysfs dynamically?

I can't comment on sysfs specifically, but I believe it would be
generally true that a pin that isn't know to the pinctrl subsystem can't
be manipulated in any way.
