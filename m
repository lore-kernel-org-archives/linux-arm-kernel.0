From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Sep 2015 12:26:14 +0200
Subject: [GIT PULL 9/9] ARM: tegra: Default configuration updates for
 v4.3-rc1
In-Reply-To: <7h7fnw3mvd.fsf@linaro.org>
References: <CANMBJr6DSXW-h8P8__LKBu-Xv77T35JwxHWvarvqy1keVrtVQQ@mail.gmail.com>
 <CAMAWPa_rus4z+Sg3Uff7ndqrpB8dF1c1rQBVQ9r7vXh6PFcVkQ@mail.gmail.com>
 <55F2AF45.5040706@nvidia.com> <20150911123759.GA8473@ulmo>
 <55F2D2E3.4010906@nvidia.com> <20150911132526.GB21673@ulmo>
 <55F2F895.5040704@nvidia.com>
 <20150911155946.GA13945@ulmo.nvidia.com>
 <20150911163346.GA20235@ulmo.nvidia.com>
 <7h7fnw3mvd.fsf@linaro.org>
Message-ID: <20150917102613.GA9804@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 10:08:06AM -0700, Kevin Hilman wrote:
> Thierry Reding <thierry.reding@gmail.com> writes:
> 
> > On Fri, Sep 11, 2015 at 05:59:48PM +0200, Thierry Reding wrote:
> >> On Fri, Sep 11, 2015 at 04:51:49PM +0100, Jon Hunter wrote:
> >> > 
> >> > On 11/09/15 14:25, Thierry Reding wrote:
> >> > 
> >> > [snip]
> >> > 
> >> > > Works for me 100% of the time. Unloading and reloading isn't a problem
> >> > > either. What revision of the Jetson TK1 do you have? Mine is a C.2
> >> > 
> >> > Unfortunately, I am not sure it is whatever is in Paul's automation rig
> >> > [0]. However, I have also reproduced this on a tegra124 nyan-big in the
> >> > office.
> >> 
> >> I was able to reproduce this using a busybox initial ramdisk. Just to
> >> make sure I built a separate one from git and it exposes the same
> >> behaviour. I suspect that this is some sort of weird interaction between
> >> mdev and async probing and nobody's noticed so far because async probing
> >> isn't very common (at least in the ARM world).
> >> 
> >> I'll be off for the weekend soonish, but I'll try to find some more time
> >> next week to track this down.
> >
> > Before I head into the weekend, here are my findings: looks like this
> > might be some sort of recursive locking problem. Here's the output with
> > a lot of debug messages:
> 
> FWIW, in kernelci we use a buildroot initramfs[1] with eudev enabled for
> module loading.  Before booting, modules are injected into the ramdisk
> so they are loaded during boot by eudev.
> 
> The source is on github[2] and can be rebuilt using './configs/frags/build armel'

This turned out to be rather interesting. The reason why I wasn't seeing
this on my setup was because request_module() ends up directly calling
the /sbin/modprobe userspace helper. On my setup I had these files
installed in /usr/bin (because that's the default installation path that
kmod uses) and I was missing a symlink from /sbin to /usr/bin, therefore
causing request_module() to return with -ENOENT. Unfortunately the HDA
core code completely ignores errors from request_module() so didn't give
any indication at all. Thanks to Jon Hunter who put me on that trail.

After fixing the root filesystem I was seeing the deadlocks as well. But
the root cause of this was now clearly the request_module(). It turns
out that this causes the driver for the HDA codec to be bound to the HDA
codec device immediately, from within the HDA controller's ->probe()
callback, hence leading to the deadlock.

That's a known problem in HDA land and for Intel this has been worked
around rather creatively by deferring HDA codec probing to a work queue
that runs asynchronously to the controller's probe. To be fair there
seem to be other reasons why this is necessary on Intel (the HDA codec
and i915 display drivers interact weirdly). It's possible that a work-
around isn't necessary on Intel anymore either because the recursive
locking of HDA controller vs. HDA codec is gone and the i915 device
should be relatively far removed to not cause any deadlocks. I haven't
invested any time in fixing this because I don't have a setup where I
could test this.

The solution I came up with, and I've sent patches earlier with a couple
of people from this thread Cc'ed, is to get rid of the explicit calls to
the request_module() function and use existing infrastructure instead. I
implemented a uevent callback in the HDA bus that reports the MODALIAS
information to the userspace helper, which can then use it to auto-load
the proper module. That gets rid of the recursive locking because both
devices are now probed from different contexts.

This should work just fine with any relatively modern distribution. Both
systemd and eudev implementations of udev should support loading modules
when they see a MODALIAS environment variable. For busybox this doesn't
work out of the box, but you can enable it by adding the following line
to /etc/mdev.conf:

	# support module loading on hotplug
	$MODALIAS=.*    root:root 660 @modprobe "$MODALIAS"

Make sure you have /etc/passwd and /etc/group entries for root, or else
mdev will fail to parse this file. mdev still doesn't automatically load
modules on boot (mdev -s isn't quite the same as udevadm trigger), but
that's only a minor inconvenience and maybe even expected when you use
mdev.

Given that the patches are somewhat invasive and probably need more
testing on Intel, I'm not sure if they'll make it into v4.3. If not I
suggest we go ahead and remove the problematic Kconfig option for now
(or make it built-in) and enable it again when the fixes have landed
(if not for v4.3 then hopefully for v4.4). Perhaps give it a week or so
to give the sound tree maintainers a chance to look at the patches and
evaluate whether or not they should go into v4.3.

Does that sound reasonable?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150917/499bae8d/attachment-0001.sig>
