From: tiwai@suse.de (Takashi Iwai)
Date: Sat, 19 Sep 2015 18:42:25 +0200
Subject: [PATCH 0/3] ALSA: hda - Avoid potential deadlock
In-Reply-To: <1442484006-9614-1-git-send-email-thierry.reding@gmail.com>
References: <1442484006-9614-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <s5hwpvmxswe.wl-tiwai@suse.de>
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

This looks like a sane cleanup at a glance, but I can't review in
details now because I'm traveling on vacation.  I'll take a closer
look in the next week.


thanks,

Takashi



> 
> Thierry
> 
> Thierry Reding (3):
>   ALSA: hda/hdmi - Add missing MODALIAS information
>   ALSA: hda - Advertise MODALIAS in uevent
>   ALSA: hda: Do not rely on explicit module loading
> 
>  sound/hda/hda_bus_type.c   | 12 +++++++
>  sound/pci/hda/hda_bind.c   | 80 ----------------------------------------------
>  sound/pci/hda/patch_hdmi.c |  3 ++
>  3 files changed, 15 insertions(+), 80 deletions(-)
> 
> -- 
> 2.5.0
> 
> 
