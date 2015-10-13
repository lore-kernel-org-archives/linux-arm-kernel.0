From: eric@anholt.net (Eric Anholt)
Date: Tue, 13 Oct 2015 11:19:27 -0700
Subject: [PATCH v3 3/7] drm/vc4: Add KMS support for Raspberry Pi.
In-Reply-To: <561A6BE4.9080409@lategoodbye.de>
References: <1444426068-15817-1-git-send-email-eric@anholt.net>
 <1444426068-15817-4-git-send-email-eric@anholt.net>
 <561A6BE4.9080409@lategoodbye.de>
Message-ID: <87io6a3a34.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <info@lategoodbye.de> writes:

> Hi Eric,
>
> Am 09.10.2015 um 23:27 schrieb Eric Anholt:
>> This is enough for fbcon and bringing up X using
>> xf86-video-modesetting.  It doesn't support the 3D accelerator or
>> power management yet.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> ---
>>
>> v2: Drop FB_HELPER select thanks to Archit's patches.  Do manual init
>>      ordering instead of using the .load hook.  Structure registration
>>      more like tegra's, but still using the typical "component" code.
>>      Drop no-op hooks for atomic_begin and mode_fixup() now that
>>      they're optional.  Drop sentinel in Makefile.  Fix minor style
>>      nits I noticed on another reread.
>>
>> v3: Use the new bcm2835 clk driver to manage pixel/HSM clocks instead
>>      of having a fixed video mode.  Use exynos-style component driver
>>      matching instead of devicetree nodes to list the component driver
>>      instances.  Rename compatibility strings to say bcm2835, and
>>      distinguish pv0/1/2.  Clean up some h/vsync code, and add in
>>      interlaced mode setup.  Fix up probe/bind error paths.  Use
>>      bitops.h macros for vc4_regs.h
>>
>>   drivers/gpu/drm/Kconfig           |   2 +
>>   drivers/gpu/drm/Makefile          |   1 +
>>   drivers/gpu/drm/vc4/Kconfig       |  13 +
>>   drivers/gpu/drm/vc4/Makefile      |  17 +
>>   drivers/gpu/drm/vc4/vc4_bo.c      |  52 +++
>>   drivers/gpu/drm/vc4/vc4_crtc.c    | 675 ++++++++++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/vc4/vc4_debugfs.c |  39 +++
>>   drivers/gpu/drm/vc4/vc4_drv.c     | 284 ++++++++++++++++
>>   drivers/gpu/drm/vc4/vc4_drv.h     | 115 +++++++
>>   drivers/gpu/drm/vc4/vc4_hdmi.c    | 588 +++++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/vc4/vc4_hvs.c     | 163 +++++++++
>>   drivers/gpu/drm/vc4/vc4_kms.c     |  54 +++
>>   drivers/gpu/drm/vc4/vc4_plane.c   | 320 ++++++++++++++++++
>>   drivers/gpu/drm/vc4/vc4_regs.h    | 570 ++++++++++++++++++++++++++++++++
>>   14 files changed, 2893 insertions(+)
>>   create mode 100644 drivers/gpu/drm/vc4/Kconfig
>>   create mode 100644 drivers/gpu/drm/vc4/Makefile
>>   create mode 100644 drivers/gpu/drm/vc4/vc4_bo.c
>>   create mode 100644 drivers/gpu/drm/vc4/vc4_crtc.c
>>   create mode 100644 drivers/gpu/drm/vc4/vc4_debugfs.c
>>   create mode 100644 drivers/gpu/drm/vc4/vc4_drv.c
>>   create mode 100644 drivers/gpu/drm/vc4/vc4_drv.h
>>   create mode 100644 drivers/gpu/drm/vc4/vc4_hdmi.c
>>   create mode 100644 drivers/gpu/drm/vc4/vc4_hvs.c
>>   create mode 100644 drivers/gpu/drm/vc4/vc4_kms.c
>>   create mode 100644 drivers/gpu/drm/vc4/vc4_plane.c
>>   create mode 100644 drivers/gpu/drm/vc4/vc4_regs.h
>>
>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> index 1a0a8df..c4bf9a1 100644
>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -264,3 +264,5 @@ source "drivers/gpu/drm/sti/Kconfig"
>>   source "drivers/gpu/drm/amd/amdkfd/Kconfig"
>>
>>   source "drivers/gpu/drm/imx/Kconfig"
>> +
>> +source "drivers/gpu/drm/vc4/Kconfig"
>> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
>> index 45e7719..0edc9e2 100644
>> --- a/drivers/gpu/drm/Makefile
>> +++ b/drivers/gpu/drm/Makefile
>> @@ -42,6 +42,7 @@ obj-$(CONFIG_DRM_MGA)	+= mga/
>>   obj-$(CONFIG_DRM_I810)	+= i810/
>>   obj-$(CONFIG_DRM_I915)  += i915/
>>   obj-$(CONFIG_DRM_MGAG200) += mgag200/
>> +obj-$(CONFIG_DRM_VC4)  += vc4/
>>   obj-$(CONFIG_DRM_CIRRUS_QEMU) += cirrus/
>>   obj-$(CONFIG_DRM_SIS)   += sis/
>>   obj-$(CONFIG_DRM_SAVAGE)+= savage/
>> diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
>> new file mode 100644
>> index 0000000..e810ef7
>> --- /dev/null
>> +++ b/drivers/gpu/drm/vc4/Kconfig
>> @@ -0,0 +1,13 @@
>> +config DRM_VC4
>> +	tristate "Broadcom VC4 Graphics"
>> +	depends on ARCH_BCM2835
>
> depends on (ARCH_BCM2835 || COMPILE_TEST) ?

