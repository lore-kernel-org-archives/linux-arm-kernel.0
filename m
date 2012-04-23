From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 23 Apr 2012 16:40:14 -0700
Subject: [PATCH 0/8] common clk support for mxs
In-Reply-To: <1335023840-1394-1-git-send-email-shawn.guo@linaro.org>
References: <1335023840-1394-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAJOA=zMQC27K1vxKB3mev6HK-yUPjt5BwV1Op+g+hvuRZLVN3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 21, 2012 at 8:57 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> The mxs clock porting to common clk framework has been ready for a
> while. ?I was planning to post it after Mike's -next branch is
> published. ?Since the ETA of the branch is still uncertain while the
> series needs to take some time to go through the review process, I
> can not hold it for any longer, so here it is.

I have been waiting a bit on Saravana's changes to struct clk_hw,
however I don't think that such a patch will break this series too
badly.  Your clk code doesn't rely too heavily on
__clk_internal_function() too much, so you shouldn't be adversely
affected.

> It's based on v3.4-rc3 plus various fixup/cleanup patches that Mike
> confirmed pick-up on his -next branch and the clkdev one below.
>
> ?CLKDEV: Add helper routines to allocate and add clkdevs for given struct clk *
>
> The series originally kept the code in arch/arm/mach-mxs. ?With Arnd's
> comment taken, I reworked it a bit to put it into drivers/clk/mxs in
> the same way that spear clock moves.

Most of the series looks good except for the minor issues I pointed
out in the first three patches.

Which tree are you targeting this for?  clk-next or arm-soc?

Thanks,
Mike

> Shawn Guo (8):
> ? ? ?clk: mxs: add mxs specific clocks
> ? ? ?clk: mxs: add clock support for imx23
> ? ? ?clk: mxs: add clock support for imx28
> ? ? ?ARM: mxs: request clock for timer
> ? ? ?ARM: mxs: change the lookup name for fec phy clock
> ? ? ?ARM: mxs: switch to common clk framework
> ? ? ?ARM: mxs: remove old clock support
> ? ? ?ARM: mxs: remove now unused timer_clk argument from mxs_timer_init
>
> ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/mach-mxs/Makefile ? ? ? ? ? ? ?| ? ?5 +-
> ?arch/arm/mach-mxs/clock-mx23.c ? ? ? ? ?| ?536 ---------------------
> ?arch/arm/mach-mxs/clock-mx28.c ? ? ? ? ?| ?803 -------------------------------
> ?arch/arm/mach-mxs/clock.c ? ? ? ? ? ? ? | ?211 --------
> ?arch/arm/mach-mxs/include/mach/clock.h ?| ? 62 ---
> ?arch/arm/mach-mxs/include/mach/common.h | ? ?6 +-
> ?arch/arm/mach-mxs/mach-mx28evk.c ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-mxs/regs-clkctrl-mx23.h ? | ?331 -------------
> ?arch/arm/mach-mxs/regs-clkctrl-mx28.h ? | ?486 -------------------
> ?arch/arm/mach-mxs/system.c ? ? ? ? ? ? ?| ? 16 -
> ?arch/arm/mach-mxs/timer.c ? ? ? ? ? ? ? | ? 11 +-
> ?drivers/clk/Makefile ? ? ? ? ? ? ? ? ? ?| ? ?2 +
> ?drivers/clk/mxs/Makefile ? ? ? ? ? ? ? ?| ? ?8 +
> ?drivers/clk/mxs/clk-div.c ? ? ? ? ? ? ? | ?102 ++++
> ?drivers/clk/mxs/clk-frac.c ? ? ? ? ? ? ?| ?127 +++++
> ?drivers/clk/mxs/clk-imx23.c ? ? ? ? ? ? | ?195 ++++++++
> ?drivers/clk/mxs/clk-imx28.c ? ? ? ? ? ? | ?318 ++++++++++++
> ?drivers/clk/mxs/clk-pll.c ? ? ? ? ? ? ? | ?123 +++++
> ?drivers/clk/mxs/clk-ref.c ? ? ? ? ? ? ? | ?139 ++++++
> ?drivers/clk/mxs/clk.h ? ? ? ? ? ? ? ? ? | ? 95 ++++
> ?21 files changed, 1123 insertions(+), 2456 deletions(-)
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
