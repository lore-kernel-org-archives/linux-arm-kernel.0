From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sat, 9 Oct 2010 03:07:50 +0200
Subject: 2.6.35.6 fails to suspend (pxa2xx-mci.0)
In-Reply-To: <201010082208.25767.rjw@sisk.pl>
References: <1286177435.2140.5.camel@sven> <201010072323.05218.rjw@sisk.pl>
	<1286526197.4493.19.camel@sven> <201010082208.25767.rjw@sisk.pl>
Message-ID: <AANLkTinSmPpswdHaZnP2rN688Wu1=-2Y2RBzC4+1qTpM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 8, 2010 at 10:08 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> There is a problem with the pxa2xx-mci.0 suspend that has been introduced
> some time after 2.6.34, but it is not related to commit 152e1d5920.

Sven, what type of card do you have in that slot ? is it SDIO ? what's
the function driver ?

I have a hunch about this, but it may be a wild guess as I don't know
what's your setup exactly.

Anyway, can you please try this and see if anything changes ?

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c94565d..515ff39 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1682,6 +1682,19 @@ int mmc_suspend_host(struct mmc_host *host)
        if (host->bus_ops && !host->bus_dead) {
                if (host->bus_ops->suspend)
                        err = host->bus_ops->suspend(host);
+               if (err == -ENOSYS || !host->bus_ops->resume) {
+                       /*
+                        * We simply "remove" the card in this case.
+                        * It will be redetected on resume.
+                        */
+                       if (host->bus_ops->remove)
+                               host->bus_ops->remove(host);
+                       mmc_claim_host(host);
+                       mmc_detach_bus(host);
+                       mmc_release_host(host);
+                       host->pm_flags = 0;
+                       err = 0;
+               }
        }
        mmc_bus_put(host);

The reason I'm asking this is because it seems like commit
4c2ef25fe0b847d2ae818f74758ddb0be1c27d8e "mmc: fix all hangs related
to mmc/sd card insert/removal during suspend/resume" has broken
suspending SDIO function drivers which don't have a suspend handler
(or do have one, but for some reason it returns -ENOSYS, like
libertas_sdio's does).

> ?The
> problem was not visible with pm_async=1 because of the very bug fixed by
> commit 152e1d5920.
>
> Please see if the problem is there in 2.6.35 (please test with pm_async=0).
>
> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
