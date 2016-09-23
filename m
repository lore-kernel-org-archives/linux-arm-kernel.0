From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 23 Sep 2016 14:43:51 -0700
Subject: [PATCH] clk: zx296718: register driver earlier with core_initcall
In-Reply-To: <1474595108-15790-1-git-send-email-shawn.guo@linaro.org>
References: <1474595108-15790-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20160923214351.GB21232@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23, Shawn Guo wrote:
> Clock driver should be registered with an earlier initcall than
> module_init which is used by most of client device drivers.  Otherwise,
> probing of these client drivers will likely be deferred due to that
> calls into clk API will return -EPROBE_DEFER.
> 
> Deferred probing is not a problem for most subsystems, but could bring
> some side effect for particular subsystem, like display.  On ZX296718
> platform, we get Linux logo and boot log lost from display device, just
> because the DRM/KMS driver gets -EPROBE_DEFER from devm_clk_get() call.
> 
> Let's use core_initcall (qcom and a few other clk drivers use that) for
> driver registration to avoid those unnecessary -EPROBE_DEFER and get rid
> of the side effect with ZX296718 display system.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

Not the ideal solution but it'll do for now.

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
