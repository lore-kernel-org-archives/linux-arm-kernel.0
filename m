From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 18 May 2012 09:48:23 -0600
Subject: [PATCH RFC 1/1] pinctrl: improve gpio support for dt
In-Reply-To: <20120518072613.GJ10347@shlinux2.ap.freescale.net>
References: <1337090839-21224-1-git-send-email-b29396@freescale.com>
 <4FB55A35.1010902@wwwdotorg.org>
 <20120518072613.GJ10347@shlinux2.ap.freescale.net>
Message-ID: <4FB66F47.8010306@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2012 01:26 AM, Dong Aisheng wrote:
> On Fri, May 18, 2012 at 04:06:13AM +0800, Stephen Warren wrote:
>> On 05/15/2012 08:07 AM, Dong Aisheng wrote:
>>> For dt, the gpio base may be dynamically allocated, thus the original
>>> implementation of gpio support based on static gpio number and pin id
...
>> For example, Tegra might have:
>>
>> gpio-controllers = <&tegra_gpio>; // there's just 1
>>
>> i.MX23 might have:
>>
>> gpio-controllers = <&gpio0 &gpio1 &gpio2 &gpio3>; // it has 4 banks
>>
>> whereas pinctrl-simple/pinctrl-generic might want to put the entire
>> range table in this property, so might do something like:
>>
>> gpio-ranges =	<&gpio0 $gpio_offset $pin_offset $count>
>> 		<&gpio1 $gpio_offset $pin_offset $count> ...;
>>
>> and hence set cellskip to 3. the pinctrl-simple/pinctrl-generic code
>> would need to parse the other 3 cells itself.
>
> I like this way. :-)
> You made me come up a few more thoughts on it.
> Why shouldn't we use this format as a standard binding way for gpio ranges
> in pinctrl core and let core handle it totally for creating the range table?

Yes, that's probably reasonable.

Typically I'd argue that since the pinctrl driver probably knows this
information, and it's static, it should be in the driver not DT.
However, since the data is very small, and half of it needs to be in DT
anyway to provide the ability to look up the gpio_chip, it seems
reasonable to just put the whole thing in DT..

> The only concern is i'm not sure if any other SoC needs more cells for
> this format since we want this to be a standard bind format.
> But for now i did not see any need, people may raise it if any.

There's still the open question re: how to look up the gpio_chip from
the DT node, since there may be multiple gpio_chips for a single DT node
(banked controllers). Still, I hope that's just an implementation detail
rather than anything that conceptually breaks this idea.
