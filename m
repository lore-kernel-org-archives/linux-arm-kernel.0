From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 24 May 2013 09:45:06 -0600
Subject: [PATCH] pinctrl: sink pinctrldev_list_mutex
In-Reply-To: <CACRpkdZieCmFnHCGUkv8EqcAtb3DA7dSZpimSdB4P81tZPJRoQ@mail.gmail.com>
References: <1368690525-32252-1-git-send-email-linus.walleij@stericsson.com>
 <519A8A57.9060007@wwwdotorg.org>
 <CACRpkdZieCmFnHCGUkv8EqcAtb3DA7dSZpimSdB4P81tZPJRoQ@mail.gmail.com>
Message-ID: <519F8B02.1080000@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2013 02:04 AM, Linus Walleij wrote:
> On Mon, May 20, 2013 at 10:40 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
>> This seems fine on the surface, but I do have one question:
>>
>> I think the pinctrl lock serves a couple of purposes:
>>
>> 1) Basic protection for accesses to the pinctrldev_list itself.
>>
>> This patch seems just fine w.r.t. this point.
>>
>> 2) Preventing pinctrl drivers from being unregistered (and their modules
>> unloaded) when some operation is being performed on/to them.
> 
> Prevention of module unloading of pin controllers has never
> been working properly, as there is no way to release the
> pinctrl handles taken by different drivers.
> 
> I think that is why most pin controller drivers are bool rather
> than tristate.

Once we get to multi-platform distro kernels, we will probably want all
the pinctrl drivers to be modules so only the correct one gets loaded
from an initrd. Hence, we'll want to move things to tristate rather than
away from it.

If we know the pinctrl subsystem doesn't yet work correctly with module
unloads, should we modify pinctrl_register() to simply take a lock on
the driver module and never drop it, so that we guarantee we don't try
to unload the module later? Or, is this effectively already in place?

In other words, I can accept that we know that we can't unload pinctrl
drivers, but given that, I think the kernel should make sure the user
/actually/ can't unload them.
