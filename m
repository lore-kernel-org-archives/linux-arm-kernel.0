From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 1 Jul 2011 18:13:54 +0300
Subject: [RFC 7/8] drivers: introduce rpmsg,
	a remote-processor messaging bus
In-Reply-To: <BANLkTikJGHSwqMW2W2YA4EnvJ0yj+9C6ow@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-8-git-send-email-ohad@wizery.com>
	<20110627222121.GD20865@ponder.secretlab.ca>
	<BANLkTikt08CDJiKNxGF2mKmOhyxHfv21_g@mail.gmail.com>
	<BANLkTim+CemMz7A3J94e1UywCNd0r1SABQ@mail.gmail.com>
	<BANLkTi=16XEpvhWEAoUt_s5F41czeq2DVQ@mail.gmail.com>
	<BANLkTikJGHSwqMW2W2YA4EnvJ0yj+9C6ow@mail.gmail.com>
Message-ID: <BANLkTi=XBVNqNx_dvW87AHHqAKdMJMiMmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 6:43 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> So you are right that device_unregister drops the refcount to zero,
> but the code still needs to be fixed to not call kfree() directly.

Good point, thanks !

> It also looks like rpmsg_destroy_channel() needs to be fixed to remove
> the kfree call

Yes, I need to remove this direct kfree as well, and indeed just let
rpmsg_release_device do its thing when the last reference is dropped.

I should also remove the direct kfree when device_register fails: in
that case, I need only to put_device and let the release handler do
its thing too.

> and an extra put_device() call.

We need that extra put_device in rpmsg_destroy_channel because
device_find_child() is doing get_device before returning it.

Thanks, Grant!

Ohad.
