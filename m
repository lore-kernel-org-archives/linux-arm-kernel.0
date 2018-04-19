From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 19 Apr 2018 15:17:43 +0200
Subject: [PATCH v3 0/7] mmc: sunxi: Add runtime PM support
In-Reply-To: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
References: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAPDyKFpNE3YG6N4zowd8qFYbiw5-KmiZ-TfkzsQEbRNupORqrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 April 2018 at 16:22, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
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
>
> Let me know what you think,
> Maxime
>

Nice work! Applied for next!

Kind regards
Uffe

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
