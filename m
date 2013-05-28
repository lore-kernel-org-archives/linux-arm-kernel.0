From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 28 May 2013 09:14:02 -0600
Subject: [PATCH] pinctrl: sink pinctrldev_list_mutex
In-Reply-To: <CACRpkdYxvBvYAnmp-p5WwB3QD0rd83qDcdg-BMhN7-2Jv8Oo_w@mail.gmail.com>
References: <1368690525-32252-1-git-send-email-linus.walleij@stericsson.com>
 <519A8A57.9060007@wwwdotorg.org>
 <CACRpkdZieCmFnHCGUkv8EqcAtb3DA7dSZpimSdB4P81tZPJRoQ@mail.gmail.com>
 <519F8B02.1080000@wwwdotorg.org>
 <CACRpkdYxvBvYAnmp-p5WwB3QD0rd83qDcdg-BMhN7-2Jv8Oo_w@mail.gmail.com>
Message-ID: <51A4C9BA.40903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/2013 03:09 AM, Linus Walleij wrote:
> On Fri, May 24, 2013 at 5:45 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 05/24/2013 02:04 AM, Linus Walleij wrote:
> 
>>> Prevention of module unloading of pin controllers has never
>>> been working properly, as there is no way to release the
>>> pinctrl handles taken by different drivers.
>>>
>>> I think that is why most pin controller drivers are bool rather
>>> than tristate.
>>
>> Once we get to multi-platform distro kernels, we will probably want all
>> the pinctrl drivers to be modules so only the correct one gets loaded
>> from an initrd. Hence, we'll want to move things to tristate rather than
>> away from it.
> 
> OK ... As some kind of excuse I think the current situation is an
> outgrowth of the fact that all the custom set-up used to be in machines
> down in arch/arm/* and inevitably done at machine init.
> 
>> If we know the pinctrl subsystem doesn't yet work correctly with module
>> unloads, should we modify pinctrl_register() to simply take a lock on
>> the driver module and never drop it, so that we guarantee we don't try
>> to unload the module later? Or, is this effectively already in place?
> 
> Hm, it won't happen with anything but pinctrl-single for sure.
> But I know that Tony used it at one point, however I still
> suspect that he was only using hogs.
> 
> We should maybe take the lock at the instant we instatiate a
> pinctrl handle from something else than a hog, so as to mark
> that we then have external dependencies that make unloading
> impossible.

Yes.

> But it'd be even cooler to actually just iterate over the
> pinctrl_list och handles and orphan them, and later recouple
> them if a driver is loaded back in.

Hmm. What happens if the client driver wants to select a different state
while the pinctrl driver itself isn't loaded? I'm not sure how workable
that is. I think the only way to make it work would be to cache enough
information in the struct pinctrl that it could be activated even if the
driver wasn't loaded. That seems a little scary.

I'd be fine if there was a requirement to unload all drives that were
clients of the pinctrl driver before you could unload the pinctrl
driver, just like any other driver/subsystem. This would work fine at
least for testing with just hogs, which while not great for full-system
testing would surely be fine at least when first developing the pinctrl
driver.