Done.

>> +	depends on DRM
>> +	select DRM_KMS_HELPER
>> +	select DRM_KMS_CMA_HELPER
>> +	help
>> +	  Choose this option if you have a system that has a Broadcom
>> +	  VC4 GPU, such as the Raspberry Pi or other BCM2708/BCM2835.
>> +
>> +	  This driver requires that "avoid_warnings=2" be present in
>> +	  the config.txt for the firmware, to keep it from smashing
>> +	  our display setup.
>> + [...]
>> +static void vc4_crtc_disable(struct drm_crtc *crtc)
>> +{
>> +	struct drm_device *dev = crtc->dev;
>> +	struct vc4_dev *vc4 = to_vc4_dev(dev);
>> +	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
>> +	u32 chan = vc4_crtc->channel;
>> +
>> +	require_hvs_enabled(dev);
>> +
>> +	CRTC_WRITE(PV_V_CONTROL,
>> +		   CRTC_READ(PV_V_CONTROL) & ~PV_VCONTROL_VIDEN);
>> +	while (CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN)
>> +		cpu_relax();
>> +
>> +	/* Without a wait here, we end up with a black screen. */
>> +	msleep(30);
>
> This looks a little bit strange. First we do a busy loop without any 
> timeout and then a fixed msleep without reason for the exact duration.
>
> Sorry for the possibly dumb questions:
>
> Is it safe to read PV_V_CONTROL exactly after writing to them? No 
> sleeping required?

Correct.  We're waiting for the value to land, so you just read until it
does.

I've pulled in a later change for doing waits with timouts.

> How did you come to the 30 milli seconds?

a bit more than a frame.  The comment was there to document why the
sleep was there.  It looks like in retesting now that it's not required.

>> +  [...]
>> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
>> new file mode 100644
>> index 0000000..ae37fec
>> --- /dev/null
>> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
>> @@ -0,0 +1,588 @@
>> +/*
>> + * Copyright (C) 2015 Broadcom
>> + * Copyright (c) 2014 The Linux Foundation. All rights reserved.
>> + * Copyright (C) 2013 Red Hat
>> + * Author: Rob Clark <robdclark@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published by
>> + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along with
>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +/**
>> + * DOC: VC4 Falcon HDMI module
>> + *
>> + * The HDMI core has a state machine and a PHY.  Most of the unit
>> + * operates off of the HSM clock from CPRMAN.  It also internally uses
>> + * the PLLH_PIX clock for the PHY.
>> + */
>> +
>> +#include "drm_atomic_helper.h"
>> +#include "drm_crtc_helper.h"
>> +#include "drm_edid.h"
>> +#include "linux/clk.h"
>> +#include "linux/component.h"
>
> #include "linux/i2c.h" ?

Done.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151013/6a1758a9/attachment.sig>
