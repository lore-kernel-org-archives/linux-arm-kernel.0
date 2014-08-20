From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Aug 2014 13:30:30 +0100
Subject: [PATCH] mfd: twl4030-power: Fix PM idle pin configuration to not
 conflict with regulators
In-Reply-To: <20140819152405.GA12002@atomide.com>
References: <20140819152405.GA12002@atomide.com>
Message-ID: <20140820123030.GL4266@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Aug 2014, Tony Lindgren wrote:

> Commit 43fef47f94a1 (mfd: twl4030-power: Add a configuration to turn
> off oscillator during off-idle) added support for configuring the PMIC
> to cut off resources during deeper idle states to save power.
> 
> This however caused regression for n900 display power that needed the
> PMIC configuration to be disabled with commit d937678ab625 (ARM: dts:
> Revert enabling of twl configuration for n900).
> 
> Turns out the root cause of the problem is that we must use
> TWL4030_RESCONFIG_UNDEF instead of DEV_GRP_NULL to avoid disabling
> regulators that may have been enabled before the init function
> for twl4030-power.c runs. With TWL4030_RESCONFIG_UNDEF we let the
> regulator framework control the regulators like it should. Here we
> need to only configure the sys_clken and sys_off_mode triggers for
> the regulators that cannot be done by the regulator framework as
> it's not running at that point.
> 
> This allows us to enable the PMIC configuration for n900.
> 
> Fixes: 43fef47f94a1 (mfd: twl4030-power: Add a configuration to turn off oscillator during off-idle)
> Cc: stable at vger.kernel.org # v3.16
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> ---
> 
> Lee, can you please pick this one for the v3.17-rc series?

Applied with Aaro's Tested-by.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
