From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 26 Jul 2013 10:01:13 -0600
Subject: Issue with gpio and pinmux
In-Reply-To: <20130726092601.GA1909@ab42.lan>
References: <51E667BC.3070804@parrot.com> <51E82FBB.1080905@wwwdotorg.org>
 <CACRpkdb1n07KoQZSme1EMJfV-9pHr-kd_1eJ6HsBV5gz7Dh3Ww@mail.gmail.com>
 <51EB590A.4010600@wwwdotorg.org>
 <CACRpkdZdbxEt67+YBKif4-BKAToOmN0_c8HFOdjSG91dtJwJQw@mail.gmail.com>
 <20130726092601.GA1909@ab42.lan>
Message-ID: <51F29D49.9090807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2013 03:26 AM, Christian Ruppert wrote:
> On Thu, Jul 25, 2013 at 11:37:52AM +0200, Linus Walleij wrote:
>> On Sun, Jul 21, 2013 at 5:44 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>
>>> Actually, a better way to do (c) might be to just add an extra "op" to
>>> struct pinmux_ops; something like validate_gpio_mux(), passing in
>>> information such as whether a mux function is in effect on that pin,
>>> whether the pin is already claimed as a GPIO, and whether the function
>>> is being called to check a GPIO-claim or mux-claim operation . If the op
>>> is missing, no "dual claim" is allowed. If the op is present, the code
>>> in the op validates whether the particular GPIO is allowed to be claimed
>>> while the particular mux function is active.
>>>
>>> That way, I think any driver that doesn't want to allow dual-claim
>>> doesn't have to do anything, but the few drivers that do can code up
>>> whatever algorithm they want; for Tegra, I'd just allow everything for
>>> simplicity, but we could always enhance that later if we want.
>>
>> You are right, this would be an elegant solution.
>>
>> Christian, are you interested in coding this up?
> 
> When thinking about it, we require the same mechanism the other way
> round: If a GPIO is claimed first we need a mechanism to forbid
> incompatible reconfiguration of other functionalities until that GPIO is
> free again.
> 
> I like Stephen's proposal (in another mail) to claim GPIOs from the
> pinctrl drivers but instead of modifying the callback prototypes I
> suggest to add the following functions:
> 
> /*
>  * Claim GPIO pin (in the sense: forbid acutal GPIO usage)
>  */
> int claim_gpios(struct pinctrl_dev *pctl, unsigned *pins
>                 unsigned port_selector, unsigned func_selector);

I don't think that interface is quite right.

It assumes there's a concept of ports in pinctrl which there isn't. I
know you're arguing for that below, but dual-claiming and ports seem
like two related but separate issues, and I believe we should keep the
discussions somewhat separate.

How many entries are there in *pins? If just one, no need for a pointer.
If multiple, there needs to be a count parameter, and the
port/func_selector would also need to be arrays, since presumably
there's no reason to expect all the GPIOs to be in the same physical pin
group, if the HW is muxed at a pingroup level.

I think both a claim_gpios() and claim_mux_function() API would be
needed. If this function is intended to cover both, then I'd rather name
it claim_pins, since in the context of pinctrl, "GPIO" is a particular
usage of a pin, rather than a noun meaning the pin/ball/pad itself.

> /* allow GPIO usage of the given pins */
> void unclaim_gpios(struct pinctrl_dev *pctl, unsigned *pins);
> 
> Claiming could be fully dynamic. This way, driver authors don't need to
> implement additional callbacks or modify their existing ones. In the
> simplest case they do nothing. The entire conflict-checking logic is
> confined inside the core.
> 
> Alternatively, a similar set of functions could make the use of GPIOs
> exclusive with other functions for a given set of pins. This would work
> very well with the proposal below and would be easier to manage for most
> driver authors: The configuration would be static in most cases.
> (We just have to discuss about the default mode, do we want to keep the
> backward-compatible inclusive default or change everything to exclusive
> by default?).
> 
> A last point I would like to address before passing on to implementation
> is to introduce the notion of interfaces: I think it is important to
> introduce some orthogonality between unrelated interfaces which happen
> to be muxed on the same port and ideally we implement this coherently
> with the above.
> 
> I would like to know your opinion if the following proposal is generic
> enough or if it encodes too much chip-specific logic into the core:
> 
> - We extend the notion of pin groups to represent either ports (as it is
>   currently the case) or interfaces. No need to use name pin groups in
>   both cases, I'm open to proposals for better terminology.

I think if we start doing this, we really need to come up with unique
names for the usages for each type of "group of pins". Overloading "pin
group" for all the different uses will become rather confusing. It's bad
enough with some pinctrl drivers using them for real HW pingroups and
others for arbitrary SW groups of logically related pins. Introducing
new usage for "ports" and so on without actually calling them "ports" is
going to get even worse.

Perhaps each pin group needs a type associated with it, and we'll have:

PIN_GROUP_TYPE_PHYSICAL (only exists for HW that muxes groups of pins).
PIN_GROUP_TYPE_VIRTUAL (SW fake versions of _PHYSICAL)
PIN_GROUP_TYPE_PORT
PIN_GROUP_TYPE_...

?

I'm still not convinced that pinctrl should care about interfaces at all
though. Perhaps it might be useful if pinctrl wants to be really anal
about validating every detail of whether GPIOs and mux functions can
share pins. However, if the pinctrl configuration is correct, this isn't
necessary anyway, and hence just seems to bring additional complexity
for little benefit.

> - Functions are associated either to one port or a set of interfaces.

> - Functions continue to apply to an entire port but they only claim the
>   pins of the interfaces they are associated with.

This will be rather difficult to model in 100% accurate detail. Some
signals may be optional on some HW modules.

Consider an SDHCI controller which supports either 1-, 4-, or 8-bit
operation. Will a new function value be created for each of those
options, even though they all represent connecting the pins to the same
HW module, and hence the HW probably needs the same value programmed
into it for the relevant pins/groups irrespective of the bus width?

What about the pinctrl DT bindings that already exist, where the set of
available functions has already been defined to match HW. We need to
maintain compatibility with the old DT bindings, and hence can't just
create new function values out of thin air.

> - A client can request either a function or an interface from the
>   pinctrl core. In the second case, the core will figure out if the
>   request is coherent with previous requests (i.e. if there is a
>   function providing all requested interfaces) and call the driver
>   accordingly.

Requesting an interface doesn't make sense. The definition of an
interface implies zero knowledge, in general, about which pins that
interface will be routed to; in general HW can be designed to allow any
interface to be routed to/from different sets of pins. While it's true
that some SoCs don't actually allow this, I think it's best to keep the
pinctrl API model fully general, rather than allowing some drivers to
tailor their usage to more specific configurations. After all, the whole
point of pinctrl is to provide common semantics to drivers, so that if
the HW block they control are re-used across SoCs with different pinctrl
units, the drivers don't have to change.

> We'll have to figure out a few details but I would like to have an
> agreement on fundamentals before spending time on implementation.
