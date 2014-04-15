From: tim.kryger@linaro.org (Tim Kryger)
Date: Tue, 15 Apr 2014 12:03:49 -0700
Subject: [PATCH 3/4] mmc: sdhci: defer probing on regulator_get_optional()
 failures
In-Reply-To: <1397526163-20126-4-git-send-email-abrestic@chromium.org>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
 <1397526163-20126-4-git-send-email-abrestic@chromium.org>
Message-ID: <CAAYSxhrmCbGLsu43mK15ParXHa_FJ9OVQiCPUdqyWEpTE=r1uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 6:42 PM, Andrew Bresticker
<abrestic@chromium.org> wrote:
> If regulator_get_optional() returns EPROBE_DEFER, it indicates
> that the regulator may show up later (e.g. the DT property is
> present but the corresponding regulator may not have probed).
> Instead of continuing without the regulator, return EPROBE_DEFER
> from sdhci_add_host().  Also, fix regulator leaks in the error
> paths in sdhci_add_host().
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>  drivers/mmc/host/sdhci.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

This appears to be an improvement on Mike Looijmans patch:

https://lkml.org/lkml/2014/4/7/34

The regulator_put() calls are appropriate but I wonder if we should
take this a step farther.  Ulf is sure to point out that
mmc_regulator_get_supply() can be used to get regulators (though it
does stuff the pointers in host->mmc->supply.vmmc/vqmmc instead of
host->vmmc/vqmmc).  However, that function doesn't put back the
reference to vmmc if the request for vqmmc returns EPROBE_DEFER.  If
it did, it believe it could be used here to simplify the error
handling as all the regulator checks would happen up front.  What do
you think?

-Tim
