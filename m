From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 19 Nov 2013 09:23:36 -0500
Subject: [RFC PATCH V2 2/2] kbuild: dtbs_install: new make target
In-Reply-To: <20131119122801.GL16735@n2100.arm.linux.org.uk>
References: <cover.1384798508.git.jason@lakedaemon.net>
 <eaf050fbd62803784856a4f37d4b332f7778e22c.1384798508.git.jason@lakedaemon.net>
 <528A65DF.8060000@wwwdotorg.org>
 <20131118191955.GG10335@titan.lakedaemon.net>
 <528A6944.3070303@wwwdotorg.org>
 <20131118192852.GI10335@titan.lakedaemon.net>
 <528A6CA3.9030904@wwwdotorg.org>
 <20131118195243.GJ10335@titan.lakedaemon.net>
 <528A98C8.9040803@wwwdotorg.org>
 <20131119122801.GL16735@n2100.arm.linux.org.uk>
Message-ID: <20131119142336.GA28859@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Tue, Nov 19, 2013 at 12:28:01PM +0000, Russell King - ARM Linux wrote:
> As for renaming the files from what we have in the kernel, I'd say...
> why bother.

When I first read your email, I agreed, and started down the path of
dropping the rename, then...

> What if we have two DT blobs with the same compatible string (which is
> not unlikely when you have two configurations for a platform)?

If a board has two different, especially destructive, configurations, it
should have two different compatible strings.  Especially since 90% (I'm
swagging) of a distro's use of dtbs is to upgrade the dtb on an already
installed system.  They'll most likely pull the board compatible string
from /proc/device-tree/compatible, and then go hunt for the dtb.

That's why I prefer to rename the dtbs, it removes the need to parse the
dtb (fdtget *isn't* currently built/installed by default in dtc), and it
allows distros, for the most common use case, to easily find a matching
dtb on an existing system.

In the event that an already deployed dtb is found to have an alternate
rev (with or without destructive changes), on our side, we add a more
specific compatible string and a new dts for the new rev.  The distro
dtb upgrader detects it's on a 'globalscale,mirabox' and sees that the
options are now globalscale,mirabox-rev1.dtb and
globalscale,mirabox-rev2.dtb.  It throws up a user prompt asking the
user to determine which board rev it's on.  Or, if safe to do so, it
programatically determines which rev it is on and updates the dtb.

> I'd recommend keeping the names in the kernel tree when installing.
> If a distro needs to find the compatible string, then that's a bit of
> parsing they should do.  Otherwise, we lose the ability to tell users
> "you need this DT blob file called X" because X will depend whether
> it's been installed or not.

All I'm suggesting doing is extending the same standard we have for
compatible strings at the node level to the board level.  If we don't
change the filename, then we *have* to extend the consistent naming to
the dts files as well.

I think it's just as easy to say "you need globalscale,mirabox-rev1 now"
as anything else.

> And in some cases where getting the wrong DT blob could end up quite
> literally destroying your hardware (eg, by setting an LDO regulator to
> bypass mode), it's extremely important that anything here is _simple_
> and doesn't involve lots of indirection.

kept for context, above.

thx,

Jason.
