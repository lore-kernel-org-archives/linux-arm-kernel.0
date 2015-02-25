From: dianders@chromium.org (Doug Anderson)
Date: Wed, 25 Feb 2015 12:23:42 -0800
Subject: [PATCH v3 1/3] mmc: core: Add mmc_regulator_set_vqmmc()
In-Reply-To: <1418689340-29517-1-git-send-email-dianders@chromium.org>
References: <1418689340-29517-1-git-send-email-dianders@chromium.org>
Message-ID: <CAD=FV=WMZ4z-cA1jQ2FiP6tAA7O7F3WQqfQEBmmfOtB147fL6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf,

On Mon, Dec 15, 2014 at 4:22 PM, Doug Anderson <dianders@chromium.org> wrote:
> This adds logic to the MMC core to set VQMMC.  This is expected to be
> called by MMC drivers like dw_mmc as part of (or instead of) their
> start_signal_voltage_switch() callback.
>
> A few notes:
>
> * When setting the signal voltage to 3.3V we do our best to make VQMMC
>   and VMMC match.  It's been reported that this makes some old cards
>   happy since they were tested back in the day before UHS when VQMMC
>   and VMMC were provided by the same regulator.  A nice side effect of
>   this is that we don't end up on the hairy edge of VQMMC (2.7V),
>   which some EEs claim is a little too close to the minimum for
>   comfort.
>
> * When setting the signal voltage to 1.8V or 1.2V we aim for that
>   specific voltage instead of picking the lowest one in the range.
>
> * We very purposely don't print errors in mmc_regulator_set_vqmmc().
>   There are cases where the MMC core will try several different
>   voltages and we don't want to pollute the logs.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
> ---
> Changes in v3: None
> Changes in v2:
> - Now use existing regulator_set_voltage_tol() function.
>
>  drivers/mmc/core/core.c  | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/host.h |  7 +++++++
>  2 files changed, 58 insertions(+)

Do you know the status of this patch and its partner patch (mmc:
dw_mmc: Use mmc_regulator_set_vqmmc in start_signal_voltage_switch -
https://patchwork.kernel.org/patch/5498551/)?

I'm happy to repost them or address feedback.

Thanks!  :)

-Doug
