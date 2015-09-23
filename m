From: tiwai@suse.de (Takashi Iwai)
Date: Wed, 23 Sep 2015 11:03:44 +0200
Subject: [PATCH 0/3] ALSA: hda - Avoid potential deadlock
In-Reply-To: <1442484006-9614-1-git-send-email-thierry.reding@gmail.com>
References: <1442484006-9614-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <s5hfv258q33.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Sep 2015 12:00:03 +0200,
Thierry Reding wrote:
> 
> From: Thierry Reding <treding@nvidia.com>
> 
> The Tegra HDA controller driver committed in v3.16 causes deadlocks when
> loaded as a module. The reason is that the driver core will lock the HDA
> controller device upon calling its probe callback and the probe callback
> then goes on to create child devices for detected codecs and loads their
> modules via a request_module() call. This is problematic because the new
> driver will immediately be bound to the device, which will in turn cause
> the parent of the codec device (the HDA controller device) to be locked
> again, causing a deadlock.
> 
> This problem seems to have been present since the modularization of the
> HD-audio driver in commit 1289e9e8b42f ("ALSA: hda - Modularize HD-audio
> driver"). On Intel platforms this has been worked around by splitting up
> the probe sequence into a synchronous and an asynchronous part where the
> request_module() calls are asynchronous and hence avoid the deadlock.
> 
> An alternative proposal is provided in this series of patches. Rather
> than relying on explicit request_module() calls to load kernel modules
> for HDA codec drivers, this implements a uevent callback for the HDA bus
> to advertises the MODALIAS information to the userspace helper.
> 
> Effectively this results in the same modules being loaded, but it uses
> the more canonical infrastructure to perform this. Deferring the module
> loading to userspace removes the need for the explicit request_module()
> calls and works around the recursive locking issue because both drivers
> will be bound from separate contexts.

While this looks definitely like the right direction to go, I'm afraid
that this will give a few major regressions.  First off, there is no
way to bind with the generic codec driver.  There are two generic
drivers, one for HDMI/DP and one for normal audio.  Binding to them is
judged by parsing the codec widgets whether they are digital-only.
So, either user-space or kernel needs to parse the codec widgets
beforehand.  If we rip off all binding magic as in your patch, this
has to be done by udev.  With the sysfs stuff, now it should be
possible, but this would break the existing system.

Another possible regression is the matching with the vendor-only
alias.  Maybe the current wildcard works, but we need to double
check.

So, unless these are addressed, I think we need another quick band-aid
over snd-hda-tegra just doing the async probe like snd-hda-intel.

Of course, as already written, converting to the standard udev probe
would be best.  We can finally get rid of the manual alias entries by
tweaking the scripts/* stuff.  But I'd like to avoid regressions as
the first priority.


thanks,

Takashi
