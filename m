From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 20 May 2013 14:40:55 -0600
Subject: [PATCH] pinctrl: sink pinctrldev_list_mutex
In-Reply-To: <1368690525-32252-1-git-send-email-linus.walleij@stericsson.com>
References: <1368690525-32252-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <519A8A57.9060007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2013 01:48 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The pinctrldev_list_mutex is sinked into the functions that
> actually traverse the list and lock it there. The code makes
> much more sense in this way. All the callers are in
> non-performance critical paths and the code is way more
> readable this way.
> 
> Also refactor the function get_pinctrl_dev_from_devname() to
> follow the design pattern of get_pinctrl_dev_from_of_node()
> which is slightly simpler.

This seems fine on the surface, but I do have one question:

I think the pinctrl lock serves a couple of purposes:

1) Basic protection for accesses to the pinctrldev_list itself.

This patch seems just fine w.r.t. this point.

2) Preventing pinctrl drivers from being unregistered (and their modules
unloaded) when some operation is being performed on/to them.

So, that means some code is written as follows:

lock
find pinctrl device
perform operation on pinctrl device
unlock
// only now could the found pinctrl device be unregistered

However, I think this patch changes that to the following for some
operations:

lock
find pinctrl device
unlock
// now the found pinctrl device can be unregistered
perform operation on pinctrl device

Is this true here, or am I off-base?

If this isn't an issue, then the patch is fine by me. But, how is the
unregistration prevented while the device is being operated on then?
