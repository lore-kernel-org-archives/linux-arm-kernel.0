From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 8 Jul 2016 18:35:42 +0200
Subject: [PATCH v3 00/14] regulator: pwm: various improvements
In-Reply-To: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160708163542.GD1151@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 11:13:08AM +0200, Boris Brezillon wrote:
> Hello,
> 
> This patch series series aims at adding two important features to the
> pwm-regulator driver.
> 
> The first one is the support for 'smooth handover' between the
> bootloader and the kernel. This is mainly solving problems we have when
> the PWM is controlling a critical regulator (like the one powering the
> DDR chip). Currently, when the PWM regulator acquire the PWM device it
> assumes it was off and it's safe to change the configuration before
> enabling it, which can generate glitches on the PWM signal which in turn
> generated glitches on the output voltage.
> To solve that we've introduced support for hardware readout to the
> PWM framework, so that the PWM regulator driver can adjust the PWM
> a probe time and avoid glitches.
> Atomic update is also helping in this regard.
> 
> Patch 1 is adding convenient helpers (at the PWM level) that will be
> used by the PWM regulator driver.
> Patches 2 to 7 are preparing everything on the PWM driver side to make
> hardware readout available to all platforms using the PWM regulator
> driver (rockchip and sti).
> Patches 8 to 11 are making use of the atomic update and hardware readout
> features to implement this smooth handover.
> 
> The second feature we add to the driver is the capability of using
> a sub duty_cycle range in continuous mode. By default the regulator
> is assuming that min_uV is achieved with a 0% dutycyle and max_uV
> with a 100% dutycycle, but this is not necessarily true.
> Moreover, in some cases (when the PWM device does not support
> polarity inversion), we might have min_uV at 100% and max_uV at 0%.
> Hence the addition of new properties to the existing DT bindings.
> The feature is added in patch 12 and 13.
> 
> Best Regards,
> 
> Boris
> 
> Changes since v2:
> - add Heiko's Tested-by
> - split patch 1 in 2 patches
> - rework the documentation
> - rename pwm_prepare_new_state() into pwm_init_state()
> - make pwm_set_relative_duty_cycle() return an error code when scale
>   or duty_cycle are inconsistent
> 
> Changes since v1:
> - dropped already applied patches
> - added R-b/A-b/T-b tags
> - s/readl/readl_relaxed/ in patch 3 (as suggested by Brian)
> - fixed pwm-regulator DT binding doc
> - added some comments in the code
> - replaced pwm_get_state() + if (state.enabled) by if (pwm_is_enabled())
> 
> Boris Brezillon (14):
>   pwm: Add an helper to prepare a new PWM state
>   pwm: Add two helpers to ease relative duty cycle manipulation
>   pwm: rockchip: Fix period and duty_cycle approximation
>   pwm: rockchip: Add support for hardware readout
>   pwm: rockchip: Avoid glitches on already running PWMs
>   pwm: rockchip: Add support for atomic update
>   pwm: sti: Add support for hardware readout
>   pwm: sti: Avoid glitches on already running PWMs
>   regulator: pwm: Adjust PWM config at probe time
>   regulator: pwm: Switch to the atomic PWM API
>   regulator: pwm: Properly initialize the ->state field
>   regulator: pwm: Retrieve correct voltage
>   regulator: pwm: Support extra continuous mode cases
>   regulator: pwm: Document pwm-dutycycle-unit and pwm-dutycycle-range

I've applied everything in this series to the PWM tree, except for the
two pwm-sti driver patches, which I'd like to get an Acked-by from one
of the maintainers.

Mark, let me know how you'd like to handle the miniature conflict in the
regulator-pwm driver that I mentioned in one of the patches.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160708/7fb53553/attachment.sig>
