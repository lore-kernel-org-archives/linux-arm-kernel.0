From: broonie@kernel.org (Mark Brown)
Date: Mon, 9 Jan 2017 19:17:58 +0000
Subject: [RFC PATCH 1/5] regulator: Extend the power-management APIs
In-Reply-To: <1480687036-5037-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1480687036-5037-1-git-send-email-boris.brezillon@free-electrons.com>
 <1480687036-5037-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170109191758.7zzxeh45pvwiw3jo@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 02:57:12PM +0100, Boris Brezillon wrote:

> The idea to solve #2 is to allow runtime changes. Since this kind of
> change is likely to have an impact on the whole system, we require the
> board to explicitly state that runtime changes are allowed (using a DT
> property).

> Allowing runtime changes, may also be a problem if devices are not
> suspended in the correct order: a device using a regulator should be
> suspended before the regulator itself, otherwise we may change the
> regulator state while it's still being used.
> Hopefully, this problem will be solved with the work done on device
> dependency description.

I'm not sure that adding an extra property is going to help with the
problems here - the system already has to provide explicit support for
setting the suspend configuration so that should be enough.  However it
*is* a bit more than just making sure that the device suspend ordering
is good (though that's definitely part of it), there will be things
kicked off by hardware signalling without software knowing about it.

Anything that doesn't affect a hardware supported runtime state probably
needs to be split off and handled separately as that's the much more
risky bit, moving changing of suspend mode earlier isn't going to cause
too much grief, that patch should just be split out and can probably
just go straight in.

> + * This function should be called from the regulator driver ->suspend() hook
> + * and after the platform has called regulator_suspend_begin() to properly set
> + * the rdev->suspend.target field.

Requring these functions to be called from every single driver seems
like we're doing something wrong - if we're going to do this we should
find some way to loop over all regulators and apply any unapplied
changes.  Batching things up at the end of suspend would also mean that
we'd be able to minimise the chances that we get the ordering wrong.

For the target bit...  we should be able to find some way to figure out
what kind of suspend we're doing without the platform being involved, a
callback from the PM core would be helpful here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170109/6ac2c655/attachment.sig>
