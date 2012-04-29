From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Sun, 29 Apr 2012 17:40:37 +0200
Subject: [PATCH v6 00/17] Add PWM framework and device tree support
In-Reply-To: <1334070400-25013-1-git-send-email-thierry.reding@avionic-design.de>
References: <1334070400-25013-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120429174037.59c0de8d@eb-e6520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

Le Tue, 10 Apr 2012 17:06:23 +0200,
Thierry Reding <thierry.reding@avionic-design.de> a ?crit :

> This patch series adds very rudimentary device-tree support for PWM
> devices. With all of these patches applied (plus one board-specific
> patch that is not included), I'm able to control the backlight on the
> device I'm working on using the sysfs interface provided by the pwm-bl
> driver and the backlight class.
> 
> This series is based on Sascha Hauer's series of patches[0] to add a
> generic PWM framework. The first patch in this series is taken from
> Sascha's branch, while the second patch enables each PWM chip to provide
> multiple PWM devices (the Blackfin and PXA drivers have been ported to
> the framework for reference). Currently a global namespace is still
> provided to keep backwards-compatibility with the legacy PWM API. In
> order to achieve this, the number of global PWM devices is limited to
> 1024. However, patch 2 introduces per-chip indexing of PWM devices in
> the core and patch 4 adds an API to request a PWM device using a lookup
> table registered by board setup code. They are supposed to eventually
> replace pwm_request() and allow to get rid of the global namespace. The
> device tree support code does not use the global namespace.
> 
> Patch 3 adds a debugfs interface.
> 
> Patch 5 adds some code to lookup a PWM chip given its device-tree
> handle. This code will be used later on by the pwm-bl driver to find the
> PWM device that it should be using. If the no corresponding PWM chip is
> available yet, the code returns EPROBE_DEFER to have users automatically
> probed again later when the PWM provider may have become available.
> Device tree binding documentation is also provided.
> 
> Patch 6 was taken from the Chromium tree and is required to provide
> proper clocking of the Tegra2 PWFM controller. All Chromium-specific
> tags have been removed from the commit message. Some cleanup of the
> clock registration for Tegra is done in patch 7 because a subsequent
> patch will instantiate one PWFM controller device instead of four.
> 
> Patch 8 adds a generic PWM framework driver for the Tegra2 PWFM
> controller. The code is taken from the Chromium tree with some
> adjustments to integrate it with the PWM framework. Device tree based
> probing of the driver is implemented in patch 9.
> 
> Patches 10 and 11 are ports of the Blackfin PWM and the PXA PWM drivers
> to the PWM framework. These are only compile-tested as I do not have any
> hardware to test them on.
> 
> Patches 12, 13 and 14 move the i.MX, Samsung and VT8500 drivers over to
> the framework. These are originally by Sascha Hauer and were updated to
> take advantage of the multiple PWM devices per chip feature. Patch 15
> adds support for Freescale MXS by Shawn Guo.
> 
> Patch 16 implements DT-based probing in the pwm-backlight driver. Note
> that this code only handles the "pwms" property (by looking up the PWM
> device via the new PWM DT binding). Switching power to the backlight via
> GPIOs is not supported yet. The DT binding also deviates from the
> platform data in that it requires a list of brightness levels to be
> specified instead of assuming a linearily spaced range from 0 to a given
> maximum brightness.
> 
> Finally, patch 17 makes me the new maintainer of the PWM subsystem.
> 
> The whole series is based on the linux-next tree from 20120405. I think
> I've addressed all of the concerns raised in the first five versions. I
> have also pushed this version of the series to the PWM subsystem
> repository[1].
> 
> Thierry
> 
> [0]: http://git.pengutronix.de/?p=imx/linux-2.6.git;a=shortlog;h=refs/heads/pwmlib
> [1]: http://gitorious.org/linux-pwm/linux-pwm/trees/pwm-v6
> 
> Sascha Hauer (4):
>   pwm: Add PWM framework support
>   ARM i.MX: Move i.MX pwm driver to pwm framework
>   ARM Samsung: Move s3c pwm driver to pwm framework
>   ARM vt8500: Move vt8500 pwm driver to pwm framework
> 
> Shawn Guo (1):
>   pwm: add pwm-mxs support
> 
> Simon Que (1):
>   ARM: tegra: Fix PWM clock programming
> 
> Thierry Reding (11):
>   pwm: Allow chips to support multiple PWMs
>   pwm: Add debugfs interface
>   pwm: Add table-based lookup for static mappings
>   pwm: Add device tree support
>   ARM: tegra: Provide clock for only one PWM controller
>   pwm: Add NVIDIA Tegra SoC support
>   pwm: tegra: Add device tree support
>   pwm: Move Blackfin PWM driver to PWM framework
>   pwm: Move PXA PWM driver to PWM framework
>   pwm-backlight: Add rudimentary device tree support
>   pwm: Take over maintainership of the PWM subsystem
> 
for pwm-core & pwm-imx (with the 3 patches I sent a few minutes ago) :
Tested-by: Eric B?nard <eric@eukrea.com>

Thanks !

Eric
