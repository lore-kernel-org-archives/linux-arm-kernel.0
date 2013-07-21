From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 20 Jul 2013 21:44:10 -0600
Subject: Issue with gpio and pinmux
In-Reply-To: <CACRpkdb1n07KoQZSme1EMJfV-9pHr-kd_1eJ6HsBV5gz7Dh3Ww@mail.gmail.com>
References: <51E667BC.3070804@parrot.com> <51E82FBB.1080905@wwwdotorg.org>
 <CACRpkdb1n07KoQZSme1EMJfV-9pHr-kd_1eJ6HsBV5gz7Dh3Ww@mail.gmail.com>
Message-ID: <51EB590A.4010600@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2013 04:44 PM, Linus Walleij wrote:
> On Thu, Jul 18, 2013 at 8:11 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
>> The issue is that some HW muxes groups of pins at a time, so simply
>> because that group of pins is "claimed" by a mux function, implies
>> nothing about which specific pins in that group are actually used; some
>> may actually still be free for usage as a GPIO.
> 
> This we need to get into the documentation.
> 
>> The solution here may be one of:
>>
>> a) Modify pinctrl /not/ to allow both a GPIO and a mux function to claim
>> a pin *if* the group that contains the pin only contains a single pin.
>> This is a bit of a hacky special case though; there are other situations
>> where "dual claiming" shouldn't be allowed, and this doesn't solve those.
>>
>> b) Ignore the issue; if the system configuration is correct, the issue
>> won't cause problems in practice, since nothing will be configured to
>> "dual claim" any pin.
>>
>> c) Enhance pinctrl with extra information, so it knows which pins in a
>> group are usable as GPIO even when the group is claimed by a mux
>> function. The list of pins could theoretically vary per mux function, so
>> you'd need a table with lookup key (pin group, mux function) and output
>> data (list of pins that can be "dual claimed"). This would be a complete
>> solution. If a list wasn't provided, the pinctrl core could assume that
>> mean no dual claim was allowed.
> 
> I guess (b) is what we have.
> 
> But it really feels incomplete does it not? IIRC the system was strict
> not to allow simultaneous use of pins for GPIO and other functions
> at all until the above corner case made it necessary to relax this
> restriction.
> 
> A simple way to get (a) would be to just add a flag like ".strict"
> to struct pinmux_ops but it feels cheap.
> 
> What do we need for (c)? I think we can refactor this as the Tegra
> and U300 should be the two platforms with such tricky groups so
> the impact should be fairly small right now. I'm just worried it would
> be a complex and memory-consuming thing :-/

Actually, a better way to do (c) might be to just add an extra "op" to
struct pinmux_ops; something like validate_gpio_mux(), passing in
information such as whether a mux function is in effect on that pin,
whether the pin is already claimed as a GPIO, and whether the function
is being called to check a GPIO-claim or mux-claim operation . If the op
is missing, no "dual claim" is allowed. If the op is present, the code
in the op validates whether the particular GPIO is allowed to be claimed
while the particular mux function is active.

That way, I think any driver that doesn't want to allow dual-claim
doesn't have to do anything, but the few drivers that do can code up
whatever algorithm they want; for Tegra, I'd just allow everything for
simplicity, but we could always enhance that later if we want.
