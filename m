From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 24 May 2012 23:11:34 +0300
Subject: [PATCH] remoteproc: block premature rproc booting
In-Reply-To: <4FBDFC4A.1060602@codeaurora.org>
References: <1337687472-23009-1-git-send-email-ohad@wizery.com>
 <4FBDFC4A.1060602@codeaurora.org>
Message-ID: <CAK=WgbaP5qSso_Eu=Oup4eqLDcorZ-qf=mysMKiEvOS=m7yLmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, May 24, 2012 at 12:15 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> The request_firmware timeout is defaulted to 60 seconds but not
> necessarily 60 if the user has changed the timeout in sysfs.
..
> Why does this need to be a timeout at all? Presumably
> request_firmware_nowait() in rproc_register() will timeout and complete
> the firmware_loading_complete completion variable.

Very good points, thanks for pointing them out!

> Would it suffice to
> have some new rproc->state like RPROC_UNKNOWN that we set in
> rproc_register() before adding it to the list of rprocs? If we find the
> firmware then we set it to RPROC_READY or RPROC_REGISTERED? Then we
> wait_for_completion() and check the state, failing if it's still in the
> unknown state.

That makes me think - what if we'll add the rproc to the list only
after we find the firmware? This way we avoid this race completely.

Speaking of which, I was wondering whether you guys have some free
cycles to try remoteproc out.

The main reason we kept the get/put interface was to make it easier
for you guys to adopt it, but I've been re-thinking lately whether we
really want that interface. It's a problematic interface with
non-negligible maintenance burden, and the code will be greatly
simplified without it.

Even if you guys won't be adopting virtio (of any other
virtio-over-smd variant) - do you think you'll be able to adopt a
similar model with which remoteproc registers, according to the fw
capabilities, the relevant devices which then get bound to the
relevant higher-level drivers (virtio drivers, smd drivers, etc..) ?
That way these devices can point to the rproc context and we don't
need any get_by_name interface.

Thanks,
Ohad.
