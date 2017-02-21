From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 21 Feb 2017 18:47:13 +0100
Subject: [PATCH] clk: rockchip: Set "ignore unused" for PMU M0 clocks on
 rk3399
In-Reply-To: <20170214210114.5846-1-dianders@chromium.org>
References: <20170214210114.5846-1-dianders@chromium.org>
Message-ID: <6585236.hCVu3AsgCt@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 14. Februar 2017, 13:01:14 CET schrieb Douglas Anderson:
> The PMU Cortex M0 on rk3399 is intended to be used for things like
> DDRFreq transitions, suspend/resume, and other things that are the
> purview of ARM Trusted Firmware and not the kernel.  As such, the
> kernel shouldn't be messing with the clocks.  Add CLK_IGNORE_UNUSED to
> these clocks.
> 
> Without this change, the following was observed on a Chromebook with a
> rk3399 (using not-yet-upstream ARM Trusted Firmware code and
> not-yet-upstream kernel code based on kernel-4.4):
> 
> 1. We init the clock framework.
> 
> 2. We start up "DDRFreq", which causes ATF to occasionally fire up the
>    M0 for transitions.  Each time ATF fires up the M0 it will turn on
>    these clocks and each time it is done it will turn them off.
> 
> 3. We finally get to the the part of the kernel that calls
>    clk_disable_unused() and we disables the clocks.
> 
> You can see the race above.  Basically everything is fine as long as
> ARM Trusted Firmware isn't starting up the M0 at exactly the same time
> that the kernel is disabling unused clocks.  ...but if the race
> happens then we go boom.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 4.12

Thanks
Heiko
