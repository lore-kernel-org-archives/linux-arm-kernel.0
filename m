From: megous@megous.com (=?utf-8?Q?Ond=C5=99ej?= Jirman)
Date: Mon, 16 Jul 2018 19:14:28 +0200
Subject: [PATCH v3 0/7] mmc: sunxi: Add runtime PM support
In-Reply-To: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
References: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
Message-ID: <20180716171428.ud3zsmeccds545si@core>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maxime,

On Mon, Apr 16, 2018 at 04:22:58PM +0200, Maxime Ripard wrote:
> Hi,
> 
> Since it's introduction, our MMC controller has had its external clocks
> running all the time.
> 
> While that was working great, the power usage and most importantly the EMI
> that it generated was pretty bad.
> 
> Let's implement some runtime_pm hooks with an autosuspend to shut down the
> whole block when the MMC is not active.
> 
> However, some SDIO devices will not probe properly if we keep shutting down
> the controller, so the autosuspend is disabled for the SDIO devices.

I've tested your patches on TBS A711 tablet (A83T). I get this in the log:

  sunxi-mmc 1c10000.mmc: fatal err update clk timeout

Interestingly, this only happens after the first boot. If I hard power cycle the
tablet (removing/reinserting the battery) the first boot after that, there's no
timeout, and WiFi chip connected to the mmc controller works.

Any other reboot (even power cycling via PMIC), it fails with the above error.
Maybe there's some unforeseen interaction of runtime PM with mmc-powerseq used
for the wifi chip power seuencing? Do you know what's the above error about?
I don't know anything about mmc subsystem.

Reverting "mmc: sunxi: Add runtime_pm support" (+ various cleanup patches
afterwards) helps.

thank you and regards,
  o.

> Let me know what you think,
> Maxime
> 
> Changes from v2:
>   - Dropped the patches already applied
>   - Do not power up or down the card during a runtime_resume or
>     runtime_suspend, but only take care of the controller
>   - In order to do the above, split the set_ios function into smaller
>     chunks that can be called from set_ios and our runtime_resume hook
> 
> Changes from v1:
>   - Disable entirely the controller
>   - Made sure the driver would work with CONFIG_PM off
>   - Fixed an issue with the SDIO devices
>   - Rebased on top of 4.16
> 
> Maxime Ripard (7):
>   mmc: sunxi: Reorder the headers
>   mmc: sunxi: Change sunxi_mmc_init_host argument type
>   mmc: sunxi: Move bus width configuration to a function
>   mmc: sunxi: Move clock configuration to a function
>   mmc: sunxi: Move the card power configuration to a function
>   mmc: sunxi: Add runtime_pm support
>   mmc: sunxi: Drop the init / reset of the controller from set_ios
> 
>  drivers/mmc/host/sunxi-mmc.c | 185 +++++++++++++++++++++++-------------
>  1 file changed, 122 insertions(+), 63 deletions(-)
> 
> base-commit: 60cc43fc888428bb2f18f08997432d426a243338
> -- 
> git-series 0.9.1
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
